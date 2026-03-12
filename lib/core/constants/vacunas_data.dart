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
        },
        {
          "id": "hepatitis_b",
          "nombre": "Hepatitis B",
          "dosis": 1,
          "protege_contra": ["Hepatitis B"],
          "descripcion": "Aplicar dentro de las primeras 24 horas",
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
        },
        {
          "id": "polio_ipv_1",
          "nombre": "Polio (IPV)",
          "dosis": 1,
          "protege_contra": ["Poliomielitis"],
        },
        {
          "id": "rotavirus_1",
          "nombre": "Rotavirus",
          "dosis": 1,
          "protege_contra": ["Gastroenteritis por rotavirus"],
        },
        {
          "id": "neumococo_1",
          "nombre": "Neumococo conjugada",
          "dosis": 1,
          "protege_contra": ["Neumonia", "Meningitis"],
        },
      ],
    },

    {
      "edad": "4_meses",
      "edad_meses": 4,
      "vacunas": [
        {"id": "pentavalente_2", "nombre": "Pentavalente", "dosis": 2},
        {"id": "polio_ipv_2", "nombre": "Polio (IPV)", "dosis": 2},
        {"id": "rotavirus_2", "nombre": "Rotavirus", "dosis": 2},
        {"id": "neumococo_2", "nombre": "Neumococo conjugada", "dosis": 2},
      ],
    },

    {
      "edad": "6_meses",
      "edad_meses": 6,
      "vacunas": [
        {"id": "pentavalente_3", "nombre": "Pentavalente", "dosis": 3},
        {"id": "polio_ipv_3", "nombre": "Polio (IPV)", "dosis": 3},
        {
          "id": "influenza_1",
          "nombre": "Influenza",
          "dosis": 1,
          "nota": "Primera dosis si es la primera vez",
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
        },
        {
          "id": "neumococo_refuerzo",
          "nombre": "Neumococo conjugada",
          "dosis": 3,
        },
      ],
    },
  ],
};
