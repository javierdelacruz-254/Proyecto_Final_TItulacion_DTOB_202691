final Map<String, List<Map<String, dynamic>>> recomendaciones = {
  "embarazo": [
    // Etapa 1
    {
      "min": 0,
      "max": 8,
      "tips": [
        {
          "texto": "Empieza a tomar ácido fólico si tu médico lo indicó.",
          "articuloId": "01",
          "vitamina_prenatalaes": false,
        },
        {
          "texto": "Descansa lo suficiente y evita esfuerzos físicos intensos.",
          "articuloId": "02",
          "relevancia": "estado_animo, horas_sueno",
          "estado_animo": 2,
          "horas_sueno": {"min": 0, "max": 4},
        },
        {
          "texto":
              "Mantén una alimentación equilibrada rica en frutas y verduras.",
          "articuloId": "03",
          "relevancia": "hierro, vitaminas_prenatales",
          "hierro": false,
          "vitaminas_prenatales": false,
        },
      ],
    },

    // Etapa 2
    {
      "min": 9,
      "max": 16,
      "tips": [
        {
          "texto": "Programa y mantén tus controles prenatales.",
          "articuloId": "04",
        },
        {
          "texto": "Evita alcohol, tabaco y alimentos crudos.",
          "articuloId": "05",
        },
        {
          "texto":
              "Mantente hidratada y realiza actividad física suave como caminar.",
          "articuloId": "06",
          "vasos_agua": {"min": 0, "max": 5},
        },
      ],
    },

    // Etapa 3
    {
      "min": 17,
      "max": 28,
      "tips": [
        {
          "texto": "Podrías empezar a sentir los movimientos del bebé.",
          "articuloId": "07",
          "movimientos_fetales": {"min": 0, "max": 5},
        },
        {
          "texto": "Consume alimentos ricos en hierro y calcio.",
          "articuloId": "08",
          "hierro": false,
          "vitaminas_prenatales": false,
        },
        {
          "texto": "Mantén una postura correcta al sentarte o descansar.",
          "articuloId": "09",
        },
      ],
    },

    // Etapa 4
    {
      "min": 29,
      "max": 40,
      "tips": [
        {
          "texto": "Prepara tu bolso y documentos para el hospital.",
          "articuloId": "10",
        },
        {"texto": "Descansa con mayor frecuencia.", "articuloId": "11"},
        {
          "texto": "Consulta con tu médico sobre el plan de parto.",
          "articuloId": "12",
        },
      ],
    },
  ],

  "postparto": [
    // Etapa 1
    {
      "min": 0,
      "max": 4,
      "tips": [
        {
          "texto": "Alimenta a tu bebé cada 2-3 horas.",
          "articuloId": "13",
          "tomas_lactancia": true,
        },
        {
          "texto": "El contacto piel con piel ayuda a regular su temperatura.",
          "articuloId": "14",
        },
        {"texto": "Descansa cuando tu bebé duerma.", "articuloId": "15"},
      ],
    },

    // Etapa 2
    {
      "min": 5,
      "max": 12,
      "tips": [
        {"texto": "Tu bebé empieza a reconocer tu voz.", "articuloId": "16"},
        {
          "texto": "Hablarle y cantarle estimula su desarrollo.",
          "articuloId": "17",
        },
        {
          "texto": "Mantén la lactancia frecuente.",
          "articuloId": "18",
          "tomas_lactancia": true,
        },
      ],
    },

    // Etapa 3
    {
      "min": 13,
      "max": 52,
      "tips": [
        {
          "texto": "Tu bebé explora cada vez más su entorno.",
          "articuloId": "19",
        },
        {
          "texto": "Interactúa con juegos simples y seguros.",
          "articuloId": "20",
        },
        {
          "texto": "Mantén controles regulares con el pediatra.",
          "articuloId": "21",
        },
      ],
    },
  ],
};
