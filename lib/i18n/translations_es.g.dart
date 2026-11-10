///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'translations.g.dart';

// Path: <root>
class TranslationsEs extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsEs({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.es,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <es>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	late final TranslationsEs _root = this; // ignore: unused_field

	@override 
	TranslationsEs $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsEs(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$auth$es auth = _Translations$auth$es._(_root);
	@override late final _Translations$common$es common = _Translations$common$es._(_root);
	@override late final _Translations$contact$es contact = _Translations$contact$es._(_root);
	@override late final _Translations$dashboard$es dashboard = _Translations$dashboard$es._(_root);
	@override late final _Translations$emoji$es emoji = _Translations$emoji$es._(_root);
	@override late final _Translations$errors$es errors = _Translations$errors$es._(_root);
	@override late final _Translations$goals$es goals = _Translations$goals$es._(_root);
	@override late final _Translations$history$es history = _Translations$history$es._(_root);
	@override late final _Translations$legal$es legal = _Translations$legal$es._(_root);
	@override late final _Translations$nav$es nav = _Translations$nav$es._(_root);
	@override late final _Translations$profile$es profile = _Translations$profile$es._(_root);
	@override late final _Translations$session$es session = _Translations$session$es._(_root);
	@override late final _Translations$settings$es settings = _Translations$settings$es._(_root);
	@override late final _Translations$stats$es stats = _Translations$stats$es._(_root);
	@override late final _Translations$templates$es templates = _Translations$templates$es._(_root);
	@override late final _Translations$tempo$es tempo = _Translations$tempo$es._(_root);
}

// Path: auth
class _Translations$auth$es extends Translations$auth$en {
	_Translations$auth$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override late final _Translations$auth$fields$es fields = _Translations$auth$fields$es._(_root);
	@override String get backToLogin => 'Volver al inicio de sesión';
	@override late final _Translations$auth$login$es login = _Translations$auth$login$es._(_root);
	@override late final _Translations$auth$signup$es signup = _Translations$auth$signup$es._(_root);
	@override late final _Translations$auth$onboarding$es onboarding = _Translations$auth$onboarding$es._(_root);
	@override late final _Translations$auth$verifyEmail$es verifyEmail = _Translations$auth$verifyEmail$es._(_root);
	@override late final _Translations$auth$forgotPassword$es forgotPassword = _Translations$auth$forgotPassword$es._(_root);
	@override late final _Translations$auth$updatePassword$es updatePassword = _Translations$auth$updatePassword$es._(_root);
	@override late final _Translations$auth$changePassword$es changePassword = _Translations$auth$changePassword$es._(_root);
	@override late final _Translations$auth$validators$es validators = _Translations$auth$validators$es._(_root);
}

// Path: common
class _Translations$common$es extends Translations$common$en {
	_Translations$common$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override late final _Translations$common$actions$es actions = _Translations$common$actions$es._(_root);
	@override String get unnamed => '(sin nombre)';
	@override late final _Translations$common$units$es units = _Translations$common$units$es._(_root);
	@override late final _Translations$common$date$es date = _Translations$common$date$es._(_root);
	@override late final _Translations$common$language$es language = _Translations$common$language$es._(_root);
}

// Path: contact
class _Translations$contact$es extends Translations$contact$en {
	_Translations$contact$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override late final _Translations$contact$header$es header = _Translations$contact$header$es._(_root);
	@override late final _Translations$contact$sections$es sections = _Translations$contact$sections$es._(_root);
	@override late final _Translations$contact$fields$es fields = _Translations$contact$fields$es._(_root);
	@override String counter({required Object current, required Object max}) => '${current} / ${max}';
	@override String get submit => 'Enviar';
	@override late final _Translations$contact$categories$es categories = _Translations$contact$categories$es._(_root);
	@override late final _Translations$contact$success$es success = _Translations$contact$success$es._(_root);
}

// Path: dashboard
class _Translations$dashboard$es extends Translations$dashboard$en {
	_Translations$dashboard$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override late final _Translations$dashboard$greeting$es greeting = _Translations$dashboard$greeting$es._(_root);
	@override String get defaultName => 'Atleta';
	@override String get seeAll => 'Ver todo';
	@override late final _Translations$dashboard$sections$es sections = _Translations$dashboard$sections$es._(_root);
	@override late final _Translations$dashboard$templates$es templates = _Translations$dashboard$templates$es._(_root);
	@override String exerciseCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} ejercicio',
		other: '${n} ejercicios',
	);
	@override late final _Translations$dashboard$hero$es hero = _Translations$dashboard$hero$es._(_root);
	@override late final _Translations$dashboard$recent$es recent = _Translations$dashboard$recent$es._(_root);
	@override late final _Translations$dashboard$inProgress$es inProgress = _Translations$dashboard$inProgress$es._(_root);
	@override late final _Translations$dashboard$stats$es stats = _Translations$dashboard$stats$es._(_root);
	@override String streakBadge({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} semana seguida',
		other: '${n} semanas seguidas',
	);
	@override late final _Translations$dashboard$consistency$es consistency = _Translations$dashboard$consistency$es._(_root);
}

// Path: emoji
class _Translations$emoji$es extends Translations$emoji$en {
	_Translations$emoji$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override Map<String, String> get groups => {
		'sport': 'Deporte y entrenamiento',
		'body': 'Cuerpo y gestos',
		'energy': 'Energía y símbolos',
		'faces': 'Caras',
		'hearts': 'Corazones',
		'animals': 'Animales',
		'food': 'Comida y bebidas',
		'nature': 'Naturaleza y clima',
		'places': 'Lugares y viajes',
		'objects': 'Objetos y herramientas',
	};
	@override Map<String, String> get labels => {
		'person-lifting-weights': 'Persona levantando pesas',
		'man-lifting-weights': 'Hombre levantando pesas',
		'woman-lifting-weights': 'Mujer levantando pesas',
		'flexed-biceps': 'Bíceps flexionado',
		'boxing-glove': 'Guante de boxeo',
		'martial-arts-uniform': 'Uniforme de artes marciales',
		'person-wrestling': 'Personas luchando',
		'person-running': 'Persona corriendo',
		'man-running': 'Hombre corriendo',
		'woman-running': 'Mujer corriendo',
		'running-shoe': 'Zapatilla de deporte',
		'running-shirt': 'Camiseta de correr',
		'hiking-boot': 'Bota de senderismo',
		'person-walking': 'Persona caminando',
		'person-climbing': 'Persona escalando',
		'person-biking': 'Ciclista',
		'person-mountain-biking': 'Ciclista de montaña',
		'bicycle': 'Bicicleta',
		'person-swimming': 'Nadador',
		'person-surfing': 'Surfista',
		'person-rowing-boat': 'Remero',
		'canoe': 'Canoa',
		'person-in-lotus-position': 'Posición de loto',
		'lotus': 'Loto',
		'person-cartwheeling': 'Voltereta lateral',
		'person-juggling': 'Malabarista',
		'person-bouncing-ball': 'Persona botando un balón',
		'person-playing-handball': 'Balonmano',
		'person-playing-water-polo': 'Waterpolo',
		'person-fencing': 'Esgrima',
		'person-golfing': 'Golfista',
		'horse-racing': 'Carrera de caballos',
		'skier': 'Esquiador',
		'snowboarder': 'Snowboarder',
		'ice-skate': 'Patín de hielo',
		'roller-skate': 'Patín de ruedas',
		'skateboard': 'Monopatín',
		'basketball': 'Balón de baloncesto',
		'soccer-ball': 'Balón de fútbol',
		'american-football': 'Fútbol americano',
		'rugby-football': 'Balón de rugby',
		'tennis': 'Tenis',
		'volleyball': 'Voleibol',
		'baseball': 'Béisbol',
		'ping-pong': 'Ping-pong',
		'badminton': 'Bádminton',
		'field-hockey': 'Hockey sobre hierba',
		'ice-hockey': 'Hockey sobre hielo',
		'bowling': 'Bolos',
		'flying-disc': 'Disco volador',
		'bow-and-arrow': 'Arco y flecha',
		'bullseye': 'Diana',
		'pool-8-ball': 'Bola 8 de billar',
		'parachute': 'Paracaídas',
		'trophy': 'Trofeo',
		'sports-medal': 'Medalla deportiva',
		'1st-place-medal': 'Medalla de oro',
		'2nd-place-medal': 'Medalla de plata',
		'3rd-place-medal': 'Medalla de bronce',
		'military-medal': 'Medalla militar',
		'chequered-flag': 'Bandera de cuadros',
		'triangular-flag': 'Banderín',
		'stadium': 'Estadio',
		'stopwatch': 'Cronómetro',
		'timer-clock': 'Temporizador',
		'alarm-clock': 'Despertador',
		'hourglass-not-done': 'Reloj de arena',
		'leg': 'Pierna',
		'foot': 'Pie',
		'anatomical-heart': 'Corazón anatómico',
		'lungs': 'Pulmones',
		'bone': 'Hueso',
		'brain': 'Cerebro',
		'footprints': 'Huellas',
		'eyes': 'Ojos',
		'raised-fist': 'Puño en alto',
		'oncoming-fist': 'Puño de frente',
		'left-facing-fist': 'Puño hacia la izquierda',
		'right-facing-fist': 'Puño hacia la derecha',
		'thumbs-up': 'Pulgar hacia arriba',
		'clapping-hands': 'Aplausos',
		'raising-hands': 'Manos levantadas',
		'heart-hands': 'Manos formando un corazón',
		'handshake': 'Apretón de manos',
		'folded-hands': 'Manos juntas',
		'victory-hand': 'Signo de victoria',
		'ok-hand': 'Señal de OK',
		'waving-hand': 'Mano saludando',
		'pinched-fingers': 'Dedos juntos',
		'sign-of-the-horns': 'Cuernos',
		'call-me-hand': 'Llámame',
		'crossed-fingers': 'Dedos cruzados',
		'love-you-gesture': 'Gesto de te quiero',
		'sweat-droplets': 'Gotas de sudor',
		'zzz': 'Zzz',
		'person-standing': 'Persona de pie',
		'person-kneeling': 'Persona de rodillas',
		'fire': 'Fuego',
		'high-voltage': 'Rayo',
		'collision': 'Colisión',
		'dizzy': 'Mareo',
		'sparkles': 'Destellos',
		'star': 'Estrella',
		'shooting-star': 'Estrella fugaz',
		'rocket': 'Cohete',
		'flying-saucer': 'Platillo volante',
		'hundred-points': 'Cien puntos',
		'check-mark-button': 'Marca de verificación',
		'battery': 'Batería',
		'light-bulb': 'Bombilla',
		'bomb': 'Bomba',
		'fireworks': 'Fuegos artificiales',
		'party-popper': 'Confeti',
		'confetti-ball': 'Bola de confeti',
		'mirror-ball': 'Bola de discoteca',
		'crown': 'Corona',
		'gem-stone': 'Piedra preciosa',
		'shield': 'Escudo',
		'crossed-swords': 'Espadas cruzadas',
		'infinity': 'Infinito',
		'skull': 'Calavera',
		'skull-and-crossbones': 'Calavera y huesos',
		'ghost': 'Fantasma',
		'alien': 'Alienígena',
		'robot': 'Robot',
		'pile-of-poo': 'Caca',
		'magic-wand': 'Varita mágica',
		'crystal-ball': 'Bola de cristal',
		'grinning-face': 'Cara sonriente',
		'grinning-face-with-big-eyes': 'Cara sonriente con ojos grandes',
		'grinning-face-with-smiling-eyes': 'Cara sonriente con ojos sonrientes',
		'beaming-face-with-smiling-eyes': 'Cara radiante',
		'grinning-squinting-face': 'Risa con ojos cerrados',
		'grinning-face-with-sweat': 'Sonrisa con sudor',
		'face-with-tears-of-joy': 'Lágrimas de alegría',
		'rolling-on-the-floor-laughing': 'Rodando de risa',
		'smiling-face-with-smiling-eyes': 'Cara feliz con ojos sonrientes',
		'smiling-face-with-halo': 'Cara con aureola',
		'smiling-face-with-hearts': 'Cara sonriente con corazones',
		'smiling-face-with-heart-eyes': 'Ojos de corazón',
		'star-struck': 'Ojos de estrella',
		'face-blowing-a-kiss': 'Cara lanzando un beso',
		'face-savoring-food': 'Cara saboreando comida',
		'face-with-tongue': 'Cara sacando la lengua',
		'winking-face': 'Guiño',
		'winking-face-with-tongue': 'Guiño con lengua',
		'zany-face': 'Cara loca',
		'money-mouth-face': 'Cara con dinero en la boca',
		'hugging-face': 'Cara abrazando',
		'face-with-hand-over-mouth': 'Cara con mano sobre la boca',
		'face-with-peeking-eye': 'Cara espiando entre los dedos',
		'shushing-face': 'Cara pidiendo silencio',
		'thinking-face': 'Cara pensativa',
		'saluting-face': 'Cara saludando',
		'zipper-mouth-face': 'Boca cerrada con cremallera',
		'face-with-raised-eyebrow': 'Ceja levantada',
		'neutral-face': 'Cara neutral',
		'unamused-face': 'Cara de poca gracia',
		'smirking-face': 'Sonrisa pícara',
		'drooling-face': 'Cara babeando',
		'sleeping-face': 'Cara durmiendo',
		'face-with-medical-mask': 'Mascarilla',
		'hot-face': 'Cara con calor',
		'cold-face': 'Cara con frío',
		'woozy-face': 'Cara de mareo',
		'face-with-spiral-eyes': 'Ojos en espiral',
		'exploding-head': 'Cabeza explotando',
		'cowboy-hat-face': 'Cara con sombrero vaquero',
		'partying-face': 'Cara de fiesta',
		'disguised-face': 'Cara disfrazada',
		'smiling-face-with-sunglasses': 'Cara con gafas de sol',
		'nerd-face': 'Cara de empollón',
		'face-with-monocle': 'Cara con monóculo',
		'slightly-smiling-face': 'Ligera sonrisa',
		'upside-down-face': 'Cara al revés',
		'melting-face': 'Cara derritiéndose',
		'flushed-face': 'Cara sonrojada',
		'pleading-face': 'Cara suplicante',
		'face-holding-back-tears': 'Cara aguantando las lágrimas',
		'loudly-crying-face': 'Llanto desconsolado',
		'face-screaming-in-fear': 'Cara gritando de miedo',
		'downcast-face-with-sweat': 'Cara abatida con sudor',
		'weary-face': 'Cara agotada',
		'tired-face': 'Cara cansada',
		'yawning-face': 'Bostezo',
		'face-with-steam-from-nose': 'Cara resoplando',
		'angry-face': 'Cara enfadada',
		'smiling-face-with-horns': 'Diablillo',
		'angry-face-with-horns': 'Diablo enfadado',
		'red-heart': 'Corazón rojo',
		'orange-heart': 'Corazón naranja',
		'yellow-heart': 'Corazón amarillo',
		'green-heart': 'Corazón verde',
		'blue-heart': 'Corazón azul',
		'purple-heart': 'Corazón morado',
		'black-heart': 'Corazón negro',
		'white-heart': 'Corazón blanco',
		'pink-heart': 'Corazón rosa',
		'sparkling-heart': 'Corazón brillante',
		'growing-heart': 'Corazón creciente',
		'beating-heart': 'Corazón latiendo',
		'revolving-hearts': 'Corazones giratorios',
		'two-hearts': 'Dos corazones',
		'heart-on-fire': 'Corazón en llamas',
		'mending-heart': 'Corazón recuperándose',
		'broken-heart': 'Corazón roto',
		'heart-with-arrow': 'Corazón con flecha',
		'heart-with-ribbon': 'Corazón con lazo',
		'gorilla': 'Gorila',
		'lion': 'León',
		'tiger': 'Tigre',
		'leopard': 'Leopardo',
		'bear': 'Oso',
		'polar-bear': 'Oso polar',
		'ox': 'Buey',
		'water-buffalo': 'Búfalo de agua',
		'bison': 'Bisonte',
		'cow': 'Vaca',
		'rhinoceros': 'Rinoceronte',
		'elephant': 'Elefante',
		'hippopotamus': 'Hipopótamo',
		'mammoth': 'Mamut',
		'horse': 'Caballo',
		'zebra': 'Cebra',
		'giraffe': 'Jirafa',
		'camel': 'Camello',
		'deer': 'Ciervo',
		'ram': 'Carnero',
		'goat': 'Cabra',
		'pig': 'Cerdo',
		'wolf': 'Lobo',
		'fox': 'Zorro',
		'dog': 'Perro',
		'cat': 'Gato',
		'black-cat': 'Gato negro',
		'monkey': 'Mono',
		'see-no-evil-monkey': 'Mono tapándose los ojos',
		'kangaroo': 'Canguro',
		'rabbit': 'Conejo',
		'hedgehog': 'Erizo',
		'koala': 'Koala',
		'panda': 'Panda',
		'sloth': 'Perezoso',
		'otter': 'Nutria',
		'seal': 'Foca',
		'bat': 'Murciélago',
		'eagle': 'Águila',
		'owl': 'Búho',
		'rooster': 'Gallo',
		'chicken': 'Gallina',
		'baby-chick': 'Pollito',
		'duck': 'Pato',
		'swan': 'Cisne',
		'flamingo': 'Flamenco',
		'peacock': 'Pavo real',
		'parrot': 'Loro',
		'dove': 'Paloma',
		'penguin': 'Pingüino',
		'shark': 'Tiburón',
		'whale': 'Ballena',
		'dolphin': 'Delfín',
		'octopus': 'Pulpo',
		'fish': 'Pez',
		'tropical-fish': 'Pez tropical',
		'crab': 'Cangrejo',
		'lobster': 'Langosta',
		'shrimp': 'Camarón',
		'turtle': 'Tortuga',
		'crocodile': 'Cocodrilo',
		'snake': 'Serpiente',
		'frog': 'Rana',
		't-rex': 'T-Rex',
		'sauropod': 'Saurópodo',
		'dragon': 'Dragón',
		'unicorn': 'Unicornio',
		'butterfly': 'Mariposa',
		'honeybee': 'Abeja',
		'scorpion': 'Escorpión',
		'cut-of-meat': 'Filete',
		'meat-on-bone': 'Carne con hueso',
		'poultry-leg': 'Muslo de pollo',
		'bacon': 'Beicon',
		'egg': 'Huevo',
		'cooked-rice': 'Arroz cocido',
		'steaming-bowl': 'Bol humeante',
		'green-salad': 'Ensalada',
		'broccoli': 'Brócoli',
		'avocado': 'Aguacate',
		'banana': 'Plátano',
		'red-apple': 'Manzana roja',
		'green-apple': 'Manzana verde',
		'pear': 'Pera',
		'peach': 'Melocotón',
		'cherries': 'Cerezas',
		'strawberry': 'Fresa',
		'blueberries': 'Arándanos',
		'grapes': 'Uvas',
		'watermelon': 'Sandía',
		'pineapple': 'Piña',
		'mango': 'Mango',
		'kiwi-fruit': 'Kiwi',
		'lemon': 'Limón',
		'coconut': 'Coco',
		'carrot': 'Zanahoria',
		'potato': 'Patata',
		'tomato': 'Tomate',
		'bell-pepper': 'Pimiento',
		'hot-pepper': 'Chile',
		'eggplant': 'Berenjena',
		'bread': 'Pan',
		'croissant': 'Cruasán',
		'glass-of-milk': 'Vaso de leche',
		'hot-beverage': 'Café',
		'honey-pot': 'Tarro de miel',
		'chocolate-bar': 'Chocolate',
		'cookie': 'Galleta',
		'doughnut': 'Dónut',
		'ice-cream': 'Helado',
		'birthday-cake': 'Tarta de cumpleaños',
		'pancakes': 'Tortitas',
		'popcorn': 'Palomitas',
		'lollipop': 'Piruleta',
		'pizza': 'Pizza',
		'hamburger': 'Hamburguesa',
		'french-fries': 'Patatas fritas',
		'taco': 'Taco',
		'sushi': 'Sushi',
		'fork-and-knife': 'Cubiertos',
		'bottle-with-popping-cork': 'Botella descorchándose',
		'clinking-glasses': 'Brindis',
		'wine-glass': 'Copa de vino',
		'beer-mug': 'Jarra de cerveza',
		'tropical-drink': 'Bebida tropical',
		'sun': 'Sol',
		'sun-with-face': 'Sol con cara',
		'sunrise': 'Amanecer',
		'sunrise-over-mountains': 'Amanecer en la montaña',
		'sunset': 'Atardecer',
		'cloud': 'Nube',
		'cloud-with-rain': 'Lluvia',
		'cloud-with-lightning': 'Tormenta',
		'cloud-with-lightning-and-rain': 'Tormenta con lluvia',
		'snowflake': 'Copo de nieve',
		'rainbow': 'Arcoíris',
		'crescent-moon': 'Luna creciente',
		'full-moon': 'Luna llena',
		'night-with-stars': 'Noche estrellada',
		'milky-way': 'Vía Láctea',
		'mountain': 'Montaña',
		'snow-capped-mountain': 'Montaña nevada',
		'volcano': 'Volcán',
		'desert-island': 'Isla desierta',
		'beach-with-umbrella': 'Playa con sombrilla',
		'water-wave': 'Ola',
		'droplet': 'Gota',
		'tornado': 'Tornado',
		'palm-tree': 'Palmera',
		'cactus': 'Cactus',
		'seedling': 'Brote',
		'four-leaf-clover': 'Trébol de cuatro hojas',
		'sunflower': 'Girasol',
		'rose': 'Rosa',
		'tulip': 'Tulipán',
		'cherry-blossom': 'Flor de cerezo',
		'maple-leaf': 'Hoja de arce',
		'globe-showing-europe-africa': 'Globo terráqueo',
		'globe-with-meridians': 'Globo con meridianos',
		'house': 'Casa',
		'cityscape': 'Ciudad',
		'tent': 'Tienda de campaña',
		'hot-springs': 'Aguas termales',
		'world-map': 'Mapa del mundo',
		'compass': 'Brújula',
		'airplane': 'Avión',
		'automobile': 'Coche',
		'racing-car': 'Coche de carreras',
		'motorcycle': 'Moto',
		'sailboat': 'Velero',
		'gear': 'Engranaje',
		'hammer': 'Martillo',
		'wrench': 'Llave inglesa',
		'hammer-and-wrench': 'Martillo y llave',
		'brick': 'Ladrillo',
		'puzzle-piece': 'Pieza de puzle',
		'game-die': 'Dado',
		'joystick': 'Joystick',
		'video-game': 'Mando de videojuego',
		'headphone': 'Auriculares',
		'musical-note': 'Nota musical',
		'musical-notes': 'Notas musicales',
		'guitar': 'Guitarra',
		'calendar': 'Calendario',
		'mobile-phone': 'Móvil',
		'laptop': 'Portátil',
		'clipboard': 'Portapapeles',
		'memo': 'Nota',
		'pencil': 'Lápiz',
		'chart-increasing': 'Gráfico ascendente',
		'bar-chart': 'Gráfico de barras',
		'balance-scale': 'Balanza',
		'books': 'Libros',
		'open-book': 'Libro abierto',
		'graduation-cap': 'Birrete',
		'money-bag': 'Bolsa de dinero',
		'coin': 'Moneda',
		'locked': 'Candado cerrado',
		'unlocked': 'Candado abierto',
		'key': 'Llave',
		'dna': 'ADN',
		'pill': 'Pastilla',
		'stethoscope': 'Estetoscopio',
		'adhesive-bandage': 'Tirita',
		'speech-balloon': 'Bocadillo de diálogo',
		'thought-balloon': 'Bocadillo de pensamiento',
	};
}

