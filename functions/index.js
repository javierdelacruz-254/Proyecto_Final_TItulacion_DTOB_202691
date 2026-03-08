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
 * LactaAmor — Cloud Function: Alerta por WhatsApp via UltraMsg (GRATUITO)
 *
 * ── CÓMO FUNCIONA ────────────────────────────────────────────────────────────
 *  1. La app Flutter escribe en `alertas_sms` con procesado: false
 *  2. Esta función se dispara, lee el perfil y obtiene `celular_confianza`
 *  3. Envía el WhatsApp via UltraMsg (el contacto no hace nada)
 *  4. Marca el documento como procesado: true
 *
 * ── SETUP ULTRAMSG (una sola vez, lo hace el equipo) ─────────────────────────
 *  1. Ir a https://ultramsg.com → crear cuenta gratis
 *  2. Crear una instancia → escanear QR con el WhatsApp del equipo
 *  3. Copiar Instance ID y Token desde el panel
 *  4. Guardar como secrets de Firebase:
 *
 *       firebase functions:secrets:set ULTRAMSG_INSTANCE_ID
 *       firebase functions:secrets:set ULTRAMSG_TOKEN
 *
 *  5. Desplegar:
 *       firebase deploy --only functions
 *
 * ── LÍMITES PLAN GRATUITO ─────────────────────────────────────────────────────
 *  • 500 mensajes incluidos — suficiente para el proyecto académico
 *  • Sin restricciones en el contacto destinatario
 */

const { onDocumentCreated } = require("firebase-functions/v2/firestore");
const { initializeApp }     = require("firebase-admin/app");
const { getFirestore }      = require("firebase-admin/firestore");
const https                 = require("https");

initializeApp();

// ⚠️ Solo para uso académico — reemplaza con tus credenciales reales de UltraMsg
const ULTRAMSG_INSTANCE_ID = "instance164512";  // ej: instance12345
const ULTRAMSG_TOKEN       = "bf37735uu5thm70k";         // ej: abc123xyz

exports.enviarAlertaWhatsApp = onDocumentCreated(
  {
    document: "alertas_sms/{alertaId}",
    region:   "us-central1",
  },
  async (event) => {
    const db       = getFirestore();
    const alerta   = event.data.data();
    const alertaId = event.params.alertaId;

    // Evitar reprocesamiento
    if (alerta.procesado) return null;

    const uid = alerta.uid;
    if (!uid) return null;

    // ── 1. Leer perfil de la madre ──────────────────────────────────────────
    const userSnap = await db.collection("users").doc(uid).get();
    if (!userSnap.exists) return null;

    const userData    = userSnap.data();
    const nombreMadre = userData.fullname || "La usuaria";

    // Número de confianza — formato Firestore: "961 777 998"
    // UltraMsg necesita: "51961777998" (sin +, con código de país)
    let telefono = userData.celular_confianza;
    if (!telefono) {
      console.log(`[${alertaId}] Sin número de confianza para uid: ${uid}`);
      await event.data.ref.update({ procesado: true, error: "sin_numero" });
      return null;
    }
    telefono = telefono.replace(/\s|-/g, "");
    if (telefono.startsWith("+")) {
      telefono = telefono.substring(1); // quitar el +
    } else if (!telefono.startsWith("51")) {
      telefono = "51" + telefono;       // agregar código Perú
    }

    // ── 2. Construir mensaje ────────────────────────────────────────────────
    const tipo  = alerta.tipo === "postparto" ? "postparto" : "embarazo";
    let mensaje = `🔔 *LactaAmor — Alerta de salud*\n\n`;
    mensaje    += `*${nombreMadre}* registró señales que podrían requerir atención médica.\n\n`;
    mensaje    += tipo === "embarazo"
      ? buildMensajeEmbarazo(alerta)
      : buildMensajePostparto(alerta);
    mensaje    += `\nPor favor contáctala o sugiérele ir al centro de salud más cercano. 🏥`;

    // ── 3. Enviar via UltraMsg ──────────────────────────────────────────────
    const instanceId = ULTRAMSG_INSTANCE_ID;
    const token      = ULTRAMSG_TOKEN;

    const body = JSON.stringify({
      token:   token,
      to:      telefono,
      body:    mensaje,
    });

    const options = {
      hostname: "api.ultramsg.com",
      path:     `/${instanceId}/messages/chat`,
      method:   "POST",
      headers:  {
        "Content-Type":   "application/json",
        "Content-Length": Buffer.byteLength(body),
      },
    };

    try {
      const respuesta = await httpPost(options, body);
      console.log(`[${alertaId}] WhatsApp enviado a ${telefono}:`, respuesta);

      await event.data.ref.update({
        procesado:  true,
        enviado_a:  telefono,
        enviado_at: new Date(),
        canal:      "ultramsg_whatsapp",
        respuesta:  respuesta,
      });
    } catch (error) {
      console.error(`[${alertaId}] Error UltraMsg:`, error.message);
      await event.data.ref.update({
        procesado: true,
        error:     error.message,
      });
    }

    return null;
  }
);

// ─────────────────────────────────────────────────────────────────────────────
//  Helper: POST con https nativo (sin axios, sin node-fetch)
// ─────────────────────────────────────────────────────────────────────────────
function httpPost(options, body) {
  return new Promise((resolve, reject) => {
    const req = https.request(options, (res) => {
      let data = "";
      res.on("data", (chunk) => { data += chunk; });
      res.on("end", () => {
        try {
          resolve(JSON.parse(data));
        } catch {
          resolve(data);
        }
      });
    });
    req.on("error", reject);
    req.write(body);
    req.end();
  });
}

// ─────────────────────────────────────────────────────────────────────────────
//  Helpers para construir el mensaje según etapa
// ─────────────────────────────────────────────────────────────────────────────

function buildMensajeEmbarazo(alerta) {
  let msg = `📋 *Etapa:* Embarazo`;
  if (alerta.semana_gestacion) msg += ` (semana ${alerta.semana_gestacion})`;
  msg += "\n";

  if (alerta.estado_animo <= 2) {
    const map = { 1: "😢 Muy mal", 2: "😟 Triste" };
    msg += `• Estado de ánimo: ${map[alerta.estado_animo] ?? alerta.estado_animo}\n`;
  }
  if (alerta.sintomas_graves?.length) {
    msg += `• Síntomas graves: ${alerta.sintomas_graves.join(", ")}\n`;
  }
  if (alerta.presion && alerta.presion !== "/") {
    msg += `• Presión arterial: ${alerta.presion} mmHg\n`;
  }
  return msg;
}

function buildMensajePostparto(alerta) {
  let msg = `📋 *Etapa:* Postparto\n`;

  if (alerta.hay_alerta_madre) {
    msg += "\n🩺 *Sobre la madre:*\n";
    if (alerta.estado_animo <= 2) {
      const map = { 1: "😢 Muy mal", 2: "😟 Triste" };
      msg += `• Ánimo: ${map[alerta.estado_animo] ?? alerta.estado_animo}\n`;
    }
    if (alerta.sintomas_graves?.length) {
      msg += `• Síntomas: ${alerta.sintomas_graves.join(", ")}\n`;
    }
  }

  if (alerta.hay_alerta_bebe) {
    msg += "\n👶 *Sobre el bebé:*\n";
    if (alerta.temperatura_bebe) {
      msg += `• Temperatura: ${alerta.temperatura_bebe}°C\n`;
    }
    if (alerta.color_deposicion) {
      msg += `• Deposición: ${alerta.color_deposicion}\n`;
    }
  }

  return msg;
}