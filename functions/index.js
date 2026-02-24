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
