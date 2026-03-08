const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

exports.sendResetCode = functions.https.onCall(async (data, context) => {
  const email = data.email;
  const code = data.code;

  await admin.firestore().collection("reset_codes").doc(email).set({
    code: code,
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
  });

  console.log(`Código ${code} guardado para ${email}`);

  console.log(`Código ${code} guardado para ${email}`);
});

// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

// exports.helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

/**
 * LactaAmor — Cloud Function: Alerta por WhatsApp al número de confianza
 *
 * CÓMO FUNCIONA:
 *   1. La app Flutter escribe un documento en la colección `alertas_sms`
 *      con el campo `procesado: false`.
 *   2. Esta función escucha esa colección (onDocumentCreated).
 *   3. Lee el perfil de la madre para obtener el `celular_confianza`.
 *   4. Envía un mensaje de WhatsApp via Twilio con el resumen de la alerta.
 *   5. Marca el documento como `procesado: true`.
 *
 * SETUP TWILIO WHATSAPP SANDBOX (para pruebas — gratis):
 *   1. Ir a twilio.com → Messaging → Try it out → Send a WhatsApp message
 *   2. El número de confianza debe enviar "join <palabra>" al sandbox una vez
 *   3. Configurar secrets:
 *        firebase functions:secrets:set TWILIO_ACCOUNT_SID
 *        firebase functions:secrets:set TWILIO_AUTH_TOKEN
 *        firebase functions:secrets:set TWILIO_WHATSAPP_FROM
 *        (valor: whatsapp:+14155238886  ← número sandbox de Twilio)
 *
 *   npm install twilio
 *   firebase deploy --only functions
 *
 * PARA PRODUCCIÓN:
 *   Solicitar WhatsApp Business API aprobada en Twilio (~1 mes de revisión)
 *   o usar Meta Business directamente.
 */

const { onDocumentCreated } = require("firebase-functions/v2/firestore");
const { initializeApp } = require("firebase-admin/app");
const { getFirestore } = require("firebase-admin/firestore");
const { defineSecret } = require("firebase-functions/params");

initializeApp();

const twilioSid = defineSecret("AC54ae06990eb0dc0df004e2504a201a5c");
const twilioToken = defineSecret("96bb0cb084e92483c54c66248e66df10");
const twilioFrom = defineSecret("+17242692766");

exports.enviarAlertaWhatsApp = onDocumentCreated(
  {
    document: "alertas_sms/{alertaId}",
    secrets: [twilioSid, twilioToken, twilioFrom],
    region: "us-central1",
  },
  async (event) => {
    const db = getFirestore();
    const alerta = event.data.data();
    const alertaId = event.params.alertaId;

    // Evitar reprocesamiento
    if (alerta.procesado) return null;

    const uid = alerta.uid;
    if (!uid) return null;

    // ── 1. Leer perfil de la madre ───────────────────────────────────────
    const userSnap = await db.collection("users").doc(uid).get();
    if (!userSnap.exists) return null;

    const userData = userSnap.data();
    const nombreMadre = userData.fullname || "La usuaria";
    let telefonoConfianza = userData.celular_confianza;

    if (!telefonoConfianza) {
      console.log(`[${alertaId}] Sin número de confianza para uid: ${uid}`);
      await event.data.ref.update({ procesado: true, error: "sin_numero" });
      return null;
    }

    // Normalizar número peruano: si empieza con 9xx → +519xxxxxxxx
    telefonoConfianza = telefonoConfianza.replace(/\s/g, "");
    if (!telefonoConfianza.startsWith("+")) {
      telefonoConfianza = "+51" + telefonoConfianza;
    }

    // ── 2. Construir mensaje WhatsApp ─────────────────────────────────────────
    const tipo = alerta.tipo === "postparto" ? "postparto" : "embarazo";
    let mensaje = `🔔 LactaAmor - Alerta de salud\n\n`;
    mensaje += `${nombreMadre} registró señales que podrían requerir atención.\n\n`;

    if (tipo === "embarazo") {
      mensaje += buildMensajeEmbarazo(alerta);
    } else {
      mensaje += buildMensajePostparto(alerta);
    }

    mensaje += `\nPor favor comunícate con ella o sugiérele ir al centro de salud más cercano.`;

    // ── 3. Enviar WhatsApp via Twilio ─────────────────────────────────────────
    const twilio = require("twilio")(
      twilioSid.value(),
      twilioToken.value()
    );

    try {
      const sms = await twilio.messages.create({
        body: mensaje,
        from: twilioFrom.value(),   // formato: "whatsapp:+14155238886"
        to: "whatsapp:" + telefonoConfianza,  // WhatsApp destination
      });

      console.log(`[${alertaId}] WhatsApp enviado. SID: ${sms.sid}`);

      await event.data.ref.update({
        procesado: true,
        sms_sid: sms.sid,
        enviado_a: telefonoConfianza,
        enviado_at: new Date(),
      });
    } catch (error) {
      console.error(`[${alertaId}] Error enviando SMS:`, error.message);
      await event.data.ref.update({
        procesado: true,
        error: error.message,
      });
    }

    return null;
  }
);

// ─────────────────────────────────────────────────────────────────────────────
//  Helpers para construir el mensaje
// ─────────────────────────────────────────────────────────────────────────────

function buildMensajeEmbarazo(alerta) {
  let msg = `📋 Etapa: Embarazo`;

  if (alerta.semana_gestacion) {
    msg += ` (semana ${alerta.semana_gestacion})`;
  }
  msg += "\n";

  if (alerta.estado_animo && alerta.estado_animo <= 2) {
    const emojis = { 1: "😢 Muy mal", 2: "😟 Triste" };
    msg += `• Estado de ánimo: ${emojis[alerta.estado_animo] || alerta.estado_animo}\n`;
  }

  if (alerta.sintomas_graves && alerta.sintomas_graves.length > 0) {
    msg += `• Síntomas graves: ${alerta.sintomas_graves.join(", ")}\n`;
  }

  if (alerta.presion && alerta.presion !== "/") {
    msg += `• Presión arterial: ${alerta.presion} mmHg\n`;
  }

  return msg;
}

function buildMensajePostparto(alerta) {
  let msg = `📋 Etapa: Postparto\n`;

  if (alerta.hay_alerta_madre) {
    msg += "\n🩺 Sobre la madre:\n";
    if (alerta.estado_animo && alerta.estado_animo <= 2) {
      const emojis = { 1: "😢 Muy mal", 2: "😟 Triste" };
      msg += `• Ánimo: ${emojis[alerta.estado_animo] || alerta.estado_animo}\n`;
    }
    if (alerta.sintomas_graves && alerta.sintomas_graves.length > 0) {
      msg += `• Síntomas: ${alerta.sintomas_graves.join(", ")}\n`;
    }
  }

  if (alerta.hay_alerta_bebe) {
    msg += "\n👶 Sobre el bebé:\n";
    if (alerta.temperatura_bebe) {
      msg += `• Temperatura: ${alerta.temperatura_bebe}°C\n`;
    }
    if (alerta.color_deposicion) {
      msg += `• Deposición: ${alerta.color_deposicion}\n`;
    }
  }

  return msg;
}