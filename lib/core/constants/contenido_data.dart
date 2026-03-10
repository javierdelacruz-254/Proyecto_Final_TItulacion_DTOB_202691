import '../../features/contenidos/models/contenido_model.dart';

final List<TemaContenido> todosLosTemas = [
  // ================= CONSEJOS BASICOS =================
  TemaContenido(
    titulo: "Consejos básicos",
    imagen:
        "https://res.cloudinary.com/dqqhqnbny/image/upload/v1771547695/images_oqtdm8.jpg",
    descripcion: "Guía esencial para iniciar la lactancia correctamente.",
    articulos: [
      ArticuloContenido(
        id: "01",
        titulo: "Importancia del ácido fólico durante el embarazo",

        imagen:
            "https://doihojqqs770p.cloudfront.net/articulos/articulos-171153-1200x675.jpg",
        descripcion:
            "El ácido fólico es uno de los nutrientes más importantes durante las primeras etapas del embarazo, ya que ayuda al desarrollo adecuado del cerebro y la columna vertebral del bebé.",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: """
            El ácido fólico es una vitamina del complejo B que cumple un papel fundamental en la formación del sistema nervioso del bebé.

            Durante las primeras semanas del embarazo, el cuerpo necesita mayores cantidades de esta vitamina para ayudar a prevenir defectos congénitos del tubo neural, que pueden afectar el cerebro o la médula espinal del bebé.

            Por esta razón, muchos médicos recomiendan empezar a tomar ácido fólico incluso antes de quedar embarazada o apenas se confirma el embarazo.

            Algunos alimentos ricos en ácido fólico son:
            • Espinaca
            • Brócoli
            • Lentejas
            • Palta
            • Cereales fortificados

            Recuerda siempre seguir las recomendaciones de tu médico respecto a suplementos vitamínicos.
            """,
          ),
        ],
      ),

      ArticuloContenido(
        id: "02",
        titulo: "Descansa lo suficiente y evita esfuerzos físicos intensos.",
        imagen:
            "https://nuevodescanso.com/blog/wp-content/uploads/2025/02/descanso-durante-el-embarazo.jpg",
        descripcion:
            "Durante el embarazo, el cuerpo de la madre experimenta muchos cambios físicos y hormonales, por lo que descansar adecuadamente es fundamental para la salud de ambos.",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: """
            El descanso es una parte esencial del bienestar durante el embarazo. A medida que el cuerpo trabaja para apoyar el crecimiento del bebé, es normal sentir mayor cansancio o fatiga.

            Dormir bien y evitar esfuerzos físicos intensos ayuda a reducir el estrés, mejorar la circulación y mantener niveles adecuados de energía.

            Algunas recomendaciones para mejorar el descanso son:

            • Dormir entre 7 y 9 horas cada noche.
            • Intentar dormir de lado, preferiblemente del lado izquierdo.
            • Evitar cargar peso excesivo.
            • Tomar pequeños descansos durante el día si te sientes cansada.
            • Mantener una rutina de sueño regular.

            Escuchar a tu cuerpo es muy importante. Si sientes cansancio, permite que tu cuerpo descanse y recupere energía.
            """,
          ),
        ],
      ),

      ArticuloContenido(
        id: "3",
        titulo:
            "Mantén una alimentación equilibrada rica en frutas y verduras.",
        imagen:
            "https://hospitalgalenia.com/wp-content/uploads/2024/08/embarazo4-k12-U501843487346qJE-624x385@El-Correo.jpg",
        descripcion:
            "Una alimentación equilibrada durante el embarazo ayuda a cubrir las necesidades nutricionales de la madre y favorece el desarrollo saludable del bebé.",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: """
            Durante el embarazo, la alimentación cumple un papel muy importante en el crecimiento y desarrollo del bebé.

            No es necesario comer el doble, pero sí es importante elegir alimentos nutritivos que aporten vitaminas, minerales y energía.

            Una dieta equilibrada durante el embarazo debería incluir:

            • Frutas y verduras frescas todos los días.
            • Proteínas como pollo, pescado bien cocido, huevos y legumbres.
            • Cereales integrales como arroz integral, avena o quinua.
            • Lácteos como leche, yogurt o queso para aportar calcio.

            También es importante:

            • Beber suficiente agua durante el día.
            • Evitar alimentos ultraprocesados o con exceso de azúcar.
            • Reducir el consumo de sal.
            • Mantener horarios de comida regulares.

            Una buena alimentación no solo beneficia a tu bebé, sino que también ayuda a que te sientas con más energía durante el embarazo.
            """,
          ),
        ],
      ),

      ArticuloContenido(
        id: "04",
        titulo: "La importancia de los controles prenatales",
        imagen:
            "https://res.cloudinary.com/dqqhqnbny/image/upload/v1771559103/images_11_rc8o3r.jpg",
        descripcion:
            "Los controles prenatales permiten monitorear la salud de la madre y el desarrollo del bebé durante todo el embarazo.",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: """
            Los controles prenatales son consultas médicas periódicas que permiten verificar que el embarazo se desarrolle de forma saludable.

            Durante estas visitas, el personal de salud evalúa diferentes aspectos importantes como:

            • La presión arterial de la madre.
            • El aumento de peso durante el embarazo.
            • El crecimiento y desarrollo del bebé.
            • Los latidos cardíacos del bebé.
            • Resultados de análisis de sangre y orina.

            También se realizan ecografías para observar el desarrollo del bebé y detectar posibles complicaciones a tiempo.

            Asistir regularmente a tus controles prenatales ayuda a prevenir y detectar problemas como:

            • Anemia
            • Diabetes gestacional
            • Preeclampsia
            • Parto prematuro

            Recuerda llevar siempre tus resultados médicos y seguir las recomendaciones del profesional de salud que te atiende.
            """,
          ),
        ],
      ),

      ArticuloContenido(
        id: "05",
        titulo: "Alimentos y sustancias que debes evitar durante el embarazo",
        imagen:
            "https://res.cloudinary.com/dqqhqnbny/image/upload/v1771558939/images_10_bel6ij.jpg",
        descripcion:
            "Durante el embarazo es importante evitar ciertos alimentos y sustancias que pueden afectar el desarrollo del bebé.",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: """
            Durante el embarazo, algunos alimentos y sustancias pueden representar riesgos para la salud de tu bebé.

            Es importante evitar el consumo de alcohol y tabaco, ya que estas sustancias pueden afectar el desarrollo del bebé y aumentar el riesgo de complicaciones durante el embarazo.

            También se recomienda evitar alimentos crudos o mal cocidos, ya que pueden contener bacterias o parásitos que podrían causar infecciones.

            Entre los alimentos que se recomienda evitar están:

            • Pescado crudo o sushi.
            • Carne cruda o poco cocida.
            • Huevos crudos.
            • Leche o quesos no pasteurizados.

            Además, es recomendable limitar el consumo de cafeína y evitar bebidas energéticas.

            Elegir alimentos bien cocidos y mantener una alimentación saludable ayuda a proteger tanto tu salud como la de tu bebé.
            """,
          ),
        ],
      ),

      ArticuloContenido(
        id: "06",
        titulo: "Hidratación y actividad física durante el embarazo",
        imagen:
            "https://fundasbcn.com/blog/wp-content/uploads/ejercicios-aptos-embarazadas-1-1900x1267.jpg",
        descripcion:
            "Mantenerse hidratada y realizar actividad física suave puede mejorar el bienestar físico y emocional durante el embarazo.",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: """
            Durante el embarazo, mantenerse hidratada es muy importante para el buen funcionamiento del organismo.

            Beber suficiente agua ayuda a:

            • Mantener una buena circulación.
            • Regular la temperatura corporal.
            • Evitar el estreñimiento.
            • Reducir la hinchazón.

            Se recomienda beber entre 6 y 8 vasos de agua al día, o más si el clima es caluroso o realizas actividad física.

            La actividad física suave también puede ser beneficiosa durante el embarazo, siempre que sea aprobada por tu médico.

            Algunas actividades recomendadas incluyen:

            • Caminar diariamente.
            • Ejercicios de estiramiento suaves.
            • Yoga prenatal.
            • Ejercicios de respiración.

            Estas actividades pueden ayudar a mejorar la circulación, reducir el estrés y preparar el cuerpo para el parto.
            """,
          ),
        ],
      ),

      ArticuloContenido(
        id: "07",
        titulo: "Primeros movimientos del bebé durante el embarazo",
        imagen:
            "https://www.mamanatural.com/wp-content/uploads/Quickening-in-Pregnancy.-When-Can-You-Feel-the-Baby-Move-Mama-Natural.jpg",
        descripcion:
            "A partir del segundo trimestre muchas madres comienzan a sentir los primeros movimientos del bebé, una experiencia emocionante que indica su crecimiento y desarrollo.",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: """
            Durante el embarazo, especialmente entre las semanas 16 y 20, muchas madres comienzan a sentir los primeros movimientos del bebé.

            Al inicio estos movimientos pueden sentirse como pequeñas burbujas, cosquilleos o un ligero aleteo dentro del abdomen.

            A medida que el bebé crece, los movimientos se vuelven más fuertes y frecuentes.

            Sentir los movimientos del bebé es una señal de que está activo y desarrollándose correctamente.

            Algunas recomendaciones:

            • Presta atención a los momentos en que tu bebé suele moverse.
            • Muchas madres sienten más movimientos cuando están descansando.
            • Comer algo dulce o beber agua fría puede estimular al bebé.

            Si en algún momento notas que el bebé deja de moverse durante muchas horas o los movimientos disminuyen considerablemente, es importante consultar con tu médico.
            """,
          ),
        ],
      ),

      ArticuloContenido(
        id: "08",
        titulo: "La importancia del hierro y el calcio durante el embarazo",
        imagen: "https://i.blogs.es/02476c/2560_3000/840_560.jpeg",
        descripcion:
            "Durante el embarazo, el cuerpo necesita mayores cantidades de hierro y calcio para apoyar el desarrollo del bebé y mantener la salud de la madre.",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: """
            Durante el embarazo, los nutrientes como el hierro y el calcio cumplen funciones muy importantes en el desarrollo del bebé.

            El hierro ayuda a prevenir la anemia y permite que la sangre transporte suficiente oxígeno al bebé.

            El calcio, por su parte, es esencial para la formación de los huesos y dientes del bebé.

            Algunos alimentos ricos en hierro incluyen:

            • Lentejas
            • Espinaca
            • Sangrecita
            • Carne roja magra
            • Quinua

            Alimentos ricos en calcio:

            • Leche
            • Yogurt
            • Queso
            • Almendras
            • Brócoli

            Una alimentación equilibrada que incluya estos alimentos ayuda a mantener tu energía y contribuye al desarrollo saludable del bebé.

            Siempre consulta con tu médico antes de tomar suplementos nutricionales.
            """,
          ),
        ],
      ),

      ArticuloContenido(
        id: "09",
        titulo: "Cómo mantener una postura correcta durante el embarazo",
        imagen:
            "https://i.blogs.es/18e521/1366_2000---2021-07-02t141949.155/1200_900.jpg",
        descripcion:
            "Mantener una postura adecuada durante el embarazo puede ayudar a reducir dolores de espalda y mejorar el bienestar físico.",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: """
            Durante el embarazo el cuerpo cambia constantemente para adaptarse al crecimiento del bebé.

            Esto puede provocar molestias en la espalda, cuello o piernas si no se mantiene una postura adecuada.

            Adoptar buenas posturas al sentarse, caminar o descansar puede ayudar a prevenir dolores y mejorar la comodidad.

            Algunas recomendaciones importantes:

            • Mantén la espalda recta al sentarte.
            • Apoya bien los pies en el suelo.
            • Evita permanecer mucho tiempo en la misma posición.
            • Utiliza almohadas para apoyar la espalda al descansar.
            • Dormir de lado, preferiblemente del lado izquierdo, puede mejorar la circulación.

            Pequeños cambios en la postura diaria pueden ayudarte a sentirte más cómoda durante el embarazo y reducir molestias físicas.
            """,
          ),
        ],
      ),

      ArticuloContenido(
        id: "10",
        titulo: "Cómo preparar tu bolso para el hospital",
        imagen:
            "https://www.petitmicacu.com/server/Portal_0006044_0042017/img/blogposts/como-preparar-la-bolsa-del-hospital-sin-olvidarte-de-nada_1032.jpg",
        descripcion:
            "En las últimas semanas del embarazo es recomendable preparar con anticipación el bolso que llevarás al hospital para el nacimiento de tu bebé.",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: """
            A medida que se acerca la fecha del parto, es importante preparar con anticipación el bolso que llevarás al hospital.

            Tener todo listo te ayudará a sentirte más tranquila cuando llegue el momento.

            Algunas cosas que puedes incluir en tu bolso:

            Para la mamá:
            • Documentos de identidad
            • Historia clínica o controles prenatales
            • Ropa cómoda
            • Artículos de higiene personal
            • Pantuflas o sandalias

            Para el bebé:
            • Ropita para recién nacido
            • Manta o cobija
            • Pañales
            • Gorrito y medias

            También es recomendable guardar todos los documentos importantes en una carpeta para tenerlos a la mano cuando llegues al hospital.

            Preparar el bolso con anticipación te permitirá enfocarte en lo más importante cuando llegue el momento del nacimiento.
            """,
          ),
        ],
      ),

      ArticuloContenido(
        id: "11",
        titulo:
            "La importancia del descanso en las últimas semanas de embarazo",
        imagen:
            "https://portalwinnyprod.blob.core.windows.net/portal-winny-prod/images/El-esquivo-descanso.original_nw12mXT.jpg",
        descripcion:
            "Durante las últimas semanas del embarazo el cuerpo necesita más descanso para prepararse para el parto.",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: """
            En las últimas semanas del embarazo es normal sentir mayor cansancio.

            El cuerpo está realizando un gran esfuerzo para apoyar el crecimiento del bebé y prepararse para el parto.

            Descansar con mayor frecuencia puede ayudarte a sentirte mejor y reducir molestias físicas.

            Algunas recomendaciones:

            • Duerme suficientes horas durante la noche.
            • Si es posible, toma pequeñas siestas durante el día.
            • Evita actividades físicas muy intensas.
            • Eleva ligeramente las piernas cuando descanses para mejorar la circulación.

            Escuchar a tu cuerpo y respetar tus momentos de descanso es fundamental durante esta etapa final del embarazo.
            """,
          ),
        ],
      ),

      ArticuloContenido(
        id: "12",
        titulo: "Qué es un plan de parto y por qué es importante",
        imagen:
            "https://www.suavinex.com/livingsuavinex/wp-content/uploads/2012/02/plan_de_parto_y_nacimiento.jpg",
        descripcion:
            "El plan de parto permite que la madre converse con su médico sobre cómo desea que se desarrolle el nacimiento de su bebé.",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: """
            Un plan de parto es una guía donde la madre puede expresar sus preferencias sobre cómo le gustaría que se desarrolle el nacimiento de su bebé.

            Este plan se conversa previamente con el médico o el personal de salud.

            Algunos aspectos que se pueden incluir en el plan de parto:

            • Quién te acompañará durante el parto.
            • Posiciones para el trabajo de parto.
            • Uso o no de anestesia.
            • Contacto piel con piel con el bebé después del nacimiento.
            • Preferencias sobre la lactancia inmediata.

            Hablar sobre el plan de parto con tu médico te permitirá sentirte más preparada y segura para ese momento tan importante.

            Recuerda que cada parto es diferente, por lo que algunas decisiones pueden adaptarse según las necesidades médicas del momento.
            """,
          ),
        ],
      ),

      ArticuloContenido(
        id: "13",
        titulo: "Alimentación del recién nacido en sus primeros días",
        imagen:
            "https://clubmamasypapas.com/media/mageplaza/blog/post/m/e/mejores-tecnicas-y-consejos-para-una-lactancia-materna-efectiva.jpg",
        descripcion:
            "Durante los primeros días de vida, los recién nacidos necesitan alimentarse con frecuencia para mantenerse hidratados y recibir los nutrientes necesarios.",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: """
            Durante los primeros días de vida, los recién nacidos suelen necesitar alimentación frecuente.

            La mayoría de los bebés se alimentan aproximadamente cada 2 o 3 horas, aunque algunos pueden hacerlo con mayor frecuencia.

            La leche materna es el alimento ideal para el bebé, ya que contiene los nutrientes necesarios y anticuerpos que ayudan a protegerlo de enfermedades.

            Algunas señales de que tu bebé tiene hambre pueden ser:

            • Llevarse las manos a la boca
            • Mover la cabeza buscando el pecho
            • Hacer sonidos o movimientos inquietos

            Intentar alimentar al bebé antes de que llore puede facilitar la lactancia.

            Si tienes dudas sobre la alimentación o notas que tu bebé no se alimenta bien, es recomendable consultar con un profesional de salud.
            """,
          ),
        ],
      ),

      ArticuloContenido(
        id: "14",
        titulo: "Beneficios del contacto piel con piel con tu bebé",
        imagen:
            "http://cdn.shopify.com/s/files/1/0523/3364/1926/files/piel_con_piel_-_gabis_-_madres.jpg?v=1685614321",
        descripcion:
            "El contacto piel con piel entre la madre y el bebé ayuda a fortalecer el vínculo y contribuye a regular la temperatura del recién nacido.",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: """
            El contacto piel con piel consiste en colocar al bebé directamente sobre el pecho de la madre o del padre.

            Este contacto tiene múltiples beneficios para el recién nacido.

            Ayuda a:

            • Regular la temperatura corporal del bebé
            • Estabilizar su respiración
            • Fortalecer el vínculo afectivo
            • Facilitar el inicio de la lactancia

            Durante los primeros días después del nacimiento, el contacto piel con piel puede ayudar al bebé a sentirse seguro y tranquilo.

            También es una experiencia muy especial para los padres, ya que fortalece la conexión emocional con el bebé desde el inicio de su vida.
            """,
          ),
        ],
      ),

      ArticuloContenido(
        id: "15",
        titulo: "La importancia del descanso después del nacimiento del bebé",
        imagen:
            "https://www.salud.mapfre.es/media/2016/07/habitos-descanso-3.jpg",
        descripcion:
            "Después del nacimiento del bebé, el descanso de la madre es fundamental para su recuperación física y bienestar emocional.",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: """
            Después del nacimiento del bebé, el cuerpo de la madre necesita tiempo para recuperarse.

            El cuidado de un recién nacido puede ser demandante, por lo que es importante aprovechar los momentos de descanso.

            Una recomendación común es intentar descansar cuando el bebé duerme.

            Algunas sugerencias que pueden ayudarte:

            • Aprovecha las siestas del bebé para descansar.
            • Pide apoyo a tu pareja o familiares.
            • Evita realizar demasiadas tareas domésticas en los primeros días.
            • Mantente hidratada y aliméntate bien.

            Cuidar de ti misma también es una parte importante del cuidado de tu bebé.
            """,
          ),
        ],
      ),

      ArticuloContenido(
        id: "16",
        titulo: "Tu bebé empieza a reconocer tu voz",
        imagen: "https://i.blogs.es/4895b8/1366_2000/450_1000.jpeg",
        descripcion:
            "Entre las 3 y 8 semanas de vida, los bebés empiezan a reconocer la voz de su madre y de los familiares cercanos, lo que fortalece el vínculo afectivo.",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: """
            Durante las primeras semanas de vida, los bebés desarrollan la capacidad de reconocer voces familiares, especialmente la voz de su madre.

            Esto ayuda a:

            • Generar seguridad y confianza en el bebé.
            • Fortalecer el vínculo afectivo desde los primeros días.
            • Favorecer la calma cuando el bebé se siente inquieto.

            Puedes estimular este reconocimiento:

            • Habla frecuentemente a tu bebé mientras lo alimentas o cambias.
            • Usa tonos suaves y calmados.
            • Cántale canciones de cuna o melodías que le gusten.

            Este vínculo temprano tiene un efecto positivo en el desarrollo emocional y social del bebé a largo plazo.
            """,
          ),
        ],
      ),

      ArticuloContenido(
        id: "17",
        titulo: "Hablarle y cantarle al bebé estimula su desarrollo",
        imagen:
            "https://www.abrazandosudesarrollo.com.mx/media/ezumi1ht/cantarle-a-tu-bebe-promueve-su-desarrollo-3.jpg",
        descripcion:
            "Hablarle y cantarle al bebé no solo fortalece el vínculo afectivo, sino que también estimula su desarrollo cognitivo y sensorial.",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: """
            Hablar y cantar al bebé ayuda a estimular diferentes áreas de su desarrollo.

            Beneficios:

            • Favorece el desarrollo del lenguaje y la comunicación.
            • Estimula la audición y la memoria.
            • Promueve la atención y la concentración.
            • Fortalece la relación afectiva con los cuidadores.

            Algunas ideas:

            • Cuéntale lo que estás haciendo durante el día.
            • Cántale canciones de cuna o melodías suaves.
            • Utiliza gestos y expresiones faciales mientras hablas o cantas.
            • Repite palabras simples y sonidos para que comience a imitarlos.

            Estas prácticas diarias contribuyen a que tu bebé aprenda y se sienta seguro.
            """,
          ),
        ],
      ),

      ArticuloContenido(
        id: "18",
        titulo: "La importancia de la lactancia frecuente",
        imagen:
            "https://www.materna.com.ar/Portals/0/images/articulos/bebe/bebe-3456-preparacion-para-la-lactancia-147309906.jpg",
        descripcion:
            "Mantener la lactancia frecuente asegura que el bebé reciba los nutrientes necesarios y ayuda a establecer una producción de leche adecuada.",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: """
            Durante las primeras semanas de vida, la lactancia frecuente es fundamental para el bienestar del bebé y para establecer correctamente la producción de leche materna.

            Recomendaciones:

            • Alimenta al bebé cada 2–3 horas o según sus señales de hambre.
            • Observa signos de hambre como succión de manos o movimientos inquietos.
            • Asegúrate de que el bebé se prenda correctamente al pecho.
            • Alterna ambos pechos durante cada toma para estimular la producción de leche.

            La lactancia frecuente no solo aporta nutrición, sino que también contribuye al desarrollo afectivo y al vínculo entre madre e hijo.
            """,
          ),
        ],
      ),

      ArticuloContenido(
        id: "19",
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

      ArticuloContenido(
        id: "20",
        titulo: "Interactúa con juegos simples y seguros",
        imagen:
            "https://www.learnandplay.es/images/clases/infantil/ei1/baby1.jpg",
        descripcion:
            "Los juegos sencillos ayudan al desarrollo motor y sensorial del bebé y fortalecen el vínculo afectivo con la madre o cuidador.",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: """
            A partir del segundo mes, el bebé empieza a interactuar más con su entorno.

            Juegos simples y seguros que puedes practicar:

            • Mostrarle tus manos y moverlas lentamente.
            • Sonreír y hacer gestos para que lo imite.
            • Colocar un sonajero a su alcance y dejar que lo observe.
            • Cantar canciones suaves mientras lo sostienes.

            Estos juegos no solo estimulan la motricidad y los sentidos, sino que también fortalecen el vínculo afectivo entre el bebé y la madre o cuidador.
            """,
          ),
        ],
      ),

      ArticuloContenido(
        id: "21",
        titulo: "Mantén controles regulares con el pediatra",
        imagen:
            "https://ed9b43akgvi.exactdn.com/storage/2024/02/Depositphotos_656886526_L.jpg?strip=all",
        descripcion:
            "Las visitas regulares al pediatra son fundamentales para monitorear el crecimiento, desarrollo y salud general del bebé.",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: """
            Durante los primeros meses, las visitas regulares al pediatra son esenciales.

            Durante estos controles, se revisa:

            • Peso y talla del bebé
            • Desarrollo motor y cognitivo
            • Vacunas y calendario de inmunización
            • Signos de alerta o posibles complicaciones

            Algunos consejos:

            • Lleva un registro de las citas y vacunas.
            • Consulta dudas sobre alimentación, sueño y desarrollo.
            • Lleva una lista de preguntas o preocupaciones antes de cada visita.
            • No esperes hasta la cita si notas algo inusual en el bebé.

            Estas visitas aseguran que tu bebé crezca sano y recibas orientación profesional para cualquier situación.
            """,
          ),
        ],
      ),
    ],
  ),

  // ================= PROBLEMAS COMUNES =================
  TemaContenido(
    titulo: "Problemas comunes",
    imagen:
        "https://res.cloudinary.com/dqqhqnbny/image/upload/v1771547695/images_1_axk2io.jpg",
    descripcion:
        "Guía sobre los problemas más frecuentes que enfrentan las madres primerizas durante la lactancia y cómo abordarlos.",
    articulos: [
      ArticuloContenido(
        id: "22",
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
        id: "23",
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
        id: "24",
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
        id: "25",
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
      ArticuloContenido(
        id: "26",
        titulo: "Problemas de agarre del bebé",
        imagen:
            "https://www.fisanfisioterapia.es/wp-content/uploads/2022/03/Titulo-blog.png",
        descripcion:
            "El bebé no se engancha correctamente al pecho, causando dolor o poca ingesta de leche.",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: """
            Un agarre incorrecto puede generar dolor en la madre y frustración en el bebé.  

            Cómo mejorar:  
            • Acerca al bebé al pecho con el cuerpo alineado y su boca bien abierta.  
            • Toma suficiente areola, no solo el pezón.  
            • Prueba distintas posiciones de lactancia: cuna, balón de rugby, acostada de lado.  

            Si el problema persiste, busca la ayuda de un consultor de lactancia certificado.
            """,
          ),
        ],
      ),
    ],
  ),

  // ================= EXTRACCION Y CONSERVACION =================
  TemaContenido(
    titulo: "Extracción y conservación",
    imagen:
        "https://res.cloudinary.com/dqqhqnbny/image/upload/v1771547695/000987235W_x0wd7m.webp",
    descripcion:
        "Guía práctica para extraer, almacenar y conservar la leche materna de manera segura y efectiva.",
    articulos: [
      ArticuloContenido(
        id: "27",
        titulo: "Técnicas de extracción manual",
        imagen:
            "https://blog.lactapp.es/wp-content/uploads/shutterstock_194985809-1038x576.jpg",
        descripcion:
            "Cómo extraer leche materna con las manos de forma segura y efectiva.",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: """
            La extracción manual es útil cuando no se dispone de un sacaleches.  

            Pasos recomendados:  
            • Lava tus manos y esteriliza los recipientes.  
            • Coloca el pulgar y el índice alrededor de la areola, no sobre el pezón.  
            • Haz movimientos rítmicos de compresión y liberación.  
            • Alterna entre ambos pechos durante la sesión.  

            La leche extraída puede almacenarse inmediatamente en recipientes limpios y adecuados.
            """,
          ),
        ],
      ),
      ArticuloContenido(
        id: "28",
        titulo: "Uso correcto del sacaleches",
        imagen: "https://i.blogs.es/edc971/istock-988542166/450_1000.jpg",
        descripcion:
            "Cómo usar sacaleches eléctricos o manuales para extraer leche eficientemente.",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: """
            El sacaleches permite extraer grandes cantidades de leche de manera rápida.  

            Recomendaciones:  
            • Lava tus manos y asegura que todas las piezas estén limpias y esterilizadas.  
            • Ajusta la succión a un nivel cómodo, nunca doloroso.  
            • Extrae leche de ambos pechos alternativamente para mantener la producción.  
            • Guarda la leche inmediatamente en recipientes limpios y etiquetados.  
            """,
          ),
        ],
      ),
      ArticuloContenido(
        id: "29",
        titulo: "Almacenamiento seguro de la leche materna",
        imagen:
            "https://clubmamasypapas.com/media/mageplaza/blog/post/a/l/almacenamiento-de-leche-materna-puntos-clave-que-debes-conocer.jpg",
        descripcion:
            "Cómo almacenar la leche materna para mantener su calidad y nutrientes.",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: """
            Para conservar la leche materna:  
            • A temperatura ambiente (25 °C aprox.): hasta 4 horas.  
            • En refrigerador (4 °C): hasta 4 días.  
            • En congelador (-18 °C): hasta 6 meses.  

            Siempre utiliza recipientes limpios y etiqueta con fecha y hora de extracción.
            """,
          ),
        ],
      ),
      ArticuloContenido(
        id: "30",
        titulo: "Descongelación y calentamiento",
        imagen:
            "https://www.pantai.com.my/images/pantaihospitalmalaysialibraries/health-pulse/thumbnail-health-pulse-proper-breastmilk-storage.webp?sfvrsn=74531ed6_7",
        descripcion:
            "Cómo descongelar y calentar la leche materna sin perder nutrientes.",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: """
            Para descongelar la leche:  
            • Coloca el recipiente en el refrigerador durante varias horas o toda la noche.  
            • También puedes usar un baño maría con agua tibia (no caliente).  

            Nunca uses microondas, ya que puede destruir nutrientes y crear puntos calientes peligrosos para el bebé.
            """,
          ),
        ],
      ),
      ArticuloContenido(
        id: "31",
        titulo: "Higiene y seguridad durante todo el proceso",
        imagen:
            "https://www.infomed.hlg.sld.cu/wp-content/uploads/2025/01/extraccinlechematerna.jpg",
        descripcion:
            "Consejos para mantener la leche materna libre de contaminación.",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: """
            La higiene es clave para proteger al bebé:  
            • Lava siempre tus manos antes de tocar el pecho o los recipientes.  
            • Esteriliza botellas, tetinas y sacaleches regularmente.  
            • Evita mezclar leche recién extraída con leche previamente congelada que ya fue descongelada.  
            • Descarta cualquier leche con olor extraño o apariencia inusual.  
            """,
          ),
        ],
      ),
    ],
  ),

  // ================= LACTANCIA Y ALIMENTACION =================
  TemaContenido(
    titulo: "Lactancia y Alimentación",
    imagen:
        "https://www.losconsejosdetumatrona.com/wp-content/uploads/2021/03/03-01-Recien-Nacido.jpg",
    descripcion:
        "Guía esencial para iniciar la lactancia y alimentación correctamente.",
    articulos: [
      ArticuloContenido(
        id: "42",
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
        id: "43",
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
        id: "44",
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

      // 3. Posición correcta al amamantar
      ArticuloContenido(
        id: "45",
        titulo: "Posición correcta al amamantar",
        imagen:
            "https://static.guiainfantil.com/uploads/Alimentacin/posicionamamantar-p.jpg",
        descripcion:
            "Una postura correcta evita dolor, facilita la succión y asegura que el bebé reciba suficiente leche.",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: """
            Para una lactancia cómoda y efectiva:

            • Asegúrate de que la boca del bebé cubra areola y pezón correctamente.
            • Mantén la espalda y hombros relajados.
            • Apoya el bebé con cojines si es necesario.
            • Alterna los pechos en cada toma para estimular la producción de leche.
            """,
          ),
          ContenidoBloque(
            tipo: TipoBloque.imagen,
            valor:
                "https://smartmedia.digital4danone.com/is/image/danonecs/guide-to-breastfeeding-LATAM?ts=1742213864823&dpr=off",
          ),
        ],
      ),

      // 4. Estimular succión
      ArticuloContenido(
        id: "46",
        titulo: "Estimular succión",
        imagen:
            "https://www.efisioterapia.net/sites/default/files/imagen_articulos/succion.png",
        descripcion:
            "Si el bebé se cansa, masajea suavemente su mandíbula y mejillas para ayudarle a continuar succión y digestión.",
        bloques: [
          ContenidoBloque(
            tipo: TipoBloque.texto,
            valor: """
            La succión efectiva es clave para la nutrición del bebé:

            • Observa si el bebé se separa o se cansa.
            • Masajea suavemente mandíbula y mejillas para estimular la succión.
            • Mantén contacto visual y verbal durante la alimentación.
            • Pausas breves ayudan a evitar sobrealimentación y cólicos.
            """,
          ),
          ContenidoBloque(
            tipo: TipoBloque.imagen,
            valor:
                "https://www.fisioterapia-online.com/sites/default/files/estimulacion_de_la_succion_en_el_bebe.jpg",
          ),
        ],
      ),
    ],
  ),

  // ================= SUEÑO SEGURO =================
  TemaContenido(
    titulo: "Sueño Seguro",
    imagen:
        "https://sisanjuan.b-cdn.net/media/k2/items/cache/106db5f93bb1be2e877fae1383599b8d_XL.jpg?t=20190610_163700",
    descripcion: "Guía para garantizar un sueño seguro y saludable del bebé.",
    articulos: [
      ArticuloContenido(
        id: "47",
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
        id: "48",
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

      // 3. Evitar mantas sueltas
      ArticuloContenido(
        id: "49",
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

      // 4. Ambiente tranquilo
      ArticuloContenido(
        id: "50",
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

      // 5. Supervisión nocturna
      ArticuloContenido(
        id: "51",
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

  // ================= HIGIENE Y BAÑO =================
  TemaContenido(
    titulo: "Higiene y Baño",
    imagen:
        "https://biotexcom.es/wp-content/uploads/2018/11/consejos-practicos-para.jpg",
    descripcion: "Guía para mantener la higiene y cuidado del recién nacido.",
    articulos: [
      // 1. Limpieza del cordón umbilical
      ArticuloContenido(
        id: "52",
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

      // 2. Baño suave
      ArticuloContenido(
        id: "53",
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

      // 3. Cambio de pañal frecuente
      ArticuloContenido(
        id: "54",
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

      // 4. Secar pliegues de la piel
      ArticuloContenido(
        id: "55",
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

      // 5. Evitar cremas fuertes
      ArticuloContenido(
        id: "56",
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
    ],
  ),

  // ================= DESARROLLO Y ESTIMULACION =================
  TemaContenido(
    titulo: 'Desarrollo y estimulacion',
    imagen:
        'https://clubmamasypapas.com/media/mageplaza/blog/post/t/o/top-5-de-juegos-para-la-estimulacion-temprana-de-mi-bebe.jpg',
    descripcion:
        "Guía para estimular y favorecer el desarrollo del recién nacido.",
    articulos: [
      // 1. Contacto piel con piel
      ArticuloContenido(
        id: "57",
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

      // 2. Estimulación visual
      ArticuloContenido(
        id: "58",
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

      // 3. Estimulación auditiva
      ArticuloContenido(
        id: "59",
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

      // 4. Movimientos suaves
      ArticuloContenido(
        id: "60",
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

      // 5. Juegos simples
      ArticuloContenido(
        id: "61",
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
    ],
  ),

  // ================= Recetas para Mamá =================
  TemaContenido(
    titulo: "Recetas para Mamá",
    imagen:
        "https://static.guiainfantil.com/media/4925/c/7-alimentos-estrella-que-te-ayudaran-a-sentirte-mejor-tras-el-parto-lg.jpg",
    descripcion:
        "Recetas nutritivas para apoyar la lactancia y la recuperacion de la madre.",
    articulos: [
      ArticuloContenido(
        id: "62",
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
        id: "63",
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
        id: "64",
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
        id: "65",
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
        id: "66",
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
        id: "67",
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
        id: "68",
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
        id: "69",
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
        id: "70",
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
        id: "71",
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

  // ================= Recetas para el Bebé =================
  TemaContenido(
    titulo: "Recetas para el bebé",
    imagen:
        "https://res.cloudinary.com/dqqhqnbny/image/upload/v1771547938/images_4_s47wfh.jpg",
    descripcion:
        "Recetas suaves y nutritivas para introducir alimentos sólidos al bebé de forma segura.",
    articulos: [
      ArticuloContenido(
        id: "72",
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
        id: "73",
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
        id: "74",
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
        id: "75",
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
        id: "76",
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
        id: "76",
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
        id: "77",
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

  // ================= Alimentos condicionales =================
  TemaContenido(
    titulo: "Alimentarios condicionales",
    imagen:
        "https://res.cloudinary.com/dqqhqnbny/image/upload/v1771547938/images_5_s24o70.jpg",
    descripcion:
        'Alimentos necesarios y recomendados para madres con sintomas de Anemia grave o estan en lactancia exclusiva',
    articulos: [
      ArticuloContenido(
        id: '78',
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
        id: '79',
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
        id: '80',
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
        id: '81',
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
        id: '82',
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
        id: '83',
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
        id: '84',
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
];