// Path: errors
class _Translations$errors$es extends Translations$errors$en {
	_Translations$errors$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get network => 'Sin conexión de red. Comprueba tu conexión.';
	@override String get notFound => 'Elemento no encontrado.';
	@override String get generic => 'Se produjo un error. Inténtalo de nuevo.';
	@override String get invalidCode => 'Código no válido o caducado.';
	@override String get passwordSameAsOld => 'La nueva contraseña debe ser distinta de la anterior.';
	@override late final _Translations$errors$auth$es auth = _Translations$errors$auth$es._(_root);
}

// Path: goals
class _Translations$goals$es extends Translations$goals$en {
	_Translations$goals$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get strength => 'Fuerza';
	@override String get hypertrophy => 'Hipertrofia';
	@override String get endurance => 'Resistencia';
	@override String get weightLoss => 'Pérdida de peso';
	@override String get maintenance => 'Mantenimiento';
}

// Path: history
class _Translations$history$es extends Translations$history$en {
	_Translations$history$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Historial';
	@override String get emptySubtitle => 'Sin sesiones';
	@override String get emptyTitle => 'Aún no hay sesiones';
	@override String get emptyMessage => 'Inicia tu primera sesión desde la pantalla de inicio — aparecerá aquí.';
	@override String sessionCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} sesión',
		other: '${n} sesiones',
	);
	@override String get deleteError => 'Error al eliminar.';
	@override late final _Translations$history$groups$es groups = _Translations$history$groups$es._(_root);
	@override late final _Translations$history$panel$es panel = _Translations$history$panel$es._(_root);
	@override late final _Translations$history$detail$es detail = _Translations$history$detail$es._(_root);
}

// Path: legal
class _Translations$legal$es extends Translations$legal$en {
	_Translations$legal$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get onlyInEnglish => 'Este documento solo está disponible en inglés.';
}

// Path: nav
class _Translations$nav$es extends Translations$nav$en {
	_Translations$nav$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get home => 'Inicio';
	@override String get program => 'Programas';
	@override String get history => 'Historial';
	@override String get stats => 'Estadísticas';
	@override String get settings => 'Ajustes';
}

// Path: profile
class _Translations$profile$es extends Translations$profile$en {
	_Translations$profile$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get notConnected => 'No has iniciado sesión.';
	@override String get navTitle => 'PERFIL';
	@override String get defaultName => 'Atleta';
	@override String since({required Object month}) => 'Desde ${month}';
	@override late final _Translations$profile$editSheet$es editSheet = _Translations$profile$editSheet$es._(_root);
	@override late final _Translations$profile$sections$es sections = _Translations$profile$sections$es._(_root);
	@override late final _Translations$profile$stats$es stats = _Translations$profile$stats$es._(_root);
	@override String sessionCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} sesión',
		other: '${n} sesiones',
	);
	@override late final _Translations$profile$badges$es badges = _Translations$profile$badges$es._(_root);
	@override late final _Translations$profile$avatar$es avatar = _Translations$profile$avatar$es._(_root);
	@override late final _Translations$profile$editForm$es editForm = _Translations$profile$editForm$es._(_root);
}

// Path: session
class _Translations$session$es extends Translations$session$en {
	_Translations$session$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get bw => 'PC';
	@override String get continueLabel => 'Continuar';
	@override late final _Translations$session$error$es error = _Translations$session$error$es._(_root);
	@override late final _Translations$session$live$es live = _Translations$session$live$es._(_root);
	@override late final _Translations$session$confirm$es confirm = _Translations$session$confirm$es._(_root);
	@override late final _Translations$session$add$es add = _Translations$session$add$es._(_root);
	@override late final _Translations$session$swap$es swap = _Translations$session$swap$es._(_root);
	@override late final _Translations$session$variants$es variants = _Translations$session$variants$es._(_root);
	@override late final _Translations$session$finish$es finish = _Translations$session$finish$es._(_root);
	@override late final _Translations$session$timer$es timer = _Translations$session$timer$es._(_root);
	@override late final _Translations$session$rest$es rest = _Translations$session$rest$es._(_root);
	@override late final _Translations$session$set$es set = _Translations$session$set$es._(_root);
	@override late final _Translations$session$exercise$es exercise = _Translations$session$exercise$es._(_root);
	@override late final _Translations$session$overview$es overview = _Translations$session$overview$es._(_root);
	@override late final _Translations$session$superset$es superset = _Translations$session$superset$es._(_root);
	@override late final _Translations$session$duration$es duration = _Translations$session$duration$es._(_root);
	@override late final _Translations$session$weight$es weight = _Translations$session$weight$es._(_root);
	@override late final _Translations$session$search$es search = _Translations$session$search$es._(_root);
	@override late final _Translations$session$history$es history = _Translations$session$history$es._(_root);
	@override late final _Translations$session$fields$es fields = _Translations$session$fields$es._(_root);
	@override late final _Translations$session$toast$es toast = _Translations$session$toast$es._(_root);
	@override late final _Translations$session$notif$es notif = _Translations$session$notif$es._(_root);
}

// Path: settings
class _Translations$settings$es extends Translations$settings$en {
	_Translations$settings$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ajustes';
	@override late final _Translations$settings$sections$es sections = _Translations$settings$sections$es._(_root);
	@override String get defaultName => 'Atleta';
	@override String get editProfile => 'EDITAR';
	@override String get profileUnavailable => 'Perfil no disponible';
	@override late final _Translations$settings$rows$es rows = _Translations$settings$rows$es._(_root);
	@override String get soon => 'Pronto';
	@override String get soonToast => 'Próximamente';
	@override late final _Translations$settings$logout$es logout = _Translations$settings$logout$es._(_root);
	@override String get version => 'Repster v1.0 · Entrena, progresa, repite.';
	@override late final _Translations$settings$language$es language = _Translations$settings$language$es._(_root);
}

// Path: stats
class _Translations$stats$es extends Translations$stats$en {
	_Translations$stats$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Estadísticas';
	@override String sessionsCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} sesión',
		other: '${n} sesiones',
	);
	@override String weeksShort({required Object n}) => '${n} sem.';
	@override late final _Translations$stats$subtitle$es subtitle = _Translations$stats$subtitle$es._(_root);
	@override late final _Translations$stats$empty$es empty = _Translations$stats$empty$es._(_root);
	@override late final _Translations$stats$range$es range = _Translations$stats$range$es._(_root);
	@override late final _Translations$stats$kpi$es kpi = _Translations$stats$kpi$es._(_root);
	@override late final _Translations$stats$weeklyVolume$es weeklyVolume = _Translations$stats$weeklyVolume$es._(_root);
	@override late final _Translations$stats$exercise$es exercise = _Translations$stats$exercise$es._(_root);
	@override late final _Translations$stats$records$es records = _Translations$stats$records$es._(_root);
	@override late final _Translations$stats$strength$es strength = _Translations$stats$strength$es._(_root);
}

// Path: templates
class _Translations$templates$es extends Translations$templates$en {
	_Translations$templates$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override late final _Translations$templates$list$es list = _Translations$templates$list$es._(_root);
	@override late final _Translations$templates$card$es card = _Translations$templates$card$es._(_root);
	@override late final _Translations$templates$detail$es detail = _Translations$templates$detail$es._(_root);
	@override late final _Translations$templates$editor$es editor = _Translations$templates$editor$es._(_root);
	@override late final _Translations$templates$fields$es fields = _Translations$templates$fields$es._(_root);
	@override late final _Translations$templates$slot$es slot = _Translations$templates$slot$es._(_root);
	@override late final _Translations$templates$emojiPicker$es emojiPicker = _Translations$templates$emojiPicker$es._(_root);
	@override late final _Translations$templates$programs$es programs = _Translations$templates$programs$es._(_root);
}

// Path: tempo
class _Translations$tempo$es extends Translations$tempo$en {
	_Translations$tempo$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get helper => 'Excéntrica — pausa — concéntrica — pausa (en s)';
	@override String get formatError => 'Formato esperado: 3-1-X-0';
}

// Path: auth.fields
class _Translations$auth$fields$es extends Translations$auth$fields$en {
	_Translations$auth$fields$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get email => 'Correo electrónico';
	@override String get password => 'Contraseña';
}

// Path: auth.login
class _Translations$auth$login$es extends Translations$auth$login$en {
	_Translations$auth$login$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get welcomeTitle => 'Qué bueno verte de nuevo';
	@override String get welcomeSubtitle => 'Inicia sesión para continuar.';
	@override String get forgotPassword => '¿Olvidaste tu contraseña?';
	@override String get submit => 'Iniciar sesión';
	@override String get submitLoading => 'Iniciando sesión…';
	@override String get noAccount => '¿Aún no tienes cuenta?';
	@override String get createAccount => 'Crear una cuenta';
}

// Path: auth.signup
class _Translations$auth$signup$es extends Translations$auth$signup$en {
	_Translations$auth$signup$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Crear una cuenta';
	@override String get subtitle => 'Únete a miles de atletas.';
	@override String get passwordHint => 'Contraseña (8 car. mín.)';
	@override String get submit => 'Crear mi cuenta';
	@override String get submitLoading => 'Creando…';
	@override String get termsPrefix => 'Al crear una cuenta, aceptas nuestras ';
	@override String get termsLink => 'condiciones de uso';
}

// Path: auth.onboarding
class _Translations$auth$onboarding$es extends Translations$auth$onboarding$en {
	_Translations$auth$onboarding$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get step1Title => '¿Cómo te\nllamas?';
	@override String get step1Subtitle => 'Para personalizar tu experiencia.';
	@override String get nameHint => 'Tu nombre';
	@override String get continueLabel => 'Continuar';
	@override String get step2Title => '¿Cuál es tu\nobjetivo?';
	@override String get step2Subtitle => 'Adaptaremos tus sesiones en consecuencia.';
	@override String get step3Title => 'Algunos datos';
	@override String get optional => 'Opcional';
	@override String get step3Subtitle => 'Para recomendaciones más precisas.';
	@override String get weightHint => 'Peso (kg)';
	@override String get heightHint => 'Altura (cm)';
	@override String get birthdate => 'Fecha de nacimiento';
	@override String get submit => '¡Vamos!';
	@override String get submitLoading => 'Guardando…';
	@override String get skip => 'Omitir este paso';
	@override late final _Translations$auth$onboarding$goalDescriptions$es goalDescriptions = _Translations$auth$onboarding$goalDescriptions$es._(_root);
	@override String get nameRequired => 'Tu nombre es obligatorio.';
	@override String get nameTooLong => 'Nombre demasiado largo.';
	@override String get goalRequired => 'Elige un objetivo.';
	@override String get weightInvalid => 'Peso no válido';
	@override String get heightInvalid => 'Altura no válida';
}

// Path: auth.verifyEmail
class _Translations$auth$verifyEmail$es extends Translations$auth$verifyEmail$en {
	_Translations$auth$verifyEmail$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Verifica tu correo';
	@override String get subtitle => 'Enviamos un código de 6 dígitos';
	@override String get submitLoading => 'Verificando…';
	@override String get submitComplete => 'Verificar el código';
	@override String get submitIncomplete => 'Introduce el código recibido';
	@override String get noCode => '¿No recibiste el código?';
	@override String get resent => '¡Código reenviado!';
	@override String resendCooldown({required Object n}) => 'Reenviar en ${n}s';
	@override String get resending => 'Enviando…';
	@override String get resend => 'Reenviar el código';
	@override String get emailMissing => 'Falta el correo. Vuelve al registro.';
}

// Path: auth.forgotPassword
class _Translations$auth$forgotPassword$es extends Translations$auth$forgotPassword$en {
	_Translations$auth$forgotPassword$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Contraseña olvidada';
	@override String get subtitle => 'Te enviaremos un enlace de restablecimiento';
	@override String get submit => 'Enviar el enlace';
	@override String get submitLoading => 'Enviando…';
	@override String get successMessage => 'Se ha enviado un enlace de restablecimiento a tu correo electrónico. Revisa tu bandeja de entrada.';
}

