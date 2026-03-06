const admin = require("firebase-admin");
const serviceAccount = require("C:/Users/Arturo Anticona/Downloads/lactaamor-de5cd-firebase-adminsdk-fbsvc-fa6ecce636.json");
const data = require("../especialistas.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

const db = admin.firestore();

async function importar() {
  const especialistas = data.especialistas;

  for (const id in especialistas) {
    await db.collection("especialistas").doc(id).set(especialistas[id]);
    console.log(`Subido: ${id}`);
  }

  console.log("Importación completa");
}

importar();