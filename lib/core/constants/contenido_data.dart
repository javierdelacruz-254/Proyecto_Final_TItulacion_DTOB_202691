import '../../features/contenidos/models/contenido_model.dart';

final List<TemaContenido> todosLosTemas = [
  // ================= CAMBIOS EN EL EMBARAZO =================
  TemaContenido(
    titulo: "Cambios en el embarazo",
    imagen:
        "https://www.scielo.org.mx/img/revistas/facmed/v64n1//2448-4865-facmed-64-01-39-gch1.png",
    descripcion:
        "Explica los cambios físicos, emocionales y hormonales que experimenta la madre.",
    categoria: "Embarazo",
    articulos: [
      ArticuloContenido(
        id: "01",
        titulo: "Cambios del cuerpo durante el embarazo",
        descripcion:
            "Durante el embarazo el cuerpo de la mujer experimenta cambios físicos, hormonales y funcionales importantes que permiten el desarrollo del bebé y preparan al cuerpo para el parto.",
        imagen:
            "https://i2.wp.com/www.pilatesbodysoul.com/wp-content/uploads/2019/01/image2.png?resize=640%2C551",
        fuente:
            "Ministerio de Salud del Perú / Instituto Nacional Materno Perinatal.",
        tags: ["embarazo", "cuerpo", "cambios", "salud"],
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Cambios del cuerpo durante el embarazo",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Durante el embarazo el cuerpo de la mujer se adapta para permitir el crecimiento y desarrollo del bebé. Estos cambios ocurren principalmente por la acción de hormonas y por el aumento del tamaño del útero.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.lista,
            valor:
                "Crecimiento del abdomen y del útero,Aumento del tamaño de los senos,Cambios en la piel como manchas o estrías,Aumento de peso progresivo,Mayor cansancio o sueño",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Estos cambios son normales y forman parte del proceso natural del embarazo.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.tip,
            valor:
                "Usa ropa cómoda, mantente hidratada y acude a tus controles prenatales para vigilar que todo evolucione adecuadamente.",
          ),
        ],
      ),
      ArticuloContenido(
        id: "02",
        titulo: "Cambios emocionales y hormonales",
        descripcion:
            "Durante el embarazo se producen cambios hormonales importantes que pueden afectar las emociones y el estado de ánimo de la madre.",
        imagen:
            "https://drbrowns.es/wp-content/uploads/2023/08/cambios-emociones-800x532.jpg",
        fuente: "Ministerio de Salud del Perú – Salud mental materna.",
        tags: [
          "embarazo",
          "emociones",
          "cambios",
          "hormonas",
          "tristeza",
          "alegria",
          "salud",
        ],
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Cambios emocionales y hormonales en el embarazo",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Durante el embarazo el cuerpo produce diferentes hormonas que ayudan al desarrollo del bebé. Estas hormonas también pueden provocar cambios emocionales en la madre.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.lista,
            valor:
                "Cambios de humor,Sensibilidad o llanto frecuente,Ansiedad o preocupación,Mayor necesidad de apoyo emocional",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Estos cambios son comunes en muchas mujeres embarazadas y suelen variar durante cada etapa del embarazo.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.tip,
            valor:
                "Hablar con tu pareja, familia o personal de salud puede ayudarte a manejar mejor estos cambios.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.advertencia,
            valor:
                "Si sientes tristeza profunda, ansiedad constante o pérdida de interés en tus actividades, busca apoyo en un profesional de salud.",
          ),
        ],
      ),
      ArticuloContenido(
        id: "03",
        titulo: "Molestias comunes del embarazo",
        descripcion:
            "Durante el embarazo pueden aparecer molestias leves causadas por los cambios del cuerpo.",
        imagen:
            "https://www.conmishijos.com/uploads/embarazo/molestiasembarazo.jpg",
        fuente:
            "Recomendaciones de atención prenatal del Ministerio de Salud del Perú.",
        tags: ["embarazo", "cuerpo", "cambios", "salud", "molestias"],
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Molestias comunes durante el embarazo",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Es normal que durante el embarazo aparezcan algunas molestias físicas. Estas generalmente no representan un problema de salud.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.lista,
            valor:
                "Náuseas o vómitos,Cansancio o sueño,Dolor de espalda,Acidez o indigestión,Hinchazón de pies",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Estas molestias suelen presentarse con mayor frecuencia en los primeros meses del embarazo y pueden disminuir con el tiempo.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.tip,
            valor:
                "Descansa lo suficiente, mantén una alimentación saludable y consulta con tu médico si las molestias son muy intensas.",
          ),
        ],
      ),
      ArticuloContenido(
        id: "04",
        titulo: "Cuándo los cambios pueden ser señal de alerta",
        descripcion:
            "El MINSA recomienda estar atento a ciertos signos de alarma durante el embarazo, ya que pueden indicar complicaciones.",
        imagen:
            "https://melodijolamatrona.com/wp-content/uploads/2025/04/sintomas-alarma-embarazo-08.png",
        fuente:
            "Ministerio de Salud del Perú – señales de peligro en el embarazo.",
        tags: ["embarazo", "alerta", "cambios", "salud"],
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Cuándo los cambios pueden ser una señal de alerta",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Aunque muchos cambios durante el embarazo son normales, algunos síntomas pueden indicar un problema que necesita atención médica.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.lista,
            valor:
                "Dolor de cabeza intenso,Visión borrosa,Sangrado vaginal,Hinchazón repentina de cara, manos o pies,Fiebre o dolor abdominal fuerte",
          ),
          ContenidoBloque(
            tipo: TipoBloque.advertencia,
            valor:
                "Si presentas alguno de estos síntomas debes acudir inmediatamente al establecimiento de salud más cercano.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.tip,
            valor:
                "Asistir a todos tus controles prenatales permite detectar a tiempo posibles complicaciones para proteger tu salud y la de tu bebé.",
          ),
        ],
      ),
    ],
  ),

  // ================= CONTROLES PRENATALES =================
  TemaContenido(
    titulo: "Controles prenatales",
    imagen:
        "https://www.panolini.com/wp-content/uploads/2023/11/CONTROL_PRENATAL-1.webp",
    descripcion:
        "Muy importante en Perú porque el control prenatal reduce riesgos.",
    categoria: "Embarazo",
    articulos: [
      ArticuloContenido(
        id: "05",
        titulo: "Qué es el control prenatal",
        descripcion:
            "El control prenatal es un conjunto de atenciones médicas periódicas que recibe una mujer durante el embarazo para cuidar su salud y la de su bebé.",
        imagen:
            "https://medicinaycirugiafetal.pe/wp-content/uploads/2024/10/ipmcf-blog-control-prenatal.png",
        fuente: "Ministerio de Salud del Perú (MINSA).",
        tags: ["controles", "prenatales", "salud", "embarazo", "duda"],
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Qué es el control prenatal",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "El control prenatal es el conjunto de evaluaciones, exámenes y acompañamiento que ofrece el personal de salud a una mujer embarazada. Su objetivo es vigilar el crecimiento del bebé, detectar posibles riesgos o enfermedades y brindar orientación sobre nutrición, hábitos saludables y cuidados generales.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.lista,
            valor:
                "Examen físico,Análisis de laboratorio,Consejería sobre alimentación y estilo de vida,Seguimiento del crecimiento fetal,Vacunas y pruebas de detección",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Asistir a todos los controles prenatales ayuda a prevenir complicaciones tanto para la madre como para el bebé.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.tip,
            valor:
                "Inicia tu control prenatal apenas confirmes tu embarazo para detectar factores de riesgo desde temprano.",
          ),
        ],
      ),
      ArticuloContenido(
        id: "06",
        titulo: "Cada cuánto ir al control prenatal",
        descripcion:
            "El control prenatal es un conjunto de atenciones médicas periódicas que recibe una mujer durante el embarazo para cuidar su salud y la de su bebé.",
        imagen:
            "https://elcomercio.pe/resizer/v2/QSZPXFLKJBH2ZFTVJ76BVEHEQQ.jpg?auth=a1752fb7500fb6b0ea23d904a1d92e85938e2f9fb2605e75db7976fd25485a49&width=1000&height=667&quality=75&smart=true",
        fuente: "Ministerio de Salud del Perú (MINSA).",
        tags: ["embarazo", "controles", "prenatal", "duda", "salud"],
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Cada cuánto ir al control prenatal",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "La frecuencia de las consultas prenatales cambia según el mes de gestación. Es importante asistir a cada cita para monitorear la salud de la madre y del bebé.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.lista,
            valor:
                "Primer trimestre: 1 visita inicial y luego cada 4 semanas,Segundo trimestre: cada 4 semanas,Tercer trimestre: cada 2 a 4 semanas,Últimas semanas: controles semanales hasta el parto",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Generalmente se recomiendan al menos 6 controles prenatales durante todo el embarazo. La frecuencia puede aumentar dependiendo del estado de salud de la gestante y de recomendaciones del médico.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.tip,
            valor:
                "Lleva siempre tu tarjeta o carnet con las fechas de tus controles para llevar un registro claro.",
          ),
        ],
      ),
      ArticuloContenido(
        id: "07",
        titulo: "Exámenes durante el embarazo",
        descripcion:
            "El control prenatal es un conjunto de atenciones médicas periódicas que recibe una mujer durante el embarazo para cuidar su salud y la de su bebé.",
        imagen:
            "https://medicinaycirugiafetal.pe/wp-content/uploads/2024/10/ipmcf-blog-control-prenatal.png",
        fuente: "Ministerio de Salud del Perú (MINSA).",
        tags: [
          "embarazo",
          "controles",
          "prenatal",
          "duda",
          "salud",
          "examenes",
        ],
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Exámenes durante el embarazo",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Durante las consultas prenatales, el personal de salud indicará exámenes que ayudan a evaluar tu salud y la del bebé.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.lista,
            valor:
                "Análisis de sangre: detecta anemia, grupo sanguíneo y otros parámetros generales.,Examen de orina: identifica infecciones o problemas renales.,Ecografía: observa el desarrollo físico del bebé.,Prueba de glucosa: para detectar diabetes gestacional.,Medición de presión arterial: para prevenir condiciones como preeclampsia.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Estos exámenes se realizan en distintos momentos del embarazo para asegurar que todo avance de manera saludable y detectar a tiempo cualquier anomalía o enfermedad.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.tip,
            valor:
                "Si tienes dudas sobre algún examen, pregunta al profesional de salud para que te expliquen su propósito y cómo se realiza.",
          ),
        ],
      ),
      ArticuloContenido(
        id: "08",
        titulo: "Qué llevar a una cita prenatal",
        descripcion:
            "El control prenatal es un conjunto de atenciones médicas periódicas que recibe una mujer durante el embarazo para cuidar su salud y la de su bebé.",
        imagen:
            "https://medicinaycirugiafetal.pe/wp-content/uploads/2024/10/ipmcf-blog-control-prenatal.png",
        fuente: "Ministerio de Salud del Perú (MINSA).",
        tags: ["embarazo", "controles", "prenatal", "duda", "salud", "cita"],
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Qué llevar a una cita prenatal",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Ir preparada a tu consulta prenatal facilita que el personal de salud pueda atenderte mejor y resolver tus dudas.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.lista,
            valor:
                "Documento de identidad,Tarjeta o carnet de controles prenatales,Lista de medicamentos o vitaminas que tomas,Lista de preguntas o dudas para tu médico,Resultados de exámenes previos (si ya tuviste)",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "También es ideal asistir acompañada por tu pareja o un familiar de confianza, ya que pueden ayudarte a recordar indicaciones importantes.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.tip,
            valor:
                "Anota todas tus preguntas antes de la cita para aprovechar mejor el tiempo con el personal de salud.",
          ),
        ],
      ),
    ],
  ),

  // ================= ALIMENTACION EN EL EMBARAZO =================
  TemaContenido(
    titulo: "Alimentación en el embarazo",
    imagen:
        "https://hospitalgalenia.com/wp-content/uploads/2024/08/embarazo4-k12-U501843487346qJE-624x385@El-Correo.jpg",
    descripcion:
        "Guía completa sobre nutrición saludable para mujeres embarazadas, basada en recomendaciones del MINSA Perú.",
    categoria: "Embarazo",
    articulos: [
      ArticuloContenido(
        id: "09",
        titulo: "Nutrientes importantes en el embarazo",
        descripcion:
            "Conoce los nutrientes esenciales que toda gestante debe incluir en su alimentación diaria para un embarazo saludable.",
        imagen:
            "https://www.edualimentaria.com/images/nutricion-embarazo/alimentacion-saludable-embarazada.jpg",
        fuente: "Ministerio de Salud del Perú",
        tags: ["salud", "embarazo", "nutrientes", "alimentacion"],
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Nutrientes importantes en el embarazo",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Durante el embarazo, algunos nutrientes son esenciales para el desarrollo del bebé y la salud de la madre.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.lista,
            valor:
                "Hierro: previene la anemia.,Ácido fólico: previene defectos del tubo neural.,Proteínas: crecimiento de tejidos.,Vitaminas A y C: desarrollo celular.,Calcio y Zinc: huesos y sistema inmunológico.,Hidratación: 6–8 vasos de agua diarios.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.tip,
            valor:
                "Incluye alimentos locales como quinoa, kiwicha y maca para un aporte extra de nutrientes.",
          ),
        ],
      ),
      ArticuloContenido(
        id: "10",
        titulo: "Alimentos recomendados durante el embarazo",
        descripcion:
            "Lista de alimentos que aportan los nutrientes esenciales y son seguros para la gestante.",
        imagen:
            "https://www.natalben.com/sites/default/files/inline-images/Dieta%20para%20el%20estre%C3%B1imiento.jpg",
        fuente: "Ministerio de Salud del Perú",
        tags: [
          "salud",
          "embarazo",
          "nutrientes",
          "alimentacion",
          "recomendado",
        ],
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Alimentos recomendados durante el embarazo",
          ),
          ContenidoBloque(
            tipo: TipoBloque.lista,
            valor:
                "Proteínas: carnes magras, pescado, huevos, lácteos pasteurizados.,Hierro y ácido fólico: vísceras, menestras, vegetales de hoja verde.,Frutas y verduras: papaya, plátano, zanahoria, espinaca.,Hidratación: agua natural 6–8 vasos/día.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.tip,
            valor:
                "Prefiere alimentos locales y de temporada para mayor frescura y nutrientes.",
          ),
        ],
      ),
      ArticuloContenido(
        id: "11",
        titulo: "Alimentos que se deben evitar durante el embarazo",
        descripcion:
            "Alimentos y bebidas que pueden poner en riesgo la salud de la madre y el bebé.",
        imagen:
            "https://www.farmaofficego.com/uploads/post/F0010/blog/alimentacion%20y%20embarazo%2003.jpg",
        fuente: "Ministerio de Salud del Perú",
        tags: [
          "salud",
          "embarazo",
          "nutrientes",
          "alimentacion",
          "evitas",
          "consejo",
        ],
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Alimentos que se deben evitar durante el embarazo",
          ),
          ContenidoBloque(
            tipo: TipoBloque.advertencia,
            valor:
                "Evita alimentos crudos o poco cocidos como carnes y huevos, lácteos no pasteurizados y pescados con alto contenido de mercurio.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.lista,
            valor:
                "Bebidas alcohólicas y no pasteurizadas.,Comida chatarra y bebidas azucaradas.,Frutas y verduras sin lavar adecuadamente.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.tip,
            valor:
                "Lava siempre bien frutas y verduras y cocina bien las carnes y huevos.",
          ),
        ],
      ),
      ArticuloContenido(
        id: "12",
        titulo: "Ejemplo de alimentación diaria para gestantes",
        descripcion:
            "Patrón de comidas recomendado para cubrir los requerimientos nutricionales durante el embarazo.",
        imagen:
            "https://nutricionnervion.es/wp-content/uploads/2023/11/distribucion-proporciones-plato-de-harvard.jpg",
        fuente: "Ministerio de Salud del Perú",
        tags: ["salud", "embarazo", "nutrientes", "alimentacion", "diaria"],
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Ejemplo de alimentación diaria para gestantes",
          ),
          ContenidoBloque(
            tipo: TipoBloque.lista,
            valor:
                "Desayuno: avena con leche pasteurizada, fruta (papaya o plátano), huevo cocido.,Refrigerio mañana: yogur natural o fruta.,Almuerzo: arroz integral o quinua, carne magra o pescado cocido, verduras de hoja verde, frijoles o lentejas.,Refrigerio tarde: frutos secos o fruta.,Cena: sopa nutritiva con menestras, ensalada de verduras, pan integral.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.tip,
            valor:
                "Mantente hidratada durante todo el día con 6–8 vasos de agua.",
          ),
        ],
      ),
    ],
  ),

  // ================= SEÑALES DE ALERTA EN EL EMBARAZO =================
  TemaContenido(
    titulo: "Señales de alerta en el embarazo",
    imagen:
        "https://todossomosuno.com.mx/portal/wp-content/uploads/2016/02/embarazo-riesgo.jpg",
    descripcion:
        "Conoce los signos de alarma durante el embarazo que requieren atención médica inmediata.",
    categoria: "Embarazo",
    articulos: [
      ArticuloContenido(
        id: "13",
        titulo: "Signos de alarma en el embarazo",
        descripcion:
            "Estos signos pueden indicar un problema serio en el embarazo y requieren atención inmediata.",
        imagen:
            "https://thumbs.dreamstime.com/b/peligro-de-la-precauci%C3%B3n-del-embarazo-de-la-se%C3%B1al-de-peligro-54586479.jpg",
        fuente: "Ministerio de Salud del Perú",
        tags: ["salud", "embarazo", "alarma", "peligro", "signos"],
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Signos de alarma en el embarazo",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Durante el embarazo pueden aparecer señales que indican riesgo para la madre o el bebé.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.lista,
            valor:
                "Pérdida de líquido por las partes genitales,Fiebre,Vómitos persistentes,Molestias o dolor al orinar,Dolor del bajo vientre,Ausencia o disminución de movimientos del bebé (después de la semana 20),Hinchazón de manos, pies o cara",
          ),
          ContenidoBloque(
            tipo: TipoBloque.advertencia,
            valor:
                "Si presentas alguno de estos síntomas acude inmediatamente a un centro de salud.",
          ),
        ],
      ),
      ArticuloContenido(
        id: "14",
        titulo: "Sangrado vaginal durante el embarazo",
        descripcion:
            "El sangrado vaginal puede indicar complicaciones y siempre debe ser evaluado por un profesional de salud.",
        imagen:
            "https://hemeranix.com/wp-content/uploads/2025/05/Sangrado-durante-el-embarazo-ilustracion-educativa.webp",
        fuente: "Ministerio de Salud del Perú",
        tags: ["salud", "embarazo", "alarma", "peligro", "signos", "sangrado"],
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Sangrado vaginal durante el embarazo",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "El sangrado vaginal en cualquier momento del embarazo —ya sea poco o mucho— puede ser un signo de riesgo.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.lista,
            valor:
                "Amenaza de aborto o aborto espontáneo,Rotura de membranas (pérdida de líquido amniótico),Otros problemas obstétricos que deben ser evaluados",
          ),
          ContenidoBloque(
            tipo: TipoBloque.advertencia,
            valor:
                "Aunque no todo sangrado significa pérdida del embarazo, siempre debe evaluarse por un profesional.",
          ),
        ],
      ),
      ArticuloContenido(
        id: "15",
        titulo: "Fiebre o infección durante el embarazo",
        descripcion:
            "La fiebre alta puede indicar infección que afecta a la madre y al bebé, y requiere atención inmediata.",
        imagen:
            "https://cuidateplus.marca.com/sites/default/files/styles/ratio_43/public/cms/embarazada_0.jpg.webp?itok=Pw7quNYI",
        fuente: "Ministerio de Salud del Perú",
        tags: [
          "salud",
          "embarazo",
          "alarma",
          "peligro",
          "signos",
          "fiebre",
          "infeccion",
        ],
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Fiebre o infección durante el embarazo",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Fiebre alta (38 °C o más) durante el embarazo puede ser una señal de infección grave.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.lista,
            valor:
                "Escalofríos,Dolor al orinar,Malestar fuerte,Aumento de temperatura persistente",
          ),
          ContenidoBloque(
            tipo: TipoBloque.advertencia,
            valor:
                "Si tienes fiebre persistente de más de 24 horas o síntomas de infección, acude rápidamente a un establecimiento de salud.",
          ),
        ],
      ),
      ArticuloContenido(
        id: "16",
        titulo: "Cuándo acudir de emergencia al hospital",
        descripcion:
            "Existen situaciones de emergencia durante el embarazo que requieren atención inmediata en un hospital.",
        imagen:
            "https://www.quironsalud.com/idcsalud-client/cm/images?locale=es_ES&idMmedia=3760424",
        fuente: "Ministerio de Salud del Perú",
        tags: [
          "salud",
          "embarazo",
          "alarma",
          "peligro",
          "signos",
          "emergencia",
          "hospital",
        ],
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Cuándo acudir de emergencia al hospital",
          ),
          ContenidoBloque(
            tipo: TipoBloque.lista,
            valor:
                "Sangrado vaginal importante,Pérdida clara de líquido (posible ruptura de fuente),Disminución o ausencia de movimientos fetales,Fiebre alta y persistente,Dolor abdominal fuerte o contínuo,Vómitos que no ceden,Hinchazón marcada de manos, rostro o pies,Dolor intenso de cabeza o visión borrosa",
          ),
          ContenidoBloque(
            tipo: TipoBloque.advertencia,
            valor:
                "Estas señales pueden indicar complicaciones como amenaza de aborto, infección o riesgo materno-fetal. Consulta sin demora con profesionales de salud.",
          ),
        ],
      ),
    ],
  ),

  // ================= DESARROLLO DEL BEBE DURANTE EL EMBARAZO =================
  TemaContenido(
    titulo: "Desarrollo del bebé durante el embarazo",
    imagen:
        "https://www.conmishijos.com/assets/posts/14000/14731-desarrollo-del-bebe-en-el-embarazo.jpg",
    descripcion:
        "Paso a paso de como se desarrolla el bebé dentro del vientre de la madre",
    categoria: "Embarazo",
    articulos: [
      ArticuloContenido(
        id: "17",
        titulo: "Cómo crece el bebé mes a mes",
        descripcion:
            "Descubre los hitos principales del desarrollo de tu bebé durante cada mes del embarazo, desde la concepción hasta el nacimiento.",
        imagen:
            "https://www.materna.com.ar/Portals/0/images/articulos/embarazo/embarazo-3398-el-desarrollo-del-bebe-en-el-tercer-trimestre-155837296.jpgg",
        fuente: "Ministerio de Salud del Perú, Gob.pe",
        tags: ["embarazo", "salud", "crecimiento", "desarrollo", "bebe", "mes"],
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Cómo crece el bebé mes a mes",
          ),

          // Introducción
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Durante el embarazo, tu bebé atraviesa etapas de crecimiento muy rápidas. Conocer cómo se desarrolla cada mes te ayudará a comprender mejor los cambios y estar atenta a su bienestar.",
          ),

          // Mes 1
          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Mes 1 (1–4 semanas)",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "El óvulo fecundado se implanta en el útero y empieza a formarse el embrión. Se inicia la formación de estructuras básicas y la placenta comienza a desarrollarse.",
          ),

          // Mes 2
          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Mes 2 (5–8 semanas)",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Se forman los órganos principales: corazón, cerebro, hígado y pulmones. El corazón comienza a latir y el embrión empieza a adoptar una forma más definida.",
          ),

          // Mes 3
          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Mes 3 (9–12 semanas)",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Se definen brazos, piernas, dedos, ojos y orejas. El bebé comienza a moverse, aunque aún no es perceptible para la madre.",
          ),

          // Mes 4
          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Mes 4 (13–16 semanas)",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Aparecen los reflejos y los movimientos son más coordinados. La madre puede empezar a notar cambios físicos más evidentes como crecimiento del abdomen.",
          ),

          // Mes 5
          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Mes 5 (17–20 semanas)",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "El bebé mide aproximadamente 20–25 cm. Empieza a moverse perceptiblemente y la madre puede sentir las primeras pataditas. Los órganos continúan madurando.",
          ),

          // Mes 6
          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Mes 6 (21–24 semanas)",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Los movimientos son más fuertes y frecuentes. Se desarrollan músculos, pulmones y piel. El bebé puede tener hipo y responder a estímulos externos.",
          ),

          // Mes 7
          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Mes 7 (25–28 semanas)",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "El bebé gana peso rápidamente, sus órganos continúan madurando y empieza a adquirir grasa corporal para regular la temperatura al nacer.",
          ),

          // Mes 8
          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Mes 8 (29–32 semanas)",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Los pulmones y el cerebro se desarrollan más. El espacio en el útero disminuye, por lo que los movimientos son más controlados.",
          ),

          // Mes 9
          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Mes 9 (33–40 semanas)",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "El bebé está listo para nacer. Gana peso final, sus pulmones están maduros y se prepara para adaptarse al ambiente exterior. Los movimientos se perciben hasta el momento del parto.",
          ),

          // Tip final
          ContenidoBloque(
            tipo: TipoBloque.tip,
            valor:
                "Recuerda que cada bebé es único y los tiempos pueden variar. Lo importante es asistir a tus controles prenatales para monitorear su desarrollo.",
          ),
        ],
      ),
      ArticuloContenido(
        id: "18",
        titulo: "Cambios del bebé en cada trimestre",
        descripcion:
            "Conoce cómo se desarrolla tu bebé durante cada trimestre del embarazo.",
        imagen:
            "https://www.conmishijos.com/uploads/embarazo/bebe-semana-24.jpg",
        fuente: "Ministerio de Salud del Perú",

        tags: [
          "embarazo",
          "salud",
          "crecimiento",
          "desarrollo",
          "bebe",
          "trimestre",
        ],
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Cambios del bebé en cada trimestre",
          ),
          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Primer trimestre (0–13 semanas)",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "En este período se forman los órganos principales, el corazón empieza a latir y el embrión experimenta un crecimiento rápido.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Segundo trimestre (14–26 semanas)",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "El bebé desarrolla huesos, cabello, uñas y reflejos. Comienza a moverse, y es posible escuchar sus latidos y observar movimientos en ecografía.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Tercer trimestre (27–40 semanas)",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Durante estas semanas el bebé gana peso y tamaño rápidamente. Los pulmones finalizan su maduración y se prepara para nacer.",
          ),
        ],
      ),
      ArticuloContenido(
        id: "19",
        titulo: "Movimientos del bebé",
        descripcion:
            "Aprende cuándo y cómo sentir los movimientos de tu bebé durante el embarazo.",
        imagen:
            "https://www.mamanatural.com/wp-content/uploads/Quickening-in-Pregnancy.-When-Can-You-Feel-the-Baby-Move-Mama-Natural.jpg",
        fuente: "Ministerio de Salud del Perú",
        tags: [
          "embarazo",
          "salud",
          "crecimiento",
          "desarrollo",
          "bebe",
          "movimiento",
        ],
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Movimientos del bebé",
          ),
          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Cuándo se sienten los movimientos",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Generalmente los movimientos empiezan a sentirse entre la semana 17 y 20, aunque puede variar según cada embarazo.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.lista,
            valor:
                "Sensación inicial: parecida a 'aleteo de mariposa' o burbujas.\nPrimeros movimientos fuertes: alrededor de la semana 18–20.\nEmbarazos previos pueden sentirlos antes.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.advertencia,
            valor:
                "Si el bebé deja de moverse o hay menos movimientos de lo usual, consulta inmediatamente con un profesional de salud.",
          ),
        ],
      ),
      ArticuloContenido(
        id: "20",
        titulo: "Cuándo empezar a sentir al bebé",
        descripcion:
            "Información sobre cuándo la madre puede comenzar a percibir los movimientos del bebé.",
        imagen:
            "https://www.clebastien.com/wp-content/uploads/2024/06/movimiento_embarazada.png",
        fuente: "Ministerio de Salud del Perú",
        tags: [
          "embarazo",
          "salud",
          "crecimiento",
          "desarrollo",
          "bebe",
          "movimiento",
          "sentir",
        ],
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Cuándo empezar a sentir al bebé",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Muchas madres notan los primeros movimientos entre 18 y 20 semanas aproximadamente. En embarazos previos puede sentirse antes, entre 16 y 18 semanas.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.tip,
            valor:
                "Recuerda que cada embarazo es diferente; algunas madres pueden sentir los movimientos un poco más tarde y eso puede ser normal.",
          ),
        ],
      ),
    ],
  ),

  // ================= ACTIVIDAD FISICA Y CUIDADOS =================
  TemaContenido(
    titulo: "Actividad física y cuidados",
    imagen:
        "https://www.egr.es/wp-content/uploads/2023/11/vista-lateral-joven-embarazada-haciendo-ejercicio-pelota-fitness.jpg",
    descripcion:
        "Recomendaciones sobre activiades que se pueden realizar estando embarazada",
    categoria: "Embarazo",
    articulos: [
      ArticuloContenido(
        id: "21",
        titulo: "Actividad física segura durante el embarazo",
        descripcion:
            "Aprende qué tipos de ejercicio son seguros y beneficiosos durante la gestación.",
        imagen:
            "https://www.gomezroig.com/wp-content/uploads/2016/08/Ejerecicio-durante-el-Embarazo-Gomez-Roig.jpg",
        fuente: "Ministerio de Salud del Perú",
        tags: ["embarazo", "salud", "actividad", "fisico", "saludable"],
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Actividad física segura durante el embarazo",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "La actividad física durante el embarazo es beneficiosa siempre que no exista ninguna contraindicación médica.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.lista,
            valor:
                "Beneficios:,- Reduce riesgo de diabetes gestacional y hipertensión,- Mejora circulación y controla el peso,- Alivia estrés y mejora el ánimo",
          ),
          ContenidoBloque(
            tipo: TipoBloque.lista,
            valor:
                "Tipos de actividad recomendados:,- Caminatas moderadas,- Natación y ejercicios en el agua,- Yoga prenatal y estiramientos suaves",
          ),
          ContenidoBloque(
            tipo: TipoBloque.advertencia,
            valor:
                "Evita ejercicios de alto impacto, deportes de contacto y acostarte boca arriba durante el ejercicio después de las primeras semanas.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.tip,
            valor:
                "Mantente hidratada antes, durante y después de la actividad física.",
          ),
        ],
      ),
      ArticuloContenido(
        id: "22",
        titulo: "Cómo dormir durante el embarazo",
        descripcion:
            "Consejos para descansar de forma segura y cómoda durante la gestación.",
        imagen:
            "https://images.logicommerce.cloud/109/blog/almohadas-para-embarazadas.jpg",
        fuente: "TV Perú / Profesionales de salud",
        tags: ["embarazo", "salud", "descanso", "sueño", "saludable"],
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Cómo dormir durante el embarazo",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Dormir bien es fundamental durante el embarazo para el bienestar de la madre y el bebé.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.lista,
            valor:
                "Posturas recomendadas:,- Dormir de lado, preferentemente sobre el lado izquierdo,- Colocar una almohada entre las piernas,- Usar almohadas adicionales para apoyar la espalda o abdomen",
          ),
          ContenidoBloque(
            tipo: TipoBloque.lista,
            valor:
                "Problemas comunes:,- Dificultad para encontrar una postura cómoda,- Dolor lumbar o calambres nocturnos",
          ),
          ContenidoBloque(
            tipo: TipoBloque.tip,
            valor:
                "Evita líquidos justo antes de dormir y realiza respiración profunda o relajación para conciliar mejor el sueño.",
          ),
        ],
      ),
      ArticuloContenido(
        id: "23",
        titulo: "Viajar estando embarazada",
        descripcion:
            "Recomendaciones para viajar de manera segura durante la gestación.",
        imagen:
            "https://www.bupasalud.com/sites/default/files/styles/640_x_400/public/articulos/2024-09/fotos/Viajar%20en%20avi%C3%B3n%20embarazada-1.jpg?itok=Ghbt1TGp",
        fuente: "Ministerio de Salud del Perú",
        tags: ["embarazo", "salud", "actividad", "viaje", "saludable", "bebe"],
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Viajar estando embarazada",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Viajar durante el embarazo puede ser seguro, pero requiere planificación y precaución, especialmente en viajes largos o en el último trimestre.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.lista,
            valor:
                "Recomendaciones generales:,- Mantente hidratada durante el viaje,- Consulta al médico antes de viajes largos,- Planifica paradas frecuentes si viajas por carretera",
          ),
          ContenidoBloque(
            tipo: TipoBloque.lista,
            valor:
                "Viajes en avión:,- Consulta la autorización médica antes de volar,- Evita vuelos largos en el último trimestre sin autorización,- Revisa políticas de aerolíneas para gestantes",
          ),
          ContenidoBloque(
            tipo: TipoBloque.lista,
            valor:
                "Viajes en carretera:,- Levántate y camina cada cierto tiempo,- Evita permanecer sentada demasiado tiempo,- Lleva ropa cómoda y suelta",
          ),
        ],
      ),
      ArticuloContenido(
        id: "24",
        titulo: "Cuidado del cuerpo y la piel durante el embarazo",
        descripcion:
            "Aprende a cuidar tu piel y tu cuerpo durante la gestación para prevenir molestias y problemas comunes.",
        imagen:
            "https://www.clikisalud.net/wp-content/uploads/2018/05/consejos-para-cuidar-la-piel-durante-el-embarazo.jpg",
        fuente: "TV Perú / Profesionales de salud",
        tags: ["embarazo", "salud", "cuidado", "fisico", "saludable", "piel"],
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Cuidado del cuerpo y la piel durante el embarazo",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Durante el embarazo, la piel se vuelve más sensible y pueden aparecer cambios como estrías, acné o pigmentación.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.lista,
            valor:
                "Cuidados recomendados:,- Hidratar la piel diariamente,- Aplicar protector solar al salir,- Evitar productos con químicos agresivos",
          ),
          ContenidoBloque(
            tipo: TipoBloque.tip,
            valor:
                "Usa cremas suaves y ricas en vitamina E o aceites naturales. Prefiere duchas con agua tibia, no caliente.",
          ),
        ],
      ),
    ],
  ),

  // ================= PREPARACION PARA EL PARTO =================
  TemaContenido(
    titulo: "Preparación para el parto",
    imagen:
        "https://www.fisanfisioterapia.es/wp-content/uploads/2020/02/otra-1024x682.jpg",
    descripcion:
        "Información necesario para la madre para planificar su pronto parto",
    categoria: "Embarazo",
    articulos: [
      ArticuloContenido(
        id: "25",
        titulo: "Señales de inicio del parto",
        descripcion:
            "Conoce cómo identificar cuándo el trabajo de parto está comenzando.",
        imagen:
            "https://wl-genial.cf.tsp.li/resize/1200x630/jpg/e6d/9aa/dc44215183b436642f06fa4a2d.jpg",
        fuente:
            "Adaptado de Mayo Clinic y recomendaciones generales de trabajo de parto",
        tags: ["embarazo", "salud", "señales", "parto"],
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "¿Cómo saber si está empezando el parto?",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "El trabajo de parto suele iniciar con contracciones regulares y progresivas que hacen que el cuello uterino se dilate y se ablande, preparándose para el nacimiento.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.lista,
            valor:
                "Contracciones frecuentes y regulares,Expulsión del tapón mucoso,Pérdida de líquido amniótico o \"romper fuente\",Dolor de espalda baja persistente",
          ),
          ContenidoBloque(
            tipo: TipoBloque.tip,
            valor:
                "Es normal sentir contracciones leves al inicio; si son regulares y cada vez más intensas, es momento de comunicarse con tu profesional de salud.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.advertencia,
            valor:
                "Si el líquido sale con un olor fuerte o hay sangrado abundante, acude de inmediato al establecimiento de salud.",
          ),
        ],
      ),
      ArticuloContenido(
        id: "26",
        titulo: "Qué llevar al hospital para el parto",
        descripcion:
            "Lista de artículos recomendados para la mamá y el bebé cuando vayas al centro de salud.",
        imagen:
            "https://ginecologoscdmx.com/wp-content/uploads/2021/07/maleta-hospital.jpg",
        fuente: "Recomendaciones del Instituto Nacional Materno Perinatal",
        tags: [
          "embarazo",
          "salud",
          "hospital",
          "parto",
          "maletin",
          "utencilios",
        ],
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Qué llevar al hospital para el parto",
          ),
          ContenidoBloque(
            tipo: TipoBloque.lista,
            valor:
                "Documento de identidad (DNI),Tarjeta de control prenatal,Historia clínica o exámenes recientes",
          ),
          ContenidoBloque(tipo: TipoBloque.titulo, valor: "Para la mamá"),
          ContenidoBloque(
            tipo: TipoBloque.lista,
            valor:
                "Útiles de aseo personal (jabón, cepillo y pasta de dientes),Bata y sandalias cómodas,Pañales para la mamá",
          ),
          ContenidoBloque(tipo: TipoBloque.titulo, valor: "Para el bebé"),
          ContenidoBloque(
            tipo: TipoBloque.lista,
            valor:
                "Pañales para recién nacido,Ropa cómoda para el bebé,Manta o cobijas según clima",
          ),
          ContenidoBloque(
            tipo: TipoBloque.tip,
            valor:
                "Prepara tu bolsa de parto unas 3–4 semanas antes de la fecha probable de nacimiento.",
          ),
        ],
      ),
      ArticuloContenido(
        id: "27",
        titulo: "Tipos de parto",
        descripcion:
            "Aprende las diferencias entre los principales tipos de parto.",
        imagen:
            "https://partonaturalmadrid.es/wp-content/uploads/2022/08/Tipos-de-parto-vaginal-2.png",
        fuente:
            "Guías de práctica clínica y recursos médicos sobre tipos de parto",
        tags: ["embarazo", "salud", "tipos", "parto", "diferencia"],
        bloques: [
          ContenidoBloque(tipo: TipoBloque.titulo, valor: "Tipos de parto"),
          ContenidoBloque(tipo: TipoBloque.titulo, valor: "Parto vaginal"),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Es el nacimiento del bebé a través del canal vaginal de la madre, generalmente con recuperación más rápida y menor hospitalización.",
          ),
          ContenidoBloque(tipo: TipoBloque.titulo, valor: "Parto por cesárea"),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Es una intervención quirúrgica en la que el bebé nace a través de una incisión en el abdomen. Puede ser programada o de emergencia.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Parto respetado o humanizado",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Es el que privilegia las decisiones de la madre, donde se evita la intervención médica innecesaria y se respeta su voluntad y bienestar.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.tip,
            valor:
                "La decisión del tipo de parto debe ser tomada siempre con tu equipo médico, según tu estado de salud y el bienestar del bebé.",
          ),
        ],
      ),
      ArticuloContenido(
        id: "28",
        titulo: "Plan de parto",
        descripcion:
            "Qué es un plan de parto y cómo ayuda a anticipar tus decisiones antes del nacimiento.",
        imagen:
            "https://dondeparir.com/wp-content/uploads/2022/03/istock-516071104.jpg",
        fuente: "Modelo general de plan de parto y recomendaciones médicas",
        tags: ["embarazo", "salud", "plan", "parto"],
        bloques: [
          ContenidoBloque(tipo: TipoBloque.titulo, valor: "Tu plan de parto"),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Un plan de parto es un documento donde tú y tu equipo de salud establecen tus preferencias para el momento del nacimiento.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Qué incluye un plan de parto",
          ),
          ContenidoBloque(
            tipo: TipoBloque.lista,
            valor:
                "Preferencias sobre quién te acompaña\nTipo de analgesia deseado o no deseado\nPosiciones para el parto\nExpectativas sobre la atención",
          ),
          ContenidoBloque(
            tipo: TipoBloque.tip,
            valor:
                "Habla de tu plan con tu médico o matrona durante los controles prenatales para ajustarlo según tu salud y la evolución del embarazo.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.advertencia,
            valor:
                "Un plan de parto puede modificarse en cualquier momento si hay una necesidad médica urgente.",
          ),
        ],
      ),
    ],
  ),

  // ================ COMO INICIAR LACTANCIA =================
  TemaContenido(
    titulo: "Como iniciar la lactancia",
    imagen: "https://i.blogs.es/f1e196/1366_2000/450_1000.jpeg",
    descripcion: "Guía esencial para iniciar la lactancia correctamente.",
    categoria: "Lactancia",
    articulos: [
      ArticuloContenido(
        id: "29",
        titulo: "Beneficios de la lactancia materna",
        descripcion:
            "Descubre cómo la lactancia materna favorece la salud del bebé y aporta beneficios a la madre.",
        imagen:
            "https://media.licdn.com/dms/image/v2/D4E12AQEu16QGpx67og/article-cover_image-shrink_720_1280/article-cover_image-shrink_720_1280/0/1722619590930?e=2147483647&v=beta&t=FNgMVETbfV5le0eqfy6ZQDEnvXaiA5fhKuCx7enlZQo",
        fuente: "Ministerio de Salud del Perú y UNICEF",
        tags: [
          "lactancia",
          "beneficios",
          "madre",
          "bebé",
          "salud"
              "nutrición",
        ],
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Importancia para el bebé",
          ),
          ContenidoBloque(
            tipo: TipoBloque.lista,
            valor:
                "• Aporta todos los nutrientes esenciales durante los primeros 6 meses.\n• Contiene anticuerpos que protegen contra infecciones y enfermedades.\n• Favorece el desarrollo del sistema digestivo y neurológico.\n• Ayuda a prevenir alergias, obesidad y enfermedades crónicas en el futuro.\n• Promueve el vínculo afectivo y la seguridad emocional.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Importancia para la madre",
          ),
          ContenidoBloque(
            tipo: TipoBloque.lista,
            valor:
                "• Favorece la recuperación postparto y ayuda a reducir el riesgo de hemorragias.\n• Contribuye a perder peso ganado durante el embarazo de manera saludable.\n• Reduce el riesgo de cáncer de mama y ovario.\n• Fortalece el vínculo emocional con el bebé.\n• Genera sensación de satisfacción y bienestar al alimentar a tu hijo.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.tip,
            valor:
                "Tip: La lactancia materna exclusiva durante los primeros 6 meses garantiza la mejor nutrición y protección para tu bebé.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.advertencia,
            valor:
                "Advertencia: Evita reemplazar la leche materna con fórmulas sin indicación médica durante los primeros 6 meses. Consulta siempre con un profesional de salud si hay dudas sobre la alimentación del bebé.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "La lactancia materna no solo es un alimento, sino también un acto de protección y amor que beneficia tanto al bebé como a la madre, fortaleciendo su salud y vínculo emocional.",
          ),
        ],
      ),
      ArticuloContenido(
        id: "30",
        titulo: "Alimentación del recién nacido en sus primeros días",
        imagen:
            "https://clubmamasypapas.com/media/mageplaza/blog/post/m/e/mejores-tecnicas-y-consejos-para-una-lactancia-materna-efectiva.jpg",
        descripcion:
            "Durante los primeros días de vida, los recién nacidos necesitan alimentarse con frecuencia para mantenerse hidratados y recibir los nutrientes necesarios.",
        fuente: "Ministerio de Salud del Perú",
        tags: ["madre", "bebe", "lactancia", "leche materna", "primero dias"],
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Frecuencia de la alimentación",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Durante los primeros días, los recién nacidos necesitan alimentarse con frecuencia para mantenerse hidratados y recibir los nutrientes esenciales. La mayoría se alimenta cada 2 a 3 horas, aunque algunos pueden requerir más frecuencia.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "La leche materna: alimento ideal",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "La leche materna contiene todos los nutrientes necesarios y anticuerpos que protegen al bebé de enfermedades. Es el alimento recomendado durante los primeros meses de vida.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.lista,
            valor:
                "Señales de hambre del bebé:,• Llevarse las manos a la boca,• Mover la cabeza buscando el pecho,• Hacer sonidos o movimientos inquietos,• Chuparse los labios o emitir pequeños gemidos",
          ),
          ContenidoBloque(
            tipo: TipoBloque.tip,
            valor:
                "Tip: Intenta alimentar al bebé antes de que llore, esto facilita que la lactancia sea más tranquila y efectiva.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.advertencia,
            valor:
                "Advertencia: Si notas que tu bebé no se alimenta bien, no gana peso o tiene signos de deshidratación, consulta inmediatamente con un profesional de salud.",
          ),
        ],
      ),
      ArticuloContenido(
        id: "31",
        titulo: "La importancia de la lactancia frecuente",
        imagen:
            "https://www.materna.com.ar/Portals/0/images/articulos/bebe/bebe-3456-preparacion-para-la-lactancia-147309906.jpg",
        descripcion:
            "Mantener la lactancia frecuente asegura que el bebé reciba los nutrientes necesarios y ayuda a establecer una producción de leche adecuada.",
        fuente: "Ministerio de Salud del Perú",
        tags: [
          "madre",
          "bebe",
          "lactancia",
          "leche materna",
          "primero dias",
          "frecuente",
        ],
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "¿Por qué es importante la lactancia frecuente?",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Durante las primeras semanas de vida, la lactancia frecuente es fundamental para el bienestar del bebé y para establecer correctamente la producción de leche materna. Además, fortalece el vínculo afectivo entre madre e hijo.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Recomendaciones prácticas",
          ),
          ContenidoBloque(
            tipo: TipoBloque.lista,
            valor:
                "• Alimenta al bebé cada 2–3 horas o según sus señales de hambre.\n• Observa signos de hambre como succión de manos, movimientos inquietos o búsqueda del pecho.\n• Asegúrate de que el bebé se prenda correctamente al pecho.\n• Alterna ambos pechos durante cada toma para estimular la producción de leche.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.tip,
            valor:
                "Tip: No esperes a que el bebé llore para alimentarlo. Atender sus señales tempranas de hambre facilita una lactancia más tranquila y efectiva.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.advertencia,
            valor:
                "Advertencia: Si notas que el bebé no gana peso, tiene pocas evacuaciones o parece insatisfecho después de cada toma, consulta con un profesional de salud o especialista en lactancia.",
          ),
        ],
      ),
      ArticuloContenido(
        id: "32",
        titulo: "Importancia del ácido fólico durante el embarazo",

        imagen:
            "https://doihojqqs770p.cloudfront.net/articulos/articulos-171153-1200x675.jpg",
        descripcion:
            "El ácido fólico es uno de los nutrientes más importantes durante las primeras etapas del embarazo, ya que ayuda al desarrollo adecuado del cerebro y la columna vertebral del bebé.",
        fuente: "Ministerio de Salud del Perú",
        tags: ["madre", "bebe", "lactancia", "acido folico", "embarazo"],
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "¿Qué es el ácido fólico?",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "El ácido fólico es una vitamina del complejo B que cumple un papel fundamental en la formación del sistema nervioso del bebé. Ayuda a prevenir defectos del tubo neural, que pueden afectar el cerebro o la médula espinal.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "¿Por qué es importante durante el embarazo?",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Durante las primeras semanas del embarazo, el cuerpo necesita mayores cantidades de ácido fólico para asegurar un desarrollo adecuado del cerebro y la columna vertebral del bebé. Por eso, se recomienda empezar a tomarlo incluso antes de quedar embarazada.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.lista,
            valor:
                "Alimentos ricos en ácido fólico:,• Espinaca,• Brócoli,• Lentejas,• Palta,• Cereales fortificados",
          ),
          ContenidoBloque(
            tipo: TipoBloque.tip,
            valor:
                "Tip: Combina alimentos naturales con suplementos según las indicaciones de tu médico para asegurar la cantidad necesaria de ácido fólico.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.advertencia,
            valor:
                "Advertencia: No tomes dosis altas de suplementos sin supervisión médica, ya que un exceso también puede ser perjudicial.",
          ),
        ],
      ),
    ],
  ),

  // ================ TECNICAS Y POSICIONES CORRECTAS =================
  TemaContenido(
    titulo: "Técnicas y posiciones correctas",
    imagen: "https://bhealthy.es/wp-content/uploads/2023/03/1-3.jpg",
    descripcion:
        "Información sobre las tecnicas y posiciones correctas en la lactancia",
    categoria: "Lactancia",
    articulos: [
      ArticuloContenido(
        id: "33",
        titulo: "Posición correcta al amamantar",
        imagen:
            "https://static.guiainfantil.com/uploads/Alimentacin/posicionamamantar-p.jpg",
        descripcion:
            "Una postura correcta evita dolor, facilita la succión y asegura que el bebé reciba suficiente leche.",
        fuente: "Adaptado de Ministerio de Salud del Perú (MINSA) y OMS",
        tags: [
          "lactancia",
          "posición correcta",
          "amamantar",
          "madres primerizas",
          "bebe",
          "salud",
        ],
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Importancia de la posición correcta",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Una postura correcta ayuda a evitar dolor en los pezones y espalda, facilita que el bebé succione adecuadamente y asegura que reciba suficiente leche.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Señales de una buena posición",
          ),
          ContenidoBloque(
            tipo: TipoBloque.lista,
            valor:
                "Boca del bebé cubriendo areola y pezón correctamente,Cabeza, cuello y espalda alineados,Cuerpo del bebé cerca del tuyo, no solo la cabeza,Boca abierta y labios evertidos hacia fuera,Oreja, hombro y cadera del bebé en línea recta",
          ),
          ContenidoBloque(
            tipo: TipoBloque.imagen,
            valor:
                "https://smartmedia.digital4danone.com/is/image/danonecs/guide-to-breastfeeding-LATAM?ts=1742213864823&dpr=off",
          ),
          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Posiciones recomendadas",
          ),
          ContenidoBloque(
            tipo: TipoBloque.lista,
            valor:
                "Posición cuna: bebé apoyado en tu antebrazo,Posición balón de rugby: bebé a tu lado, bajo tu brazo,Posición tumbada: útil si estás cansada o en recuperación postparto",
          ),
          ContenidoBloque(
            tipo: TipoBloque.tip,
            valor:
                "Usa cojines o almohadas para apoyar tu espalda y brazos, así reduces tensión y haces la lactancia más cómoda.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.advertencia,
            valor:
                "Si sientes dolor intenso en los pezones, grietas o el bebé no succiona correctamente, busca ayuda de un profesional de salud o una consultora en lactancia.",
          ),
          ContenidoBloque(tipo: TipoBloque.titulo, valor: "Alterna los pechos"),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Durante cada toma, cambia de pecho al menos una vez. Esto ayuda a estimular la producción de leche y evita que un pecho quede más vacío que el otro.",
          ),
        ],
      ),
      ArticuloContenido(
        id: "34",
        titulo: "Estimular la succión del bebé",
        imagen:
            "https://www.efisioterapia.net/sites/default/files/imagen_articulos/succion.png",
        descripcion:
            "Aprende cómo ayudar a tu bebé a succionar de forma efectiva durante la lactancia, asegurando buena alimentación y digestión.",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Importancia de la succión efectiva",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Una succión adecuada garantiza que el bebé reciba suficiente leche, favorece su digestión y ayuda a estimular la producción de leche en la madre.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Señales de que tu bebé necesita ayuda",
          ),
          ContenidoBloque(
            tipo: TipoBloque.lista,
            valor:
                "Se separa frecuentemente del pecho\nSe muestra cansado o frustrado\nNo traga con regularidad\nLlora o muestra inquietud durante la toma",
          ),
          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Cómo estimular la succión",
          ),
          ContenidoBloque(
            tipo: TipoBloque.lista,
            valor:
                "Masajea suavemente mandíbula y mejillas\nMantén contacto visual y verbal para tranquilizar al bebé\nOfrece pausas breves para evitar fatiga y cólicos\nAjusta la posición del bebé para un mejor agarre",
          ),
          ContenidoBloque(
            tipo: TipoBloque.imagen,
            valor:
                "https://www.fisioterapia-online.com/sites/default/files/estimulacion_de_la_succion_en_el_bebe.jpg",
          ),
          ContenidoBloque(
            tipo: TipoBloque.tip,
            valor:
                "Si el bebé se cansa, no lo obligues; dale unos segundos y retoma la lactancia. Esto mejora la experiencia y previene frustración.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.advertencia,
            valor:
                "Si tu bebé tiene dificultades persistentes para succionar, no aumenta de peso o muestra signos de deshidratación, consulta inmediatamente a un profesional de salud o consultora en lactancia.",
          ),
        ],
      ),
      ArticuloContenido(
        id: "35",
        titulo: "Agarre correcto y señales de succión efectiva",
        descripcion:
            "Aprende a identificar si tu bebé está prendido correctamente del pecho para una lactancia cómoda y efectiva.",
        imagen:
            "https://82f3b26b2c.cbaul-cdnwnd.com/f12bc78a0f37f2a5c4ba536eaadf9160/200000000-1260013596/700/b21528_55588a8023d540c0977c92f9763b2ee3.jpg?ph=82f3b26b2c",
        fuente: "Adaptado de MINSA y OMS sobre lactancia materna",
        tags: [
          "lactancia",
          "agarre correcto",
          "succión efectiva",
          "bebé",
          "prevención problemas",
          "salud",
        ],
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Importancia del agarre correcto",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Un buen agarre ayuda a evitar dolor en los pezones, previene grietas y asegura que el bebé reciba suficiente leche. Además, estimula la producción de leche de manera efectiva.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Señales de un buen agarre",
          ),
          ContenidoBloque(
            tipo: TipoBloque.lista,
            valor:
                "Labios evertidos (hacia afuera),Mentón tocando el pecho,Nariz libre para respirar,Movimientos rítmicos y constantes de succión,Mejillas redondas y llenas durante la succión",
          ),
          ContenidoBloque(
            tipo: TipoBloque.imagen,
            valor: "https://www.lactancia.org/images/agarre_visual.jpg",
          ),
          ContenidoBloque(
            tipo: TipoBloque.tip,
            valor:
                "Si sientes dolor o notas grietas en los pezones, reajusta la posición del bebé antes de continuar la toma.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.advertencia,
            valor:
                "Si el dolor persiste, hay grietas profundas o el bebé no se alimenta correctamente, consulta a un profesional de salud o consultora en lactancia.",
          ),
        ],
      ),
    ],
  ),

  // ================ COMO SABER SI EL BEBÉ SE ALIMENTA BIEN =================
  TemaContenido(
    titulo: "Como saber si el bebé se alimenta bien",
    imagen:
        "https://www.materna.com.ar/Portals/0/images/articulos/bebe/bebe-20161-como-saber-si-se-esta-alimentando-bien-157624374.jpg",
    descripcion:
        "Guía de conocimientos basicos e información necesario para saber sobre la alimentacion de tu bebé",
    categoria: "Lactancia",
    articulos: [
      ArticuloContenido(
        id: "36",
        titulo: "Señales de que el bebé se alimenta bien",
        descripcion:
            "Aprende a identificar si tu bebé está recibiendo suficiente leche y alimentándose correctamente.",
        imagen:
            "https://clubmamasypapas.com/media/mageplaza/blog/post/t/u/tu-leche-materna-es-su-mejor-alimento-5.jpg",
        fuente: "Adaptado de MINSA y OMS sobre lactancia materna",
        tags: [
          "lactancia",
          "alimentación",
          "bebé",
          "señales de succión",
          "monitoreo",
          "salud",
        ],
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Señales durante la lactancia",
          ),
          ContenidoBloque(
            tipo: TipoBloque.lista,
            valor:
                "Boca bien prendida al pecho, labios evertidos,Succión rítmica y constante,Tragar con regularidad,Manos y piernas relajadas, no rígidas",
          ),
          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Señales después de la lactancia",
          ),
          ContenidoBloque(
            tipo: TipoBloque.lista,
            valor:
                "Número suficiente de pañales mojados (6–8/día),Deposiciones frecuentes y consistentes,Aumento de peso adecuado,Comportamiento tranquilo y alerta",
          ),
          ContenidoBloque(
            tipo: TipoBloque.tip,
            valor:
                "Lleva un registro de pañales y tomas para monitorear la alimentación de tu bebé de forma efectiva.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.advertencia,
            valor:
                "Si el bebé muestra letargo, poca succión o pérdida de peso, consulta de inmediato a un profesional de salud.",
          ),
        ],
      ),
      ArticuloContenido(
        id: "37",
        titulo: "Problemas frecuentes en la alimentación del bebé",
        descripcion:
            "Identifica los signos de posibles dificultades de alimentación y aprende cuándo buscar ayuda profesional.",
        imagen:
            "https://smartmedia.digital4danone.com/is/image/danonecs/crying-newborn-in-mums-arms-1?ts=1693838627048&dpr=off",
        fuente: "Adaptado de MINSA y OMS sobre lactancia materna",
        tags: ["lactancia", "problemas", "alimentación", "bebé", "succión"],
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Dificultades comunes",
          ),
          ContenidoBloque(
            tipo: TipoBloque.lista,
            valor:
                "Succión débil o interrumpida,Llanto frecuente durante la toma,Poca producción de pañales mojados o secos,Letargo o irritabilidad",
          ),
          ContenidoBloque(tipo: TipoBloque.titulo, valor: "Qué hacer"),
          ContenidoBloque(
            tipo: TipoBloque.lista,
            valor:
                "Revisa la posición y agarre del bebé,Estimula la succión con pausas o masajes suaves,Ofrece ambos pechos en cada toma,Monitorea la frecuencia de tomas y pañales",
          ),
          ContenidoBloque(
            tipo: TipoBloque.advertencia,
            valor:
                "Si el bebé no gana peso, presenta signos de deshidratación o muestra dificultades persistentes para alimentarse, acude inmediatamente a un profesional de salud o consultora en lactancia.",
          ),
        ],
      ),
      ArticuloContenido(
        id: "38",
        titulo: "Frecuencia y duración de las tomas",
        descripcion:
            "Aprende cuántas veces y cuánto tiempo debe alimentarse tu bebé para asegurarte de que recibe suficiente leche.",
        imagen: "https://bebe.consumer.es/wp-content/uploads/Duraciontomas.jpg",
        fuente: "Adaptado de MINSA y OMS sobre lactancia materna",
        tags: ["lactancia", "tomas", "frecuencia", "duración", "bebé"],
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Importancia de la frecuencia y duración",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "El número de tomas y la duración de cada una son indicadores clave de que tu bebé se alimenta bien y que tu producción de leche se ajusta a sus necesidades.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Frecuencia recomendada",
          ),
          ContenidoBloque(
            tipo: TipoBloque.lista,
            valor:
                "Recién nacidos: 8–12 tomas por 24 horas,Bebés de 1–2 meses: 7–10 tomas por 24 horas,A medida que crecen, algunas tomas se espacian según necesidades individuales",
          ),
          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Duración de cada toma",
          ),
          ContenidoBloque(
            tipo: TipoBloque.lista,
            valor:
                "Promedio de 10–20 minutos por pecho,Algunos bebés pueden necesitar más tiempo si están cansados o recién iniciando,Permite que el bebé decida cuándo soltar el pecho",
          ),
          ContenidoBloque(
            tipo: TipoBloque.tip,
            valor:
                "Observa señales de saciedad: el bebé se suelta solo, está relajado, satisfecho y tranquilo después de la toma.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.advertencia,
            valor:
                "Si tu bebé siempre parece hambriento, se muestra irritable, somnoliento o no gana peso, consulta de inmediato a un profesional de salud.",
          ),
        ],
      ),
    ],
  ),

  // ================ PROBLEMAS FRECUENTES Y SOLUCIONES =================
  TemaContenido(
    titulo: "Problemas frecuentes y soluciones",
    imagen:
        "https://res.cloudinary.com/dqqhqnbny/image/upload/v1771547695/images_1_axk2io.jpg",
    descripcion:
        "Guía sobre los problemas más frecuentes que enfrentan las madres primerizas durante la lactancia y cómo abordarlos.",
    categoria: "Lactancia",
    articulos: [
      ArticuloContenido(
        id: "39",
        titulo: "Pezones adoloridos o agrietados",
        imagen:
            "https://drbrowns.es/wp-content/uploads/2022/03/grietas-800x532.jpg", // Reemplaza con tu imagen
        descripcion:
            "Dolor o grietas en los pezones durante los primeros días de lactancia.",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: """
            El dolor en los pezones es común al inicio de la lactancia, especialmente si el bebé no se engancha correctamente.  

            Para aliviarlo:  
            • Asegúrate de que el bebé abra bien la boca y tome suficiente areola.  
            • Cambia de posición al amamantar para evitar presión en la misma zona.  
            • Aplica compresas de leche materna o cremas especiales para pezones.  

            Si el dolor persiste, consulta con un especialista en lactancia.
            """,
          ),
        ],
      ),
      ArticuloContenido(
        id: "40",
        titulo: "Mastitis o inflamación del pecho",
        imagen:
            "https://clinicarisso.com/wp-content/uploads/2025/09/Mastitis.jpg",
        descripcion:
            "Inflamación del tejido mamario que puede causar dolor, enrojecimiento y fiebre.",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: """
            La mastitis suele ocurrir cuando hay conductos bloqueados o infección.  

            Para prevenirla o tratarla:  
            • Amamanta frecuentemente al bebé, asegurando vaciar bien cada pecho.  
            • Aplica calor antes de amamantar para facilitar el flujo de leche.  
            • Masajea suavemente las áreas duras para descongestionar.  

            Consulta al médico si hay fiebre alta o dolor intenso.
            """,
          ),
        ],
      ),
      ArticuloContenido(
        id: "41",
        titulo: "Baja producción de leche",
        imagen:
            "https://carmensancho.es/wp-content/uploads/2023/04/Sin-titulo-750-%C3%97-500-px-3.png",
        descripcion:
            "Sensación de que la producción de leche no es suficiente para el bebé.",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: """
            La producción de leche puede variar según la frecuencia de lactancia y la técnica de succión.  

            Recomendaciones:  
            • Amamanta a demanda, al menos 8-12 veces al día.  
            • Evita lactancia con horarios estrictos al inicio.  
            • Mantente hidratada y bien alimentada.  
            • Considera extraer leche con sacaleches si el bebé no vacía el pecho completamente.  

            Si persiste la preocupación, consulta con un especialista en lactancia.
            """,
          ),
        ],
      ),
      ArticuloContenido(
        id: "42",
        titulo: "Infecciones como candidiasis",
        imagen:
            "https://www.clinicaferrusbratos.com/app/uploads/que-es-la-candidiasis-oral-822x513.jpg",
        descripcion:
            "Infección por hongos que puede afectar pezones y boca del bebé.",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: """
            La candidiasis puede causar pezones doloridos, con picazón o descamación, y el bebé puede tener lengua blanca o irritación bucal.  

            Para tratarla:  
            • Lava bien los pezones y esteriliza biberones y chupetes.  
            • Consulta con tu médico para aplicar antifúngicos seguros durante la lactancia.  
            • Mantén la lactancia, ya que suspenderla puede empeorar la infección.  
            """,
          ),
        ],
      ),
    ],
  ),

  // ================ ALIMENTACION Y CUIDADOS DE LA MADRE =================
  TemaContenido(
    titulo: "Alimentacion y cuidados de la madre",
    imagen:
        "https://bebe.consumer.es/wp-content/uploads/Cuidados-madre-lactancia-scaled.jpg",
    descripcion: "Artículos de alimentación de la madre",
    categoria: "Lactancia",
    articulos: [
      ArticuloContenido(
        id: "43",
        titulo: "Nutrición de la madre durante la lactancia",
        descripcion:
            "Alimentarse bien durante la lactancia es clave para producir suficiente leche y mantener tu energía.",
        imagen: "https://www.panolini.com/wp-content/uploads/2024/01/DIETA.jpg",
        fuente: "Adaptado de MINSA y OMS sobre lactancia materna",
        tags: ["lactancia", "alimentación", "madre", "nutrición", "cuidado"],
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Alimentos recomendados",
          ),
          ContenidoBloque(
            tipo: TipoBloque.lista,
            valor:
                "Frutas y verduras frescas,Proteínas: carne magra, huevo, legumbres,Cereales integrales,Lácteos bajos en grasa,Agua suficiente (8–10 vasos/día)",
          ),
          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Alimentos a moderar",
          ),
          ContenidoBloque(
            tipo: TipoBloque.lista,
            valor:
                "Azúcares refinados,Comida ultraprocesada,Cafeína en exceso,Alcohol y tabaco",
          ),
          ContenidoBloque(
            tipo: TipoBloque.tip,
            valor:
                "Planifica comidas pequeñas y frecuentes para mantener niveles de energía estables.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.advertencia,
            valor:
                "Si presentas pérdida de apetito, fatiga extrema o síntomas de desnutrición, consulta a un nutricionista o médico.",
          ),
        ],
      ),
      ArticuloContenido(
        id: "44",
        titulo: "Hidratación y descanso",
        descripcion:
            "Mantenerse hidratada y descansar adecuadamente ayuda a la producción de leche y al bienestar de la madre.",
        imagen:
            "https://unaqua.es/wp-content/uploads/2023/02/Diseno-sin-titulo.jpg",
        fuente: "Adaptado de MINSA y OMS sobre lactancia materna",
        tags: ["lactancia", "hidratación", "descanso", "madre", "cuidado"],
        bloques: [
          ContenidoBloque(tipo: TipoBloque.titulo, valor: "Hidratación"),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Bebe agua durante todo el día, antes y después de cada toma. Los líquidos ayudan a mantener la producción de leche y previenen la fatiga.",
          ),
          ContenidoBloque(tipo: TipoBloque.titulo, valor: "Descanso"),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Duerme cuando tu bebé duerma. Pequeñas siestas pueden mejorar tu energía y bienestar mental. Evita sobrecargarte con tareas innecesarias.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.tip,
            valor:
                "Pide ayuda a familiares para tomar descansos y alimentarte bien, sobre todo durante las primeras semanas.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.advertencia,
            valor:
                "La falta de sueño prolongada puede afectar tu salud y la producción de leche. Si presentas fatiga extrema, acude a un profesional de salud.",
          ),
        ],
      ),
      ArticuloContenido(
        id: "45",
        titulo: "Actividad física y cuidados personales",
        descripcion:
            "Ejercicios suaves y cuidados diarios ayudan a la recuperación postparto y al bienestar de la madre durante la lactancia.",
        imagen: "https://www.lactancia.org/images/actividad_fisica.jpg",
        fuente: "Adaptado de MINSA y OMS sobre lactancia materna",
        tags: [
          "lactancia",
          "actividad física",
          "cuidados",
          "madre",
          "postparto",
        ],
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Actividad física recomendada",
          ),
          ContenidoBloque(
            tipo: TipoBloque.lista,
            valor:
                "Caminatas cortas,Estiramientos suaves,Ejercicios postparto supervisados,Yoga o respiración consciente",
          ),
          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Cuidados personales",
          ),
          ContenidoBloque(
            tipo: TipoBloque.lista,
            valor:
                "Higiene adecuada de pezones y pechos,Ropa cómoda y sujetadores de lactancia,Control del estrés y bienestar emocional",
          ),
          ContenidoBloque(
            tipo: TipoBloque.tip,
            valor:
                "Empieza con rutinas suaves y aumenta progresivamente según tu energía y recuperación postparto.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.advertencia,
            valor:
                "Evita ejercicios intensos sin supervisión durante las primeras semanas si tu médico no lo ha autorizado.",
          ),
        ],
      ),
    ],
  ),

  // ================ LACTANCIA MATERNA =================
  TemaContenido(
    titulo: "Lactancia materna",
    imagen:
        "https://www.losconsejosdetumatrona.com/wp-content/uploads/2021/03/03-01-Recien-Nacido.jpg",
    descripcion: "Cuidados basicos para el bebé en la lactancia para el bebé",
    categoria: "Cuidados del bebé",
    articulos: [
      ArticuloContenido(
        id: "46",
        titulo: "Alimentar al bebé cada 2-3 horas",
        descripcion:
            "Alimenta a tu bebé frecuentemente para estimular la producción de leche y favorecer su crecimiento saludable.",
        imagen:
            "https://www.enfamil.es/cdn/shop/articles/Mejores_horas_comida_biberon_bebe_1200x.jpg?v=1568707531",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: """
            La lactancia frecuente es fundamental durante los primeros días y semanas. Alimentar a tu bebé cada 2-3 horas:

            • Estimula la producción de leche materna.
            • Ayuda a regular la temperatura y azúcar en sangre del bebé.
            • Favorece la digestión y disminuye el riesgo de cólicos.

            Observa las señales de hambre del bebé: movimientos de succión, llevarse las manos a la boca, inquietud o llanto.  

            Recuerda: cada bebé es diferente, pero la regla general es ofrecer el pecho o biberón al menos cada 2-3 horas durante el día y la noche.
            """,
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: """
            Consejos prácticos:

            1. Mantén un registro de las tomas para identificar patrones.
            2. Alterna ambos pechos si estás amamantando.
            3. Si usas biberón, asegúrate de que la tetina tenga flujo adecuado.
            4. Mantén siempre contacto piel con piel durante y después de la alimentación.
            5. Relájate y aprovecha para hablarle o cantarle al bebé mientras come.
            """,
          ),
          ContenidoBloque(
            tipo: TipoBloque.imagen,
            valor:
                "https://images.ctfassets.net/2ql69mthp94m/7qtu1Jmzj9KcsDXCNqloUJ/83e504462e75fd785dd3b3c45eaf4bac/A80.jpeg",
          ),
        ],
      ),
      ArticuloContenido(
        id: "47",
        titulo: "Lactancia exclusiva si aplica",
        imagen:
            "https://www.unicef.org/venezuela/sites/unicef.org.venezuela/files/styles/open_graph_image/public/QTA.%20SAN%20PEDRO-39_2.jpg.jpeg?itok=aasXcS3l",
        descripcion:
            "Evita dar agua, jugos o alimentos sólidos durante los primeros 6 meses. La leche materna cubre todas las necesidades del bebé.",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: """
            La lactancia exclusiva durante los primeros 6 meses es fundamental para:

            • Proveer todos los nutrientes esenciales.
            • Fortalecer el sistema inmunológico.
            • Favorecer el desarrollo cognitivo y físico del bebé.
            • Establecer un vínculo afectivo cercano con la madre.

            No es necesario dar agua o infusiones al bebé si está alimentándose correctamente con leche materna.
            """,
          ),
          ContenidoBloque(
            tipo: TipoBloque.imagen,
            valor:
                "https://cloudfront-us-east-1.images.arcpublishing.com/infobae/ZAMJEPAUSVAQZNVEFCEEJWYW2I.jpg",
          ),
        ],
      ),
      ArticuloContenido(
        id: "48",
        titulo: "Registrar tomas",
        imagen:
            "https://www.nestlefamilynes.com.mx/sites/default/files/styles/content_media_mobile/public/2021-03/como_bebe_hambre_satisfecho.jpg?itok=ZMj5lkDl",
        descripcion:
            "Llevar un registro ayuda a identificar patrones de hambre y horas de sueño, optimizando la alimentación y descanso.",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: """
            Registrar las tomas te permitirá:

            • Saber cuánto y cada cuánto come el bebé.
            • Detectar posibles problemas de alimentación o digestión.
            • Organizar mejor tus tiempos de descanso y tus rutinas.
            • Compartir información precisa con el pediatra si surge alguna duda.
            """,
          ),
          ContenidoBloque(
            tipo: TipoBloque.imagen,
            valor:
                "https://www.nestlebebe.es/sites/default/files/styles/content_media_mobile/public/field/image/your_babys_hunger_and_fullness_signs_02_learn_is_he_hungry.jpg?h=e600c7d0&itok=ZcPtRbPG",
          ),
        ],
      ),
    ],
  ),

  // ================= HIGIENE Y BAÑO =================
  TemaContenido(
    titulo: "Higiene y Baño",
    imagen:
        "https://biotexcom.es/wp-content/uploads/2018/11/consejos-practicos-para.jpg",
    descripcion: "Guía para mantener la higiene y cuidado del recién nacido.",
    categoria: "Cuidados del bebé",
    articulos: [
      ArticuloContenido(
        id: "49",
        titulo: "Limpieza del cordón umbilical",
        imagen:
            "https://portalwinnyprod.blob.core.windows.net/portal-winny-prod/images/Cuidado_del_cordon_umbilical_luego_del_nacimien.original_qIvslXb.jpg",
        descripcion:
            "Mantén el cordón limpio y seco hasta que caiga por sí solo para prevenir infecciones.",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: """
            Recomendaciones para la limpieza del cordón:

            • Lava tus manos antes de tocar el cordón.
            • Limpia con algodón humedecido en alcohol o solución indicada por tu pediatra.
            • Evita cubrir el cordón con pañales; dobla la parte superior para que quede al aire.
            • No tires del cordón, deja que caiga naturalmente.
            """,
          ),
          ContenidoBloque(
            tipo: TipoBloque.imagen,
            valor:
                "https://portalwinnyprod.blob.core.windows.net/portal-winny-prod/images/ombligo-de-bebe.original_gOheU1a.jpg",
          ),
        ],
      ),
      ArticuloContenido(
        id: "50",
        titulo: "Baño suave",
        imagen:
            "https://plazavea.vteximg.com.br/arquivos/ids/26114628-418-418/image-01d8645b005842048e6992beab63a10c.jpg",
        descripcion:
            "Baña al bebé con agua tibia y jabón neutro, 2-3 veces por semana según edad y necesidad.",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: """
            Consejos para un baño seguro:

            • Mantén la temperatura del agua entre 36-37°C.
            • Sujeta al bebé firmemente, pero suavemente.
            • Evita jabones fuertes o perfumes; usa productos específicos para recién nacidos.
            • Seca cuidadosamente todos los pliegues de la piel después del baño.
            """,
          ),
          ContenidoBloque(
            tipo: TipoBloque.imagen,
            valor:
                "https://images.ctfassets.net/zmk7e03n1uhr/2XeHYhkDtBpDsvhTDmltUQ/3e0b746a1bff8107a3feb584bd83332f/bebe-recien-nacido-sonriendo-en-la-hora-de-bano_1-es-pe-",
          ),
        ],
      ),
      ArticuloContenido(
        id: "51",
        titulo: "Cambio de pañal frecuente",
        imagen:
            "https://stronglify-1.s3.sa-east-1.amazonaws.com/farmadodo/Aprende-a-cambiar-panales-con-estos-consejos-para-padres.png",
        descripcion:
            "Cambiar el pañal frecuentemente previene irritaciones, dermatitis y molestias en el bebé.",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: """
            Tips para cambiar el pañal:

            • Cambia el pañal siempre que esté húmedo o sucio.
            • Limpia suavemente con toallitas sin alcohol o algodón con agua.
            • Aplica crema barrera si es necesario para prevenir dermatitis.
            """,
          ),
          ContenidoBloque(
            tipo: TipoBloque.imagen,
            valor: "https://olmitos.com/img/ybc_blog/post/consejos.jpg",
          ),
        ],
      ),
      ArticuloContenido(
        id: "52",
        titulo: "Secar pliegues de la piel",
        imagen:
            "https://d2b6jlxtx94mlg.cloudfront.net/media/1350/blog_plantilla_julio2025_2.png",
        descripcion:
            "Evita la humedad en cuello, axilas y área del pañal para prevenir irritaciones y hongos.",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: """
            Recomendaciones:

            • Después del baño, seca cuidadosamente los pliegues con una toalla suave.
            • Presta atención a cuello, axilas, detrás de las orejas y área del pañal.
            • Evita frotar; mejor dar palmaditas suaves para secar.
            """,
          ),
          ContenidoBloque(
            tipo: TipoBloque.imagen,
            valor:
                "https://popeye.cl/wp-content/uploads/2023/04/cuello-bebe.jpg",
          ),
        ],
      ),
      ArticuloContenido(
        id: "53",
        titulo: "Evitar cremas fuertes",
        imagen:
            "https://mejorconsalud.as.com/wp-content/uploads/2018/07/crema-bebe.jpg",
        descripcion:
            "Usa productos suaves y específicos para bebés; evita cremas fuertes o con fragancia.",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: """
            Consejos sobre cremas y productos:

            • Utiliza solo productos recomendados para recién nacidos.
            • Evita perfumes, alcohol o químicos agresivos.
            • Aplica cremas solo cuando sea necesario, como barrera para la zona del pañal.
            """,
          ),
          ContenidoBloque(
            tipo: TipoBloque.imagen,
            valor:
                "https://babysalus.es/wp-content/uploads/2023/10/Bebe-crema-1-1-scaled-1.jpg",
          ),
        ],
      ),
      ArticuloContenido(
        id: "54",
        titulo: "Señales de infección o complicaciones",
        descripcion:
            "Aprende a identificar signos de infección en el cordón umbilical y posibles complicaciones en el bebé.",
        imagen:
            "https://www.opeluce.com.pe/blog/wp-content/uploads/2024/09/Conjuntivitis-en-bebes-Opeluce-scaled.jpg",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Señales de infección en el cordón umbilical",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Tras el nacimiento, el cordón umbilical se seca y suele caer de forma natural entre los 5 y 15 días de vida del bebé. En este periodo es importante mantener el área limpia y seca, y observar si hay signos de infección o complicación.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.lista,
            valor:
                "Emisión de una descarga con mal olor o pus,Piel de color rojo intenso alrededor del cordón,Hinchazón o calor al tacto en la zona,Fiebre o síntomas generales de enfermedad en el bebé,El bebé llora o se incomoda al tocar el área",
          ),
          ContenidoBloque(
            tipo: TipoBloque.tip,
            valor:
                "Observa si el bebé no se alimenta bien, está muy irritable o somnoliento, ya que pueden acompañar una infección y requerir atención médica.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.advertencia,
            valor:
                "Una infección del cordón umbilical, llamada onfalitis, puede avanzar rápidamente y necesita evaluación médica inmediata si se presentan varios de estos signos.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Si el cordón umbilical tarda mucho en caer (más de 3–4 semanas) o si observas secreción persistente con mal olor incluso después de la caída, consulta con un profesional de salud para descartar complicaciones.",
          ),
        ],
        fuente: "Mayo Clinic / MedlinePlus / HealthyChildren.org",
        urlExterna: null,
        tags: ["infección", "cordón umbilical", "cuidados bebé"],
      ),
    ],
  ),

  // ================= SUEÑO DEL BEBE =================
  TemaContenido(
    titulo: "Sueño del bebé",
    imagen:
        "https://sisanjuan.b-cdn.net/media/k2/items/cache/106db5f93bb1be2e877fae1383599b8d_XL.jpg?t=20190610_163700",
    descripcion: "Guía para garantizar un sueño seguro y saludable del bebé.",
    categoria: "Cuidados del bebé",
    articulos: [
      ArticuloContenido(
        id: "55",
        titulo: "Dormir boca arriba",
        imagen:
            "https://letsfamily.es/wp-content/uploads/2010/03/muerte-subita-bebe-1.jpg",
        descripcion:
            "Colocar al bebé boca arriba reduce significativamente el riesgo de muerte súbita infantil.",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: """
            Dormir boca arriba es la postura más segura para tu bebé:

            • Siempre coloca la cabeza del bebé sobre la espalda, nunca de lado ni boca abajo.
            • Esta posición asegura que las vías respiratorias estén libres.
            • No importa si el bebé duerme en cuna, moisés o cama de colecho (con supervisión adecuada).
            """,
          ),
          ContenidoBloque(
            tipo: TipoBloque.imagen,
            valor:
                "https://www.venceremos.cu/images/salud/bebe-dormir-boca-arriba.jpg",
          ),
        ],
      ),
      ArticuloContenido(
        id: "56",
        titulo: "Cuna firme y segura",
        imagen:
            "https://www.hola.com/horizon/landscape/a29785a2864a-qu-debe-y-que-no-debe-tener-la-cuna-de-tu-beb-para-que-duerma-seguro.jpg",
        descripcion:
            "Usar un colchón firme y bien ajustado reduce riesgos de asfixia o accidentes durante el sueño.",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: """
            Al preparar la cuna del bebé:

            • Asegúrate de que el colchón sea firme y encaje perfectamente en la cuna.
            • Evita camas blandas, almohadas, cojines o juguetes dentro de la cuna.
            • Mantén la cuna libre de objetos que puedan tapar la respiración del bebé.
            """,
          ),
          ContenidoBloque(
            tipo: TipoBloque.imagen,
            valor:
                "https://mamasmateas.com/cdn/shop/articles/Portada36_2x_a74b0269-33e6-4a5d-96f4-e98b4deb290c.png?v=1657136617",
          ),
        ],
      ),
      ArticuloContenido(
        id: "57",
        titulo: "Evitar mantas sueltas",
        imagen:
            "https://cdn.shopify.com/s/files/1/0691/5774/9027/files/stellamoon-co-baby-tummy-time-on-swaddle_480x480.jpg?v=1693376994",
        descripcion:
            "En lugar de mantas sueltas, usa sacos o pijamas que cubran al bebé de manera segura.",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: """
            Para mantener al bebé abrigado sin riesgos:

            • Evita cobijas, mantas o edredones dentro de la cuna.
            • Utiliza sacos de dormir para bebés con la talla adecuada.
            • Ajusta la temperatura de la habitación para que sea confortable.
            """,
          ),
          ContenidoBloque(
            tipo: TipoBloque.imagen,
            valor:
                "https://asepri.com/wp-content/uploads/shutterstock_552365467-1.jpg",
          ),
        ],
      ),
      ArticuloContenido(
        id: "58",
        titulo: "Cómo establecer rutinas de sueño",
        descripcion:
            "Guía práctica para crear rutinas de sueño que ayuden al bebé a descansar mejor.",
        imagen:
            "https://mibebeyyo.elmundo.es/images/bebes/rutinas-sueno-saludable-bebes-ninos.webp",
        fuente: "HeadStart.gov / Babynaps / Guías de sueño infantil",
        tags: ["sueno", "rutina", "bebé", "descanso"],
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "¿Por qué es importante una rutina de sueño?",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Las rutinas de sueño ayudan a los bebés a reconocer señales de descanso y a vincular ciertas actividades con la hora de dormir, favoreciendo un sueño más tranquilo y predecible.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.lista,
            valor:
                "Los bebés recién nacidos duermen muchas horas pero en ciclos cortos.,Una rutina constante favorece descanso más profundo a medida que crece el bebé.,Rutinas regulares ayudan a distinguir entre día y noche.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Pasos para establecer una rutina de sueño",
          ),
          ContenidoBloque(
            tipo: TipoBloque.lista,
            valor:
                "Definir un horario fijo para acostarse cada noche.,Comenzar la rutina 30–60 minutos antes de dormir.,Actividades tranquilas: baño tibio, alimentación, música suave o lectura.,Crear un entorno adecuado: luz tenue y reducida, sin ruido fuerte.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.tip,
            valor:
                "Observa las señales de cansancio del bebé, como bostezar, frotarse los ojos o irritabilidad, para iniciar la rutina antes de que esté demasiado cansado.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "En las primeras semanas de vida, los bebés no tienen un patrón claro de sueño y vigilia, pero desde aproximadamente las 6–8 semanas puedes empezar a aplicar rutinas suavemente.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.tip,
            valor:
                "Mantén las mismas acciones cada noche en el mismo orden (como baño, pijama, canción) para que el bebé asocie cada paso con dormir.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.advertencia,
            valor:
                "Evita pantallas y luces brillantes antes de la hora de dormir, ya que pueden dificultar que el bebé se relaje adecuadamente.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Ten en cuenta que cada bebé es diferente: la rutina puede ajustarse con el tiempo y según su ritmo individual.",
          ),
        ],
      ),
      ArticuloContenido(
        id: "59",
        titulo: "Ambiente tranquilo",
        imagen:
            "https://ecuskids.com/cdn/shop/articles/como_debe_ser_la_habitacion_para_dormir_al_bebe_2024_blog_01_kids.jpg?v=1708447491&width=2048",
        descripcion:
            "Mantener luz tenue y bajo ruido ayuda al bebé a dormir más relajado y seguro.",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: """
            Consejos para crear un ambiente de sueño seguro:

            • Reduce ruidos fuertes y evita televisores encendidos.
            • Mantén la habitación con luz tenue o apagada durante la noche.
            • Mantén objetos y cables fuera del alcance del bebé.
            """,
          ),
          ContenidoBloque(
            tipo: TipoBloque.imagen,
            valor:
                "https://www.babysec.cl/assets/uploads/article/3959a-istock-870774246-1-.jpg",
          ),
        ],
      ),
      ArticuloContenido(
        id: "60",
        titulo: "Supervisión nocturna",
        imagen:
            "https://www.mennencentralamerica.com/adobe/dynamicmedia/deliver/dm-aid--eb64c16b-f9f0-4aa4-b37f-1d2e0758e1e3/dormir-bebes.png?quality=85&preferwebp=true",
        descripcion:
            "Revisar al bebé regularmente durante los primeros días asegura su bienestar y tranquilidad para la madre.",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: """
            Algunas recomendaciones de supervisión:

            • Acércate al bebé para observar su respiración y postura.
            • Mantén contacto visual y verbal para tranquilizarlo.
            • No es necesario levantarlo cada hora, pero sí vigilar que esté cómodo y seguro.
            """,
          ),
          ContenidoBloque(
            tipo: TipoBloque.imagen,
            valor:
                "https://www.chicco.es/dw/image/v2/BJJJ_PRD/on/demandware.static/-/Sites-Chicco-Spain-Library/es_ES/dw11f4950b/site/advice-pages/descanso/oscuridad-o-luz-bebes/dormir-bebe-luz-oscuridad.jpg",
          ),
        ],
      ),
    ],
  ),

  // ================= DESARROLLO Y ESTIMULACION TEMPRANA=================
  TemaContenido(
    titulo: 'Desarrollo y estimulacion temprana',
    imagen:
        'https://clubmamasypapas.com/media/mageplaza/blog/post/t/o/top-5-de-juegos-para-la-estimulacion-temprana-de-mi-bebe.jpg',
    descripcion:
        "Guía para estimular y favorecer el desarrollo del recién nacido.",
    categoria: "Cuidados del bebé",
    articulos: [
      ArticuloContenido(
        id: "61",
        titulo: "Contacto piel con piel",
        imagen:
            "https://www.gomezroig.com/wp-content/uploads/2022/01/Piel-con-Piel-con-la-Madre.jpg",
        descripcion:
            "Favorece el vínculo afectivo, regula la temperatura y la respiración del bebé.",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: """
            Beneficios del contacto piel con piel:

            • Favorece el vínculo emocional entre madre y bebé.
            • Regula la temperatura corporal y respiración.
            • Ayuda a estabilizar el ritmo cardíaco.
            • Reduce estrés y llanto del bebé.
            """,
          ),
        ],
      ),
      ArticuloContenido(
        id: "62",
        titulo: "Estimulación visual",
        imagen:
            "https://ceimanoloalvaro.es/wp-content/uploads/2020/11/estimulacion-visual-educacion-infantil-1.jpg",
        descripcion:
            "Muéstrale objetos de alto contraste para ayudar al desarrollo visual.",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: """
            Consejos de estimulación visual:

            • Usa juguetes o tarjetas en blanco y negro.
            • Coloca objetos a 20-30 cm de su rostro.
            • Observa la reacción del bebé y alterna colores y formas.
            • Estimula por períodos cortos varias veces al día.
            """,
          ),
        ],
      ),
      ArticuloContenido(
        id: "63",
        titulo: "Estimulación auditiva",
        imagen:
            "https://blog-es.kinedu.com/wp-content/uploads/2020/11/post_thumbnail-9f45f8051e5cb4fec37a5ad041da2270.jpeg",
        descripcion:
            "Habla y canta suavemente al bebé para estimular su audición y lenguaje.",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: """
            Consejos de estimulación auditiva:

            • Habla y canta con voz suave y clara.
            • Repite palabras y nombres de objetos cercanos.
            • Introduce sonidos suaves como música clásica o canciones infantiles.
            • Observa la reacción del bebé y ajusta volumen y ritmo.
            """,
          ),
        ],
      ),
      ArticuloContenido(
        id: "64",
        titulo: "Movimientos suaves",
        imagen:
            "https://www.triciclodebebe.com/modules/dbblog/views/img/post/Estiramientos%20para%20beb%C3%A9%20Beneficios%20y%20c%C3%B3mo%20hacerlos%20de%20manera%20segura.jpg",
        descripcion:
            "Mueve brazos y piernas suavemente para desarrollar coordinación y fuerza.",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: """
            Cómo estimular movimientos:

            • Flexiona y estira suavemente brazos y piernas.
            • Haz movimientos lentos y controlados.
            • Observa si el bebé se muestra cómodo.
            • Evita forzar articulaciones o movimientos bruscos.
            """,
          ),
        ],
      ),
      ArticuloContenido(
        id: "65",
        titulo: "Juegos simples",
        imagen:
            "https://images.ctfassets.net/2ly8a1n15gva/3Rb0Uzs93KpsPvg84DKA84/ac294e4ffbb5dc1d9df3c2c97cf1e88c/juegos-para-bebes-de-un-ano-cuadrada.jpg",
        descripcion:
            "Usa sonajeros o juguetes seguros para estimular sentidos y coordinación.",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: """
            Consejos para juegos simples:

            • Usa juguetes de colores brillantes y texturas suaves.
            • Introduce sonidos suaves como sonajeros.
            • Juega de manera breve varias veces al día.
            • Observa señales de fatiga o incomodidad.
            """,
          ),
        ],
      ),
      ArticuloContenido(
        id: "66",
        titulo: "Tu bebé empieza a explorar su entorno",
        imagen:
            "https://red.aeiotu.org/wp-content/uploads/2023/06/baby-boy-looking-at-the-camera-while-lying-on-his-2022-10-12-16-26-29-utc-1024x683.jpeg",
        descripcion:
            "A partir de las 6–8 semanas, los bebés comienzan a fijarse en objetos, colores y movimientos a su alrededor, explorando su entorno de manera activa.",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: """
            Durante las primeras semanas, el bebé empieza a prestar atención a su entorno.

            Se fija en:

            • Caras de personas
            • Objetos de colores llamativos
            • Movimientos y luces

            Esto es parte de su desarrollo cognitivo y sensorial.

            Algunas recomendaciones para estimularlo:

            • Coloca juguetes seguros y blandos cerca de él.
            • Háblale y muéstrale objetos de diferentes colores.
            • Cambia la posición de los juguetes para que siga con la mirada.
            • Evita objetos pequeños que puedan ser peligrosos.

            Permitir que el bebé observe y explore su entorno fortalece su curiosidad y aprendizaje desde muy temprano.
            """,
          ),
        ],
      ),
    ],
  ),

  // ================= ENFERMEDADES COMUNES Y PRIMEROS AUXILIOS =================
  TemaContenido(
    titulo: "Enfermedades comunes y primeros auxilios",
    imagen:
        "https://salucity.com/img/especialidades/rehabilitacion-cardiopulmonar.webp",
    descripcion:
        "Cómo reconocer y manejar las enfermedades más frecuentes en bebés y qué hacer en casa antes de acudir al centro de salud.",
    categoria: "Cuidados del bebé",
    articulos: [
      ArticuloContenido(
        id: "67",
        titulo: "Fiebre y resfriados en el bebé",
        descripcion:
            "Entiende cuándo preocuparte por fiebre o un resfriado y cómo manejar estos síntomas en casa.",
        imagen:
            "https://portalwinnyprod.blob.core.windows.net/portal-winny-prod/images/gripa-en-bebes.original.jpg",
        fuente: "Guías pediátricas generales",
        tags: ["fiebre", "resfriado", "síntomas"],
        bloques: [
          ContenidoBloque(tipo: TipoBloque.titulo, valor: "Fiebre en bebés"),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "La fiebre es una señal de que el cuerpo está luchando contra una infección. En bebés menores de 3 meses, cualquier fiebre debe considerarse con atención médica inmediata.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.lista,
            valor:
                "Menos de 3 meses: fiebre mayor a 38 °C requiere evaluación médica.,Entre 3 y 6 meses: fiebre hasta 38 °C si el bebé parece bien de salud, si no, consulta.,Más de 38 °C por más de un día: consulta al profesional de salud.",
          ),
          ContenidoBloque(tipo: TipoBloque.titulo, valor: "Resfriados"),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Un simple resfriado puede causar congestión, secreción nasal y tos leve. En la mayoría de los casos puedes manejarlo en casa observando la evolución.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.tip,
            valor:
                "Asegúrate de mantener hidratado al bebé y evita exponerlo a personas con síntomas respiratorios fuertes.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.advertencia,
            valor:
                "Si el resfriado va acompañado de dificultad para respirar, fiebre persistente o letargo, acude cuanto antes al centro de salud.",
          ),
        ],
      ),
      ArticuloContenido(
        id: "68",
        titulo: "Diarrea y cólicos",
        descripcion:
            "Información sobre diarrea, cólicos y cómo cuidar al bebé.",
        imagen:
            "https://www.quironsalud.com/idcsalud-client/cm/images?locale=es_ES&idMmedia=1676265",
        fuente: "Recomendaciones de pediatría general",
        tags: ["diarrea", "colicos", "digestivo"],
        bloques: [
          ContenidoBloque(tipo: TipoBloque.titulo, valor: "Diarrea en bebés"),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "La diarrea puede ser frecuente en bebés y, en muchos casos, tiene origen viral. Sin embargo, es importante vigilar si se presentan muchos episodios.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.lista,
            valor:
                "Más de 3 heces muy líquidas en un día: considera consulta médica.,Diarrea persistente por varios días.,Heces con sangre o dolor abdominal intenso.",
          ),
          ContenidoBloque(tipo: TipoBloque.titulo, valor: "Cólicos"),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Los cólicos son contracciones del abdomen que pueden causar llanto intenso y malestar. Suelen presentarse en las primeras semanas de vida.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.tip,
            valor:
                "Ayuda a aliviar cólicos masajeando suavemente el abdomen del bebé o colocándolo boca abajo sobre tus piernas.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.advertencia,
            valor:
                "Si el llanto es inconsolable o parece indicar dolor severo, consulta con un profesional de salud.",
          ),
        ],
      ),
      ArticuloContenido(
        id: "69",
        titulo: "Cuándo acudir al centro de salud",
        descripcion:
            "Señales de alerta que deben motivar una consulta médica para tu bebé.",
        imagen:
            "https://www.unicef.org/venezuela/sites/unicef.org.venezuela/files/styles/hero_extended/public/UN0791217.JPG.webp?itok=sBN8Or5t",
        fuente: "Guías de atención pediátrica",
        tags: ["alertas", "salud", "emergencia"],
        bloques: [
          ContenidoBloque(tipo: TipoBloque.titulo, valor: "Señales de alerta"),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "No todas las enfermedades en bebés requieren urgencia, pero hay señales que no debes ignorar y que indican la necesidad de atención médica.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.lista,
            valor:
                "Fiebre en menores de 3 meses.,Dificultad para respirar o respiración rápida.,Deshidratación: menos pañales mojados, boca muy seca.,Letargo, somnolencia excesiva o dificultad para despertar.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.tip,
            valor:
                "Si estás preocupada o algo no parece normal, confía en tu intuición y llama o visita al centro de salud.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.advertencia,
            valor:
                "Dolor intenso, convulsiones o coloración azulada de piel y labios requieren atención médica urgente.",
          ),
        ],
      ),
      ArticuloContenido(
        id: "70",
        titulo: "Primeros auxilios básicos en casa",
        descripcion:
            "Consejos de primeros auxilios para situaciones leves antes de acudir al profesional de salud.",
        imagen:
            "https://www.quironprevencion.com/portal-client/cm/images?locale=es_ES&idMmedia=40546",
        fuente: "Guías de cuidado infantil",
        tags: ["primeros auxilios", "casa", "cuidados"],
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Cómo actuar en casa",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Antes de ir al centro de salud, hay medidas básicas que puedes tomar para cuidar a tu bebé si presenta síntomas leves.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.lista,
            valor:
                "Mantén al bebé hidratado ofrecendo leche con frecuencia.,Controla la temperatura y usa métodos para bajarla como paños tibios.,Si tiene congestión nasal, usa suero fisiológico para limpiar nariz.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.tip,
            valor:
                "Ofrece de forma frecuente pero poca cantidad de agua o leche si hay diarrea, para prevenir deshidratación.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.advertencia,
            valor:
                "No administres medicamentos sin indicación médica; algunos pueden ser peligrosos para bebés.",
          ),
        ],
      ),
    ],
  ),

  // ================= VACUNAS GENERALES =================
  TemaContenido(
    titulo: "Vacunas en el embarazo",
    imagen:
        "https://res.cloudinary.com/dqqhqnbny/image/upload/v1771548015/images_6_oxn9kf.jpg",
    descripcion:
        "Vacunas recomendadas para mujeres embarazadas y madres lactantes para proteger la salud de la madre y del bebé",
    categoria: "Vacunas",
    articulos: [
      ArticuloContenido(
        id: "71",
        titulo: "Vacuna BCG",
        descripcion:
            "Protege al recién nacido contra tuberculosis grave y sus complicaciones.",
        imagen:
            "https://diarioenelistmo.com/wp-content/uploads/2025/07/3350761.webp",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "La vacuna BCG protege contra formas graves de tuberculosis, especialmente tuberculosis miliar y meningitis tuberculosa en niños. Se recomienda aplicar al nacer, preferiblemente antes del primer mes de vida.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Dosis: 1 dosis única, vía intradérmica, usualmente en el brazo derecho del bebé.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Efectos secundarios frecuentes: pequeña inflamación o nódulo en el sitio de aplicación que puede dejar una cicatriz. Reacciones graves son muy poco comunes.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Importancia: Esta vacuna es obligatoria según el calendario nacional de vacunación del Perú y es clave para prevenir enfermedades graves en los recién nacidos.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.imagen,
            valor:
                "https://blog.clinicainternacional.com.pe/wp-content/uploads/2021/11/que-enfermedades-relacionadas-con-ausencia-vacunas.jpg",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Consejos: Después de la vacunación, observar la zona de aplicación. Consultar al personal de salud ante cualquier reacción inusual.",
          ),
        ],
      ),
      ArticuloContenido(
        id: "72",
        titulo: "Vacuna Hepatitis B",
        descripcion:
            "Protege al recién nacido y al niño contra la infección por Hepatitis B.",
        imagen:
            "https://www.beatself.cl/wp-content/uploads/2024/01/vacuna-hepatitis-B-duracion.jpg",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "La vacuna contra la Hepatitis B protege contra infecciones que afectan el hígado y que pueden causar enfermedad crónica, cirrosis o cáncer de hígado en el futuro. Se recomienda iniciar la vacunación dentro de las primeras 24 horas de vida.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Esquema de vacunación: 3 dosis en total (al nacer, 2 meses, 6 meses). La primera dosis protege al bebé desde el nacimiento y las siguientes completan la inmunización.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Administración: Vía intramuscular, generalmente en el muslo del recién nacido. Cada dosis debe respetar los intervalos recomendados por el calendario nacional.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Efectos secundarios frecuentes: dolor leve, enrojecimiento o hinchazón en el sitio de aplicación. Reacciones graves son muy raras.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.imagen,
            valor:
                "https://www.healthychildren.org/SiteCollectionImagesArticleImages/baby-getting-vaccinated.jpg?RenditionID=3",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Importancia: Vacunando al bebé se previenen infecciones graves y complicaciones a largo plazo. Cumplir el esquema completo asegura protección duradera.",
          ),
        ],
      ),
      ArticuloContenido(
        id: "73",
        titulo: "Vacuna Pentavalente",
        descripcion:
            "Protege al bebé contra cinco enfermedades graves: Difteria, Tétanos, Tos ferina, Hepatitis B y Haemophilus influenzae tipo B.",
        imagen:
            "https://img.saludsavia.com/wp-content/uploads/2019/06/Vacuna-Pentavalente.jpg",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "La vacuna Pentavalente combina protección contra Difteria, Tétanos, Tos ferina, Hepatitis B y Haemophilus influenzae tipo B (Hib), enfermedades que pueden causar complicaciones graves en los bebés y niños pequeños.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Esquema de vacunación: se administra en 3 dosis generalmente a los 2, 4 y 6 meses de edad, según el calendario nacional de vacunación.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Administración: vía intramuscular, normalmente en el muslo del bebé. Cada dosis debe respetar los intervalos recomendados para garantizar la inmunidad completa.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Efectos secundarios frecuentes: dolor, enrojecimiento o inflamación en el sitio de aplicación; fiebre leve. Reacciones graves son muy raras.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.imagen,
            valor:
                "https://www.saludayacucho.gob.pe/wp-content/uploads/2025/06/WhatsApp-Image-2025-06-10-at-11.01.06-AM.jpeg",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Importancia: Vacunar a tiempo protege al bebé de infecciones potencialmente mortales y es fundamental para la salud pública.",
          ),
        ],
      ),
      ArticuloContenido(
        id: "74",
        titulo: "Vacuna Polio (IPV)",
        descripcion:
            "Protege al bebé contra la Poliomielitis, enfermedad que puede causar parálisis irreversible.",
        imagen:
            "https://www.isglobal.org/documents/10179/10088367/polio+vaccine/94c6d271-e5fc-4cb7-9ca3-326a9fb1da68?t=1666077889327",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "La vacuna IPV (Polio inactivada) previene la poliomielitis, enfermedad viral que puede causar parálisis y complicaciones graves en los niños.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Esquema de vacunación: normalmente se aplica en 3 dosis a los 2, 4 y 6 meses de edad, siguiendo el calendario nacional.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Administración: vía intramuscular, usualmente en el muslo del bebé. Es importante respetar las fechas recomendadas.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Efectos secundarios frecuentes: dolor o enrojecimiento en el sitio de aplicación, fiebre leve. Reacciones graves son muy poco comunes.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.imagen,
            valor:
                "https://observatorio.medicina.uc.cl/wp-content/uploads/2019/10/polio-vacunacion.jpg",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Importancia: Cumplir el esquema de vacunación asegura protección contra la poliomielitis y contribuye a la erradicación de la enfermedad.",
          ),
        ],
      ),
      ArticuloContenido(
        id: "75",
        titulo: "Vacuna Rotavirus",
        descripcion:
            "Protege al bebé contra gastroenteritis grave por rotavirus, causa común de diarrea y deshidratación.",
        imagen:
            "https://canaldiabetes.com/wp-content/uploads/2019/10/Captura-de-pantalla-2019-10-16-a-las-17.50.29.png",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "La vacuna contra el Rotavirus previene infecciones graves que pueden provocar diarrea severa, vómitos y deshidratación en los bebés.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Esquema de vacunación: se administra vía oral en 2 o 3 dosis, según el tipo de vacuna, generalmente a los 2, 4 y 6 meses de edad.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Administración: oral. Es muy importante seguir el intervalo recomendado entre dosis para asegurar la inmunidad completa.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Efectos secundarios frecuentes: irritabilidad, diarrea leve o vómitos. Reacciones graves son extremadamente raras.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.imagen,
            valor:
                "https://assets.babycenter.com/ims/2015/02/iStock_55894090_wide.jpg",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Importancia: Proteger a los bebés de gastroenteritis grave reduce hospitalizaciones y complicaciones por deshidratación.",
          ),
        ],
      ),
      ArticuloContenido(
        id: "76",
        titulo: "Vacuna Neumococo Conjugada",
        descripcion:
            "Protege al bebé contra neumonía, meningitis y otras infecciones graves causadas por Streptococcus pneumoniae.",
        imagen:
            "https://blob.medicinaysaludpublica.com/images/2022/11/26/formato-sacs---2022-11-26t124557672-51416e45.png",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "La vacuna neumococo conjugada previene infecciones graves como neumonía, meningitis y otitis causada por Streptococcus pneumoniae.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Esquema de vacunación: generalmente 3 dosis a los 2, 4 y 6 meses, y una dosis de refuerzo a los 12 meses, según el calendario nacional.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Administración: vía intramuscular, usualmente en el muslo del bebé. Seguir el esquema recomendado garantiza inmunidad completa.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Efectos secundarios frecuentes: dolor, enrojecimiento o hinchazón en el sitio de aplicación, fiebre leve. Reacciones graves son muy poco comunes.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.imagen,
            valor:
                "https://image.tuasaude.com/media/article/qs/fy/prevenar-13_48084.jpg?width=686&height=487",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Importancia: La vacunación protege al bebé de infecciones graves y contribuye a reducir la mortalidad infantil.",
          ),
        ],
      ),
      ArticuloContenido(
        id: "77",
        titulo: "Vacuna Influenza",
        descripcion:
            "Protege a la madre y al bebé contra la gripe estacional y sus complicaciones.",
        imagen:
            "https://www.clikisalud.net/wp-content/uploads/2021/07/vacunas-influenza-debes-saber.jpg",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "La vacuna contra la Influenza previene la gripe estacional, que puede causar complicaciones graves en mujeres embarazadas, lactantes y personas con enfermedades crónicas.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Esquema de vacunación: se recomienda una dosis anual. Si es la primera vez que la madre recibe la vacuna, puede requerir una dosis adicional según indicación del personal de salud.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Administración: vía intramuscular, generalmente en el brazo. Puede aplicarse en cualquier trimestre del embarazo o durante la lactancia.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Efectos secundarios frecuentes: dolor o enrojecimiento en el sitio de aplicación, fiebre leve o malestar general. Reacciones graves son extremadamente raras.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.imagen,
            valor: "https://clinicamontesur.com.pe/images/influenza.webp",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Importancia: Vacunarse protege a la madre y al bebé contra complicaciones graves por gripe, como neumonía o hospitalizaciones, y ayuda a reducir la transmisión en la comunidad.",
          ),
        ],
      ),
      ArticuloContenido(
        id: "78",
        titulo: "Vacuna SRP (Sarampión, Paperas y Rubéola)",
        descripcion:
            "Protege a los niños y adultos contra sarampión, paperas y rubéola, enfermedades contagiosas con posibles complicaciones graves.",
        imagen:
            "https://vacunasaep.org/sites/vacunasaep.org/files/vacuna-srp-shutterstock_566240707.jpg?1669707911",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "La vacuna SRP protege contra sarampión, paperas y rubéola, enfermedades virales que pueden causar complicaciones graves como neumonía, meningitis o defectos congénitos si la madre se infecta durante el embarazo.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Esquema de vacunación: se aplica en 2 dosis según el calendario nacional: la primera dosis generalmente a los 12 meses y la segunda a los 18 meses. En adultos no vacunados, se puede aplicar según indicación médica.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Administración: vía subcutánea, generalmente en el brazo. La vacuna es segura durante la infancia; no se recomienda durante el embarazo, pero sí antes de planificar un embarazo.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Efectos secundarios frecuentes: fiebre leve, erupción cutánea, dolor o inflamación en el sitio de aplicación. Reacciones graves son muy raras.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.imagen,
            valor:
                "https://www.paho.org/sites/default/files/styles/story_hero/public/2024-04/cri-child-receives-vaccine-1400x907.jpg?h=b48b91a7&itok=zjZOMpzb",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Importancia: Cumplir el esquema de vacunación asegura protección contra estas enfermedades altamente contagiosas y previene complicaciones graves, especialmente en bebés y mujeres embarazadas.",
          ),
        ],
      ),
      ArticuloContenido(
        id: "79",
        titulo: "Vacuna Tdap (Tétano, Difteria y Tos ferina)",
        descripcion:
            "Protege a la madre y al recién nacido contra Tétano, Difteria y Tos ferina.",
        imagen:
            "https://cdn.aarp.net/content/dam/aarp/health/conditions_treatments/2023/09/1140-tdap-vaccine-esp.jpg",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "La vacuna Tdap protege contra tres enfermedades graves: Tétano, Difteria y Tos ferina. Aplicarla durante el embarazo permite que la madre transfiera anticuerpos al bebé, brindándole protección durante los primeros meses de vida.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Esquema de vacunación: se recomienda una dosis única entre la semana 20 y 36 de gestación en cada embarazo. Esto asegura que el bebé reciba la máxima protección al nacer.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Administración: vía intramuscular, generalmente en el brazo. Puede aplicarse en cualquier trimestre a criterio del personal de salud, pero se prioriza entre las semanas 27 y 36 para máxima transferencia de anticuerpos.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Efectos secundarios frecuentes: dolor, enrojecimiento o inflamación en el sitio de aplicación, fiebre leve o malestar general. Reacciones graves son muy raras.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.imagen,
            valor:
                "https://medlineplus.gov/images/TetanusDiphtheriaandPertussisVaccines_share.jpg",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Importancia: La vacunación Tdap protege a la madre y al recién nacido de enfermedades graves, especialmente la tos ferina, que puede ser mortal en los primeros meses de vida.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Consejos: Aplicar la vacuna en cada embarazo, aunque la madre haya recibido Tdap previamente. Mantener registro en el carnet de vacunación.",
          ),
        ],
      ),
    ],
  ),
  // ================= IMPORTANCIA VACUNAS =================
  TemaContenido(
    titulo: "Importancia de las vacunas",
    imagen:
        "https://www.aipediatria.es/wp-content/uploads/2020/08/importancia-vacunas-ninos-AIP-x2.jpg",
    descripcion:
        "Sección para explicar con detalle la importancia de las vacunas",
    categoria: "Vacunas",
    articulos: [
      ArticuloContenido(
        id: "80",
        titulo: "Cómo funcionan las vacunas",
        descripcion:
            "Las vacunas ayudan al cuerpo del bebé a defenderse de enfermedades peligrosas.",
        imagen:
            "https://i.ytimg.com/vi/hRj5D0ctQm8/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLAW87D1USDqdB42nkspaa5-Qn0GKQ",
        fuente:
            "Información sobre inmunización y funcionamiento del sistema inmunitario",
        tags: ["vacunas", "sistema inmunológico", "bebé"],
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Las vacunas ayudan al sistema inmunológico del bebé a aprender a reconocer y combatir virus y bacterias antes de que causen una enfermedad.",
          ),

          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Cuando una vacuna entra al cuerpo, presenta una pequeña parte del germen o una versión debilitada del mismo. Esto permite que el organismo cree defensas llamadas anticuerpos.",
          ),

          ContenidoBloque(
            tipo: TipoBloque.lista,
            valor:
                "La vacuna enseña al sistema inmunológico a reconocer el germen,El cuerpo produce defensas llamadas anticuerpos,Si el bebé se expone a la enfermedad real, el cuerpo ya sabe cómo defenderse",
          ),

          ContenidoBloque(
            tipo: TipoBloque.tip,
            valor:
                "Gracias a las vacunas, el cuerpo del bebé puede protegerse sin tener que enfermarse primero.",
          ),
        ],
      ),
      ArticuloContenido(
        id: "81",
        titulo: "Enfermedades que previenen las vacunas",
        descripcion:
            "Las vacunas protegen a los bebés contra muchas enfermedades peligrosas.",
        imagen:
            "https://www.unicef.org/guatemala/sites/unicef.org.guatemala/files/styles/hero_extended/public/5H0A8673_0.jpg.webp?itok=OUV_uvgk",
        fuente: "Esquema Nacional de Vacunación",
        tags: ["enfermedades", "vacunas", "prevención"],
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Las vacunas protegen a los niños contra enfermedades graves que antes causaban muchas muertes o complicaciones.",
          ),

          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "En el Perú, el esquema nacional de vacunación protege contra más de 28 enfermedades gracias a 18 vacunas gratuitas que se aplican desde el nacimiento.",
          ),

          ContenidoBloque(
            tipo: TipoBloque.lista,
            valor:
                "Tuberculosis,Hepatitis B,Poliomielitis,Rotavirus,Neumonía,Sarampión,Rubéola,Paperas,Varicela,Fiebre amarilla",
          ),

          ContenidoBloque(
            tipo: TipoBloque.tip,
            valor:
                "Cumplir con el calendario de vacunación protege no solo a tu bebé, sino también a otros niños en la comunidad.",
          ),
        ],
      ),
      ArticuloContenido(
        id: "82",
        titulo: "Mitos y verdades sobre las vacunas",
        descripcion:
            "Conoce la verdad detrás de algunos mitos comunes sobre las vacunas.",
        imagen:
            "https://www.paho.org/sites/default/files/styles/max_650x650/public/2021-07/mythstrutscovidvax-es.png?itok=gSAkRhCF",
        fuente: "Información sobre inmunización de organismos de salud",
        tags: ["mitos vacunas", "seguridad vacunas"],
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Existen muchos mitos sobre las vacunas, pero la evidencia científica demuestra que son seguras y eficaces.",
          ),

          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Mito: Las vacunas enferman al bebé",
          ),

          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Las vacunas no causan la enfermedad que previenen. Algunas pueden provocar reacciones leves como fiebre o dolor en el lugar de la inyección.",
          ),

          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Mito: Las vacunas no son necesarias",
          ),

          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Las vacunas siguen siendo necesarias porque muchas enfermedades todavía existen y pueden reaparecer si las personas dejan de vacunarse.",
          ),

          ContenidoBloque(
            tipo: TipoBloque.advertencia,
            valor:
                "No vacunar a los niños puede ponerlos en riesgo de enfermedades graves como sarampión, meningitis o tos ferina.",
          ),
        ],
      ),
    ],
  ),

  // ================= REACCIONES DESPUES DE VACUNAR =================
  TemaContenido(
    titulo: "Reacciones después de vacunar",
    imagen:
        "https://pwvytjekbuthureiryun.supabase.co/storage/v1/object/public/wp-uploads/uploads/2022/09/bebe-despues-de-vacunar-5-768x469.jpg",
    descripcion:
        "Descrición e información sobre como el bebé puede reaccionar a las vacunas",
    categoria: "Vacunas",
    articulos: [
      ArticuloContenido(
        id: "83",
        titulo: "Reacciones normales después de una vacuna",
        descripcion:
            "Algunos bebés pueden presentar molestias leves después de vacunarse. Estas reacciones suelen ser temporales.",
        imagen:
            "https://www.hospitalmetropolitano.org/storage/articles/1901704390728.jpg",
        fuente: "Información médica sobre reacciones comunes a vacunas",
        tags: ["vacunas", "reacciones", "bebé"],
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Después de recibir una vacuna, el cuerpo del bebé comienza a generar defensas contra enfermedades. Durante este proceso es normal que aparezcan algunas reacciones leves.",
          ),

          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Reacciones más comunes",
          ),

          ContenidoBloque(
            tipo: TipoBloque.lista,
            valor:
                "Dolor o sensibilidad en el lugar de la inyección,Enrojecimiento o leve hinchazón,Fiebre leve,Irritabilidad o llanto,Cansancio o más sueño de lo normal",
          ),

          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Estas reacciones suelen aparecer pocas horas después de la vacunación y normalmente desaparecen en uno o dos días.",
          ),

          ContenidoBloque(
            tipo: TipoBloque.tip,
            valor:
                "Estas molestias leves son una señal de que el sistema inmunológico del bebé está respondiendo y creando protección contra enfermedades.",
          ),
        ],
      ),
      ArticuloContenido(
        id: "84",
        titulo: "Cómo aliviar fiebre o dolor después de una vacuna",
        descripcion:
            "Algunas acciones simples pueden ayudar a que tu bebé se sienta mejor después de vacunarse.",
        imagen:
            "https://media.cnn.com/api/v1/images/stellar/prod/cnne-19217575-120505035831-recien-nacido-story-top.jpg?c=16x9&q=h_833,w_1480,c_fill",
        fuente: "Recomendaciones para el cuidado después de la vacunación",
        tags: ["vacunas", "cuidados", "bebé"],
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Si tu bebé presenta molestias leves después de una vacuna, existen algunas formas seguras de ayudarlo a sentirse mejor.",
          ),

          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Qué puedes hacer en casa",
          ),

          ContenidoBloque(
            tipo: TipoBloque.lista,
            valor:
                "Aplicar un paño limpio y frío en el lugar de la inyección,Ofrecer más líquidos o leche materna,Permitir que el bebé descanse más,Mantener al bebé cómodo y con ropa ligera",
          ),

          ContenidoBloque(
            tipo: TipoBloque.tip,
            valor:
                "El contacto con la madre, la lactancia y cargar al bebé pueden ayudar a calmar la irritabilidad después de la vacunación.",
          ),

          ContenidoBloque(
            tipo: TipoBloque.advertencia,
            valor:
                "Antes de dar medicamentos para la fiebre o el dolor, consulta con el profesional de salud que atiende a tu bebé.",
          ),
        ],
      ),
      ArticuloContenido(
        id: "85",
        titulo: "Cuándo acudir al médico después de una vacuna",
        descripcion:
            "Aunque las reacciones graves son muy raras, es importante conocer las señales de alerta.",
        imagen:
            "https://blog-es.kinedu.com/wp-content/uploads/2016/09/H_2111.jpg",
        fuente: "Guías médicas sobre reacciones poco comunes a vacunas",
        tags: ["vacunas", "alerta", "salud"],
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Las reacciones graves a las vacunas son muy poco frecuentes. Sin embargo, es importante reconocer algunos signos que requieren atención médica.",
          ),

          ContenidoBloque(tipo: TipoBloque.titulo, valor: "Señales de alerta"),

          ContenidoBloque(
            tipo: TipoBloque.lista,
            valor:
                "Fiebre muy alta,Dificultad para respirar,Inflamación en la cara o garganta,Llanto inconsolable por varias horas,Convulsiones,Debilidad extrema",
          ),

          ContenidoBloque(
            tipo: TipoBloque.advertencia,
            valor:
                "Si tu bebé presenta dificultad para respirar, convulsiones o se ve muy débil, busca atención médica inmediata.",
          ),

          ContenidoBloque(
            tipo: TipoBloque.tip,
            valor:
                "Si tienes dudas o notas algo que te preocupa después de una vacuna, consulta con el centro de salud o pediatra.",
          ),
        ],
      ),
    ],
  ),

  // ================= COMO PREPARAR AL BEBE PARA UNA VACUNA =================
  TemaContenido(
    titulo: "Como prepara al bebé para una vacuna",
    imagen:
        "https://hic.fcv.org/co/images/blog/2024/agosto/cuales-son-las-primeras-vacunas-que-se-le-deben-aplicar-a-un-bebe-y-por-que-1.jpg",
    descripcion: "Sección importante para la vacunación de tu bebé.",
    categoria: "Vacunas",
    articulos: [
      ArticuloContenido(
        id: "86",
        titulo: "Qué hacer antes de vacunar al bebé",
        descripcion:
            "Preparar al bebé antes de su vacuna puede ayudar a que la experiencia sea más tranquila.",
        imagen:
            "https://www.consumer.es/app/uploads/2019/07/img_aliviar-dolor-ante-vacunas-hd.jpg",
        fuente: "Recomendaciones de vacunación infantil",
        tags: ["vacunas", "preparación", "bebé"],
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Las vacunas son una forma segura de proteger a tu bebé contra enfermedades graves. Antes de acudir al centro de salud, es recomendable preparar algunos aspectos para que el proceso sea más cómodo.",
          ),

          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Antes de la vacunación",
          ),

          ContenidoBloque(
            tipo: TipoBloque.lista,
            valor:
                "Revisa la cartilla o tarjeta de vacunación del bebé,Asegúrate de que el bebé esté bien alimentado,Lleva ropa cómoda y fácil de retirar,Mantén la calma para transmitir tranquilidad al bebé",
          ),

          ContenidoBloque(
            tipo: TipoBloque.tip,
            valor:
                "La lactancia antes o después de la vacuna puede ayudar a calmar al bebé.",
          ),

          ContenidoBloque(
            tipo: TipoBloque.advertencia,
            valor:
                "Si el bebé tiene fiebre, enfermedad grave o reacción previa a una vacuna, consulta con el personal de salud antes de vacunarlo.",
          ),
        ],
      ),
      ArticuloContenido(
        id: "87",
        titulo: "Qué llevar al centro de salud",
        descripcion:
            "Llevar algunos artículos básicos facilitará el proceso de vacunación.",
        imagen:
            "https://centromedicoabc.com/wp-content/uploads/2021/04/abc-thumb-blog-maleta-embarazo.jpg",
        fuente: "Recomendaciones de atención infantil",
        tags: ["vacunas", "centro de salud"],
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Antes de acudir al centro de salud para la vacunación de tu bebé, es recomendable llevar algunos elementos importantes.",
          ),

          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Elementos importantes",
          ),

          ContenidoBloque(
            tipo: TipoBloque.lista,
            valor:
                "Tarjeta o carnet de vacunación,Documento de identidad del bebé o la madre,Pañales y toallitas,Ropa extra para el bebé,Una manta ligera",
          ),

          ContenidoBloque(
            tipo: TipoBloque.tip,
            valor:
                "Llevar un juguete o objeto favorito del bebé puede ayudar a distraerlo durante la vacunación.",
          ),
        ],
      ),
      ArticuloContenido(
        id: "88",
        titulo: "Consejos para tranquilizar al bebé durante la vacunación",
        descripcion:
            "Algunas acciones simples pueden ayudar a que tu bebé se sienta más tranquilo.",
        imagen:
            "https://eresmama.com/wp-content/uploads/2021/09/vacuna-rotavirus-oral.jpg?auto=format%2Ccompress&quality=75&width=3840&height=2160&fit=cover&gravity=center&sharp=true&progressive=true",
        fuente: "Consejos de cuidado infantil durante la vacunación",
        tags: ["vacunas", "bebé", "calmar"],
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Es normal que los bebés lloren cuando reciben una vacuna. Sin embargo, existen formas de ayudar a calmarlos.",
          ),

          ContenidoBloque(tipo: TipoBloque.titulo, valor: "Consejos útiles"),

          ContenidoBloque(
            tipo: TipoBloque.lista,
            valor:
                "Cargar o abrazar al bebé,Hablarle con voz calmada,Ofrecer lactancia materna,Usar un juguete o distracción",
          ),

          ContenidoBloque(
            tipo: TipoBloque.tip,
            valor:
                "El contacto piel con piel puede ayudar a reducir el dolor y la ansiedad del bebé.",
          ),
        ],
      ),
    ],
  ),

  // ================= CUIDADO DEL BEBE DESPUES DE VACUNAR =================
  TemaContenido(
    titulo: "Cuidado del bebé despúes de vacunar",
    imagen:
        "https://images.ctfassets.net/2ly8a1n15gva/6OaKmBj3o3As9LWHjTCedH/fadfb8ded5b56b8f6268e7b710d16270/cuidados-despues-de-las-vacunas-cuadrada.png",
    descripcion: "Sección importante para la vacunación de tu bebé.",
    categoria: "Vacunas",
    articulos: [
      ArticuloContenido(
        id: "89",
        titulo: "Cuidados en casa después de una vacuna",
        descripcion:
            "Después de la vacunación, algunos cuidados simples pueden ayudar al bebé a sentirse mejor.",
        imagen:
            "https://images.ctfassets.net/2ly8a1n15gva/4w1sSSPJd59jqbZh2bf5LY/e96e825889f56f03601e0ccb2314e235/cuidados-despues-de-las-vacunas-interna.jpg?w=464&h=440&fl=progressive&q=100&fm=jpg&bg=transparent",
        fuente: "Recomendaciones sobre cuidados después de vacunas",
        tags: ["vacunas", "cuidados"],
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Después de recibir una vacuna, algunos bebés pueden sentirse incómodos o tener molestias leves.",
          ),

          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Cuidados recomendados",
          ),

          ContenidoBloque(
            tipo: TipoBloque.lista,
            valor:
                "Permitir que el bebé descanse,Ofrecer lactancia materna o líquidos,Aplicar un paño frío en la zona de la inyección,Mantener al bebé cómodo",
          ),

          ContenidoBloque(
            tipo: TipoBloque.tip,
            valor: "La mayoría de las molestias desaparecen en uno o dos días.",
          ),
        ],
      ),
      ArticuloContenido(
        id: "90",
        titulo: "Señales de alerta después de una vacuna",
        descripcion:
            "Las reacciones graves son raras, pero es importante reconocer algunos signos de alerta.",
        imagen:
            "https://gestarconamor.com/wp-content/uploads/2021/03/vacuna.jpg",
        fuente: "Guías de seguridad en vacunación",
        tags: ["vacunas", "alerta"],
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Las vacunas son seguras, pero en raras ocasiones pueden presentarse reacciones que requieren atención médica.",
          ),

          ContenidoBloque(tipo: TipoBloque.titulo, valor: "Signos de alerta"),

          ContenidoBloque(
            tipo: TipoBloque.lista,
            valor:
                "Fiebre muy alta,Dificultad para respirar,Inflamación de la cara,Convulsiones,Llanto inconsolable por varias horas",
          ),

          ContenidoBloque(
            tipo: TipoBloque.advertencia,
            valor:
                "Si notas alguno de estos síntomas, acude de inmediato al centro de salud.",
          ),
        ],
      ),
      ArticuloContenido(
        id: "91",
        titulo: "Cuándo dar medicamentos después de una vacuna",
        descripcion:
            "En algunos casos el profesional de salud puede recomendar medicamentos para aliviar molestias.",
        imagen:
            "https://cdn.aarp.net/content/dam/aarp/health/conditions_treatments/2021/02/1140-pain-pills-covid-vaccine-esp.jpg",
        fuente: "Recomendaciones pediátricas sobre vacunación",
        tags: ["vacunas", "medicamentos"],
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Algunos bebés pueden presentar fiebre o dolor después de vacunarse.",
          ),

          ContenidoBloque(
            tipo: TipoBloque.titulo,
            valor: "Recomendaciones importantes",
          ),

          ContenidoBloque(
            tipo: TipoBloque.lista,
            valor:
                "No administrar medicamentos sin indicación médica,Seguir siempre la dosis indicada,Consultar si la fiebre dura más de 48 horas",
          ),

          ContenidoBloque(
            tipo: TipoBloque.advertencia,
            valor:
                "Nunca automediques a tu bebé sin la indicación de un profesional de salud.",
          ),

          ContenidoBloque(
            tipo: TipoBloque.tip,
            valor:
                "Ante cualquier duda, consulta al personal de salud que atendió la vacunación.",
          ),
        ],
      ),
    ],
  ),

  // ================= RECETAS PARA LA MADRE =================
  TemaContenido(
    titulo: "Recetas para la madre",
    imagen:
        "https://static.guiainfantil.com/media/4925/c/7-alimentos-estrella-que-te-ayudaran-a-sentirte-mejor-tras-el-parto-lg.jpg",
    descripcion:
        "Recetas nutritivas para apoyar la lactancia y la recuperacion de la madre.",
    categoria: "Alimentacion",
    articulos: [
      ArticuloContenido(
        id: "92",
        titulo: "Sopa de quinua con verduras",
        descripcion: "Ayuda a recuperar energía y favorece la lactancia.",
        imagen:
            "https://deliciaskitchen.b-cdn.net/wp-content/uploads/2022/01/sopa-de-quinoa-con-ajos-tiernos-y-calabaza.jpg",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Esta sopa aporta nutrientes esenciales y energía para la madre lactante.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Ingredientes:\n- Quinua\n- Zanahoria\n- Zapallo\n- Apio\n- Caldo de verduras",
          ),

          ContenidoBloque(
            tipo: TipoBloque.video,
            valor: "N5wggdhhtDU", // ID del video
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Preparación:\n1. Lavar y cortar las verduras.\n2. Cocinar la quinua con las verduras y el caldo hasta que estén tiernas.\n3. Servir caliente.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.imagen,
            valor: "https://imag.bonviveur.com/sopa-de-quinoa.jpg",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: "Puedes consumirlo en el almuerzo.",
          ),
        ],
      ),
      ArticuloContenido(
        id: "93",
        titulo: "Estofado de pollo con verduras",
        descripcion:
            "Aporta proteínas y vitaminas esenciales para la recuperación.",
        imagen:
            "https://cdn7.recetasdeescandalo.com/wp-content/uploads/2021/03/Estofado-de-pollo-con-patatas-y-verduras-riquisimo.jpg",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Un plato rico en proteínas y vitaminas, ideal para la recuperación postparto.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Ingredientes:\n- Pechuga de pollo\n- Zanahoria\n- Papas\n- Choclo\n- Caldo de pollo",
          ),

          ContenidoBloque(
            tipo: TipoBloque.video,
            valor: "9pPaljaDs68", // ID del video
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Preparación:\n1. Dorar el pollo y añadir las verduras.\n2. Cocinar con caldo hasta que estén tiernas.\n3. Servir caliente.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.imagen,
            valor:
                "https://cocinaconnoelia.com/wp-content/uploads/2023/07/Contramuslos-de-pollo-guisados-con-verduras-scaled.jpg",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: "Puedes consumirlo en el almuerzo.",
          ),
        ],
      ),
      ArticuloContenido(
        id: "94",
        titulo: "Tallarines verdes con pescado",
        descripcion: "Rico en hierro y ácidos grasos esenciales.",
        imagen:
            "https://i.ytimg.com/vi/enxbUqDbq2g/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLCmlWvs33fxtTJCN94EQsFnzlwCJw",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Tallarines verdes acompañados de pescado, aportando hierro y ácidos grasos para la lactancia.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Ingredientes:\n- Tallarines verdes\n- Filete de pescado\n- Espinaca\n- Ajo y aceite de oliva",
          ),

          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Preparación:\n1. Cocinar los tallarines.\n2. Saltear la espinaca y el pescado con ajo.\n3. Mezclar todo y servir.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.imagen,
            valor:
                "https://i.ytimg.com/vi/enxbUqDbq2g/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLCmlWvs33fxtTJCN94EQsFnzlwCJw",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: "Puedes consumirlo en el almuerzo o merienda.",
          ),
        ],
      ),
      ArticuloContenido(
        id: "95",
        titulo: "Causa de atún saludable",
        descripcion: "Aporta proteínas y es ligera para el estómago.",
        imagen:
            "https://www.recetasnestle.com.co/sites/default/files/srh_recipes/aca66a1d3bf3e2e9c06f9087f9dba04c.jpg",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Una receta ligera, rica en proteínas, ideal para la madre lactante.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Ingredientes:\n- Puré de papa amarilla\n- Atún cocido\n- Limón\n- Aceite de oliva\n- Sal y pimienta",
          ),

          ContenidoBloque(
            tipo: TipoBloque.video,
            valor: "ufS2elj5mWE", // ID del video
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Preparación:\n1. Mezclar el puré con atún y condimentos.\n2. Formar capas y decorar.\n3. Servir frío o a temperatura ambiente.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.imagen,
            valor:
                "https://www.ajinomoto.com.pe:8085/img/receta/Causa-de-pollo.jpg",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: "Puedes consumirlo en el almuerzo.",
          ),
        ],
      ),
      ArticuloContenido(
        id: "96",
        titulo: "Arroz con pollo integral",
        descripcion: "Versión saludable para mejorar energía y digestión.",
        imagen:
            "https://www.unileverfoodsolutions.com.ar/dam/global-ufs/mcos/sla/argentina/calcmenu/recipes/AR-recipes/knorr-profesional-/wok-de-arroz-integral-pollo-y-vegetales-/main-header.jpg",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Arroz integral con pollo, rico en energía y fibra para una digestión saludable.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Ingredientes:\n- Arroz integral\n- Pechuga de pollo\n- Zanahoria y arvejas\n- Caldo de pollo\n- Aceite de oliva",
          ),

          ContenidoBloque(
            tipo: TipoBloque.video,
            valor: "hO2zrBc6gwo", // ID del video
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Preparación:\n1. Cocinar el arroz integral.\n2. Saltear el pollo y verduras.\n3. Mezclar con el arroz y servir.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.imagen,
            valor: "https://imag.bonviveur.com/sopa-de-quinoa.jpg",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: "Puedes consumirlo en el desayuno o almuerzo.",
          ),
        ],
      ),
      ArticuloContenido(
        id: "97",
        titulo: "Papa a la huancaína ligera",
        descripcion: "Fuente de carbohidratos y calcio.",
        imagen:
            "https://perudelights.com/wp-content/uploads/2013/07/papa-a-la-huancaina-lista-1024x768.jpg",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Receta ligera, rica en carbohidratos y calcio, ideal para la recuperación postparto.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Ingredientes:\n- Papas hervidas\n- Salsa de huancaína ligera\n- Huevo duro\n- Aceitunas",
          ),

          ContenidoBloque(
            tipo: TipoBloque.video,
            valor: "9rHZ4I_HRRw", // ID del video
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Preparación:\n1. Cocer las papas y cortar en rodajas.\n2. Preparar la salsa ligera.\n3. Servir con huevo duro y aceitunas.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.imagen,
            valor:
                "https://donangelo.pe/wp-content/uploads/2022/12/WhatsApp-Image-2022-05-28-at-1.04.56-PM-e1691953501748.jpeg",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: "Puedes consumirlo en el almuerzo.",
          ),
        ],
      ),
      ArticuloContenido(
        id: "98",
        titulo: "Lomo saltado con quinoa",
        descripcion: "Proteínas + hierro, ideal para madres en recuperación.",
        imagen:
            "https://mealpractice.b-cdn.net/39783766427832320/lomo-saltado-with-quinoa-salad-bpsVOsFUWG.webp",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Plato nutritivo que combina proteínas y hierro, ideal para la energía postparto.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Ingredientes:\n- Lomo de res magro\n- Cebolla, tomate y ají\n- Quinoa cocida\n- Salsa de soja",
          ),

          ContenidoBloque(
            tipo: TipoBloque.video,
            valor: "TGecyyZdz0", // ID del video
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Preparación:\n1. Saltear el lomo con verduras.\n2. Mezclar con quinoa cocida.\n3. Servir caliente.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.imagen,
            valor:
                "https://media-cdn.tripadvisor.com/media/photo-s/17/8d/15/54/risotto-de-quinua-con.jpg",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: "Puedes consumirlo en el almuerzo o merienda.",
          ),
        ],
      ),
      ArticuloContenido(
        id: "99",
        titulo: "Ocopa con verduras al vapor",
        descripcion: "Ligera, nutritiva y rica en vitaminas.",
        imagen: "https://i.ytimg.com/vi/IIfkUnKHmBk/maxresdefault.jpg",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Receta ligera y rica en vitaminas, ideal para la recuperación y lactancia.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Ingredientes:\n- Verduras al vapor (zanahoria, brócoli, papa)\n- Salsa de ocopa ligera\n- Huevos cocidos para decorar",
          ),

          ContenidoBloque(
            tipo: TipoBloque.video,
            valor: "jEiKrXwz_P0", // ID del video
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Preparación:\n1. Cocer las verduras al vapor.\n2. Servir con salsa de ocopa y huevo duro.\n3. Disfrutar caliente o tibio.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.imagen,
            valor:
                "https://cdn0.recetasgratis.net/es/posts/0/5/4/ocopa_arequipena_11450_600.webp",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: "Puedes consumirlo en el desayuno o almuerzo.",
          ),
        ],
      ),
      ArticuloContenido(
        id: "100",
        titulo: "Ensalada de quinua con aguaymanto",
        descripcion: "Antioxidantes y proteínas vegetales para energía.",
        imagen: "https://i.ytimg.com/vi/koOjpIeTrsM/maxresdefault.jpg",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Ensalada fresca y nutritiva con antioxidantes y proteínas vegetales.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Ingredientes:\n- Quinua cocida\n- Aguaymanto\n- Espinaca\n- Aceite de oliva y limón",
          ),

          ContenidoBloque(
            tipo: TipoBloque.video,
            valor: "yAMAqRGEscQ", // ID del video
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Preparación:\n1. Mezclar la quinua con espinaca y aguaymanto.\n2. Aliñar con aceite de oliva y limón.\n3. Servir fresca.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.imagen,
            valor:
                "https://acomer.pe/wp-content/uploads/2017/09/ensaladaquinuathumb.jpg",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: "Puedes consumirlo en el desayuno o almuerzo.",
          ),
        ],
      ),
      ArticuloContenido(
        id: "101",
        titulo: "Caldo de gallina con verduras",
        descripcion: "Reconfortante y nutritivo para recuperación postparto.",
        imagen:
            "https://mandolina.co/wp-content/uploads/2024/05/caldo-gallina-1200x733.jpg",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Caldo nutritivo y reconfortante, perfecto para la recuperación postparto.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Ingredientes:\n- Gallina\n- Papas, zanahoria y apio\n- Fideos opcionales\n- Hierbas aromáticas",
          ),

          ContenidoBloque(
            tipo: TipoBloque.video,
            valor: "QX2mtJ_AIKo", // ID del video
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Preparación:\n1. Cocer la gallina con verduras y hierbas.\n2. Añadir fideos si se desea.\n3. Servir caliente y disfrutar.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.imagen,
            valor:
                "https://mojo.generalmills.com/api/public/content/geavWbc7i0eptb2tGb-CyA_gmi_hi_res_jpeg.jpeg?v=5f30c0a4&t=16e3ce250f244648bef28c5949fb99ff",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: "Puedes consumirlo en el desayuno, almuerzo o cena.",
          ),
        ],
      ),
    ],
  ),

  // ================= RECETAS PARA EL BEBE =================
  TemaContenido(
    titulo: "Recetas para el bebé",
    imagen:
        "https://res.cloudinary.com/dqqhqnbny/image/upload/v1771547938/images_4_s47wfh.jpg",
    descripcion:
        "Recetas suaves y nutritivas para introducir alimentos sólidos al bebé de forma segura.",
    categoria: "Alimentacion",
    articulos: [
      ArticuloContenido(
        id: "102",
        titulo: "Puré de zanahoria y calabaza",
        descripcion: "Introduce vegetales al bebé de manera segura.",
        imagen:
            "https://cdn0.recetasgratis.net/es/posts/9/2/0/pure_de_calabaza_patata_y_zanahoria_60029_orig.jpg",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Puré nutritivo para iniciar la alimentación complementaria con vegetales.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Ingredientes:\n- Zanahoria\n- Calabaza\n- Agua o caldo de verduras",
          ),

          ContenidoBloque(
            tipo: TipoBloque.video,
            valor: "xeCMF9aUIOg", // ID del video
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Preparación:\n1. Cocer zanahoria y calabaza hasta que estén suaves.\n2. Hacer puré hasta obtener textura homogénea.\n3. Servir tibio y sin sal.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.imagen,
            valor:
                "https://www.annarecetasfaciles.com/files/miniatura-48-scaled.jpg",
          ),
        ],
      ),
      ArticuloContenido(
        id: "103",
        titulo: "Puré de camote y manzana",
        descripcion: "Dulce y suave para digestión delicada.",
        imagen:
            "https://memoriasdecocina.wordpress.com/wp-content/uploads/2015/03/pure-de-batatas-y-manzanas-1.jpg",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Puré dulce y suave, ideal para bebés con digestión delicada.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: "Ingredientes:\n- Camote\n- Manzana\n- Agua",
          ),

          ContenidoBloque(
            tipo: TipoBloque.video,
            valor: "8Lc9wdqNQ5I", // ID del video
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Preparación:\n1. Cocer camote y manzana hasta que estén blandos.\n2. Licuar hasta obtener textura suave.\n3. Servir tibio, sin azúcar ni sal.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.imagen,
            valor:
                "https://memoriasdecocina.wordpress.com/wp-content/uploads/2015/03/pure-de-batatas-y-manzanas-1.jpg",
          ),
        ],
      ),
      ArticuloContenido(
        id: "104",
        titulo: "Papilla de plátano y avena",
        descripcion: "Ideal para desayunos y complementar lactancia.",
        imagen:
            "https://www.pequerecetas.com/wp-content/uploads/2024/10/papilla-de-avena-con-platano.jpg",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Papilla energética para desayuno, aportando carbohidratos y fibra para bebés.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Ingredientes:\n- Plátano maduro\n- Avena cocida\n- Leche materna o fórmula",
          ),

          ContenidoBloque(
            tipo: TipoBloque.video,
            valor: "ZfZrmTX-g1s", // ID del video
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Preparación:\n1. Machacar el plátano y mezclar con avena cocida.\n2. Añadir un poco de leche materna o fórmula.\n3. Servir a temperatura adecuada para el bebé.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.imagen,
            valor:
                "https://www.pequerecetas.com/wp-content/uploads/2024/10/papilla-de-avena-y-platano-receta-800x600.jpg",
          ),
        ],
      ),
      ArticuloContenido(
        id: "105",
        titulo: "Papilla de pera y manzana",
        descripcion: "Frutas seguras y suaves para bebés.",
        imagen:
            "https://assets.babycenter.com/ims/2015/02/applepearsauce_4x3.jpg",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: "Papilla de frutas segura, suave y rica en vitaminas.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: "Ingredientes:\n- Pera madura\n- Manzana madura\n- Agua",
          ),

          ContenidoBloque(
            tipo: TipoBloque.video,
            valor: "xmBQH1jx0Ms", // ID del video
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Preparación:\n1. Pelar y cocer las frutas hasta que estén blandas.\n2. Hacer puré fino.\n3. Servir tibio y fresco, sin azúcar ni sal.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.imagen,
            valor:
                "https://storage.googleapis.com/avena-recipes-v2/agtzfmF2ZW5hLWJvdHIZCxIMSW50ZXJjb21Vc2VyGICAgIrUpJYKDA/16-08-2020/1597587531874.jpeg",
          ),
        ],
      ),
      ArticuloContenido(
        id: "106",
        titulo: "Puré de calabacín y papa",
        descripcion: "Textura suave y digestiva.",
        imagen:
            "https://www.annarecetasfaciles.com/files/pure-patata-calabacin-1-scaled.jpg",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Puré suave y digestivo, ideal para iniciar alimentación complementaria.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: "Ingredientes:\n- Calabacín\n- Papa\n- Agua",
          ),

          ContenidoBloque(
            tipo: TipoBloque.video,
            valor: "eWEvN3QsE8E", // ID del video
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Preparación:\n1. Cocer calabacín y papa hasta que estén blandos.\n2. Hacer puré homogéneo.\n3. Servir tibio, sin sal ni condimentos fuertes.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.imagen,
            valor:
                "https://i.ytimg.com/vi/thqtClfJbec/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLDmtYlYB6MfSVLp0SPBGv7eUhAntA",
          ),
        ],
      ),
      ArticuloContenido(
        id: "107",
        titulo: "Puré de calabacín y papa",
        descripcion: "Textura suave y digestiva.",
        imagen:
            "https://www.annarecetasfaciles.com/files/pure-patata-calabacin-1-scaled.jpg",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Puré suave y digestivo, ideal para iniciar alimentación complementaria.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: "Ingredientes:\n- Calabacín\n- Papa\n- Agua",
          ),

          ContenidoBloque(
            tipo: TipoBloque.video,
            valor: "eWEvN3QsE8E", // ID del video
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Preparación:\n1. Cocer calabacín y papa hasta que estén blandos.\n2. Hacer puré homogéneo.\n3. Servir tibio, sin sal ni condimentos fuertes.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.imagen,
            valor:
                "https://i.ytimg.com/vi/thqtClfJbec/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLDmtYlYB6MfSVLp0SPBGv7eUhAntA",
          ),
        ],
      ),
      ArticuloContenido(
        id: "108",
        titulo: "Papilla de espinaca y papa",
        descripcion: "Rica en hierro vegetal y vitaminas.",
        imagen:
            "https://assets.tmecosys.com/image/upload/t_web_rdp_recipe_584x480_1_5x/img/recipe/ras/Assets/965a977ef3bb870ef2a21c9c197fced5/Derivates/470134228482f706b1facc77117997e6e68aeef0.jpg",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Papilla rica en hierro vegetal y vitaminas esenciales para el bebé.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: "Ingredientes:\n- Espinaca\n- Papa\n- Agua",
          ),

          ContenidoBloque(
            tipo: TipoBloque.video,
            valor: "bSRl0MQMnRY", // ID del video
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Preparación:\n1. Cocer espinaca y papa.\n2. Hacer puré homogéneo.\n3. Servir tibio, sin sal.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.imagen,
            valor:
                "https://www.clebastien.com/wp-content/uploads/2024/06/papilla_espinaca_papa.png",
          ),
        ],
      ),
    ],
  ),

  // ================= ALIMENTOS CONDICIONALES =================
  TemaContenido(
    titulo: "Alimentarios condicionales",
    imagen:
        "https://res.cloudinary.com/dqqhqnbny/image/upload/v1771547938/images_5_s24o70.jpg",
    descripcion:
        'Alimentos necesarios y recomendados para madres con sintomas de Anemia grave o estan en lactancia exclusiva',
    categoria: "Alimentacion",
    articulos: [
      ArticuloContenido(
        id: '109',
        titulo: "Guiso de lentejas con quinua",
        descripcion: "Rico en hierro para madres con anemia en lactancia.",
        imagen:
            "https://www.tipicochileno.cl/wp-content/uploads/2021/05/lentejas-con-quinoa-1080-1080.jpg",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Guiso nutritivo rico en hierro y proteínas, ideal para complementar la lactancia de madres con anemia.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Ingredientes:\n- Lentejas\n- Quinua\n- Verduras al gusto\n- Agua",
          ),

          ContenidoBloque(
            tipo: TipoBloque.video,
            valor: "qqTPr6Hsrd8", // ID del video
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Preparación:\n1. Lavar y cocer lentejas y quinua.\n2. Agregar verduras y cocer hasta ablandar.\n3. Servir tibio, sin sal añadida.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.imagen,
            valor:
                "https://static.bainet.es/clip/c12d6f61-ad4d-4a0d-9b2a-d9e7ded6e91f_source-aspect-ratio_1600w_0.jpg",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: "Recomendado consumir en el almuerzo o merienda.",
          ),
        ],
      ),
      ArticuloContenido(
        id: '110',
        titulo: "Sopa de espinaca con quinua",
        descripcion: "Aumenta hierro y vitaminas esenciales.",
        imagen:
            "https://cdn.bolivia.com/gastronomia/2014/01/15/crema-de-quinua-y-espinaca-3526-0.jpg",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Sopa ligera rica en hierro, perfecta para la recuperación de madres con anemia.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: "Ingredientes:\n- Espinaca\n- Quinua\n- Cebolla\n- Agua",
          ),

          ContenidoBloque(
            tipo: TipoBloque.video,
            valor: "_HOKkztJ0jY", // ID del video
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Preparación:\n1. Saltear cebolla, agregar agua y hervir.\n2. Incorporar quinua y espinaca.\n3. Cocer 15 min y servir tibio.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.imagen,
            valor:
                "https://lossaboresdemexico.com/wp-content/uploads/2014/01/Sopa-de-Quinoa-espinacas-queso-feta-y-cebollitas-de-cambray.jpeg",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: "Recomendado consumir en el desayuno o almuerzo.",
          ),
        ],
      ),
      ArticuloContenido(
        id: '111',
        titulo: "Guiso de sangrecita",
        descripcion: "Fuente de hierro para recuperación postparto.",
        imagen: "https://i.ytimg.com/vi/1ctAUSACZTM/maxresdefault.jpg",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: "Rico en hierro hemo, ayuda a madres con anemia postparto.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: "Ingredientes:\n- Sangrecita\n- Verduras\n- Ajo\n- Agua",
          ),

          ContenidoBloque(
            tipo: TipoBloque.video,
            valor: "1ctAUSACZTM", // ID del video
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Preparación:\n1. Saltear ajo y verduras.\n2. Agregar sangrecita y cocer hasta ablandar.\n3. Servir tibio.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.imagen,
            valor: "https://i.ytimg.com/vi/eHZ-4AvxJfo/maxresdefault.jpg",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: "Recomendado consumir en el almuerzo.",
          ),
        ],
      ),
      ArticuloContenido(
        id: '112',
        titulo: "Tortilla de quinua y huevo",
        descripcion: "Aporta proteínas y hierro.",
        imagen:
            "https://mojo.generalmills.com/api/public/content/qaw5e6Mz8UikedRwcLmvnQ_gmi_hi_res_jpeg.jpeg?v=87c24e84&t=16e3ce250f244648bef28c5949fb99ff",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Tortilla rica en proteínas y hierro, fácil de preparar y digerir.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Ingredientes:\n- Quinua cocida\n- Huevos\n- Verduras picadas\n- Aceite",
          ),

          ContenidoBloque(
            tipo: TipoBloque.video,
            valor: "hrnjrFyIhf4", // ID del video
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Preparación:\n1. Mezclar quinua, huevos y verduras.\n2. Cocinar en sartén con un poco de aceite.\n3. Servir tibio.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.imagen,
            valor:
                "https://okdiario.com/img/2018/07/30/receta-de-tortilla-de-quinoa.jpg",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: "Recomendado consumir en el desayuno.",
          ),
        ],
      ),
      ArticuloContenido(
        id: '113',
        titulo: "Ensalada de lentejas con verduras",
        descripcion:
            "Ideal para madres en lactancia exclusiva, ligera y nutritiva.",
        imagen:
            "https://recetasdecocina.elmundo.es/wp-content/uploads/2021/07/ensalada-de-lentejas.jpg",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Ensalada fresca y ligera, aporta proteínas vegetales y vitaminas para madres en lactancia exclusiva.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Ingredientes:\n- Lentejas cocidas\n- Verduras variadas\n- Limón\n- Aceite de oliva",
          ),

          ContenidoBloque(
            tipo: TipoBloque.video,
            valor: "jr2rtUDZcws", // ID del video
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Preparación:\n1. Mezclar todos los ingredientes.\n2. Servir fría o a temperatura ambiente.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.imagen,
            valor:
                "https://comedera.com/wp-content/uploads/sites/9/2022/04/ensalada-de-lentejas-fresca.jpg",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: "Recomendado consumir en el desayuno o almuerzo.",
          ),
        ],
      ),
      ArticuloContenido(
        id: '114',
        titulo: "Guiso de quinua con hígado",
        descripcion: "Rico en proteínas y hierro para lactancia exclusiva.",
        imagen: "https://i.ytimg.com/vi/z_4Ym0dlR9o/maxresdefault.jpg",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Guiso nutritivo, alto en proteínas y hierro, recomendado para madres que alimentan exclusivamente con leche materna.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: "Ingredientes:\n- Quinua\n- Hígado\n- Verduras\n- Agua",
          ),

          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Preparación:\n1. Cocer quinua.\n2. Saltear hígado y verduras.\n3. Mezclar todo y cocinar 10–15 min. Servir tibio.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.imagen,
            valor: "https://i.ytimg.com/vi/z_4Ym0dlR9o/maxresdefault.jpg",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: "Recomendado consumir en el almuerzo.",
          ),
        ],
      ),
      ArticuloContenido(
        id: '115',
        titulo: "Sopa de lentejas con verduras",
        descripcion: "Nutritiva y ligera, perfecta para lactancia exclusiva.",
        imagen:
            "https://storage.googleapis.com/avena-recipes-v2/agtzfmF2ZW5hLWJvdHIZCxIMSW50ZXJjb21Vc2VyGICAgIrUpJYKDA/17-08-2020/1597641801975.jpeg",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Sopa ligera y nutritiva, rica en proteínas vegetales y vitaminas para madres en lactancia exclusiva.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Ingredientes:\n- Lentejas\n- Verduras variadas\n- Agua\n- Aceite de oliva",
          ),

          ContenidoBloque(
            tipo: TipoBloque.video,
            valor: "79r1PM8EiNU", // ID del video
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor:
                "Preparación:\n1. Cocer lentejas y verduras.\n2. Servir tibio, ideal para lactancia exclusiva.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.imagen,
            valor:
                "https://tiaclara.com/wp-content/uploads/2025/03/brown-lentil-recipe-GLZ9059.jpg",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: "Recomendado consumir en el desayuno, almuerzo o merienda.",
          ),
        ],
      ),
    ],
  ),

  // ================= Señales de alerta =================
  // ================= Control pediatrico =================
];