// Path: auth.updatePassword
class _Translations$auth$updatePassword$es extends Translations$auth$updatePassword$en {
	_Translations$auth$updatePassword$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Nueva contraseña';
	@override String get subtitle => 'Elige una contraseña segura';
	@override String get newHint => 'Nueva contraseña';
	@override String get confirmHint => 'Confirmar la contraseña';
	@override String get submit => 'Guardar la contraseña';
	@override String get submitLoading => 'Guardando…';
}

// Path: auth.changePassword
class _Translations$auth$changePassword$es extends Translations$auth$changePassword$en {
	_Translations$auth$changePassword$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Cambiar la contraseña';
	@override String get subtitle => 'Por tu seguridad, confirma tu contraseña actual antes de elegir una nueva.';
	@override String get currentHint => 'Contraseña actual';
	@override String get newHint => 'Nueva contraseña';
	@override String get confirmHint => 'Confirmar la nueva contraseña';
	@override String get submit => 'Actualizar la contraseña';
	@override String get submitLoading => 'Actualizando…';
	@override String get successToast => 'Contraseña actualizada';
	@override String get currentRequired => 'Contraseña actual obligatoria';
	@override String get mustDiffer => 'La nueva contraseña debe ser diferente de la actual';
	@override String get currentIncorrect => 'Contraseña actual incorrecta';
}

// Path: auth.validators
class _Translations$auth$validators$es extends Translations$auth$validators$en {
	_Translations$auth$validators$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get emailRequired => 'Correo obligatorio';
	@override String get emailInvalid => 'Correo no válido';
	@override String get passwordRequired => 'Contraseña obligatoria';
	@override String get passwordMin => 'Mínimo 8 caracteres';
	@override String get passwordMismatch => 'Las contraseñas no coinciden';
}

// Path: common.actions
class _Translations$common$actions$es extends Translations$common$actions$en {
	_Translations$common$actions$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get cancel => 'Cancelar';
	@override String get confirm => 'Confirmar';
	@override String get save => 'Guardar';
	@override String get retry => 'Reintentar';
	@override String get delete => 'Eliminar';
	@override String get close => 'Cerrar';
	@override String get edit => 'Editar';
	@override String get done => 'Hecho';
	@override String get next => 'Siguiente';
	@override String get back => 'Atrás';
}

// Path: common.units
class _Translations$common$units$es extends Translations$common$units$en {
	_Translations$common$units$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get reps => 'reps';
}

// Path: common.date
class _Translations$common$date$es extends Translations$common$date$en {
	_Translations$common$date$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get justNow => 'ahora mismo';
	@override String minutesAgo({required Object n}) => 'hace ${n} min';
	@override String hoursAgo({required Object n}) => 'hace ${n} h';
	@override String get yesterday => 'ayer';
	@override String daysAgo({required Object n}) => 'hace ${n} d';
	@override String get today => 'hoy';
	@override String weeksAgo({required Object n}) => 'hace ${n} sem';
	@override String monthsAgo({required Object n}) => 'hace ${n} meses';
}

// Path: common.language
class _Translations$common$language$es extends Translations$common$language$en {
	_Translations$common$language$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get en => 'Inglés';
	@override String get fr => 'Francés';
	@override String get es => 'Español';
	@override String get de => 'Alemán';
	@override String get it => 'Italiano';
}

// Path: contact.header
class _Translations$contact$header$es extends Translations$contact$header$en {
	_Translations$contact$header$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Contacto y feedback';
	@override String get subtitle => '¿Un error, una idea, una pregunta? Escríbenos, lo leemos todo.';
}

// Path: contact.sections
class _Translations$contact$sections$es extends Translations$contact$sections$en {
	_Translations$contact$sections$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get type => 'Tipo de solicitud';
	@override String get yourInfo => 'Tus datos';
	@override String get message => 'Mensaje';
}

// Path: contact.fields
class _Translations$contact$fields$es extends Translations$contact$fields$en {
	_Translations$contact$fields$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get nameHint => 'Tu nombre';
	@override String get nameRequired => 'Nombre obligatorio';
	@override String get emailHint => 'Tu dirección de correo';
	@override String get emailInvalid => 'Correo no válido';
	@override String get messageTooShort => 'Mensaje demasiado corto (10 caracteres mín.)';
}

// Path: contact.categories
class _Translations$contact$categories$es extends Translations$contact$categories$en {
	_Translations$contact$categories$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override late final _Translations$contact$categories$bug$es bug = _Translations$contact$categories$bug$es._(_root);
	@override late final _Translations$contact$categories$feature$es feature = _Translations$contact$categories$feature$es._(_root);
	@override late final _Translations$contact$categories$general$es general = _Translations$contact$categories$general$es._(_root);
	@override late final _Translations$contact$categories$other$es other = _Translations$contact$categories$other$es._(_root);
}

// Path: contact.success
class _Translations$contact$success$es extends Translations$contact$success$en {
	_Translations$contact$success$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Mensaje enviado';
	@override String get back => 'Volver a los ajustes';
}

// Path: dashboard.greeting
class _Translations$dashboard$greeting$es extends Translations$dashboard$greeting$en {
	_Translations$dashboard$greeting$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get morning => 'Buenos días';
	@override String get afternoon => 'Buenas tardes';
	@override String get evening => 'Buenas noches';
}

// Path: dashboard.sections
class _Translations$dashboard$sections$es extends Translations$dashboard$sections$en {
	_Translations$dashboard$sections$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get templates => 'Programa';
	@override String get recentSessions => 'Últimas sesiones';
}

// Path: dashboard.templates
class _Translations$dashboard$templates$es extends Translations$dashboard$templates$en {
	_Translations$dashboard$templates$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get empty => 'Aún no hay sesiones';
	@override String get newLabel => 'Nueva';
}

// Path: dashboard.hero
class _Translations$dashboard$hero$es extends Translations$dashboard$hero$en {
	_Translations$dashboard$hero$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get eyebrow => 'PRÓXIMA SESIÓN';
	@override String get start => 'Empezar sesión';
	@override String get emptyTitle => 'Crea tu primera sesión';
	@override String get emptyMessage => 'Configura tus ejercicios y a por ello.';
	@override String get create => 'Crear una sesión';
	@override String duration({required Object n}) => '≈ ${n} min';
}

// Path: dashboard.recent
class _Translations$dashboard$recent$es extends Translations$dashboard$recent$en {
	_Translations$dashboard$recent$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get emptyTitle => '¡Inicia tu primera sesión!';
	@override String get emptyMessage => 'Elige una sesión y a por ello.';
	@override String get tonnage => 'tonelaje';
}

// Path: dashboard.inProgress
class _Translations$dashboard$inProgress$es extends Translations$dashboard$inProgress$en {
	_Translations$dashboard$inProgress$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get label => 'SESIÓN EN CURSO';
	@override String startedAt({required Object when}) => 'Empezada ${when}';
	@override String get resume => 'Reanudar';
	@override String get discard => 'Abandonar';
	@override String get discardTitle => '¿Abandonar la sesión?';
	@override String get discardMessage => 'Se perderán todos los datos en curso.';
	@override String get discardError => 'Error — inténtalo de nuevo.';
}

// Path: dashboard.stats
class _Translations$dashboard$stats$es extends Translations$dashboard$stats$en {
	_Translations$dashboard$stats$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get sessions => 'Sesiones';
	@override String get volume => 'Volumen';
	@override String get streak => 'Racha';
	@override String get thisWeek => 'esta sem.';
	@override String weekCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'semana',
		other: 'semanas',
	);
	@override String streakLabel({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'semana\nseguida',
		other: 'semanas\nseguidas',
	);
	@override String get sessionsWeek => 'sesiones\nesta semana';
	@override String get volumeWeek => 'volumen\nesta semana';
}

// Path: dashboard.consistency
class _Translations$dashboard$consistency$es extends Translations$dashboard$consistency$en {
	_Translations$dashboard$consistency$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Constancia';
	@override String get trainingDays => 'días activos';
	@override String get perWeek => 'sesiones / sem.';
	@override String get bestStreak => 'mejor racha';
	@override String get noStreak => 'sin racha';
	@override String weeksShort({required Object n}) => '${n} sem.';
	@override String get notYet => 'Tu ritmo de entrenamiento aparecerá aquí tras tu primera sesión.';
}

// Path: errors.auth
class _Translations$errors$auth$es extends Translations$errors$auth$en {
	_Translations$errors$auth$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get invalidCredentials => 'Correo o contraseña incorrectos.';
	@override String get emailNotConfirmed => 'Confirma tu correo antes de iniciar sesión.';
	@override String get userAlreadyExists => 'Ya existe una cuenta con este correo.';
	@override String get sessionExpired => 'Sesión caducada. Vuelve a iniciar sesión.';
	@override String get notSignedIn => 'Debes iniciar sesión.';
}

// Path: history.groups
class _Translations$history$groups$es extends Translations$history$groups$en {
	_Translations$history$groups$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get thisWeek => 'Esta semana';
	@override String get lastWeek => 'Semana pasada';
	@override String weeksAgo({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'hace ${n} semana',
		other: 'hace ${n} semanas',
	);
}

// Path: history.panel
class _Translations$history$panel$es extends Translations$history$panel$en {
	_Translations$history$panel$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get sessions => 'Sesiones';
	@override String get volume => 'Volumen';
	@override String get time => 'Tiempo';
}

// Path: history.detail
class _Translations$history$detail$es extends Translations$history$detail$en {
	_Translations$history$detail$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Sesión';
	@override String get dateFormat => 'EEEE d \'de\' MMMM \'a las\' HH:mm';
	@override String get duration => 'Duración';
	@override String get tonnage => 'Tonelaje';
	@override String get sets => 'Series';
	@override String get notes => 'Notas';
	@override String get perExercise => 'Detalle por ejercicio';
	@override String setsCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} serie',
		other: '${n} series',
	);
	@override String get bodyweight => 'Peso corporal';
	@override String get colSet => 'Serie';
	@override String get colReps => 'Reps';
	@override String get colLoad => 'Carga';
	@override String get colHeld => 'Tiempo';
	@override String get totalExercise => 'Total ejercicio';
	@override String get totalHeld => 'Total tiempo';
	@override late final _Translations$history$detail$edit$es edit = _Translations$history$detail$edit$es._(_root);
}

// Path: profile.editSheet
class _Translations$profile$editSheet$es extends Translations$profile$editSheet$en {
	_Translations$profile$editSheet$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Editar perfil';
}

// Path: profile.sections
class _Translations$profile$sections$es extends Translations$profile$sections$en {
	_Translations$profile$sections$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get badges => 'Insignias';
}

// Path: profile.stats
class _Translations$profile$stats$es extends Translations$profile$stats$en {
	_Translations$profile$stats$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get sessions => 'Sesiones';
	@override String get tonnage => 'Tonelaje';
	@override String get sets => 'Series';
}

// Path: profile.badges
class _Translations$profile$badges$es extends Translations$profile$badges$en {
	_Translations$profile$badges$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get empty => '¡Empieza tu primera sesión para desbloquear insignias!';
	@override String get firstSession => 'Primera sesión';
	@override String get tenSessions => '10 sesiones';
	@override String get tenTonnes => '10 toneladas';
	@override String get planner => 'Planificador';
}

// Path: profile.avatar
class _Translations$profile$avatar$es extends Translations$profile$avatar$en {
	_Translations$profile$avatar$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get sheetTitle => 'Foto de perfil';
	@override String get takePhoto => 'Tomar una foto';
	@override String get gallery => 'Galería de fotos';
	@override String get remove => 'Eliminar la foto';
	@override String get openError => 'No se pudo abrir la foto.';
	@override String get updated => '¡Foto actualizada!';
	@override String get saveError => 'No se pudo guardar la foto.';
	@override String get removed => 'Foto eliminada.';
	@override String get removeError => 'No se pudo eliminar la foto.';
}

// Path: profile.editForm
class _Translations$profile$editForm$es extends Translations$profile$editForm$en {
	_Translations$profile$editForm$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get saved => 'Perfil actualizado.';
	@override String get pickDate => 'Elegir una fecha';
	@override late final _Translations$profile$editForm$sections$es sections = _Translations$profile$editForm$sections$es._(_root);
	@override late final _Translations$profile$editForm$fields$es fields = _Translations$profile$editForm$fields$es._(_root);
	@override late final _Translations$profile$editForm$validation$es validation = _Translations$profile$editForm$validation$es._(_root);
}

// Path: session.error
class _Translations$session$error$es extends Translations$session$error$en {
	_Translations$session$error$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get startFailed => 'No se pudo iniciar la sesión.';
	@override String get saveFailed => 'Error al guardar.';
	@override String get templateUpdateFailed => 'Sesión guardada, pero no se pudo actualizar el programa.';
}

// Path: session.live
class _Translations$session$live$es extends Translations$session$live$en {
	_Translations$session$live$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String exercisePosition({required Object current, required Object total}) => 'Ejercicio ${current} / ${total}';
	@override String supersetPosition({required Object current, required Object total}) => 'Superserie ${current} / ${total}';
	@override String headerSubtitle({required Object completed, required Object total, required Object time}) => '${completed}/${total} series · ${time}';
	@override String get totalTonnage => 'Tonelaje total';
	@override String get nextExercise => 'Siguiente ejercicio';
	@override String get nextBlock => 'Siguiente bloque';
	@override String get finishSession => 'Terminar sesión';
}

