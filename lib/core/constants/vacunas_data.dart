final Map<String, dynamic> vacunasData = {
  "pais": "Peru",
  "fuente": "MINSA - Esquema Nacional de Vacunacion",
  "version": "2026",
  "vacunas_bebe": [
    {
      "edad": "recien_nacido",
      "edad_meses": 0,
      "vacunas": [
        {
          "id": "bcg",
          "nombre": "BCG",
          "dosis": 1,
          "protege_contra": ["Tuberculosis grave"],
          "descripcion": "Aplicar al nacer",
          "articuloId": "85",
        },
        {
          "id": "hepatitis_b",
          "nombre": "Hepatitis B",
          "dosis": 1,
          "protege_contra": ["Hepatitis B"],
          "descripcion": "Aplicar dentro de las primeras 24 horas",
          "articuloId": "86",
        },
      ],
    },
    {
      "edad": "2_meses",
      "edad_meses": 2,
      "vacunas": [
        {
          "id": "pentavalente_1",
          "nombre": "Pentavalente",
          "dosis": 1,
          "protege_contra": [
            "Difteria",
            "Tetano",
            "Tos ferina",
            "Hepatitis B",
            "Haemophilus influenzae tipo B",
          ],
          "articuloId": "87",
        },
        {
          "id": "polio_ipv_1",
          "nombre": "Polio (IPV)",
          "dosis": 1,
          "protege_contra": ["Poliomielitis"],
          "articuloId": "88",
        },
        {
          "id": "rotavirus_1",
          "nombre": "Rotavirus",
          "dosis": 1,
          "protege_contra": ["Gastroenteritis por rotavirus"],
          "articuloId": "89",
        },
        {
          "id": "neumococo_1",
          "nombre": "Neumococo conjugada",
          "dosis": 1,
          "protege_contra": ["Neumonia", "Meningitis"],
          "articuloId": "90",
        },
      ],
    },

    {
      "edad": "4_meses",
      "edad_meses": 4,
      "vacunas": [
        {
          "id": "pentavalente_2",
          "nombre": "Pentavalente",
          "dosis": 2,
          "articuloId": "87",
        },
        {
          "id": "polio_ipv_2",
          "nombre": "Polio (IPV)",
          "dosis": 2,
          "articuloId": "88",
        },
        {
          "id": "rotavirus_2",
          "nombre": "Rotavirus",
          "dosis": 2,
          "articuloId": "89",
        },
        {
          "id": "neumococo_2",
          "nombre": "Neumococo conjugada",
          "dosis": 2,
          "articuloId": "90",
        },
      ],
    },

    {
      "edad": "6_meses",
      "edad_meses": 6,
      "vacunas": [
        {
          "id": "pentavalente_3",
          "nombre": "Pentavalente",
          "dosis": 3,
          "articuloId": "87",
        },
        {
          "id": "polio_ipv_3",
          "nombre": "Polio (IPV)",
          "dosis": 3,
          "articuloId": "88",
        },
        {
          "id": "influenza_1",
          "nombre": "Influenza",
          "dosis": 1,
          "nota": "Primera dosis si es la primera vez",
          "articuloId": "91",
        },
      ],
    },

    {
      "edad": "7_meses",
      "edad_meses": 7,
      "vacunas": [
        {
          "id": "influenza_2",
          "nombre": "Influenza",
          "dosis": 2,
          "nota": "Segunda dosis un mes después de la primera",
          "articuloId": "91",
        },
      ],
    },

    {
      "edad": "12_meses",
      "edad_meses": 12,
      "vacunas": [
        {
          "id": "spr",
          "nombre": "Sarampion, Paperas y Rubeola (SPR)",
          "dosis": 1,
          "articuloId": "92",
        },
        {
          "id": "neumococo_refuerzo",
          "nombre": "Neumococo conjugada",
          "dosis": 3,
          "articuloId": "90",
        },
      ],
    },
  ],
  "vacunas_madre": [
    {
      "edad": "primer_trismestre",
      "trimestre": 1,
      "vacunas": [
        {
          "id": "influenza",
          "nombre": "Influenza",
          "dosis": 1,
          "protege_contra": ["Influenza estacional"],
          "descripcion":
              "Aplicar durante cualquier momento del embarazo si no se aplico antes",
          "articuloId": "91",
        },
      ],
    },
    {
      "edad": "segundo_trimestre",
      "trimestre": 2,
      "vacunas": [
        {
          "id": "tdap",
          "nombre": "Tétano, Difteria y Tos ferina (Tdap)",
          "dosis": 1,
          "protege_contra": ["Tétano", "Difteria", "Tos ferina"],
          "descripcion": "Aplicar entre la semana 20 y 36 de gestación",
          "articuloId": "93",
        },
        {
          "id": "influenza_refuerzo",
          "nombre": "Influenza (refuerzo si necesario)",
          "dosis": 1,
          "protege_contra": ["Influenza estacional"],
          "descripcion": "Si no se aplicó en primer trimestre",
          "articuloId": "91",
        },
      ],
    },
    {
      "edad": "tercer_trimestre",
      "trimestre": 3,
      "vacunas": [
        {
          "id": "tdap_2",
          "nombre": "Tétano, Difteria y Tos ferina (Tdap) refuerzo",
          "dosis": 1,
          "protege_contra": ["Tétano", "Difteria", "Tos ferina"],
          "descripcion":
              "Para proteger al recién nacido, aplicar entre la semana 27 y 36",
          "articuloId": "93",
        },
        {
          "id": "hepatitis_b",
          "nombre": "Hepatitis B",
          "dosis": 1,
          "protege_contra": ["Hepatitis B"],
          "descripcion": "Aplicar si no se aplicó previamente",
          "articuloId": "86",
        },
      ],
    },
  ],
};
