import 'package:lactaamor/features/home/models/contenido_model.dart';

final List<TemaContenido> todosLosTemas = [

  // ================= CONSEJOS BASICOS =================
  TemaContenido(
    titulo: "Consejos básicos",
    imagen:
        "https://res.cloudinary.com/dqqhqnbny/image/upload/v1771547695/images_oqtdm8.jpg",
    descripcion: "Guía esencial para iniciar la lactancia correctamente.",
    articulos: [
      ArticuloContenido(
        titulo: "Alimentación saludable durante el embarazo",
        imagen:
            "https://res.cloudinary.com/dqqhqnbny/image/upload/v1771558939/images_10_bel6ij.jpg",
        descripcion:
            "Durante el embarazo, tu cuerpo trabaja constantemente para formar y proteger una nueva vida. Por eso, la alimentación no solo influye en tu salud, sino también en el desarrollo adecuado de tu bebé.",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: """
No se trata de “comer por dos”, sino de alimentarte mejor. Necesitas un mayor aporte de nutrientes esenciales como:
•  Ácido fólico: Ayuda a prevenir defectos del tubo neural. Se encuentra en verduras de hoja verde, lentejas y cereales fortificados.
• Hierro: Previene la anemia y favorece la oxigenación del bebé. Presente en carnes magras, espinaca y menestras.
•  Calcio: Fundamental para el desarrollo de huesos y dientes. Lo encuentras en lácteos, yogurt y queso.
• Proteínas: Apoyan el crecimiento de tejidos. Incluye pollo, pescado bien cocido, huevos y legumbres.
También es importante:
•  Beber entre 6 y 8 vasos de agua al día.
•  Evitar alimentos crudos o mal cocidos.
• Limitar el consumo de cafeína.
• Evitar bebidas alcohólicas y tabaco.
""",
          ),
        ],
      ),
      
      ArticuloContenido(
        titulo: "Controles prenatales y chequeos médicos",
        imagen: "https://res.cloudinary.com/dqqhqnbny/image/upload/v1771559103/images_11_rc8o3r.jpg",
        descripcion: "Los controles prenatales son esenciales para asegurar que tanto tú como tu bebé se encuentren en buen estado de salud.",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: """
Desde el inicio del embarazo, es importante acudir regularmente a tus consultas médicas. En estas visitas se monitorea:
* Presión arterial
* Peso
* Crecimiento del bebé
* Latidos cardíacos fetales
* Exámenes de sangre y orina
Además, se realizan ecografías que permiten observar el desarrollo del bebé y detectar posibles complicaciones.
Asistir a todos tus controles ayuda a prevenir problemas como:
* Diabetes gestacional
* Preeclampsia
* Parto prematuro
""",)]
      ),

      ArticuloContenido(
        titulo: "Cambios físicos y emocionales en el embarazo",
        imagen: "https://res.cloudinary.com/dqqhqnbny/image/upload/v1771559260/emociones-embarazo.png_vmsise.webp",
        descripcion: "El embarazo implica cambios físicos evidentes, pero también cambios emocionales importantes debido a las hormonas.",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: """
Entre los cambios físicos más comunes están:
* Náuseas y vómitos (especialmente en el primer trimestre)
* Sensibilidad en los senos
* Cansancio frecuente
* Hinchazón en pies y manos
* Dolor lumbar
A nivel emocional, puedes experimentar:
* Cambios de humor
* Ansiedad
* Sensibilidad aumentada
* Miedos relacionados con el parto o la maternidad
Es importante:
* Hablar sobre tus emociones
* Pedir apoyo a tu pareja o familia
* Descansar lo suficiente
* Practicar técnicas de relajación
""",)]
    ),


      ArticuloContenido(
        titulo: "Lactancia materna: beneficios y recomendaciones",
        imagen: "https://res.cloudinary.com/dqqhqnbny/image/upload/v1771559495/images_12_qul8j3.jpg",
        descripcion: "La lactancia materna es el alimento ideal para el recién nacido durante los primeros seis meses de vida.",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: """
La leche materna:
* Contiene anticuerpos que protegen contra infecciones.
* Se adapta a las necesidades del bebé.
* Favorece el vínculo afectivo.
* Es fácil de digerir.
Consejos para una lactancia exitosa:
* Amamanta a libre demanda.
* Asegúrate de que el bebé abarque bien el pezón y parte de la areola.
* Busca una postura cómoda.
* Mantén una buena hidratación.
Si sientes dolor intenso o grietas persistentes, consulta con un especialista.
""",)]
      ),

      
      ArticuloContenido(
        titulo: "Sueño seguro del recién nacido",
        imagen: "https://res.cloudinary.com/dqqhqnbny/image/upload/v1771559609/WhatsApp-Image-2020-04-02-at-20.43.03-1024x1024_az38t8.jpg",
        descripcion: "El sueño es fundamental para el crecimiento y desarrollo cerebral del bebé.",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: """
Durante los primeros meses, el bebé puede dormir entre 14 y 17 horas al día, pero en intervalos cortos.
Recomendaciones para un sueño seguro:
* Colocar siempre al bebé boca arriba.
* Usar un colchón firme.
* Evitar almohadas, peluches o mantas sueltas.
* Compartir habitación, pero no la misma cama.
Crear una rutina nocturna (baño tibio, ambiente tranquilo, luces bajas) ayuda a regular el sueño.
""",
      ),
    ],
  ),
    ],
  ),

  // ================= PROBLEMAS COMUNES =================

  TemaContenido(
    titulo: "Problemas comunes",
    imagen: "...",
    descripcion: "Situaciones frecuentes durante la lactancia.",
    articulos: [
      
      ArticuloContenido(
        titulo: "Mastitis: causas, síntomas y tratamiento",
        imagen: "https://res.cloudinary.com/dqqhqnbny/image/upload/v1771562066/images_13_fmrkuv.jpg",
        descripcion: "Inflamación del seno durante la lactancia",
        bloques: [],
        urlExterna: "https://my.clevelandclinic.org/health/diseases/15613-mastitis", 
      ),

      ArticuloContenido(
        titulo: "Dolor al amamantar",
        imagen: "https://res.cloudinary.com/dqqhqnbny/image/upload/v1771562117/images_14_gzoeqm.jpg",
        descripcion: "Causas y soluciones",
        bloques: [],
        urlExterna: "https://www.natalben.com/el-embarazo-y-tus-dudas/dolor-lactancia-materna",
      ),
    ],
  ),


  // ================= Recetas para Mamá =================

  TemaContenido(
    titulo: "Recetas para Mamá",
    imagen: "https://res.cloudinary.com/dqqhqnbny/image/upload/v1771547939/photo-1546069901-ba9599a7e63c_ru66vp.jpg",
    descripcion: "Recetas nutritivas para apoyar la lactancia.",
    articulos: [

      ArticuloContenido(
        titulo: "Batido energético para mamá",
        descripcion: "Ideal durante la lactancia",
        imagen: "https://res.cloudinary.com/dqqhqnbny/image/upload/v1771565131/images_15_qx0f7g.jpg",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: "Este batido ayuda a recuperar energía después del parto.",
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: "Ingredientes:\n- Avena\n- Plátano\n- Leche vegetal",
          ),
          ContenidoBloque(
            tipo: TipoBloque.video,
            valor: "Hm-sUd8hWHQ", // ID del video
          ),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: "Preparación:\nMezclar todo en la licuadora por 2 minutos.",
          ),
          ContenidoBloque(tipo: TipoBloque.imagen, valor: "https://res.cloudinary.com/dqqhqnbny/image/upload/v1771565292/istockphoto-1455417356-612x612_stjqpt.jpg"),
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: "Puedes consumirlo en el desayuno o merienda.",
          ),
        ],
      ),

    ],
  ),

];