// Path: session.confirm
class _Translations$session$confirm$es extends Translations$session$confirm$en {
	_Translations$session$confirm$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get quitTitle => '¿Abandonar la sesión?';
	@override String get quitMessage => 'Se perderá todo el progreso.';
	@override String get quitConfirm => 'Abandonar';
	@override String get inProgressTitle => 'Ya hay una sesión en curso';
	@override String inProgressMessage({required Object name, required Object date}) => '«${name}» se inició ${date}. Iniciar una nueva eliminará definitivamente su progreso.';
	@override String get overwriteAndStart => 'Sobrescribir e iniciar';
	@override String deleteExerciseTitle({required Object name}) => '¿Eliminar «${name}»?';
	@override String deleteExerciseMessage({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: 'Este ejercicio ya tiene ${n} serie completada. Se perderá.',
		other: 'Este ejercicio ya tiene ${n} series completadas. Se perderán.',
	);
	@override String get removeSessionOnly => 'Solo en esta sesión';
	@override String get removeFromTemplate => 'También del programa';
}

// Path: session.add
class _Translations$session$add$es extends Translations$session$add$en {
	_Translations$session$add$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Añadir un ejercicio';
	@override String get subtitle => 'Se añade solo a esta sesión, sin modificar el programa.';
	@override String get addLabel => 'Añadir';
	@override String get addToSession => 'Añadir a la sesión';
	@override String get reps => 'Repeticiones';
	@override String get time => 'Tiempo';
	@override String get addAndTemplate => 'Añadir a la sesión y al programa';
}

// Path: session.swap
class _Translations$session$swap$es extends Translations$session$swap$en {
	_Translations$session$swap$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Editar ejercicio';
	@override String currently({required Object name}) => 'Actualmente: ${name}';
	@override String get sessionOnly => 'Estos cambios solo se aplican a esta sesión.';
	@override String get useLabel => 'Usar';
	@override String get adoptFormat => 'Adoptar el formato';
	@override String adoptFormatSummary({required Object summary, required Object name}) => '${summary} · según «${name}»';
	@override String get apply => 'Aplicar a esta sesión';
	@override String get applyAndTemplate => 'Aplicar y actualizar el programa';
}

// Path: session.variants
class _Translations$session$variants$es extends Translations$session$variants$en {
	_Translations$session$variants$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Elegir una variante';
	@override String get lockedMessage => 'Ya hay una serie completada — termina el ejercicio o usa «Cambiar» para ajustar sobre la marcha.';
	@override String get pickMessage => 'Elige una variante para este espacio. Reemplazará el ejercicio actual.';
	@override String get empty => 'No hay ninguna variante definida para este ejercicio.';
	@override String get main => 'PRINCIPAL';
	@override String variantN({required Object n}) => 'Variante ${n}';
	@override String restSeconds({required Object n}) => '${n}s descanso';
	@override String tempoPart({required Object tempo}) => ' · tempo ${tempo}';
}

// Path: session.finish
class _Translations$session$finish$es extends Translations$session$finish$en {
	_Translations$session$finish$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => '¿Terminar sesión?';
	@override String summaryReps({required Object completed, required Object total}) => '${completed}/${total} series · ';
	@override String get summaryTonnageSuffix => ' de tonelaje';
	@override String get notesHint => 'Notas sobre la sesión (opcional)…';
	@override String get confirm => 'Terminar';
	@override String unvalidatedSets({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} SERIE SIN VALIDAR',
		other: '${n} SERIES SIN VALIDAR',
	);
	@override String get incompleteHint => 'Puedes volver a validar tus series o terminar de todos modos — solo se guardarán las series marcadas.';
	@override String get templateLabel => 'ACTUALIZACIÓN DEL PROGRAMA';
	@override String templateToggle({required Object name}) => 'Actualizar «${name}»';
	@override String get templateHint => 'Los cambios marcados durante la sesión. Desactívalo para dejar el programa como está.';
	@override String changeAdded({required Object name}) => '${name} · añadido';
	@override String changeModified({required Object name}) => '${name} · modificado';
	@override String changeRemoved({required Object name}) => '${name} · quitado';
}

// Path: session.timer
class _Translations$session$timer$es extends Translations$session$timer$en {
	_Translations$session$timer$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get preparation => 'PREPARACIÓN';
	@override String get running => 'EN CURSO';
	@override String get done => 'TERMINADO';
	@override String get go => 'YA';
	@override String get stop => 'Detener';
}

// Path: session.rest
class _Translations$session$rest$es extends Translations$session$rest$en {
	_Translations$session$rest$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'DESCANSO';
	@override String get sec => 'SEG';
	@override String get skip => 'Saltar';
	@override String get minimize => 'Minimizar';
}

// Path: session.set
class _Translations$session$set$es extends Translations$session$set$en {
	_Translations$session$set$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get addSet => 'Añadir una serie';
	@override String setLabel({required Object n}) => 'Serie ${n}';
	@override String get reps => 'Reps';
	@override String get load => 'Carga';
	@override String get duration => 'Duración';
	@override String get held => 'Aguantado';
	@override String get tonnage => 'TONELAJE';
	@override String targetReps({required Object n}) => 'objetivo ${n} reps';
	@override String targetDuration({required Object value}) => 'objetivo ${value}';
	@override String get validateWithoutTimer => 'Validar sin temporizador';
	@override String get cmpUp => 'Top';
}

// Path: session.exercise
class _Translations$session$exercise$es extends Translations$session$exercise$en {
	_Translations$session$exercise$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get timed => 'Cronometrado';
	@override String tempoChip({required Object tempo}) => 'Tempo ${tempo}';
	@override String restChip({required Object n}) => '${n}s descanso';
	@override String get modified => 'Modificado · solo esta sesión';
	@override String modifiedWas({required Object name}) => 'Modificado · solo esta sesión (era: ${name})';
	@override String get completedBadge => '✓ Hecho';
	@override String totalHeld({required Object value}) => 'Total aguantado: ${value}';
	@override String exerciseVolume({required Object value}) => 'Volumen del ejercicio: ${value} kg';
	@override String get lastTimeLabel => 'Última vez';
	@override String get otherWorkout => 'otra sesión';
	@override String targetWasReps({required Object n}) => 'buscaba ${n} reps';
	@override String targetWasSeconds({required Object n}) => 'buscaba ${n}s';
	@override String morePerfs({required Object n}) => '+${n}';
	@override String get keptInTemplate => 'Modificado · se guardará en el programa';
	@override String keptInTemplateWas({required Object name}) => 'Modificado · se guardará en el programa (antes: ${name})';
	@override String get keepInTemplateAction => 'Toca para conservar este cambio en el programa';
}

// Path: session.overview
class _Translations$session$overview$es extends Translations$session$overview$en {
	_Translations$session$overview$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ejercicios';
	@override String get current => 'EN CURSO';
	@override String setsValidated({required Object completed, required Object total}) => '${completed}/${total} series validadas';
}

// Path: session.superset
class _Translations$session$superset$es extends Translations$session$superset$en {
	_Translations$session$superset$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String badge({required Object n}) => 'SUPERSERIE · ${n} EJERCICIOS';
	@override String addSetTo({required Object letter, required Object name}) => 'Añadir una serie a ${letter} · ${name}';
}

// Path: session.duration
class _Translations$session$duration$es extends Translations$session$duration$en {
	_Translations$session$duration$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Duración por serie';
	@override String get hint => '45 o 1m30';
	@override String confirm({required Object value}) => 'Confirmar — ${value}';
}

// Path: session.weight
class _Translations$session$weight$es extends Translations$session$weight$en {
	_Translations$session$weight$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get bodyweight => 'Peso corporal';
	@override String get confirmBodyweight => 'Confirmar — Peso corporal';
	@override String confirmKg({required Object value}) => 'Confirmar — ${value} kg';
}

// Path: session.search
class _Translations$session$search$es extends Translations$session$search$en {
	_Translations$session$search$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get hint => 'Buscar un ejercicio…';
	@override String get loading => 'Cargando ejercicios…';
	@override String get noMatch => 'Ningún ejercicio coincide.';
	@override String get certifiedBadge => 'Ejercicio Repster';
}

// Path: session.history
class _Translations$session$history$es extends Translations$session$history$en {
	_Translations$session$history$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String title({required Object name}) => 'Historial · ${name}';
	@override String get empty => 'Aún no hay historial para este ejercicio.';
	@override String get loading => 'Cargando historial…';
	@override String setLabel({required Object n}) => 'Serie ${n}';
	@override String get dateFormat => 'd MMM yyyy';
}

// Path: session.fields
class _Translations$session$fields$es extends Translations$session$fields$en {
	_Translations$session$fields$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get exerciseName => 'Nombre del ejercicio';
	@override String get type => 'Tipo';
	@override String get sets => 'Series';
	@override String get durationSec => 'Duración (seg)';
	@override String get targetReps => 'Reps objetivo';
	@override String get restShort => 'Descanso (seg)';
	@override String get rest => 'Descanso (seg)';
	@override String get tempo => 'Tempo';
	@override String get notesOptional => 'Notas (opcional)';
	@override String get notesHint => 'Consejos de técnica…';
	@override String get keepInTemplate => 'Guardar también en el programa';
	@override String get keepInTemplateHint => 'Por defecto, el cambio solo vale para esta sesión.';
}

// Path: session.toast
class _Translations$session$toast$es extends Translations$session$toast$en {
	_Translations$session$toast$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String exerciseAdded({required Object name}) => '${name} añadido a la sesión';
	@override String get validateOneSet => 'Valida al menos una serie antes de terminar.';
	@override String get sessionSaved => '¡Sesión guardada! 🎉';
	@override String get finishOrSwap => 'Termina la serie actual o usa «Cambiar».';
}

// Path: session.notif
class _Translations$session$notif$es extends Translations$session$notif$en {
	_Translations$session$notif$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get countdownChannel => 'Cuenta atrás de descanso';
	@override String get doneChannel => 'Fin del descanso';
	@override String get doneTitle => 'Descanso terminado';
}

// Path: settings.sections
class _Translations$settings$sections$es extends Translations$settings$sections$en {
	_Translations$settings$sections$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get profile => 'Perfil';
	@override String get data => 'Mis datos';
	@override String get preferences => 'Preferencias';
	@override String get account => 'Cuenta';
}

// Path: settings.rows
class _Translations$settings$rows$es extends Translations$settings$rows$en {
	_Translations$settings$rows$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get templates => 'Mis programas';
	@override String get history => 'Historial de sesiones';
	@override String get stats => 'Estadísticas';
	@override String get notifications => 'Notificaciones';
	@override String get privacy => 'Privacidad';
	@override String get terms => 'Condiciones de uso';
	@override String get contact => 'Contacto y comentarios';
	@override String get language => 'Idioma';
	@override String get changePassword => 'Cambiar mi contraseña';
}

// Path: settings.logout
class _Translations$settings$logout$es extends Translations$settings$logout$en {
	_Translations$settings$logout$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get action => 'Cerrar sesión';
	@override String get error => 'Error al cerrar sesión.';
}

// Path: settings.language
class _Translations$settings$language$es extends Translations$settings$language$en {
	_Translations$settings$language$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Idioma';
	@override String get subtitle => 'Elige el idioma de la aplicación';
	@override String get system => 'Idioma del sistema';
}

// Path: stats.subtitle
class _Translations$stats$subtitle$es extends Translations$stats$subtitle$en {
	_Translations$stats$subtitle$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get empty => 'Ninguna sesión en el periodo';
}

// Path: stats.empty
class _Translations$stats$empty$es extends Translations$stats$empty$en {
	_Translations$stats$empty$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Aún no hay datos';
	@override String get message => 'Completa algunas sesiones para ver tus curvas y tu progresión.';
}

// Path: stats.range
class _Translations$stats$range$es extends Translations$stats$range$en {
	_Translations$stats$range$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override late final _Translations$stats$range$last4Weeks$es last4Weeks = _Translations$stats$range$last4Weeks$es._(_root);
	@override late final _Translations$stats$range$last3Months$es last3Months = _Translations$stats$range$last3Months$es._(_root);
	@override late final _Translations$stats$range$all$es all = _Translations$stats$range$all$es._(_root);
}

// Path: stats.kpi
class _Translations$stats$kpi$es extends Translations$stats$kpi$en {
	_Translations$stats$kpi$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get sessions => 'Sesiones';
	@override String get volume => 'Tonelaje';
	@override String get sets => 'Series';
	@override String get avgDuration => 'Duración media';
	@override String get tension => 'Tiempo bajo tensión';
}

// Path: stats.weeklyVolume
class _Translations$stats$weeklyVolume$es extends Translations$stats$weeklyVolume$en {
	_Translations$stats$weeklyVolume$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Volumen por semana';
	@override String get empty => 'Aún no hay suficientes sesiones en el periodo.';
	@override String get inProgress => 'en curso';
}

// Path: stats.exercise
class _Translations$stats$exercise$es extends Translations$stats$exercise$en {
	_Translations$stats$exercise$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Progresión por ejercicio';
	@override String get empty => 'Registra al menos 2 sesiones con el mismo ejercicio con carga para ver tu curva de fuerza.';
	@override String get pickerTitle => 'Elegir un ejercicio';
	@override String get noExercise => 'Ningún ejercicio';
	@override String get searchHint => 'Buscar…';
	@override String get oneRmMax => '1RM estimado máx.';
	@override String get bestLoad => 'mejor carga';
	@override String get record => 'récord';
	@override String get trendUnknown => 'Aún no hay sesiones suficientes para ver una tendencia';
	@override String get trendProgressing => 'Progresando';
	@override String trendPlateau({required Object n}) => 'Estancado · ${n} sesiones sin récord';
	@override String get trendRegressing => 'Retrocediendo';
	@override String perMonth({required Object value}) => '${value} %/mes';
	@override String get plateauHint => 'Prueba menos reps con más carga, o cambia de ejercicio.';
}

// Path: stats.records
class _Translations$stats$records$es extends Translations$stats$records$en {
	_Translations$stats$records$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Récords';
	@override String get bestSession => 'Mejor sesión';
	@override String get heaviestLift => 'Carga máxima';
	@override String get bestOneRm => '1RM estimado';
	@override String get bestStreak => 'Racha más larga';
	@override String get consecutiveWeeks => 'semanas consecutivas';
}

// Path: stats.strength
class _Translations$stats$strength$es extends Translations$stats$strength$en {
	_Translations$stats$strength$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Fuerza';
	@override String get scope => 'todo el historial';
}

// Path: templates.list
class _Translations$templates$list$es extends Translations$templates$list$en {
	_Translations$templates$list$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Programas';
	@override String subtitleActive({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} sesión activa',
		other: '${n} sesiones activas',
	);
	@override String get newAction => 'Crear';
	@override String get emptyTitle => 'No hay sesiones';
	@override String get emptyMessage => 'Crea tu primera sesión para armar tu programa.';
	@override String get emptyAction => 'Crear una sesión';
	@override String get reorderError => 'Error al reordenar.';
	@override String get toggleError => 'Acción imposible.';
	@override String get duplicated => '¡Sesión copiada!';
	@override String get duplicateError => 'No se pudo duplicar.';
	@override String get deleted => 'Sesión eliminada.';
	@override String get deleteError => 'No se pudo eliminar.';
	@override String get copySuffix => '(copia)';
}

// Path: templates.card
class _Translations$templates$card$es extends Translations$templates$card$en {
	_Translations$templates$card$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String exerciseCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} ejercicio',
		other: '${n} ejercicios',
	);
	@override String get activate => 'Activar';
	@override String get deactivate => 'Desactivar';
}

// Path: templates.detail
class _Translations$templates$detail$es extends Translations$templates$detail$en {
	_Translations$templates$detail$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get noExercises => 'No hay ejercicios en esta sesión.';
	@override String get superset => 'Superserie';
	@override String setsCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} serie',
		other: '${n} series',
	);
	@override String seconds({required Object n}) => '${n} s';
	@override String tempo({required Object value}) => 'Tempo ${value}';
	@override String rest({required Object n}) => 'Descanso ${n}s';
	@override String get start => 'Iniciar sesión';
}

// Path: templates.editor
class _Translations$templates$editor$es extends Translations$templates$editor$en {
	_Translations$templates$editor$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get newTitle => 'Nueva sesión';
	@override String get editTitle => 'Editar sesión';
	@override String exercisesHeader({required Object count}) => 'EJERCICIOS (${count})';
	@override String get addExercise => 'Añadir un ejercicio';
	@override String get save => 'Guardar sesión';
	@override String get validationError => 'Introduce un nombre y al menos un ejercicio con nombre.';
}

// Path: templates.fields
class _Translations$templates$fields$es extends Translations$templates$fields$en {
	_Translations$templates$fields$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get name => 'Nombre de la sesión';
	@override String get nameHint => 'ej.: Pecho / Tríceps / Hombros';
	@override String get description => 'Descripción (opcional)';
	@override String get descriptionHint => 'Describe tu sesión…';
	@override String get emoji => 'Imagen';
	@override String get exerciseName => 'Nombre del ejercicio';
	@override String get exerciseNameHint => 'ej.: Press de banca';
	@override String get type => 'Tipo';
	@override String get sets => 'Series';
	@override String get duration => 'Duración (s)';
	@override String get targetReps => 'Reps objetivo';
	@override String get rest => 'Descanso (s)';
	@override String get tempo => 'Tempo';
	@override String get tempoHint => '3-1-X-0';
	@override String get notes => 'Notas (opcional)';
	@override String get notesHint => 'Consejos técnicos…';
}

// Path: templates.slot
class _Translations$templates$slot$es extends Translations$templates$slot$en {
	_Translations$templates$slot$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get newExercise => 'Nuevo ejercicio';
	@override String variantN({required Object n}) => 'Variante ${n}';
	@override String get primary => 'PRINCIPAL';
	@override String get variant => 'Variante';
	@override String get addVariant => 'Añadir una variante';
	@override String get supersetNote => 'Encadenado en superserie con el siguiente ejercicio';
	@override String get supersetLabel => 'SUPERSERIE';
	@override String get reps => 'Repeticiones';
	@override String get time => 'Tiempo';
}

// Path: templates.emojiPicker
class _Translations$templates$emojiPicker$es extends Translations$templates$emojiPicker$en {
	_Translations$templates$emojiPicker$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Imagen de la sesión';
	@override String get searchHint => 'Buscar un emoji…';
	@override String get noResults => 'Ningún emoji coincide.';
	@override String get change => 'Cambiar';
}

// Path: templates.programs
class _Translations$templates$programs$es extends Translations$templates$programs$en {
	_Translations$templates$programs$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get newSession => 'Una sesión';
	@override String get newProgram => 'Un programa';
	@override String get nameTitleNew => 'Nuevo programa';
	@override String get nameTitleRename => 'Renombrar el programa';
	@override String get nameHint => 'PPL, Full body, Vacaciones…';
	@override String get createAction => 'Crear el programa';
	@override String sessionCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} sesión',
		other: '${n} sesiones',
	);
	@override String get active => 'Activo';
	@override String get empty => 'Vacío';
	@override String get sessionInactive => 'Desactivada';
	@override String get emptyTitle => 'Ninguna sesión';
	@override String get emptyMessage => 'Añade las sesiones que componen este programa.';
	@override String get switchOn => 'Programa activo';
	@override String get switchOff => 'Activar este programa';
	@override String get switchHint => 'Sus sesiones alimentan tu inicio. Los demás programas se desactivan.';
	@override String get addSession => 'Añadir una sesión';
	@override String addSessionTitle({required Object name}) => 'Añadir a ${name}';
	@override String get createSession => 'Crear una sesión nueva';
	@override String get loose => 'Sin programa';
	@override String get moveTitle => 'Mover a';
	@override String get start => 'Empezar';
	@override String get move => 'Mover';
	@override String get duplicate => 'Duplicar';
	@override String get rename => 'Renombrar';
	@override String get dragHint => 'Mantén pulsada una sesión para arrastrarla a un programa.';
	@override String deleteProgramTitle({required Object name}) => '¿Eliminar «${name}»?';
	@override String get deleteProgramMessage => 'Sus sesiones se conservan, sin programa.';
	@override String deleteSessionTitle({required Object name}) => '¿Eliminar «${name}»?';
	@override String get deleteSessionMessage => 'La sesión se elimina definitivamente. Tu historial se conserva.';
	@override String moved({required Object name}) => 'Movida a ${name}.';
	@override String get movedOut => 'Sacada de su programa.';
	@override String activated({required Object name}) => '${name} ya está activo.';
	@override String deactivated({required Object name}) => '${name} está desactivado.';
	@override String get programDeleted => 'Programa eliminado.';
	@override String get error => 'No se pudo. Inténtalo de nuevo.';
}

// Path: auth.onboarding.goalDescriptions
class _Translations$auth$onboarding$goalDescriptions$es extends Translations$auth$onboarding$goalDescriptions$en {
	_Translations$auth$onboarding$goalDescriptions$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get hypertrophy => 'Ganar músculo';
	@override String get strength => 'Levantar más peso';
	@override String get endurance => 'Cardio y resistencia';
	@override String get weightLoss => 'Quemar calorías';
	@override String get maintenance => 'Mantenerte en forma';
}

// Path: contact.categories.bug
class _Translations$contact$categories$bug$es extends Translations$contact$categories$bug$en {
	_Translations$contact$categories$bug$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get label => 'Error';
	@override String get placeholder => 'Ej.: tras mi serie, el cronómetro de descanso no arranca…';
	@override String get guidance => 'Indica los pasos para reproducirlo, lo que esperabas y tu modelo de teléfono: nos ayuda a corregirlo rápido.';
	@override String get successLine => 'Anotado: vamos a echarle un vistazo de cerca a este error.';
}

// Path: contact.categories.feature
class _Translations$contact$categories$feature$es extends Translations$contact$categories$feature$en {
	_Translations$contact$categories$feature$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get label => 'Idea';
	@override String get placeholder => 'Ej.: poder duplicar una sesión existente…';
	@override String get guidance => 'Describe sobre todo la necesidad detrás de la idea: ¿qué te permitiría hacer?';
	@override String get successLine => '¡Gran idea, gracias! La añadimos a nuestras reflexiones.';
}

// Path: contact.categories.general
class _Translations$contact$categories$general$es extends Translations$contact$categories$general$en {
	_Translations$contact$categories$general$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get label => 'Mensaje';
	@override String get placeholder => 'Tu pregunta, tu opinión o tus comentarios…';
	@override String get guidance => 'Una pregunta, un comentario, un ánimo: leemos cada mensaje.';
	@override String get successLine => 'Gracias por tu mensaje. Nos tomamos el tiempo de leer cada comentario.';
}

// Path: contact.categories.other
class _Translations$contact$categories$other$es extends Translations$contact$categories$other$en {
	_Translations$contact$categories$other$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get label => 'Otro';
	@override String get placeholder => 'Cuéntanoslo todo…';
	@override String get guidance => 'Danos el máximo contexto posible para poder ayudarte lo mejor posible.';
	@override String get successLine => 'Gracias por tu mensaje. Te responderemos si es necesario.';
}

// Path: history.detail.edit
class _Translations$history$detail$edit$es extends Translations$history$detail$edit$en {
	_Translations$history$detail$edit$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get open => 'Editar';
	@override String get title => 'Editar sesión';
	@override String get name => 'Título';
	@override String get namePlaceholder => 'Nombre de la sesión';
	@override String get date => 'Fecha';
	@override String get time => 'Hora';
	@override String get durationLabel => 'Duración';
	@override String get hours => 'h';
	@override String get minutes => 'min';
	@override String get notesPlaceholder => '¿Cómo fue?';
	@override String get save => 'Guardar';
	@override String get saved => 'Sesión actualizada.';
	@override String get error => 'Error al actualizar.';
	@override String get nameRequired => 'Se requiere un título.';
	@override String get dateFormat => 'd MMMM y';
}

// Path: profile.editForm.sections
class _Translations$profile$editForm$sections$es extends Translations$profile$editForm$sections$en {
	_Translations$profile$editForm$sections$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get identity => 'Identidad';
	@override String get physique => 'Físico';
	@override String get goal => 'Objetivo';
}

// Path: profile.editForm.fields
class _Translations$profile$editForm$fields$es extends Translations$profile$editForm$fields$en {
	_Translations$profile$editForm$fields$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get name => 'Nombre / Apodo';
	@override String get bio => 'Biografía';
	@override String get birthdate => 'Fecha de nacimiento';
	@override String get weight => 'Peso (kg)';
	@override String get height => 'Altura (cm)';
}

// Path: profile.editForm.validation
class _Translations$profile$editForm$validation$es extends Translations$profile$editForm$validation$en {
	_Translations$profile$editForm$validation$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get nameMin => 'Al menos 2 caracteres';
	@override String get nameMax => 'Máximo 60 caracteres';
	@override String get invalidNumber => 'Número no válido';
	@override String get heightRange => 'Entre 80 y 260 cm';
	@override String get weightRange => 'Entre 30 y 350 kg';
}

// Path: stats.range.last4Weeks
class _Translations$stats$range$last4Weeks$es extends Translations$stats$range$last4Weeks$en {
	_Translations$stats$range$last4Weeks$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get label => '4 semanas';
	@override String get short => '4 sem.';
}

// Path: stats.range.last3Months
class _Translations$stats$range$last3Months$es extends Translations$stats$range$last3Months$en {
	_Translations$stats$range$last3Months$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get label => '3 meses';
	@override String get short => '3 meses';
}

// Path: stats.range.all
class _Translations$stats$range$all$es extends Translations$stats$range$all$en {
	_Translations$stats$range$all$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get label => 'Todo';
	@override String get short => 'Todo';
}

/// The flat map containing all translations for locale <es>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsEs {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'auth.fields.email' => 'Correo electrónico',
			'auth.fields.password' => 'Contraseña',
			'auth.backToLogin' => 'Volver al inicio de sesión',
			'auth.login.welcomeTitle' => 'Qué bueno verte de nuevo',
			'auth.login.welcomeSubtitle' => 'Inicia sesión para continuar.',
			'auth.login.forgotPassword' => '¿Olvidaste tu contraseña?',
			'auth.login.submit' => 'Iniciar sesión',
			'auth.login.submitLoading' => 'Iniciando sesión…',
			'auth.login.noAccount' => '¿Aún no tienes cuenta?',
			'auth.login.createAccount' => 'Crear una cuenta',
			'auth.signup.title' => 'Crear una cuenta',
			'auth.signup.subtitle' => 'Únete a miles de atletas.',
			'auth.signup.passwordHint' => 'Contraseña (8 car. mín.)',
			'auth.signup.submit' => 'Crear mi cuenta',
			'auth.signup.submitLoading' => 'Creando…',
			'auth.signup.termsPrefix' => 'Al crear una cuenta, aceptas nuestras ',
			'auth.signup.termsLink' => 'condiciones de uso',
			'auth.onboarding.step1Title' => '¿Cómo te\nllamas?',
			'auth.onboarding.step1Subtitle' => 'Para personalizar tu experiencia.',
			'auth.onboarding.nameHint' => 'Tu nombre',
			'auth.onboarding.continueLabel' => 'Continuar',
			'auth.onboarding.step2Title' => '¿Cuál es tu\nobjetivo?',
			'auth.onboarding.step2Subtitle' => 'Adaptaremos tus sesiones en consecuencia.',
			'auth.onboarding.step3Title' => 'Algunos datos',
			'auth.onboarding.optional' => 'Opcional',
			'auth.onboarding.step3Subtitle' => 'Para recomendaciones más precisas.',
			'auth.onboarding.weightHint' => 'Peso (kg)',
			'auth.onboarding.heightHint' => 'Altura (cm)',
			'auth.onboarding.birthdate' => 'Fecha de nacimiento',
			'auth.onboarding.submit' => '¡Vamos!',
			'auth.onboarding.submitLoading' => 'Guardando…',
			'auth.onboarding.skip' => 'Omitir este paso',
			'auth.onboarding.goalDescriptions.hypertrophy' => 'Ganar músculo',
			'auth.onboarding.goalDescriptions.strength' => 'Levantar más peso',
			'auth.onboarding.goalDescriptions.endurance' => 'Cardio y resistencia',
			'auth.onboarding.goalDescriptions.weightLoss' => 'Quemar calorías',
			'auth.onboarding.goalDescriptions.maintenance' => 'Mantenerte en forma',
			'auth.onboarding.nameRequired' => 'Tu nombre es obligatorio.',
			'auth.onboarding.nameTooLong' => 'Nombre demasiado largo.',
			'auth.onboarding.goalRequired' => 'Elige un objetivo.',
			'auth.onboarding.weightInvalid' => 'Peso no válido',
			'auth.onboarding.heightInvalid' => 'Altura no válida',
			'auth.verifyEmail.title' => 'Verifica tu correo',
			'auth.verifyEmail.subtitle' => 'Enviamos un código de 6 dígitos',
			'auth.verifyEmail.submitLoading' => 'Verificando…',
			'auth.verifyEmail.submitComplete' => 'Verificar el código',
			'auth.verifyEmail.submitIncomplete' => 'Introduce el código recibido',
			'auth.verifyEmail.noCode' => '¿No recibiste el código?',
			'auth.verifyEmail.resent' => '¡Código reenviado!',
			'auth.verifyEmail.resendCooldown' => ({required Object n}) => 'Reenviar en ${n}s',
			'auth.verifyEmail.resending' => 'Enviando…',
			'auth.verifyEmail.resend' => 'Reenviar el código',
			'auth.verifyEmail.emailMissing' => 'Falta el correo. Vuelve al registro.',
			'auth.forgotPassword.title' => 'Contraseña olvidada',
			'auth.forgotPassword.subtitle' => 'Te enviaremos un enlace de restablecimiento',
			'auth.forgotPassword.submit' => 'Enviar el enlace',
			'auth.forgotPassword.submitLoading' => 'Enviando…',
			'auth.forgotPassword.successMessage' => 'Se ha enviado un enlace de restablecimiento a tu correo electrónico. Revisa tu bandeja de entrada.',
			'auth.updatePassword.title' => 'Nueva contraseña',
			'auth.updatePassword.subtitle' => 'Elige una contraseña segura',
			'auth.updatePassword.newHint' => 'Nueva contraseña',
			'auth.updatePassword.confirmHint' => 'Confirmar la contraseña',
			'auth.updatePassword.submit' => 'Guardar la contraseña',
			'auth.updatePassword.submitLoading' => 'Guardando…',
			'auth.changePassword.title' => 'Cambiar la contraseña',
			'auth.changePassword.subtitle' => 'Por tu seguridad, confirma tu contraseña actual antes de elegir una nueva.',
			'auth.changePassword.currentHint' => 'Contraseña actual',
			'auth.changePassword.newHint' => 'Nueva contraseña',
			'auth.changePassword.confirmHint' => 'Confirmar la nueva contraseña',
			'auth.changePassword.submit' => 'Actualizar la contraseña',
			'auth.changePassword.submitLoading' => 'Actualizando…',
			'auth.changePassword.successToast' => 'Contraseña actualizada',
			'auth.changePassword.currentRequired' => 'Contraseña actual obligatoria',
			'auth.changePassword.mustDiffer' => 'La nueva contraseña debe ser diferente de la actual',
			'auth.changePassword.currentIncorrect' => 'Contraseña actual incorrecta',
			'auth.validators.emailRequired' => 'Correo obligatorio',
			'auth.validators.emailInvalid' => 'Correo no válido',
			'auth.validators.passwordRequired' => 'Contraseña obligatoria',
			'auth.validators.passwordMin' => 'Mínimo 8 caracteres',
			'auth.validators.passwordMismatch' => 'Las contraseñas no coinciden',
			'common.actions.cancel' => 'Cancelar',
			'common.actions.confirm' => 'Confirmar',
			'common.actions.save' => 'Guardar',
			'common.actions.retry' => 'Reintentar',
			'common.actions.delete' => 'Eliminar',
			'common.actions.close' => 'Cerrar',
			'common.actions.edit' => 'Editar',
			'common.actions.done' => 'Hecho',
			'common.actions.next' => 'Siguiente',
			'common.actions.back' => 'Atrás',
			'common.unnamed' => '(sin nombre)',
			'common.units.reps' => 'reps',
			'common.date.justNow' => 'ahora mismo',
			'common.date.minutesAgo' => ({required Object n}) => 'hace ${n} min',
			'common.date.hoursAgo' => ({required Object n}) => 'hace ${n} h',
			'common.date.yesterday' => 'ayer',
			'common.date.daysAgo' => ({required Object n}) => 'hace ${n} d',
			'common.date.today' => 'hoy',
			'common.date.weeksAgo' => ({required Object n}) => 'hace ${n} sem',
			'common.date.monthsAgo' => ({required Object n}) => 'hace ${n} meses',
			'common.language.en' => 'Inglés',
			'common.language.fr' => 'Francés',
			'common.language.es' => 'Español',
			'common.language.de' => 'Alemán',
			'common.language.it' => 'Italiano',
			'contact.header.title' => 'Contacto y feedback',
			'contact.header.subtitle' => '¿Un error, una idea, una pregunta? Escríbenos, lo leemos todo.',
			'contact.sections.type' => 'Tipo de solicitud',
			'contact.sections.yourInfo' => 'Tus datos',
			'contact.sections.message' => 'Mensaje',
			'contact.fields.nameHint' => 'Tu nombre',
			'contact.fields.nameRequired' => 'Nombre obligatorio',
			'contact.fields.emailHint' => 'Tu dirección de correo',
			'contact.fields.emailInvalid' => 'Correo no válido',
			'contact.fields.messageTooShort' => 'Mensaje demasiado corto (10 caracteres mín.)',
			'contact.counter' => ({required Object current, required Object max}) => '${current} / ${max}',
			'contact.submit' => 'Enviar',
			'contact.categories.bug.label' => 'Error',
			'contact.categories.bug.placeholder' => 'Ej.: tras mi serie, el cronómetro de descanso no arranca…',
			'contact.categories.bug.guidance' => 'Indica los pasos para reproducirlo, lo que esperabas y tu modelo de teléfono: nos ayuda a corregirlo rápido.',
			'contact.categories.bug.successLine' => 'Anotado: vamos a echarle un vistazo de cerca a este error.',
			'contact.categories.feature.label' => 'Idea',
			'contact.categories.feature.placeholder' => 'Ej.: poder duplicar una sesión existente…',
			'contact.categories.feature.guidance' => 'Describe sobre todo la necesidad detrás de la idea: ¿qué te permitiría hacer?',
			'contact.categories.feature.successLine' => '¡Gran idea, gracias! La añadimos a nuestras reflexiones.',
			'contact.categories.general.label' => 'Mensaje',
			'contact.categories.general.placeholder' => 'Tu pregunta, tu opinión o tus comentarios…',
			'contact.categories.general.guidance' => 'Una pregunta, un comentario, un ánimo: leemos cada mensaje.',
			'contact.categories.general.successLine' => 'Gracias por tu mensaje. Nos tomamos el tiempo de leer cada comentario.',
			'contact.categories.other.label' => 'Otro',
			'contact.categories.other.placeholder' => 'Cuéntanoslo todo…',
			'contact.categories.other.guidance' => 'Danos el máximo contexto posible para poder ayudarte lo mejor posible.',
			'contact.categories.other.successLine' => 'Gracias por tu mensaje. Te responderemos si es necesario.',
			'contact.success.title' => 'Mensaje enviado',
			'contact.success.back' => 'Volver a los ajustes',
			'dashboard.greeting.morning' => 'Buenos días',
			'dashboard.greeting.afternoon' => 'Buenas tardes',
			'dashboard.greeting.evening' => 'Buenas noches',
			'dashboard.defaultName' => 'Atleta',
			'dashboard.seeAll' => 'Ver todo',
			'dashboard.sections.templates' => 'Programa',
			'dashboard.sections.recentSessions' => 'Últimas sesiones',
			'dashboard.templates.empty' => 'Aún no hay sesiones',
			'dashboard.templates.newLabel' => 'Nueva',
			'dashboard.exerciseCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} ejercicio', other: '${n} ejercicios', ), 
			'dashboard.hero.eyebrow' => 'PRÓXIMA SESIÓN',
			'dashboard.hero.start' => 'Empezar sesión',
			'dashboard.hero.emptyTitle' => 'Crea tu primera sesión',
			'dashboard.hero.emptyMessage' => 'Configura tus ejercicios y a por ello.',
			'dashboard.hero.create' => 'Crear una sesión',
			'dashboard.hero.duration' => ({required Object n}) => '≈ ${n} min',
			'dashboard.recent.emptyTitle' => '¡Inicia tu primera sesión!',
			'dashboard.recent.emptyMessage' => 'Elige una sesión y a por ello.',
			'dashboard.recent.tonnage' => 'tonelaje',
			'dashboard.inProgress.label' => 'SESIÓN EN CURSO',
			'dashboard.inProgress.startedAt' => ({required Object when}) => 'Empezada ${when}',
			'dashboard.inProgress.resume' => 'Reanudar',
			'dashboard.inProgress.discard' => 'Abandonar',
			'dashboard.inProgress.discardTitle' => '¿Abandonar la sesión?',
			'dashboard.inProgress.discardMessage' => 'Se perderán todos los datos en curso.',
			'dashboard.inProgress.discardError' => 'Error — inténtalo de nuevo.',
			'dashboard.stats.sessions' => 'Sesiones',
			'dashboard.stats.volume' => 'Volumen',
			'dashboard.stats.streak' => 'Racha',
			'dashboard.stats.thisWeek' => 'esta sem.',
			'dashboard.stats.weekCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: 'semana', other: 'semanas', ), 
			'dashboard.stats.streakLabel' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: 'semana\nseguida', other: 'semanas\nseguidas', ), 
			'dashboard.stats.sessionsWeek' => 'sesiones\nesta semana',
			'dashboard.stats.volumeWeek' => 'volumen\nesta semana',
			'dashboard.streakBadge' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} semana seguida', other: '${n} semanas seguidas', ), 
			'dashboard.consistency.title' => 'Constancia',
			'dashboard.consistency.trainingDays' => 'días activos',
			'dashboard.consistency.perWeek' => 'sesiones / sem.',
			'dashboard.consistency.bestStreak' => 'mejor racha',
			'dashboard.consistency.noStreak' => 'sin racha',
			'dashboard.consistency.weeksShort' => ({required Object n}) => '${n} sem.',
			'dashboard.consistency.notYet' => 'Tu ritmo de entrenamiento aparecerá aquí tras tu primera sesión.',
			'emoji.groups.sport' => 'Deporte y entrenamiento',
			'emoji.groups.body' => 'Cuerpo y gestos',
			'emoji.groups.energy' => 'Energía y símbolos',
			'emoji.groups.faces' => 'Caras',
			'emoji.groups.hearts' => 'Corazones',
			'emoji.groups.animals' => 'Animales',
			'emoji.groups.food' => 'Comida y bebidas',
			'emoji.groups.nature' => 'Naturaleza y clima',
			'emoji.groups.places' => 'Lugares y viajes',
			'emoji.groups.objects' => 'Objetos y herramientas',
			'emoji.labels.person-lifting-weights' => 'Persona levantando pesas',
			'emoji.labels.man-lifting-weights' => 'Hombre levantando pesas',
			'emoji.labels.woman-lifting-weights' => 'Mujer levantando pesas',
			'emoji.labels.flexed-biceps' => 'Bíceps flexionado',
			'emoji.labels.boxing-glove' => 'Guante de boxeo',
			'emoji.labels.martial-arts-uniform' => 'Uniforme de artes marciales',
			'emoji.labels.person-wrestling' => 'Personas luchando',
			'emoji.labels.person-running' => 'Persona corriendo',
			'emoji.labels.man-running' => 'Hombre corriendo',
			'emoji.labels.woman-running' => 'Mujer corriendo',
			'emoji.labels.running-shoe' => 'Zapatilla de deporte',
			'emoji.labels.running-shirt' => 'Camiseta de correr',
			'emoji.labels.hiking-boot' => 'Bota de senderismo',
			'emoji.labels.person-walking' => 'Persona caminando',
			'emoji.labels.person-climbing' => 'Persona escalando',
			'emoji.labels.person-biking' => 'Ciclista',
			'emoji.labels.person-mountain-biking' => 'Ciclista de montaña',
			'emoji.labels.bicycle' => 'Bicicleta',
			'emoji.labels.person-swimming' => 'Nadador',
			'emoji.labels.person-surfing' => 'Surfista',
			'emoji.labels.person-rowing-boat' => 'Remero',
			'emoji.labels.canoe' => 'Canoa',
			'emoji.labels.person-in-lotus-position' => 'Posición de loto',
			'emoji.labels.lotus' => 'Loto',
			'emoji.labels.person-cartwheeling' => 'Voltereta lateral',
			'emoji.labels.person-juggling' => 'Malabarista',
			'emoji.labels.person-bouncing-ball' => 'Persona botando un balón',
			'emoji.labels.person-playing-handball' => 'Balonmano',
			'emoji.labels.person-playing-water-polo' => 'Waterpolo',
			'emoji.labels.person-fencing' => 'Esgrima',
			'emoji.labels.person-golfing' => 'Golfista',
			'emoji.labels.horse-racing' => 'Carrera de caballos',
			'emoji.labels.skier' => 'Esquiador',
			'emoji.labels.snowboarder' => 'Snowboarder',
			'emoji.labels.ice-skate' => 'Patín de hielo',
			'emoji.labels.roller-skate' => 'Patín de ruedas',
			'emoji.labels.skateboard' => 'Monopatín',
			'emoji.labels.basketball' => 'Balón de baloncesto',
			'emoji.labels.soccer-ball' => 'Balón de fútbol',
			'emoji.labels.american-football' => 'Fútbol americano',
			'emoji.labels.rugby-football' => 'Balón de rugby',
			'emoji.labels.tennis' => 'Tenis',
			'emoji.labels.volleyball' => 'Voleibol',
			'emoji.labels.baseball' => 'Béisbol',
			'emoji.labels.ping-pong' => 'Ping-pong',
			'emoji.labels.badminton' => 'Bádminton',
			'emoji.labels.field-hockey' => 'Hockey sobre hierba',
			'emoji.labels.ice-hockey' => 'Hockey sobre hielo',
			'emoji.labels.bowling' => 'Bolos',
			'emoji.labels.flying-disc' => 'Disco volador',
			'emoji.labels.bow-and-arrow' => 'Arco y flecha',
			'emoji.labels.bullseye' => 'Diana',
			'emoji.labels.pool-8-ball' => 'Bola 8 de billar',
			'emoji.labels.parachute' => 'Paracaídas',
			'emoji.labels.trophy' => 'Trofeo',
			'emoji.labels.sports-medal' => 'Medalla deportiva',
			'emoji.labels.1st-place-medal' => 'Medalla de oro',
			'emoji.labels.2nd-place-medal' => 'Medalla de plata',
			'emoji.labels.3rd-place-medal' => 'Medalla de bronce',
			'emoji.labels.military-medal' => 'Medalla militar',
			'emoji.labels.chequered-flag' => 'Bandera de cuadros',
			'emoji.labels.triangular-flag' => 'Banderín',
			'emoji.labels.stadium' => 'Estadio',
			'emoji.labels.stopwatch' => 'Cronómetro',
			'emoji.labels.timer-clock' => 'Temporizador',
			'emoji.labels.alarm-clock' => 'Despertador',
			'emoji.labels.hourglass-not-done' => 'Reloj de arena',
			'emoji.labels.leg' => 'Pierna',
			'emoji.labels.foot' => 'Pie',
			'emoji.labels.anatomical-heart' => 'Corazón anatómico',
			'emoji.labels.lungs' => 'Pulmones',
			'emoji.labels.bone' => 'Hueso',
			'emoji.labels.brain' => 'Cerebro',
			'emoji.labels.footprints' => 'Huellas',
			'emoji.labels.eyes' => 'Ojos',
			'emoji.labels.raised-fist' => 'Puño en alto',
			'emoji.labels.oncoming-fist' => 'Puño de frente',
			'emoji.labels.left-facing-fist' => 'Puño hacia la izquierda',
			'emoji.labels.right-facing-fist' => 'Puño hacia la derecha',
			'emoji.labels.thumbs-up' => 'Pulgar hacia arriba',
			'emoji.labels.clapping-hands' => 'Aplausos',
			'emoji.labels.raising-hands' => 'Manos levantadas',
			'emoji.labels.heart-hands' => 'Manos formando un corazón',
			'emoji.labels.handshake' => 'Apretón de manos',
			'emoji.labels.folded-hands' => 'Manos juntas',
			'emoji.labels.victory-hand' => 'Signo de victoria',
			'emoji.labels.ok-hand' => 'Señal de OK',
			'emoji.labels.waving-hand' => 'Mano saludando',
			'emoji.labels.pinched-fingers' => 'Dedos juntos',
			'emoji.labels.sign-of-the-horns' => 'Cuernos',
			'emoji.labels.call-me-hand' => 'Llámame',
			'emoji.labels.crossed-fingers' => 'Dedos cruzados',
			'emoji.labels.love-you-gesture' => 'Gesto de te quiero',
			'emoji.labels.sweat-droplets' => 'Gotas de sudor',
			'emoji.labels.zzz' => 'Zzz',
			'emoji.labels.person-standing' => 'Persona de pie',
			'emoji.labels.person-kneeling' => 'Persona de rodillas',
			'emoji.labels.fire' => 'Fuego',
			'emoji.labels.high-voltage' => 'Rayo',
			'emoji.labels.collision' => 'Colisión',
			'emoji.labels.dizzy' => 'Mareo',
			'emoji.labels.sparkles' => 'Destellos',
			'emoji.labels.star' => 'Estrella',
			'emoji.labels.shooting-star' => 'Estrella fugaz',
			'emoji.labels.rocket' => 'Cohete',
			'emoji.labels.flying-saucer' => 'Platillo volante',
			'emoji.labels.hundred-points' => 'Cien puntos',
			'emoji.labels.check-mark-button' => 'Marca de verificación',
			'emoji.labels.battery' => 'Batería',
			'emoji.labels.light-bulb' => 'Bombilla',
			'emoji.labels.bomb' => 'Bomba',
			'emoji.labels.fireworks' => 'Fuegos artificiales',
			'emoji.labels.party-popper' => 'Confeti',
			'emoji.labels.confetti-ball' => 'Bola de confeti',
			'emoji.labels.mirror-ball' => 'Bola de discoteca',
			'emoji.labels.crown' => 'Corona',
			'emoji.labels.gem-stone' => 'Piedra preciosa',
			'emoji.labels.shield' => 'Escudo',
			'emoji.labels.crossed-swords' => 'Espadas cruzadas',
			'emoji.labels.infinity' => 'Infinito',
			'emoji.labels.skull' => 'Calavera',
			'emoji.labels.skull-and-crossbones' => 'Calavera y huesos',
			'emoji.labels.ghost' => 'Fantasma',
			'emoji.labels.alien' => 'Alienígena',
			'emoji.labels.robot' => 'Robot',
			'emoji.labels.pile-of-poo' => 'Caca',
			'emoji.labels.magic-wand' => 'Varita mágica',
			'emoji.labels.crystal-ball' => 'Bola de cristal',
			'emoji.labels.grinning-face' => 'Cara sonriente',
			'emoji.labels.grinning-face-with-big-eyes' => 'Cara sonriente con ojos grandes',
			'emoji.labels.grinning-face-with-smiling-eyes' => 'Cara sonriente con ojos sonrientes',
			'emoji.labels.beaming-face-with-smiling-eyes' => 'Cara radiante',
			'emoji.labels.grinning-squinting-face' => 'Risa con ojos cerrados',
			'emoji.labels.grinning-face-with-sweat' => 'Sonrisa con sudor',
			'emoji.labels.face-with-tears-of-joy' => 'Lágrimas de alegría',
			'emoji.labels.rolling-on-the-floor-laughing' => 'Rodando de risa',
			'emoji.labels.smiling-face-with-smiling-eyes' => 'Cara feliz con ojos sonrientes',
			'emoji.labels.smiling-face-with-halo' => 'Cara con aureola',
			'emoji.labels.smiling-face-with-hearts' => 'Cara sonriente con corazones',
			'emoji.labels.smiling-face-with-heart-eyes' => 'Ojos de corazón',
			'emoji.labels.star-struck' => 'Ojos de estrella',
			'emoji.labels.face-blowing-a-kiss' => 'Cara lanzando un beso',
			'emoji.labels.face-savoring-food' => 'Cara saboreando comida',
			'emoji.labels.face-with-tongue' => 'Cara sacando la lengua',
			'emoji.labels.winking-face' => 'Guiño',
			'emoji.labels.winking-face-with-tongue' => 'Guiño con lengua',
			'emoji.labels.zany-face' => 'Cara loca',
			'emoji.labels.money-mouth-face' => 'Cara con dinero en la boca',
			'emoji.labels.hugging-face' => 'Cara abrazando',
			'emoji.labels.face-with-hand-over-mouth' => 'Cara con mano sobre la boca',
			'emoji.labels.face-with-peeking-eye' => 'Cara espiando entre los dedos',
			'emoji.labels.shushing-face' => 'Cara pidiendo silencio',
			'emoji.labels.thinking-face' => 'Cara pensativa',
			'emoji.labels.saluting-face' => 'Cara saludando',
			'emoji.labels.zipper-mouth-face' => 'Boca cerrada con cremallera',
			'emoji.labels.face-with-raised-eyebrow' => 'Ceja levantada',
			'emoji.labels.neutral-face' => 'Cara neutral',
			'emoji.labels.unamused-face' => 'Cara de poca gracia',
			'emoji.labels.smirking-face' => 'Sonrisa pícara',
			'emoji.labels.drooling-face' => 'Cara babeando',
			'emoji.labels.sleeping-face' => 'Cara durmiendo',
			'emoji.labels.face-with-medical-mask' => 'Mascarilla',
			'emoji.labels.hot-face' => 'Cara con calor',
			'emoji.labels.cold-face' => 'Cara con frío',
			'emoji.labels.woozy-face' => 'Cara de mareo',
			'emoji.labels.face-with-spiral-eyes' => 'Ojos en espiral',
			'emoji.labels.exploding-head' => 'Cabeza explotando',
			'emoji.labels.cowboy-hat-face' => 'Cara con sombrero vaquero',
			'emoji.labels.partying-face' => 'Cara de fiesta',
			'emoji.labels.disguised-face' => 'Cara disfrazada',
			'emoji.labels.smiling-face-with-sunglasses' => 'Cara con gafas de sol',
			'emoji.labels.nerd-face' => 'Cara de empollón',
			'emoji.labels.face-with-monocle' => 'Cara con monóculo',
			'emoji.labels.slightly-smiling-face' => 'Ligera sonrisa',
			'emoji.labels.upside-down-face' => 'Cara al revés',
			'emoji.labels.melting-face' => 'Cara derritiéndose',
			'emoji.labels.flushed-face' => 'Cara sonrojada',
			'emoji.labels.pleading-face' => 'Cara suplicante',
			'emoji.labels.face-holding-back-tears' => 'Cara aguantando las lágrimas',
			'emoji.labels.loudly-crying-face' => 'Llanto desconsolado',
			'emoji.labels.face-screaming-in-fear' => 'Cara gritando de miedo',
			'emoji.labels.downcast-face-with-sweat' => 'Cara abatida con sudor',
			'emoji.labels.weary-face' => 'Cara agotada',
			'emoji.labels.tired-face' => 'Cara cansada',
			'emoji.labels.yawning-face' => 'Bostezo',
			'emoji.labels.face-with-steam-from-nose' => 'Cara resoplando',
			'emoji.labels.angry-face' => 'Cara enfadada',
			'emoji.labels.smiling-face-with-horns' => 'Diablillo',
			'emoji.labels.angry-face-with-horns' => 'Diablo enfadado',
			'emoji.labels.red-heart' => 'Corazón rojo',
			'emoji.labels.orange-heart' => 'Corazón naranja',
			'emoji.labels.yellow-heart' => 'Corazón amarillo',
			'emoji.labels.green-heart' => 'Corazón verde',
			'emoji.labels.blue-heart' => 'Corazón azul',
			'emoji.labels.purple-heart' => 'Corazón morado',
			'emoji.labels.black-heart' => 'Corazón negro',
			'emoji.labels.white-heart' => 'Corazón blanco',
			'emoji.labels.pink-heart' => 'Corazón rosa',
			'emoji.labels.sparkling-heart' => 'Corazón brillante',
			'emoji.labels.growing-heart' => 'Corazón creciente',
			'emoji.labels.beating-heart' => 'Corazón latiendo',
			'emoji.labels.revolving-hearts' => 'Corazones giratorios',
			'emoji.labels.two-hearts' => 'Dos corazones',
			'emoji.labels.heart-on-fire' => 'Corazón en llamas',
			'emoji.labels.mending-heart' => 'Corazón recuperándose',
			'emoji.labels.broken-heart' => 'Corazón roto',
			'emoji.labels.heart-with-arrow' => 'Corazón con flecha',
			'emoji.labels.heart-with-ribbon' => 'Corazón con lazo',
			'emoji.labels.gorilla' => 'Gorila',
			'emoji.labels.lion' => 'León',
			'emoji.labels.tiger' => 'Tigre',
			'emoji.labels.leopard' => 'Leopardo',
			'emoji.labels.bear' => 'Oso',
			'emoji.labels.polar-bear' => 'Oso polar',
			'emoji.labels.ox' => 'Buey',
			'emoji.labels.water-buffalo' => 'Búfalo de agua',
			'emoji.labels.bison' => 'Bisonte',
			'emoji.labels.cow' => 'Vaca',
			'emoji.labels.rhinoceros' => 'Rinoceronte',
			'emoji.labels.elephant' => 'Elefante',
			'emoji.labels.hippopotamus' => 'Hipopótamo',
			'emoji.labels.mammoth' => 'Mamut',
			'emoji.labels.horse' => 'Caballo',
			'emoji.labels.zebra' => 'Cebra',
			'emoji.labels.giraffe' => 'Jirafa',
			'emoji.labels.camel' => 'Camello',
			'emoji.labels.deer' => 'Ciervo',
			'emoji.labels.ram' => 'Carnero',
			'emoji.labels.goat' => 'Cabra',
			'emoji.labels.pig' => 'Cerdo',
			'emoji.labels.wolf' => 'Lobo',
			'emoji.labels.fox' => 'Zorro',
			'emoji.labels.dog' => 'Perro',
			'emoji.labels.cat' => 'Gato',
			'emoji.labels.black-cat' => 'Gato negro',
			'emoji.labels.monkey' => 'Mono',
			'emoji.labels.see-no-evil-monkey' => 'Mono tapándose los ojos',
			'emoji.labels.kangaroo' => 'Canguro',
			'emoji.labels.rabbit' => 'Conejo',
			'emoji.labels.hedgehog' => 'Erizo',
			'emoji.labels.koala' => 'Koala',
			'emoji.labels.panda' => 'Panda',
			'emoji.labels.sloth' => 'Perezoso',
			'emoji.labels.otter' => 'Nutria',
			'emoji.labels.seal' => 'Foca',
			'emoji.labels.bat' => 'Murciélago',
			'emoji.labels.eagle' => 'Águila',
			'emoji.labels.owl' => 'Búho',
			'emoji.labels.rooster' => 'Gallo',
			'emoji.labels.chicken' => 'Gallina',
			'emoji.labels.baby-chick' => 'Pollito',
			'emoji.labels.duck' => 'Pato',
			'emoji.labels.swan' => 'Cisne',
			'emoji.labels.flamingo' => 'Flamenco',
			'emoji.labels.peacock' => 'Pavo real',
			'emoji.labels.parrot' => 'Loro',
			'emoji.labels.dove' => 'Paloma',
			'emoji.labels.penguin' => 'Pingüino',
			'emoji.labels.shark' => 'Tiburón',
			'emoji.labels.whale' => 'Ballena',
			'emoji.labels.dolphin' => 'Delfín',
			'emoji.labels.octopus' => 'Pulpo',
			'emoji.labels.fish' => 'Pez',
			'emoji.labels.tropical-fish' => 'Pez tropical',
			'emoji.labels.crab' => 'Cangrejo',
			'emoji.labels.lobster' => 'Langosta',
			'emoji.labels.shrimp' => 'Camarón',
			'emoji.labels.turtle' => 'Tortuga',
			'emoji.labels.crocodile' => 'Cocodrilo',
			'emoji.labels.snake' => 'Serpiente',
			'emoji.labels.frog' => 'Rana',
			'emoji.labels.t-rex' => 'T-Rex',
			'emoji.labels.sauropod' => 'Saurópodo',
			'emoji.labels.dragon' => 'Dragón',
			'emoji.labels.unicorn' => 'Unicornio',
			'emoji.labels.butterfly' => 'Mariposa',
			'emoji.labels.honeybee' => 'Abeja',
			'emoji.labels.scorpion' => 'Escorpión',
			'emoji.labels.cut-of-meat' => 'Filete',
			'emoji.labels.meat-on-bone' => 'Carne con hueso',
			'emoji.labels.poultry-leg' => 'Muslo de pollo',
			'emoji.labels.bacon' => 'Beicon',
			'emoji.labels.egg' => 'Huevo',
			'emoji.labels.cooked-rice' => 'Arroz cocido',
			'emoji.labels.steaming-bowl' => 'Bol humeante',
			'emoji.labels.green-salad' => 'Ensalada',
			'emoji.labels.broccoli' => 'Brócoli',
			'emoji.labels.avocado' => 'Aguacate',
			'emoji.labels.banana' => 'Plátano',
			'emoji.labels.red-apple' => 'Manzana roja',
			'emoji.labels.green-apple' => 'Manzana verde',
			'emoji.labels.pear' => 'Pera',
			'emoji.labels.peach' => 'Melocotón',
			'emoji.labels.cherries' => 'Cerezas',
			'emoji.labels.strawberry' => 'Fresa',
			'emoji.labels.blueberries' => 'Arándanos',
			'emoji.labels.grapes' => 'Uvas',
			'emoji.labels.watermelon' => 'Sandía',
			'emoji.labels.pineapple' => 'Piña',
			'emoji.labels.mango' => 'Mango',
			'emoji.labels.kiwi-fruit' => 'Kiwi',
			'emoji.labels.lemon' => 'Limón',
			'emoji.labels.coconut' => 'Coco',
			'emoji.labels.carrot' => 'Zanahoria',
			'emoji.labels.potato' => 'Patata',
			'emoji.labels.tomato' => 'Tomate',
			'emoji.labels.bell-pepper' => 'Pimiento',
			'emoji.labels.hot-pepper' => 'Chile',
			'emoji.labels.eggplant' => 'Berenjena',
			'emoji.labels.bread' => 'Pan',
			'emoji.labels.croissant' => 'Cruasán',
			'emoji.labels.glass-of-milk' => 'Vaso de leche',
			'emoji.labels.hot-beverage' => 'Café',
			'emoji.labels.honey-pot' => 'Tarro de miel',
			'emoji.labels.chocolate-bar' => 'Chocolate',
			'emoji.labels.cookie' => 'Galleta',
			'emoji.labels.doughnut' => 'Dónut',
			'emoji.labels.ice-cream' => 'Helado',
			'emoji.labels.birthday-cake' => 'Tarta de cumpleaños',
			'emoji.labels.pancakes' => 'Tortitas',
			'emoji.labels.popcorn' => 'Palomitas',
			'emoji.labels.lollipop' => 'Piruleta',
			'emoji.labels.pizza' => 'Pizza',
			'emoji.labels.hamburger' => 'Hamburguesa',
			'emoji.labels.french-fries' => 'Patatas fritas',
			_ => null,
		} ?? switch (path) {
			'emoji.labels.taco' => 'Taco',
			'emoji.labels.sushi' => 'Sushi',
			'emoji.labels.fork-and-knife' => 'Cubiertos',
			'emoji.labels.bottle-with-popping-cork' => 'Botella descorchándose',
			'emoji.labels.clinking-glasses' => 'Brindis',
			'emoji.labels.wine-glass' => 'Copa de vino',
			'emoji.labels.beer-mug' => 'Jarra de cerveza',
			'emoji.labels.tropical-drink' => 'Bebida tropical',
			'emoji.labels.sun' => 'Sol',
			'emoji.labels.sun-with-face' => 'Sol con cara',
			'emoji.labels.sunrise' => 'Amanecer',
			'emoji.labels.sunrise-over-mountains' => 'Amanecer en la montaña',
			'emoji.labels.sunset' => 'Atardecer',
			'emoji.labels.cloud' => 'Nube',
			'emoji.labels.cloud-with-rain' => 'Lluvia',
			'emoji.labels.cloud-with-lightning' => 'Tormenta',
			'emoji.labels.cloud-with-lightning-and-rain' => 'Tormenta con lluvia',
			'emoji.labels.snowflake' => 'Copo de nieve',
			'emoji.labels.rainbow' => 'Arcoíris',
			'emoji.labels.crescent-moon' => 'Luna creciente',
			'emoji.labels.full-moon' => 'Luna llena',
			'emoji.labels.night-with-stars' => 'Noche estrellada',
			'emoji.labels.milky-way' => 'Vía Láctea',
			'emoji.labels.mountain' => 'Montaña',
			'emoji.labels.snow-capped-mountain' => 'Montaña nevada',
			'emoji.labels.volcano' => 'Volcán',
			'emoji.labels.desert-island' => 'Isla desierta',
			'emoji.labels.beach-with-umbrella' => 'Playa con sombrilla',
			'emoji.labels.water-wave' => 'Ola',
			'emoji.labels.droplet' => 'Gota',
			'emoji.labels.tornado' => 'Tornado',
			'emoji.labels.palm-tree' => 'Palmera',
			'emoji.labels.cactus' => 'Cactus',
			'emoji.labels.seedling' => 'Brote',
			'emoji.labels.four-leaf-clover' => 'Trébol de cuatro hojas',
			'emoji.labels.sunflower' => 'Girasol',
			'emoji.labels.rose' => 'Rosa',
			'emoji.labels.tulip' => 'Tulipán',
			'emoji.labels.cherry-blossom' => 'Flor de cerezo',
			'emoji.labels.maple-leaf' => 'Hoja de arce',
			'emoji.labels.globe-showing-europe-africa' => 'Globo terráqueo',
			'emoji.labels.globe-with-meridians' => 'Globo con meridianos',
			'emoji.labels.house' => 'Casa',
			'emoji.labels.cityscape' => 'Ciudad',
			'emoji.labels.tent' => 'Tienda de campaña',
			'emoji.labels.hot-springs' => 'Aguas termales',
			'emoji.labels.world-map' => 'Mapa del mundo',
			'emoji.labels.compass' => 'Brújula',
			'emoji.labels.airplane' => 'Avión',
			'emoji.labels.automobile' => 'Coche',
			'emoji.labels.racing-car' => 'Coche de carreras',
			'emoji.labels.motorcycle' => 'Moto',
			'emoji.labels.sailboat' => 'Velero',
			'emoji.labels.gear' => 'Engranaje',
			'emoji.labels.hammer' => 'Martillo',
			'emoji.labels.wrench' => 'Llave inglesa',
			'emoji.labels.hammer-and-wrench' => 'Martillo y llave',
			'emoji.labels.brick' => 'Ladrillo',
			'emoji.labels.puzzle-piece' => 'Pieza de puzle',
			'emoji.labels.game-die' => 'Dado',
			'emoji.labels.joystick' => 'Joystick',
			'emoji.labels.video-game' => 'Mando de videojuego',
			'emoji.labels.headphone' => 'Auriculares',
			'emoji.labels.musical-note' => 'Nota musical',
			'emoji.labels.musical-notes' => 'Notas musicales',
			'emoji.labels.guitar' => 'Guitarra',
			'emoji.labels.calendar' => 'Calendario',
			'emoji.labels.mobile-phone' => 'Móvil',
			'emoji.labels.laptop' => 'Portátil',
			'emoji.labels.clipboard' => 'Portapapeles',
			'emoji.labels.memo' => 'Nota',
			'emoji.labels.pencil' => 'Lápiz',
			'emoji.labels.chart-increasing' => 'Gráfico ascendente',
			'emoji.labels.bar-chart' => 'Gráfico de barras',
			'emoji.labels.balance-scale' => 'Balanza',
			'emoji.labels.books' => 'Libros',
			'emoji.labels.open-book' => 'Libro abierto',
			'emoji.labels.graduation-cap' => 'Birrete',
			'emoji.labels.money-bag' => 'Bolsa de dinero',
			'emoji.labels.coin' => 'Moneda',
			'emoji.labels.locked' => 'Candado cerrado',
			'emoji.labels.unlocked' => 'Candado abierto',
			'emoji.labels.key' => 'Llave',
			'emoji.labels.dna' => 'ADN',
			'emoji.labels.pill' => 'Pastilla',
			'emoji.labels.stethoscope' => 'Estetoscopio',
			'emoji.labels.adhesive-bandage' => 'Tirita',
			'emoji.labels.speech-balloon' => 'Bocadillo de diálogo',
			'emoji.labels.thought-balloon' => 'Bocadillo de pensamiento',
			'errors.network' => 'Sin conexión de red. Comprueba tu conexión.',
			'errors.notFound' => 'Elemento no encontrado.',
			'errors.generic' => 'Se produjo un error. Inténtalo de nuevo.',
			'errors.invalidCode' => 'Código no válido o caducado.',
			'errors.passwordSameAsOld' => 'La nueva contraseña debe ser distinta de la anterior.',
			'errors.auth.invalidCredentials' => 'Correo o contraseña incorrectos.',
			'errors.auth.emailNotConfirmed' => 'Confirma tu correo antes de iniciar sesión.',
			'errors.auth.userAlreadyExists' => 'Ya existe una cuenta con este correo.',
			'errors.auth.sessionExpired' => 'Sesión caducada. Vuelve a iniciar sesión.',
			'errors.auth.notSignedIn' => 'Debes iniciar sesión.',
			'goals.strength' => 'Fuerza',
			'goals.hypertrophy' => 'Hipertrofia',
			'goals.endurance' => 'Resistencia',
			'goals.weightLoss' => 'Pérdida de peso',
			'goals.maintenance' => 'Mantenimiento',
			'history.title' => 'Historial',
			'history.emptySubtitle' => 'Sin sesiones',
			'history.emptyTitle' => 'Aún no hay sesiones',
			'history.emptyMessage' => 'Inicia tu primera sesión desde la pantalla de inicio — aparecerá aquí.',
			'history.sessionCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} sesión', other: '${n} sesiones', ), 
			'history.deleteError' => 'Error al eliminar.',
			'history.groups.thisWeek' => 'Esta semana',
			'history.groups.lastWeek' => 'Semana pasada',
			'history.groups.weeksAgo' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: 'hace ${n} semana', other: 'hace ${n} semanas', ), 
			'history.panel.sessions' => 'Sesiones',
			'history.panel.volume' => 'Volumen',
			'history.panel.time' => 'Tiempo',
			'history.detail.title' => 'Sesión',
			'history.detail.dateFormat' => 'EEEE d \'de\' MMMM \'a las\' HH:mm',
			'history.detail.duration' => 'Duración',
			'history.detail.tonnage' => 'Tonelaje',
			'history.detail.sets' => 'Series',
			'history.detail.notes' => 'Notas',
			'history.detail.perExercise' => 'Detalle por ejercicio',
			'history.detail.setsCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} serie', other: '${n} series', ), 
			'history.detail.bodyweight' => 'Peso corporal',
			'history.detail.colSet' => 'Serie',
			'history.detail.colReps' => 'Reps',
			'history.detail.colLoad' => 'Carga',
			'history.detail.colHeld' => 'Tiempo',
			'history.detail.totalExercise' => 'Total ejercicio',
			'history.detail.totalHeld' => 'Total tiempo',
			'history.detail.edit.open' => 'Editar',
			'history.detail.edit.title' => 'Editar sesión',
			'history.detail.edit.name' => 'Título',
			'history.detail.edit.namePlaceholder' => 'Nombre de la sesión',
			'history.detail.edit.date' => 'Fecha',
			'history.detail.edit.time' => 'Hora',
			'history.detail.edit.durationLabel' => 'Duración',
			'history.detail.edit.hours' => 'h',
			'history.detail.edit.minutes' => 'min',
			'history.detail.edit.notesPlaceholder' => '¿Cómo fue?',
			'history.detail.edit.save' => 'Guardar',
			'history.detail.edit.saved' => 'Sesión actualizada.',
			'history.detail.edit.error' => 'Error al actualizar.',
			'history.detail.edit.nameRequired' => 'Se requiere un título.',
			'history.detail.edit.dateFormat' => 'd MMMM y',
			'legal.onlyInEnglish' => 'Este documento solo está disponible en inglés.',
			'nav.home' => 'Inicio',
			'nav.program' => 'Programas',
			'nav.history' => 'Historial',
			'nav.stats' => 'Estadísticas',
			'nav.settings' => 'Ajustes',
			'profile.notConnected' => 'No has iniciado sesión.',
			'profile.navTitle' => 'PERFIL',
			'profile.defaultName' => 'Atleta',
			'profile.since' => ({required Object month}) => 'Desde ${month}',
			'profile.editSheet.title' => 'Editar perfil',
			'profile.sections.badges' => 'Insignias',
			'profile.stats.sessions' => 'Sesiones',
			'profile.stats.tonnage' => 'Tonelaje',
			'profile.stats.sets' => 'Series',
			'profile.sessionCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} sesión', other: '${n} sesiones', ), 
			'profile.badges.empty' => '¡Empieza tu primera sesión para desbloquear insignias!',
			'profile.badges.firstSession' => 'Primera sesión',
			'profile.badges.tenSessions' => '10 sesiones',
			'profile.badges.tenTonnes' => '10 toneladas',
			'profile.badges.planner' => 'Planificador',
			'profile.avatar.sheetTitle' => 'Foto de perfil',
			'profile.avatar.takePhoto' => 'Tomar una foto',
			'profile.avatar.gallery' => 'Galería de fotos',
			'profile.avatar.remove' => 'Eliminar la foto',
			'profile.avatar.openError' => 'No se pudo abrir la foto.',
			'profile.avatar.updated' => '¡Foto actualizada!',
			'profile.avatar.saveError' => 'No se pudo guardar la foto.',
			'profile.avatar.removed' => 'Foto eliminada.',
			'profile.avatar.removeError' => 'No se pudo eliminar la foto.',
			'profile.editForm.saved' => 'Perfil actualizado.',
			'profile.editForm.pickDate' => 'Elegir una fecha',
			'profile.editForm.sections.identity' => 'Identidad',
			'profile.editForm.sections.physique' => 'Físico',
			'profile.editForm.sections.goal' => 'Objetivo',
			'profile.editForm.fields.name' => 'Nombre / Apodo',
			'profile.editForm.fields.bio' => 'Biografía',
			'profile.editForm.fields.birthdate' => 'Fecha de nacimiento',
			'profile.editForm.fields.weight' => 'Peso (kg)',
			'profile.editForm.fields.height' => 'Altura (cm)',
			'profile.editForm.validation.nameMin' => 'Al menos 2 caracteres',
			'profile.editForm.validation.nameMax' => 'Máximo 60 caracteres',
			'profile.editForm.validation.invalidNumber' => 'Número no válido',
			'profile.editForm.validation.heightRange' => 'Entre 80 y 260 cm',
			'profile.editForm.validation.weightRange' => 'Entre 30 y 350 kg',
			'session.bw' => 'PC',
			'session.continueLabel' => 'Continuar',
			'session.error.startFailed' => 'No se pudo iniciar la sesión.',
			'session.error.saveFailed' => 'Error al guardar.',
			'session.error.templateUpdateFailed' => 'Sesión guardada, pero no se pudo actualizar el programa.',
			'session.live.exercisePosition' => ({required Object current, required Object total}) => 'Ejercicio ${current} / ${total}',
			'session.live.supersetPosition' => ({required Object current, required Object total}) => 'Superserie ${current} / ${total}',
			'session.live.headerSubtitle' => ({required Object completed, required Object total, required Object time}) => '${completed}/${total} series · ${time}',
			'session.live.totalTonnage' => 'Tonelaje total',
			'session.live.nextExercise' => 'Siguiente ejercicio',
			'session.live.nextBlock' => 'Siguiente bloque',
			'session.live.finishSession' => 'Terminar sesión',
			'session.confirm.quitTitle' => '¿Abandonar la sesión?',
			'session.confirm.quitMessage' => 'Se perderá todo el progreso.',
			'session.confirm.quitConfirm' => 'Abandonar',
			'session.confirm.inProgressTitle' => 'Ya hay una sesión en curso',
			'session.confirm.inProgressMessage' => ({required Object name, required Object date}) => '«${name}» se inició ${date}. Iniciar una nueva eliminará definitivamente su progreso.',
			'session.confirm.overwriteAndStart' => 'Sobrescribir e iniciar',
			'session.confirm.deleteExerciseTitle' => ({required Object name}) => '¿Eliminar «${name}»?',
			'session.confirm.deleteExerciseMessage' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: 'Este ejercicio ya tiene ${n} serie completada. Se perderá.', other: 'Este ejercicio ya tiene ${n} series completadas. Se perderán.', ), 
			'session.confirm.removeSessionOnly' => 'Solo en esta sesión',
			'session.confirm.removeFromTemplate' => 'También del programa',
			'session.add.title' => 'Añadir un ejercicio',
			'session.add.subtitle' => 'Se añade solo a esta sesión, sin modificar el programa.',
			'session.add.addLabel' => 'Añadir',
			'session.add.addToSession' => 'Añadir a la sesión',
			'session.add.reps' => 'Repeticiones',
			'session.add.time' => 'Tiempo',
			'session.add.addAndTemplate' => 'Añadir a la sesión y al programa',
			'session.swap.title' => 'Editar ejercicio',
			'session.swap.currently' => ({required Object name}) => 'Actualmente: ${name}',
			'session.swap.sessionOnly' => 'Estos cambios solo se aplican a esta sesión.',
			'session.swap.useLabel' => 'Usar',
			'session.swap.adoptFormat' => 'Adoptar el formato',
			'session.swap.adoptFormatSummary' => ({required Object summary, required Object name}) => '${summary} · según «${name}»',
			'session.swap.apply' => 'Aplicar a esta sesión',
			'session.swap.applyAndTemplate' => 'Aplicar y actualizar el programa',
			'session.variants.title' => 'Elegir una variante',
			'session.variants.lockedMessage' => 'Ya hay una serie completada — termina el ejercicio o usa «Cambiar» para ajustar sobre la marcha.',
			'session.variants.pickMessage' => 'Elige una variante para este espacio. Reemplazará el ejercicio actual.',
			'session.variants.empty' => 'No hay ninguna variante definida para este ejercicio.',
			'session.variants.main' => 'PRINCIPAL',
			'session.variants.variantN' => ({required Object n}) => 'Variante ${n}',
			'session.variants.restSeconds' => ({required Object n}) => '${n}s descanso',
			'session.variants.tempoPart' => ({required Object tempo}) => ' · tempo ${tempo}',
			'session.finish.title' => '¿Terminar sesión?',
			'session.finish.summaryReps' => ({required Object completed, required Object total}) => '${completed}/${total} series · ',
			'session.finish.summaryTonnageSuffix' => ' de tonelaje',
			'session.finish.notesHint' => 'Notas sobre la sesión (opcional)…',
			'session.finish.confirm' => 'Terminar',
			'session.finish.unvalidatedSets' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} SERIE SIN VALIDAR', other: '${n} SERIES SIN VALIDAR', ), 
			'session.finish.incompleteHint' => 'Puedes volver a validar tus series o terminar de todos modos — solo se guardarán las series marcadas.',
			'session.finish.templateLabel' => 'ACTUALIZACIÓN DEL PROGRAMA',
			'session.finish.templateToggle' => ({required Object name}) => 'Actualizar «${name}»',
			'session.finish.templateHint' => 'Los cambios marcados durante la sesión. Desactívalo para dejar el programa como está.',
			'session.finish.changeAdded' => ({required Object name}) => '${name} · añadido',
			'session.finish.changeModified' => ({required Object name}) => '${name} · modificado',
			'session.finish.changeRemoved' => ({required Object name}) => '${name} · quitado',
			'session.timer.preparation' => 'PREPARACIÓN',
			'session.timer.running' => 'EN CURSO',
			'session.timer.done' => 'TERMINADO',
			'session.timer.go' => 'YA',
			'session.timer.stop' => 'Detener',
			'session.rest.title' => 'DESCANSO',
			'session.rest.sec' => 'SEG',
			'session.rest.skip' => 'Saltar',
			'session.rest.minimize' => 'Minimizar',
			'session.set.addSet' => 'Añadir una serie',
			'session.set.setLabel' => ({required Object n}) => 'Serie ${n}',
			'session.set.reps' => 'Reps',
			'session.set.load' => 'Carga',
			'session.set.duration' => 'Duración',
			'session.set.held' => 'Aguantado',
			'session.set.tonnage' => 'TONELAJE',
			'session.set.targetReps' => ({required Object n}) => 'objetivo ${n} reps',
			'session.set.targetDuration' => ({required Object value}) => 'objetivo ${value}',
			'session.set.validateWithoutTimer' => 'Validar sin temporizador',
			'session.set.cmpUp' => 'Top',
			'session.exercise.timed' => 'Cronometrado',
			'session.exercise.tempoChip' => ({required Object tempo}) => 'Tempo ${tempo}',
			'session.exercise.restChip' => ({required Object n}) => '${n}s descanso',
			'session.exercise.modified' => 'Modificado · solo esta sesión',
			'session.exercise.modifiedWas' => ({required Object name}) => 'Modificado · solo esta sesión (era: ${name})',
			'session.exercise.completedBadge' => '✓ Hecho',
			'session.exercise.totalHeld' => ({required Object value}) => 'Total aguantado: ${value}',
			'session.exercise.exerciseVolume' => ({required Object value}) => 'Volumen del ejercicio: ${value} kg',
			'session.exercise.lastTimeLabel' => 'Última vez',
			'session.exercise.otherWorkout' => 'otra sesión',
			'session.exercise.targetWasReps' => ({required Object n}) => 'buscaba ${n} reps',
			'session.exercise.targetWasSeconds' => ({required Object n}) => 'buscaba ${n}s',
			'session.exercise.morePerfs' => ({required Object n}) => '+${n}',
			'session.exercise.keptInTemplate' => 'Modificado · se guardará en el programa',
			'session.exercise.keptInTemplateWas' => ({required Object name}) => 'Modificado · se guardará en el programa (antes: ${name})',
			'session.exercise.keepInTemplateAction' => 'Toca para conservar este cambio en el programa',
			'session.overview.title' => 'Ejercicios',
			'session.overview.current' => 'EN CURSO',
			'session.overview.setsValidated' => ({required Object completed, required Object total}) => '${completed}/${total} series validadas',
			'session.superset.badge' => ({required Object n}) => 'SUPERSERIE · ${n} EJERCICIOS',
			'session.superset.addSetTo' => ({required Object letter, required Object name}) => 'Añadir una serie a ${letter} · ${name}',
			'session.duration.title' => 'Duración por serie',
			'session.duration.hint' => '45 o 1m30',
			'session.duration.confirm' => ({required Object value}) => 'Confirmar — ${value}',
			'session.weight.bodyweight' => 'Peso corporal',
			'session.weight.confirmBodyweight' => 'Confirmar — Peso corporal',
			'session.weight.confirmKg' => ({required Object value}) => 'Confirmar — ${value} kg',
			'session.search.hint' => 'Buscar un ejercicio…',
			'session.search.loading' => 'Cargando ejercicios…',
			'session.search.noMatch' => 'Ningún ejercicio coincide.',
			'session.search.certifiedBadge' => 'Ejercicio Repster',
			'session.history.title' => ({required Object name}) => 'Historial · ${name}',
			'session.history.empty' => 'Aún no hay historial para este ejercicio.',
			'session.history.loading' => 'Cargando historial…',
			'session.history.setLabel' => ({required Object n}) => 'Serie ${n}',
			'session.history.dateFormat' => 'd MMM yyyy',
			'session.fields.exerciseName' => 'Nombre del ejercicio',
			'session.fields.type' => 'Tipo',
			'session.fields.sets' => 'Series',
			'session.fields.durationSec' => 'Duración (seg)',
			'session.fields.targetReps' => 'Reps objetivo',
			'session.fields.restShort' => 'Descanso (seg)',
			'session.fields.rest' => 'Descanso (seg)',
			'session.fields.tempo' => 'Tempo',
			'session.fields.notesOptional' => 'Notas (opcional)',
			'session.fields.notesHint' => 'Consejos de técnica…',
			'session.fields.keepInTemplate' => 'Guardar también en el programa',
			'session.fields.keepInTemplateHint' => 'Por defecto, el cambio solo vale para esta sesión.',
			'session.toast.exerciseAdded' => ({required Object name}) => '${name} añadido a la sesión',
			'session.toast.validateOneSet' => 'Valida al menos una serie antes de terminar.',
			'session.toast.sessionSaved' => '¡Sesión guardada! 🎉',
			'session.toast.finishOrSwap' => 'Termina la serie actual o usa «Cambiar».',
			'session.notif.countdownChannel' => 'Cuenta atrás de descanso',
			'session.notif.doneChannel' => 'Fin del descanso',
			'session.notif.doneTitle' => 'Descanso terminado',
			'settings.title' => 'Ajustes',
			'settings.sections.profile' => 'Perfil',
			'settings.sections.data' => 'Mis datos',
			'settings.sections.preferences' => 'Preferencias',
			'settings.sections.account' => 'Cuenta',
			'settings.defaultName' => 'Atleta',
			'settings.editProfile' => 'EDITAR',
			'settings.profileUnavailable' => 'Perfil no disponible',
			'settings.rows.templates' => 'Mis programas',
			'settings.rows.history' => 'Historial de sesiones',
			'settings.rows.stats' => 'Estadísticas',
			'settings.rows.notifications' => 'Notificaciones',
			'settings.rows.privacy' => 'Privacidad',
			'settings.rows.terms' => 'Condiciones de uso',
			'settings.rows.contact' => 'Contacto y comentarios',
			'settings.rows.language' => 'Idioma',
			'settings.rows.changePassword' => 'Cambiar mi contraseña',
			'settings.soon' => 'Pronto',
			'settings.soonToast' => 'Próximamente',
			'settings.logout.action' => 'Cerrar sesión',
			'settings.logout.error' => 'Error al cerrar sesión.',
			'settings.version' => 'Repster v1.0 · Entrena, progresa, repite.',
			'settings.language.title' => 'Idioma',
			'settings.language.subtitle' => 'Elige el idioma de la aplicación',
			'settings.language.system' => 'Idioma del sistema',
			'stats.title' => 'Estadísticas',
			'stats.sessionsCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} sesión', other: '${n} sesiones', ), 
			'stats.weeksShort' => ({required Object n}) => '${n} sem.',
			'stats.subtitle.empty' => 'Ninguna sesión en el periodo',
			'stats.empty.title' => 'Aún no hay datos',
			'stats.empty.message' => 'Completa algunas sesiones para ver tus curvas y tu progresión.',
			'stats.range.last4Weeks.label' => '4 semanas',
			'stats.range.last4Weeks.short' => '4 sem.',
			'stats.range.last3Months.label' => '3 meses',
			'stats.range.last3Months.short' => '3 meses',
			'stats.range.all.label' => 'Todo',
			'stats.range.all.short' => 'Todo',
			'stats.kpi.sessions' => 'Sesiones',
			'stats.kpi.volume' => 'Tonelaje',
			'stats.kpi.sets' => 'Series',
			'stats.kpi.avgDuration' => 'Duración media',
			'stats.kpi.tension' => 'Tiempo bajo tensión',
			'stats.weeklyVolume.title' => 'Volumen por semana',
			'stats.weeklyVolume.empty' => 'Aún no hay suficientes sesiones en el periodo.',
			'stats.weeklyVolume.inProgress' => 'en curso',
			'stats.exercise.title' => 'Progresión por ejercicio',
			'stats.exercise.empty' => 'Registra al menos 2 sesiones con el mismo ejercicio con carga para ver tu curva de fuerza.',
			'stats.exercise.pickerTitle' => 'Elegir un ejercicio',
			'stats.exercise.noExercise' => 'Ningún ejercicio',
			'stats.exercise.searchHint' => 'Buscar…',
			'stats.exercise.oneRmMax' => '1RM estimado máx.',
			'stats.exercise.bestLoad' => 'mejor carga',
			'stats.exercise.record' => 'récord',
			'stats.exercise.trendUnknown' => 'Aún no hay sesiones suficientes para ver una tendencia',
			'stats.exercise.trendProgressing' => 'Progresando',
			'stats.exercise.trendPlateau' => ({required Object n}) => 'Estancado · ${n} sesiones sin récord',
			'stats.exercise.trendRegressing' => 'Retrocediendo',
			'stats.exercise.perMonth' => ({required Object value}) => '${value} %/mes',
			'stats.exercise.plateauHint' => 'Prueba menos reps con más carga, o cambia de ejercicio.',
			'stats.records.title' => 'Récords',
			'stats.records.bestSession' => 'Mejor sesión',
			'stats.records.heaviestLift' => 'Carga máxima',
			'stats.records.bestOneRm' => '1RM estimado',
			'stats.records.bestStreak' => 'Racha más larga',
			'stats.records.consecutiveWeeks' => 'semanas consecutivas',
			'stats.strength.title' => 'Fuerza',
			'stats.strength.scope' => 'todo el historial',
			'templates.list.title' => 'Programas',
			'templates.list.subtitleActive' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} sesión activa', other: '${n} sesiones activas', ), 
			'templates.list.newAction' => 'Crear',
			'templates.list.emptyTitle' => 'No hay sesiones',
			'templates.list.emptyMessage' => 'Crea tu primera sesión para armar tu programa.',
			'templates.list.emptyAction' => 'Crear una sesión',
			'templates.list.reorderError' => 'Error al reordenar.',
			'templates.list.toggleError' => 'Acción imposible.',
			'templates.list.duplicated' => '¡Sesión copiada!',
			'templates.list.duplicateError' => 'No se pudo duplicar.',
			'templates.list.deleted' => 'Sesión eliminada.',
			'templates.list.deleteError' => 'No se pudo eliminar.',
			'templates.list.copySuffix' => '(copia)',
			'templates.card.exerciseCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} ejercicio', other: '${n} ejercicios', ), 
			'templates.card.activate' => 'Activar',
			'templates.card.deactivate' => 'Desactivar',
			'templates.detail.noExercises' => 'No hay ejercicios en esta sesión.',
			'templates.detail.superset' => 'Superserie',
			'templates.detail.setsCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} serie', other: '${n} series', ), 
			'templates.detail.seconds' => ({required Object n}) => '${n} s',
			'templates.detail.tempo' => ({required Object value}) => 'Tempo ${value}',
			'templates.detail.rest' => ({required Object n}) => 'Descanso ${n}s',
			'templates.detail.start' => 'Iniciar sesión',
			'templates.editor.newTitle' => 'Nueva sesión',
			'templates.editor.editTitle' => 'Editar sesión',
			'templates.editor.exercisesHeader' => ({required Object count}) => 'EJERCICIOS (${count})',
			'templates.editor.addExercise' => 'Añadir un ejercicio',
			'templates.editor.save' => 'Guardar sesión',
			'templates.editor.validationError' => 'Introduce un nombre y al menos un ejercicio con nombre.',
			'templates.fields.name' => 'Nombre de la sesión',
			'templates.fields.nameHint' => 'ej.: Pecho / Tríceps / Hombros',
			'templates.fields.description' => 'Descripción (opcional)',
			'templates.fields.descriptionHint' => 'Describe tu sesión…',
			'templates.fields.emoji' => 'Imagen',
			'templates.fields.exerciseName' => 'Nombre del ejercicio',
			'templates.fields.exerciseNameHint' => 'ej.: Press de banca',
			'templates.fields.type' => 'Tipo',
			'templates.fields.sets' => 'Series',
			'templates.fields.duration' => 'Duración (s)',
			'templates.fields.targetReps' => 'Reps objetivo',
			'templates.fields.rest' => 'Descanso (s)',
			'templates.fields.tempo' => 'Tempo',
			'templates.fields.tempoHint' => '3-1-X-0',
			'templates.fields.notes' => 'Notas (opcional)',
			'templates.fields.notesHint' => 'Consejos técnicos…',
			'templates.slot.newExercise' => 'Nuevo ejercicio',
			'templates.slot.variantN' => ({required Object n}) => 'Variante ${n}',
			'templates.slot.primary' => 'PRINCIPAL',
			'templates.slot.variant' => 'Variante',
			'templates.slot.addVariant' => 'Añadir una variante',
			'templates.slot.supersetNote' => 'Encadenado en superserie con el siguiente ejercicio',
			'templates.slot.supersetLabel' => 'SUPERSERIE',
			'templates.slot.reps' => 'Repeticiones',
			'templates.slot.time' => 'Tiempo',
			'templates.emojiPicker.title' => 'Imagen de la sesión',
			'templates.emojiPicker.searchHint' => 'Buscar un emoji…',
			'templates.emojiPicker.noResults' => 'Ningún emoji coincide.',
			'templates.emojiPicker.change' => 'Cambiar',
			'templates.programs.newSession' => 'Una sesión',
			'templates.programs.newProgram' => 'Un programa',
			'templates.programs.nameTitleNew' => 'Nuevo programa',
			'templates.programs.nameTitleRename' => 'Renombrar el programa',
			'templates.programs.nameHint' => 'PPL, Full body, Vacaciones…',
			'templates.programs.createAction' => 'Crear el programa',
			'templates.programs.sessionCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} sesión', other: '${n} sesiones', ), 
			'templates.programs.active' => 'Activo',
			'templates.programs.empty' => 'Vacío',
			'templates.programs.sessionInactive' => 'Desactivada',
			'templates.programs.emptyTitle' => 'Ninguna sesión',
			'templates.programs.emptyMessage' => 'Añade las sesiones que componen este programa.',
			'templates.programs.switchOn' => 'Programa activo',
			'templates.programs.switchOff' => 'Activar este programa',
			'templates.programs.switchHint' => 'Sus sesiones alimentan tu inicio. Los demás programas se desactivan.',
			'templates.programs.addSession' => 'Añadir una sesión',
			'templates.programs.addSessionTitle' => ({required Object name}) => 'Añadir a ${name}',
			'templates.programs.createSession' => 'Crear una sesión nueva',
			'templates.programs.loose' => 'Sin programa',
			'templates.programs.moveTitle' => 'Mover a',
			'templates.programs.start' => 'Empezar',
			'templates.programs.move' => 'Mover',
			'templates.programs.duplicate' => 'Duplicar',
			'templates.programs.rename' => 'Renombrar',
			'templates.programs.dragHint' => 'Mantén pulsada una sesión para arrastrarla a un programa.',
			'templates.programs.deleteProgramTitle' => ({required Object name}) => '¿Eliminar «${name}»?',
			'templates.programs.deleteProgramMessage' => 'Sus sesiones se conservan, sin programa.',
			'templates.programs.deleteSessionTitle' => ({required Object name}) => '¿Eliminar «${name}»?',
			'templates.programs.deleteSessionMessage' => 'La sesión se elimina definitivamente. Tu historial se conserva.',
			'templates.programs.moved' => ({required Object name}) => 'Movida a ${name}.',
			'templates.programs.movedOut' => 'Sacada de su programa.',
			'templates.programs.activated' => ({required Object name}) => '${name} ya está activo.',
			'templates.programs.deactivated' => ({required Object name}) => '${name} está desactivado.',
			'templates.programs.programDeleted' => 'Programa eliminado.',
			'templates.programs.error' => 'No se pudo. Inténtalo de nuevo.',
			'tempo.helper' => 'Excéntrica — pausa — concéntrica — pausa (en s)',
			'tempo.formatError' => 'Formato esperado: 3-1-X-0',
			_ => null,
		};
	}
}
