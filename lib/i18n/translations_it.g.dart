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
class TranslationsIt extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsIt({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.it,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <it>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	late final TranslationsIt _root = this; // ignore: unused_field

	@override 
	TranslationsIt $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsIt(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$auth$it auth = _Translations$auth$it._(_root);
	@override late final _Translations$common$it common = _Translations$common$it._(_root);
	@override late final _Translations$contact$it contact = _Translations$contact$it._(_root);
	@override late final _Translations$dashboard$it dashboard = _Translations$dashboard$it._(_root);
	@override late final _Translations$emoji$it emoji = _Translations$emoji$it._(_root);
	@override late final _Translations$errors$it errors = _Translations$errors$it._(_root);
	@override late final _Translations$goals$it goals = _Translations$goals$it._(_root);
	@override late final _Translations$history$it history = _Translations$history$it._(_root);
	@override late final _Translations$legal$it legal = _Translations$legal$it._(_root);
	@override late final _Translations$nav$it nav = _Translations$nav$it._(_root);
	@override late final _Translations$profile$it profile = _Translations$profile$it._(_root);
	@override late final _Translations$session$it session = _Translations$session$it._(_root);
	@override late final _Translations$settings$it settings = _Translations$settings$it._(_root);
	@override late final _Translations$stats$it stats = _Translations$stats$it._(_root);
	@override late final _Translations$templates$it templates = _Translations$templates$it._(_root);
	@override late final _Translations$tempo$it tempo = _Translations$tempo$it._(_root);
}

// Path: auth
class _Translations$auth$it extends Translations$auth$en {
	_Translations$auth$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override late final _Translations$auth$fields$it fields = _Translations$auth$fields$it._(_root);
	@override String get backToLogin => 'Torna all\'accesso';
	@override late final _Translations$auth$login$it login = _Translations$auth$login$it._(_root);
	@override late final _Translations$auth$signup$it signup = _Translations$auth$signup$it._(_root);
	@override late final _Translations$auth$onboarding$it onboarding = _Translations$auth$onboarding$it._(_root);
	@override late final _Translations$auth$verifyEmail$it verifyEmail = _Translations$auth$verifyEmail$it._(_root);
	@override late final _Translations$auth$forgotPassword$it forgotPassword = _Translations$auth$forgotPassword$it._(_root);
	@override late final _Translations$auth$updatePassword$it updatePassword = _Translations$auth$updatePassword$it._(_root);
	@override late final _Translations$auth$changePassword$it changePassword = _Translations$auth$changePassword$it._(_root);
	@override late final _Translations$auth$validators$it validators = _Translations$auth$validators$it._(_root);
}

// Path: common
class _Translations$common$it extends Translations$common$en {
	_Translations$common$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override late final _Translations$common$actions$it actions = _Translations$common$actions$it._(_root);
	@override String get unnamed => '(senza nome)';
	@override late final _Translations$common$units$it units = _Translations$common$units$it._(_root);
	@override late final _Translations$common$date$it date = _Translations$common$date$it._(_root);
	@override late final _Translations$common$language$it language = _Translations$common$language$it._(_root);
}

// Path: contact
class _Translations$contact$it extends Translations$contact$en {
	_Translations$contact$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override late final _Translations$contact$header$it header = _Translations$contact$header$it._(_root);
	@override late final _Translations$contact$sections$it sections = _Translations$contact$sections$it._(_root);
	@override late final _Translations$contact$fields$it fields = _Translations$contact$fields$it._(_root);
	@override String counter({required Object current, required Object max}) => '${current} / ${max}';
	@override String get submit => 'Invia';
	@override late final _Translations$contact$categories$it categories = _Translations$contact$categories$it._(_root);
	@override late final _Translations$contact$success$it success = _Translations$contact$success$it._(_root);
}

// Path: dashboard
class _Translations$dashboard$it extends Translations$dashboard$en {
	_Translations$dashboard$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override late final _Translations$dashboard$greeting$it greeting = _Translations$dashboard$greeting$it._(_root);
	@override String get defaultName => 'Atleta';
	@override String get seeAll => 'Vedi tutto';
	@override late final _Translations$dashboard$sections$it sections = _Translations$dashboard$sections$it._(_root);
	@override late final _Translations$dashboard$templates$it templates = _Translations$dashboard$templates$it._(_root);
	@override String exerciseCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
		one: '${n} esercizio',
		other: '${n} esercizi',
	);
	@override late final _Translations$dashboard$hero$it hero = _Translations$dashboard$hero$it._(_root);
	@override late final _Translations$dashboard$recent$it recent = _Translations$dashboard$recent$it._(_root);
	@override late final _Translations$dashboard$inProgress$it inProgress = _Translations$dashboard$inProgress$it._(_root);
	@override late final _Translations$dashboard$stats$it stats = _Translations$dashboard$stats$it._(_root);
	@override String streakBadge({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
		one: '${n} settimana di fila',
		other: '${n} settimane di fila',
	);
	@override late final _Translations$dashboard$consistency$it consistency = _Translations$dashboard$consistency$it._(_root);
}

// Path: emoji
class _Translations$emoji$it extends Translations$emoji$en {
	_Translations$emoji$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override Map<String, String> get groups => {
		'sport': 'Sport e allenamento',
		'body': 'Corpo e gesti',
		'energy': 'Energia e simboli',
		'faces': 'Facce',
		'hearts': 'Cuori',
		'animals': 'Animali',
		'food': 'Cibo e bevande',
		'nature': 'Natura e meteo',
		'places': 'Luoghi e viaggi',
		'objects': 'Oggetti e strumenti',
	};
	@override Map<String, String> get labels => {
		'person-lifting-weights': 'Sollevamento pesi',
		'man-lifting-weights': 'Uomo che solleva pesi',
		'woman-lifting-weights': 'Donna che solleva pesi',
		'flexed-biceps': 'Bicipite',
		'boxing-glove': 'Guantone da boxe',
		'martial-arts-uniform': 'Kimono',
		'person-wrestling': 'Lottatori',
		'person-running': 'Corridore',
		'man-running': 'Uomo che corre',
		'woman-running': 'Donna che corre',
		'running-shoe': 'Scarpa da corsa',
		'running-shirt': 'Canotta da corsa',
		'hiking-boot': 'Scarpone da trekking',
		'person-walking': 'Persona che cammina',
		'person-climbing': 'Scalatore',
		'person-biking': 'Ciclista',
		'person-mountain-biking': 'Ciclista di montagna',
		'bicycle': 'Bicicletta',
		'person-swimming': 'Nuotatore',
		'person-surfing': 'Surfista',
		'person-rowing-boat': 'Canottaggio',
		'canoe': 'Canoa',
		'person-in-lotus-position': 'Posizione del loto',
		'lotus': 'Loto',
		'person-cartwheeling': 'Ruota',
		'person-juggling': 'Giocoliere',
		'person-bouncing-ball': 'Palleggio',
		'person-playing-handball': 'Pallamano',
		'person-playing-water-polo': 'Pallanuoto',
		'person-fencing': 'Scherma',
		'person-golfing': 'Golfista',
		'horse-racing': 'Ippica',
		'skier': 'Sciatore',
		'snowboarder': 'Snowboarder',
		'ice-skate': 'Pattino da ghiaccio',
		'roller-skate': 'Pattino a rotelle',
		'skateboard': 'Skateboard',
		'basketball': 'Palla da basket',
		'soccer-ball': 'Pallone da calcio',
		'american-football': 'Football americano',
		'rugby-football': 'Palla da rugby',
		'tennis': 'Tennis',
		'volleyball': 'Pallavolo',
		'baseball': 'Baseball',
		'ping-pong': 'Ping pong',
		'badminton': 'Badminton',
		'field-hockey': 'Hockey su prato',
		'ice-hockey': 'Hockey su ghiaccio',
		'bowling': 'Bowling',
		'flying-disc': 'Frisbee',
		'bow-and-arrow': 'Arco e freccia',
		'bullseye': 'Bersaglio',
		'pool-8-ball': 'Palla da biliardo',
		'parachute': 'Paracadute',
		'trophy': 'Trofeo',
		'sports-medal': 'Medaglia sportiva',
		'1st-place-medal': 'Medaglia d’oro',
		'2nd-place-medal': 'Medaglia d’argento',
		'3rd-place-medal': 'Medaglia di bronzo',
		'military-medal': 'Medaglia militare',
		'chequered-flag': 'Bandiera a scacchi',
		'triangular-flag': 'Bandierina',
		'stadium': 'Stadio',
		'stopwatch': 'Cronometro',
		'timer-clock': 'Timer',
		'alarm-clock': 'Sveglia',
		'hourglass-not-done': 'Clessidra',
		'leg': 'Gamba',
		'foot': 'Piede',
		'anatomical-heart': 'Cuore anatomico',
		'lungs': 'Polmoni',
		'bone': 'Osso',
		'brain': 'Cervello',
		'footprints': 'Impronte',
		'eyes': 'Occhi',
		'raised-fist': 'Pugno alzato',
		'oncoming-fist': 'Pugno frontale',
		'left-facing-fist': 'Pugno verso sinistra',
		'right-facing-fist': 'Pugno verso destra',
		'thumbs-up': 'Pollice in su',
		'clapping-hands': 'Applauso',
		'raising-hands': 'Mani alzate',
		'heart-hands': 'Mani a cuore',
		'handshake': 'Stretta di mano',
		'folded-hands': 'Mani giunte',
		'victory-hand': 'Segno di vittoria',
		'ok-hand': 'Segno OK',
		'waving-hand': 'Mano che saluta',
		'pinched-fingers': 'Mano a pigna',
		'sign-of-the-horns': 'Corna',
		'call-me-hand': 'Chiamami',
		'crossed-fingers': 'Dita incrociate',
		'love-you-gesture': 'Gesto ti amo',
		'sweat-droplets': 'Gocce di sudore',
		'zzz': 'Zzz',
		'person-standing': 'Persona in piedi',
		'person-kneeling': 'Persona in ginocchio',
		'fire': 'Fuoco',
		'high-voltage': 'Fulmine',
		'collision': 'Esplosione',
		'dizzy': 'Stordimento',
		'sparkles': 'Scintille',
		'star': 'Stella',
		'shooting-star': 'Stella cadente',
		'rocket': 'Razzo',
		'flying-saucer': 'Disco volante',
		'hundred-points': 'Cento punti',
		'check-mark-button': 'Spunta verde',
		'battery': 'Batteria',
		'light-bulb': 'Lampadina',
		'bomb': 'Bomba',
		'fireworks': 'Fuochi d’artificio',
		'party-popper': 'Spara coriandoli',
		'confetti-ball': 'Palla di coriandoli',
		'mirror-ball': 'Palla da discoteca',
		'crown': 'Corona',
		'gem-stone': 'Gemma',
		'shield': 'Scudo',
		'crossed-swords': 'Spade incrociate',
		'infinity': 'Infinito',
		'skull': 'Teschio',
		'skull-and-crossbones': 'Teschio con ossa',
		'ghost': 'Fantasma',
		'alien': 'Alieno',
		'robot': 'Robot',
		'pile-of-poo': 'Cacca',
		'magic-wand': 'Bacchetta magica',
		'crystal-ball': 'Sfera di cristallo',
		'grinning-face': 'Faccina sorridente',
		'grinning-face-with-big-eyes': 'Sorriso con occhi grandi',
		'grinning-face-with-smiling-eyes': 'Sorriso con occhi sorridenti',
		'beaming-face-with-smiling-eyes': 'Faccina raggiante',
		'grinning-squinting-face': 'Risata a occhi chiusi',
		'grinning-face-with-sweat': 'Sorriso con sudore',
		'face-with-tears-of-joy': 'Lacrime di gioia',
		'rolling-on-the-floor-laughing': 'Rotolarsi dalle risate',
		'smiling-face-with-smiling-eyes': 'Faccina con occhi sorridenti',
		'smiling-face-with-halo': 'Faccina con aureola',
		'smiling-face-with-hearts': 'Faccina con cuoricini',
		'smiling-face-with-heart-eyes': 'Occhi a cuore',
		'star-struck': 'Occhi a stella',
		'face-blowing-a-kiss': 'Faccina che manda un bacio',
		'face-savoring-food': 'Faccina golosa',
		'face-with-tongue': 'Faccina con la lingua fuori',
		'winking-face': 'Occhiolino',
		'winking-face-with-tongue': 'Occhiolino con la lingua',
		'zany-face': 'Faccina pazza',
		'money-mouth-face': 'Faccina con la bocca di dollari',
		'hugging-face': 'Faccina che abbraccia',
		'face-with-hand-over-mouth': 'Mano sulla bocca',
		'face-with-peeking-eye': 'Faccina che sbircia',
		'shushing-face': 'Faccina che fa silenzio',
		'thinking-face': 'Faccina pensierosa',
		'saluting-face': 'Faccina che saluta',
		'zipper-mouth-face': 'Bocca con cerniera',
		'face-with-raised-eyebrow': 'Sopracciglio alzato',
		'neutral-face': 'Faccina neutra',
		'unamused-face': 'Faccina scocciata',
		'smirking-face': 'Sorrisetto',
		'drooling-face': 'Faccina che sbava',
		'sleeping-face': 'Faccina addormentata',
		'face-with-medical-mask': 'Mascherina',
		'hot-face': 'Faccina accaldata',
		'cold-face': 'Faccina congelata',
		'woozy-face': 'Faccina stordita',
		'face-with-spiral-eyes': 'Occhi a spirale',
		'exploding-head': 'Testa che esplode',
		'cowboy-hat-face': 'Cappello da cowboy',
		'partying-face': 'Faccina in festa',
		'disguised-face': 'Faccina travestita',
		'smiling-face-with-sunglasses': 'Faccina con occhiali da sole',
		'nerd-face': 'Faccina da secchione',
		'face-with-monocle': 'Faccina con monocolo',
		'slightly-smiling-face': 'Sorriso leggero',
		'upside-down-face': 'Faccina capovolta',
		'melting-face': 'Faccina che si scioglie',
		'flushed-face': 'Faccina imbarazzata',
		'pleading-face': 'Faccina supplicante',
		'face-holding-back-tears': 'Faccina che trattiene le lacrime',
		'loudly-crying-face': 'Pianto a dirotto',
		'face-screaming-in-fear': 'Urlo di paura',
		'downcast-face-with-sweat': 'Faccina abbattuta e sudata',
		'weary-face': 'Faccina sfinita',
		'tired-face': 'Faccina stanca',
		'yawning-face': 'Sbadiglio',
		'face-with-steam-from-nose': 'Faccina che sbuffa',
		'angry-face': 'Faccina arrabbiata',
		'smiling-face-with-horns': 'Diavoletto',
		'angry-face-with-horns': 'Diavolo arrabbiato',
		'red-heart': 'Cuore rosso',
		'orange-heart': 'Cuore arancione',
		'yellow-heart': 'Cuore giallo',
		'green-heart': 'Cuore verde',
		'blue-heart': 'Cuore blu',
		'purple-heart': 'Cuore viola',
		'black-heart': 'Cuore nero',
		'white-heart': 'Cuore bianco',
		'pink-heart': 'Cuore rosa',
		'sparkling-heart': 'Cuore scintillante',
		'growing-heart': 'Cuore che cresce',
		'beating-heart': 'Cuore che batte',
		'revolving-hearts': 'Cuori che girano',
		'two-hearts': 'Due cuori',
		'heart-on-fire': 'Cuore in fiamme',
		'mending-heart': 'Cuore che guarisce',
		'broken-heart': 'Cuore spezzato',
		'heart-with-arrow': 'Cuore trafitto',
		'heart-with-ribbon': 'Cuore con fiocco',
		'gorilla': 'Gorilla',
		'lion': 'Leone',
		'tiger': 'Tigre',
		'leopard': 'Leopardo',
		'bear': 'Orso',
		'polar-bear': 'Orso polare',
		'ox': 'Bue',
		'water-buffalo': 'Bufalo',
		'bison': 'Bisonte',
		'cow': 'Mucca',
		'rhinoceros': 'Rinoceronte',
		'elephant': 'Elefante',
		'hippopotamus': 'Ippopotamo',
		'mammoth': 'Mammut',
		'horse': 'Cavallo',
		'zebra': 'Zebra',
		'giraffe': 'Giraffa',
		'camel': 'Cammello',
		'deer': 'Cervo',
		'ram': 'Ariete',
		'goat': 'Capra',
		'pig': 'Maiale',
		'wolf': 'Lupo',
		'fox': 'Volpe',
		'dog': 'Cane',
		'cat': 'Gatto',
		'black-cat': 'Gatto nero',
		'monkey': 'Scimmia',
		'see-no-evil-monkey': 'Scimmia che non vede',
		'kangaroo': 'Canguro',
		'rabbit': 'Coniglio',
		'hedgehog': 'Riccio',
		'koala': 'Koala',
		'panda': 'Panda',
		'sloth': 'Bradipo',
		'otter': 'Lontra',
		'seal': 'Foca',
		'bat': 'Pipistrello',
		'eagle': 'Aquila',
		'owl': 'Gufo',
		'rooster': 'Gallo',
		'chicken': 'Gallina',
		'baby-chick': 'Pulcino',
		'duck': 'Anatra',
		'swan': 'Cigno',
		'flamingo': 'Fenicottero',
		'peacock': 'Pavone',
		'parrot': 'Pappagallo',
		'dove': 'Colomba',
		'penguin': 'Pinguino',
		'shark': 'Squalo',
		'whale': 'Balena',
		'dolphin': 'Delfino',
		'octopus': 'Polpo',
		'fish': 'Pesce',
		'tropical-fish': 'Pesce tropicale',
		'crab': 'Granchio',
		'lobster': 'Aragosta',
		'shrimp': 'Gambero',
		'turtle': 'Tartaruga',
		'crocodile': 'Coccodrillo',
		'snake': 'Serpente',
		'frog': 'Rana',
		't-rex': 'T-Rex',
		'sauropod': 'Sauropode',
		'dragon': 'Drago',
		'unicorn': 'Unicorno',
		'butterfly': 'Farfalla',
		'honeybee': 'Ape',
		'scorpion': 'Scorpione',
		'cut-of-meat': 'Bistecca',
		'meat-on-bone': 'Carne con osso',
		'poultry-leg': 'Coscia di pollo',
		'bacon': 'Pancetta',
		'egg': 'Uovo',
		'cooked-rice': 'Ciotola di riso',
		'steaming-bowl': 'Ciotola fumante',
		'green-salad': 'Insalata',
		'broccoli': 'Broccoli',
		'avocado': 'Avocado',
		'banana': 'Banana',
		'red-apple': 'Mela rossa',
		'green-apple': 'Mela verde',
		'pear': 'Pera',
		'peach': 'Pesca',
		'cherries': 'Ciliegie',
		'strawberry': 'Fragola',
		'blueberries': 'Mirtilli',
		'grapes': 'Uva',
		'watermelon': 'Anguria',
		'pineapple': 'Ananas',
		'mango': 'Mango',
		'kiwi-fruit': 'Kiwi',
		'lemon': 'Limone',
		'coconut': 'Noce di cocco',
		'carrot': 'Carota',
		'potato': 'Patata',
		'tomato': 'Pomodoro',
		'bell-pepper': 'Peperone',
		'hot-pepper': 'Peperoncino',
		'eggplant': 'Melanzana',
		'bread': 'Pane',
		'croissant': 'Croissant',
		'glass-of-milk': 'Bicchiere di latte',
		'hot-beverage': 'Caffè',
		'honey-pot': 'Vasetto di miele',
		'chocolate-bar': 'Tavoletta di cioccolato',
		'cookie': 'Biscotto',
		'doughnut': 'Ciambella',
		'ice-cream': 'Gelato',
		'birthday-cake': 'Torta di compleanno',
		'pancakes': 'Pancake',
		'popcorn': 'Popcorn',
		'lollipop': 'Lecca-lecca',
		'pizza': 'Pizza',
		'hamburger': 'Hamburger',
		'french-fries': 'Patatine fritte',
		'taco': 'Taco',
		'sushi': 'Sushi',
		'fork-and-knife': 'Posate',
		'bottle-with-popping-cork': 'Bottiglia che si stappa',
		'clinking-glasses': 'Brindisi',
		'wine-glass': 'Calice di vino',
		'beer-mug': 'Boccale di birra',
		'tropical-drink': 'Cocktail tropicale',
		'sun': 'Sole',
		'sun-with-face': 'Sole con faccia',
		'sunrise': 'Alba',
		'sunrise-over-mountains': 'Alba in montagna',
		'sunset': 'Tramonto',
		'cloud': 'Nuvola',
		'cloud-with-rain': 'Pioggia',
		'cloud-with-lightning': 'Temporale',
		'cloud-with-lightning-and-rain': 'Temporale con pioggia',
		'snowflake': 'Fiocco di neve',
		'rainbow': 'Arcobaleno',
		'crescent-moon': 'Luna crescente',
		'full-moon': 'Luna piena',
		'night-with-stars': 'Notte stellata',
		'milky-way': 'Via Lattea',
		'mountain': 'Montagna',
		'snow-capped-mountain': 'Montagna innevata',
		'volcano': 'Vulcano',
		'desert-island': 'Isola deserta',
		'beach-with-umbrella': 'Spiaggia con ombrellone',
		'water-wave': 'Onda',
		'droplet': 'Goccia',
		'tornado': 'Tornado',
		'palm-tree': 'Palma',
		'cactus': 'Cactus',
		'seedling': 'Germoglio',
		'four-leaf-clover': 'Quadrifoglio',
		'sunflower': 'Girasole',
		'rose': 'Rosa',
		'tulip': 'Tulipano',
		'cherry-blossom': 'Fiore di ciliegio',
		'maple-leaf': 'Foglia d’acero',
		'globe-showing-europe-africa': 'Globo terrestre',
		'globe-with-meridians': 'Globo con meridiani',
		'house': 'Casa',
		'cityscape': 'Città',
		'tent': 'Tenda',
		'hot-springs': 'Terme',
		'world-map': 'Mappa del mondo',
		'compass': 'Bussola',
		'airplane': 'Aereo',
		'automobile': 'Automobile',
		'racing-car': 'Auto da corsa',
		'motorcycle': 'Moto',
		'sailboat': 'Barca a vela',
		'gear': 'Ingranaggio',
		'hammer': 'Martello',
		'wrench': 'Chiave inglese',
		'hammer-and-wrench': 'Martello e chiave',
		'brick': 'Mattone',
		'puzzle-piece': 'Pezzo di puzzle',
		'game-die': 'Dado',
		'joystick': 'Joystick',
		'video-game': 'Controller',
		'headphone': 'Cuffie',
		'musical-note': 'Nota musicale',
		'musical-notes': 'Note musicali',
		'guitar': 'Chitarra',
		'calendar': 'Calendario',
		'mobile-phone': 'Telefono',
		'laptop': 'Computer portatile',
		'clipboard': 'Blocco appunti',
		'memo': 'Promemoria',
		'pencil': 'Matita',
		'chart-increasing': 'Grafico in crescita',
		'bar-chart': 'Grafico a barre',
		'balance-scale': 'Bilancia',
		'books': 'Libri',
		'open-book': 'Libro aperto',
		'graduation-cap': 'Tocco di laurea',
		'money-bag': 'Sacco di soldi',
		'coin': 'Moneta',
		'locked': 'Lucchetto chiuso',
		'unlocked': 'Lucchetto aperto',
		'key': 'Chiave',
		'dna': 'DNA',
		'pill': 'Pillola',
		'stethoscope': 'Stetoscopio',
		'adhesive-bandage': 'Cerotto',
		'speech-balloon': 'Fumetto',
		'thought-balloon': 'Nuvoletta di pensiero',
	};
}

// Path: errors
class _Translations$errors$it extends Translations$errors$en {
	_Translations$errors$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get network => 'Nessuna connessione di rete. Controlla la connessione.';
	@override String get notFound => 'Elemento non trovato.';
	@override String get generic => 'Si è verificato un errore. Riprova.';
	@override String get invalidCode => 'Codice non valido o scaduto.';
	@override String get passwordSameAsOld => 'La nuova password deve essere diversa dalla precedente.';
	@override late final _Translations$errors$auth$it auth = _Translations$errors$auth$it._(_root);
}

// Path: goals
class _Translations$goals$it extends Translations$goals$en {
	_Translations$goals$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get strength => 'Forza';
	@override String get hypertrophy => 'Ipertrofia';
	@override String get endurance => 'Resistenza';
	@override String get weightLoss => 'Perdita di peso';
	@override String get maintenance => 'Mantenimento';
}

// Path: history
class _Translations$history$it extends Translations$history$en {
	_Translations$history$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Cronologia';
	@override String get emptySubtitle => 'Nessuna sessione';
	@override String get emptyTitle => 'Ancora nessuna sessione';
	@override String get emptyMessage => 'Avvia la tua prima sessione dalla schermata principale — comparirà qui.';
	@override String sessionCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
		one: '${n} sessione',
		other: '${n} sessioni',
	);
	@override String get deleteError => 'Eliminazione non riuscita.';
	@override late final _Translations$history$groups$it groups = _Translations$history$groups$it._(_root);
	@override late final _Translations$history$panel$it panel = _Translations$history$panel$it._(_root);
	@override late final _Translations$history$detail$it detail = _Translations$history$detail$it._(_root);
}

// Path: legal
class _Translations$legal$it extends Translations$legal$en {
	_Translations$legal$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get onlyInEnglish => 'Questo documento è disponibile solo in inglese.';
}

// Path: nav
class _Translations$nav$it extends Translations$nav$en {
	_Translations$nav$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get home => 'Home';
	@override String get program => 'Programmi';
	@override String get history => 'Cronologia';
	@override String get stats => 'Statistiche';
	@override String get settings => 'Impostazioni';
}

// Path: profile
class _Translations$profile$it extends Translations$profile$en {
	_Translations$profile$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get notConnected => 'Non hai effettuato l\'accesso.';
	@override String get navTitle => 'PROFILO';
	@override String get defaultName => 'Atleta';
	@override String since({required Object month}) => 'Dal ${month}';
	@override late final _Translations$profile$editSheet$it editSheet = _Translations$profile$editSheet$it._(_root);
	@override late final _Translations$profile$sections$it sections = _Translations$profile$sections$it._(_root);
	@override late final _Translations$profile$stats$it stats = _Translations$profile$stats$it._(_root);
	@override String sessionCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
		one: '${n} sessione',
		other: '${n} sessioni',
	);
	@override late final _Translations$profile$badges$it badges = _Translations$profile$badges$it._(_root);
	@override late final _Translations$profile$avatar$it avatar = _Translations$profile$avatar$it._(_root);
	@override late final _Translations$profile$editForm$it editForm = _Translations$profile$editForm$it._(_root);
}

// Path: session
class _Translations$session$it extends Translations$session$en {
	_Translations$session$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get bw => 'PC';
	@override String get continueLabel => 'Continua';
	@override late final _Translations$session$error$it error = _Translations$session$error$it._(_root);
	@override late final _Translations$session$live$it live = _Translations$session$live$it._(_root);
	@override late final _Translations$session$confirm$it confirm = _Translations$session$confirm$it._(_root);
	@override late final _Translations$session$add$it add = _Translations$session$add$it._(_root);
	@override late final _Translations$session$swap$it swap = _Translations$session$swap$it._(_root);
	@override late final _Translations$session$variants$it variants = _Translations$session$variants$it._(_root);
	@override late final _Translations$session$finish$it finish = _Translations$session$finish$it._(_root);
	@override late final _Translations$session$timer$it timer = _Translations$session$timer$it._(_root);
	@override late final _Translations$session$rest$it rest = _Translations$session$rest$it._(_root);
	@override late final _Translations$session$set$it set = _Translations$session$set$it._(_root);
	@override late final _Translations$session$exercise$it exercise = _Translations$session$exercise$it._(_root);
	@override late final _Translations$session$overview$it overview = _Translations$session$overview$it._(_root);
	@override late final _Translations$session$superset$it superset = _Translations$session$superset$it._(_root);
	@override late final _Translations$session$duration$it duration = _Translations$session$duration$it._(_root);
	@override late final _Translations$session$weight$it weight = _Translations$session$weight$it._(_root);
	@override late final _Translations$session$search$it search = _Translations$session$search$it._(_root);
	@override late final _Translations$session$history$it history = _Translations$session$history$it._(_root);
	@override late final _Translations$session$fields$it fields = _Translations$session$fields$it._(_root);
	@override late final _Translations$session$toast$it toast = _Translations$session$toast$it._(_root);
	@override late final _Translations$session$notif$it notif = _Translations$session$notif$it._(_root);
}

// Path: settings
class _Translations$settings$it extends Translations$settings$en {
	_Translations$settings$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Impostazioni';
	@override late final _Translations$settings$sections$it sections = _Translations$settings$sections$it._(_root);
	@override String get defaultName => 'Atleta';
	@override String get editProfile => 'MODIFICA';
	@override String get profileUnavailable => 'Profilo non disponibile';
	@override late final _Translations$settings$rows$it rows = _Translations$settings$rows$it._(_root);
	@override String get soon => 'Presto';
	@override String get soonToast => 'Presto disponibile';
	@override late final _Translations$settings$logout$it logout = _Translations$settings$logout$it._(_root);
	@override String get version => 'Repster v1.0 · Allenati, progredisci, ripeti.';
	@override late final _Translations$settings$language$it language = _Translations$settings$language$it._(_root);
}

// Path: stats
class _Translations$stats$it extends Translations$stats$en {
	_Translations$stats$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Statistiche';
	@override String sessionsCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
		one: '${n} sessione',
		other: '${n} sessioni',
	);
	@override String weeksShort({required Object n}) => '${n} sett.';
	@override late final _Translations$stats$subtitle$it subtitle = _Translations$stats$subtitle$it._(_root);
	@override late final _Translations$stats$empty$it empty = _Translations$stats$empty$it._(_root);
	@override late final _Translations$stats$range$it range = _Translations$stats$range$it._(_root);
	@override late final _Translations$stats$kpi$it kpi = _Translations$stats$kpi$it._(_root);
	@override late final _Translations$stats$weeklyVolume$it weeklyVolume = _Translations$stats$weeklyVolume$it._(_root);
	@override late final _Translations$stats$exercise$it exercise = _Translations$stats$exercise$it._(_root);
	@override late final _Translations$stats$records$it records = _Translations$stats$records$it._(_root);
	@override late final _Translations$stats$strength$it strength = _Translations$stats$strength$it._(_root);
}

// Path: templates
class _Translations$templates$it extends Translations$templates$en {
	_Translations$templates$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override late final _Translations$templates$list$it list = _Translations$templates$list$it._(_root);
	@override late final _Translations$templates$card$it card = _Translations$templates$card$it._(_root);
	@override late final _Translations$templates$detail$it detail = _Translations$templates$detail$it._(_root);
	@override late final _Translations$templates$editor$it editor = _Translations$templates$editor$it._(_root);
	@override late final _Translations$templates$fields$it fields = _Translations$templates$fields$it._(_root);
	@override late final _Translations$templates$slot$it slot = _Translations$templates$slot$it._(_root);
	@override late final _Translations$templates$emojiPicker$it emojiPicker = _Translations$templates$emojiPicker$it._(_root);
	@override late final _Translations$templates$programs$it programs = _Translations$templates$programs$it._(_root);
}

// Path: tempo
class _Translations$tempo$it extends Translations$tempo$en {
	_Translations$tempo$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get helper => 'Eccentrica — pausa — concentrica — pausa (in s)';
	@override String get formatError => 'Formato previsto: 3-1-X-0';
}

// Path: auth.fields
class _Translations$auth$fields$it extends Translations$auth$fields$en {
	_Translations$auth$fields$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get email => 'Indirizzo email';
	@override String get password => 'Password';
}

// Path: auth.login
class _Translations$auth$login$it extends Translations$auth$login$en {
	_Translations$auth$login$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get welcomeTitle => 'Bello rivederti';
	@override String get welcomeSubtitle => 'Accedi per continuare.';
	@override String get forgotPassword => 'Password dimenticata?';
	@override String get submit => 'Accedi';
	@override String get submitLoading => 'Accesso…';
	@override String get noAccount => 'Non hai ancora un account?';
	@override String get createAccount => 'Crea un account';
}

// Path: auth.signup
class _Translations$auth$signup$it extends Translations$auth$signup$en {
	_Translations$auth$signup$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Crea un account';
	@override String get subtitle => 'Unisciti a migliaia di atleti.';
	@override String get passwordHint => 'Password (min. 8 car.)';
	@override String get submit => 'Crea il mio account';
	@override String get submitLoading => 'Creazione…';
	@override String get termsPrefix => 'Creando un account, accetti le nostre ';
	@override String get termsLink => 'condizioni d\'uso';
}

// Path: auth.onboarding
class _Translations$auth$onboarding$it extends Translations$auth$onboarding$en {
	_Translations$auth$onboarding$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get step1Title => 'Come ti\nchiami?';
	@override String get step1Subtitle => 'Per personalizzare la tua esperienza.';
	@override String get nameHint => 'Il tuo nome';
	@override String get continueLabel => 'Continua';
	@override String get step2Title => 'Qual è il tuo\nobiettivo?';
	@override String get step2Subtitle => 'Adatteremo le tue sessioni di conseguenza.';
	@override String get step3Title => 'Qualche informazione';
	@override String get optional => 'Facoltativo';
	@override String get step3Subtitle => 'Per raccomandazioni più precise.';
	@override String get weightHint => 'Peso (kg)';
	@override String get heightHint => 'Altezza (cm)';
	@override String get birthdate => 'Data di nascita';
	@override String get submit => 'Si parte!';
	@override String get submitLoading => 'Salvataggio…';
	@override String get skip => 'Salta questo passaggio';
	@override late final _Translations$auth$onboarding$goalDescriptions$it goalDescriptions = _Translations$auth$onboarding$goalDescriptions$it._(_root);
	@override String get nameRequired => 'Il tuo nome è obbligatorio.';
	@override String get nameTooLong => 'Nome troppo lungo.';
	@override String get goalRequired => 'Scegli un obiettivo.';
	@override String get weightInvalid => 'Peso non valido';
	@override String get heightInvalid => 'Altezza non valida';
}

// Path: auth.verifyEmail
class _Translations$auth$verifyEmail$it extends Translations$auth$verifyEmail$en {
	_Translations$auth$verifyEmail$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Verifica la tua email';
	@override String get subtitle => 'Abbiamo inviato un codice a 6 cifre';
	@override String get submitLoading => 'Verifica…';
	@override String get submitComplete => 'Verifica il codice';
	@override String get submitIncomplete => 'Inserisci il codice ricevuto';
	@override String get noCode => 'Non hai ricevuto il codice?';
	@override String get resent => 'Codice inviato di nuovo!';
	@override String resendCooldown({required Object n}) => 'Invia di nuovo tra ${n}s';
	@override String get resending => 'Invio…';
	@override String get resend => 'Invia di nuovo il codice';
	@override String get emailMissing => 'Email mancante. Torna alla registrazione.';
}

// Path: auth.forgotPassword
class _Translations$auth$forgotPassword$it extends Translations$auth$forgotPassword$en {
	_Translations$auth$forgotPassword$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Password dimenticata';
	@override String get subtitle => 'Ti inviamo un link di reimpostazione';
	@override String get submit => 'Invia il link';
	@override String get submitLoading => 'Invio…';
	@override String get successMessage => 'Un link di reimpostazione è stato inviato al tuo indirizzo email. Controlla la tua casella di posta.';
}

// Path: auth.updatePassword
class _Translations$auth$updatePassword$it extends Translations$auth$updatePassword$en {
	_Translations$auth$updatePassword$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Nuova password';
	@override String get subtitle => 'Scegli una password sicura';
	@override String get newHint => 'Nuova password';
	@override String get confirmHint => 'Conferma la password';
	@override String get submit => 'Salva la password';
	@override String get submitLoading => 'Salvataggio…';
}

// Path: auth.changePassword
class _Translations$auth$changePassword$it extends Translations$auth$changePassword$en {
	_Translations$auth$changePassword$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Cambia la password';
	@override String get subtitle => 'Per la tua sicurezza, conferma la password attuale prima di sceglierne una nuova.';
	@override String get currentHint => 'Password attuale';
	@override String get newHint => 'Nuova password';
	@override String get confirmHint => 'Conferma la nuova password';
	@override String get submit => 'Aggiorna la password';
	@override String get submitLoading => 'Aggiornamento…';
	@override String get successToast => 'Password aggiornata';
	@override String get currentRequired => 'Password attuale obbligatoria';
	@override String get mustDiffer => 'La nuova password deve essere diversa da quella attuale';
	@override String get currentIncorrect => 'Password attuale errata';
}

// Path: auth.validators
class _Translations$auth$validators$it extends Translations$auth$validators$en {
	_Translations$auth$validators$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get emailRequired => 'Email obbligatoria';
	@override String get emailInvalid => 'Email non valida';
	@override String get passwordRequired => 'Password obbligatoria';
	@override String get passwordMin => 'Minimo 8 caratteri';
	@override String get passwordMismatch => 'Le password non corrispondono';
}

// Path: common.actions
class _Translations$common$actions$it extends Translations$common$actions$en {
	_Translations$common$actions$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get cancel => 'Annulla';
	@override String get confirm => 'Conferma';
	@override String get save => 'Salva';
	@override String get retry => 'Riprova';
	@override String get delete => 'Elimina';
	@override String get close => 'Chiudi';
	@override String get edit => 'Modifica';
	@override String get done => 'Fatto';
	@override String get next => 'Avanti';
	@override String get back => 'Indietro';
}

// Path: common.units
class _Translations$common$units$it extends Translations$common$units$en {
	_Translations$common$units$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get reps => 'rip.';
}

// Path: common.date
class _Translations$common$date$it extends Translations$common$date$en {
	_Translations$common$date$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get justNow => 'proprio ora';
	@override String minutesAgo({required Object n}) => '${n} min fa';
	@override String hoursAgo({required Object n}) => '${n} h fa';
	@override String get yesterday => 'ieri';
	@override String daysAgo({required Object n}) => '${n} g fa';
	@override String get today => 'oggi';
	@override String weeksAgo({required Object n}) => '${n} sett. fa';
	@override String monthsAgo({required Object n}) => '${n} mesi fa';
}

// Path: common.language
class _Translations$common$language$it extends Translations$common$language$en {
	_Translations$common$language$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get en => 'Inglese';
	@override String get fr => 'Francese';
	@override String get es => 'Spagnolo';
	@override String get de => 'Tedesco';
	@override String get it => 'Italiano';
}

// Path: contact.header
class _Translations$contact$header$it extends Translations$contact$header$en {
	_Translations$contact$header$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Contatto & feedback';
	@override String get subtitle => 'Un bug, un\'idea, una domanda? Scrivici, leggiamo tutto.';
}

// Path: contact.sections
class _Translations$contact$sections$it extends Translations$contact$sections$en {
	_Translations$contact$sections$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get type => 'Tipo di richiesta';
	@override String get yourInfo => 'I tuoi dati';
	@override String get message => 'Messaggio';
}

// Path: contact.fields
class _Translations$contact$fields$it extends Translations$contact$fields$en {
	_Translations$contact$fields$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get nameHint => 'Il tuo nome';
	@override String get nameRequired => 'Nome obbligatorio';
	@override String get emailHint => 'Il tuo indirizzo email';
	@override String get emailInvalid => 'Email non valida';
	@override String get messageTooShort => 'Messaggio troppo corto (10 caratteri min)';
}

// Path: contact.categories
class _Translations$contact$categories$it extends Translations$contact$categories$en {
	_Translations$contact$categories$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override late final _Translations$contact$categories$bug$it bug = _Translations$contact$categories$bug$it._(_root);
	@override late final _Translations$contact$categories$feature$it feature = _Translations$contact$categories$feature$it._(_root);
	@override late final _Translations$contact$categories$general$it general = _Translations$contact$categories$general$it._(_root);
	@override late final _Translations$contact$categories$other$it other = _Translations$contact$categories$other$it._(_root);
}

// Path: contact.success
class _Translations$contact$success$it extends Translations$contact$success$en {
	_Translations$contact$success$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Messaggio inviato';
	@override String get back => 'Torna alle impostazioni';
}

// Path: dashboard.greeting
class _Translations$dashboard$greeting$it extends Translations$dashboard$greeting$en {
	_Translations$dashboard$greeting$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get morning => 'Buongiorno';
	@override String get afternoon => 'Buon pomeriggio';
	@override String get evening => 'Buonasera';
}

// Path: dashboard.sections
class _Translations$dashboard$sections$it extends Translations$dashboard$sections$en {
	_Translations$dashboard$sections$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get templates => 'Programma';
	@override String get recentSessions => 'Ultime sessioni';
}

// Path: dashboard.templates
class _Translations$dashboard$templates$it extends Translations$dashboard$templates$en {
	_Translations$dashboard$templates$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get empty => 'Ancora nessuna sessione';
	@override String get newLabel => 'Nuovo';
}

// Path: dashboard.hero
class _Translations$dashboard$hero$it extends Translations$dashboard$hero$en {
	_Translations$dashboard$hero$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get eyebrow => 'PROSSIMA SESSIONE';
	@override String get start => 'Inizia la sessione';
	@override String get emptyTitle => 'Crea la tua prima sessione';
	@override String get emptyMessage => 'Configura i tuoi esercizi e via.';
	@override String get create => 'Crea una sessione';
	@override String duration({required Object n}) => '≈ ${n} min';
}

// Path: dashboard.recent
class _Translations$dashboard$recent$it extends Translations$dashboard$recent$en {
	_Translations$dashboard$recent$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get emptyTitle => 'Inizia la tua prima sessione!';
	@override String get emptyMessage => 'Scegli una sessione e via.';
	@override String get tonnage => 'tonnellaggio';
}

// Path: dashboard.inProgress
class _Translations$dashboard$inProgress$it extends Translations$dashboard$inProgress$en {
	_Translations$dashboard$inProgress$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get label => 'SESSIONE IN CORSO';
	@override String startedAt({required Object when}) => 'Iniziata ${when}';
	@override String get resume => 'Riprendi';
	@override String get discard => 'Abbandona';
	@override String get discardTitle => 'Abbandonare la sessione?';
	@override String get discardMessage => 'Tutti i dati in corso andranno persi.';
	@override String get discardError => 'Errore — riprova.';
}

// Path: dashboard.stats
class _Translations$dashboard$stats$it extends Translations$dashboard$stats$en {
	_Translations$dashboard$stats$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get sessions => 'Sessioni';
	@override String get volume => 'Volume';
	@override String get streak => 'Serie';
	@override String get thisWeek => 'questa sett.';
	@override String weekCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
		one: 'settimana',
		other: 'settimane',
	);
	@override String streakLabel({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
		one: 'settimana\ndi fila',
		other: 'settimane\ndi fila',
	);
	@override String get sessionsWeek => 'sessioni\nquesta settimana';
	@override String get volumeWeek => 'volume\nquesta settimana';
}

// Path: dashboard.consistency
class _Translations$dashboard$consistency$it extends Translations$dashboard$consistency$en {
	_Translations$dashboard$consistency$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Costanza';
	@override String get trainingDays => 'giorni attivi';
	@override String get perWeek => 'sessioni / sett.';
	@override String get bestStreak => 'miglior serie';
	@override String get noStreak => 'nessuna serie';
	@override String weeksShort({required Object n}) => '${n} sett.';
	@override String get notYet => 'Il tuo ritmo di allenamento apparirà qui dopo la prima sessione.';
}

// Path: errors.auth
class _Translations$errors$auth$it extends Translations$errors$auth$en {
	_Translations$errors$auth$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get invalidCredentials => 'Email o password non corretti.';
	@override String get emailNotConfirmed => 'Conferma la tua email prima di accedere.';
	@override String get userAlreadyExists => 'Esiste già un account con questa email.';
	@override String get sessionExpired => 'Sessione scaduta. Accedi di nuovo.';
	@override String get notSignedIn => 'Devi aver effettuato l\'accesso.';
}

// Path: history.groups
class _Translations$history$groups$it extends Translations$history$groups$en {
	_Translations$history$groups$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get thisWeek => 'Questa settimana';
	@override String get lastWeek => 'Settimana scorsa';
	@override String weeksAgo({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
		one: '${n} settimana fa',
		other: '${n} settimane fa',
	);
}

// Path: history.panel
class _Translations$history$panel$it extends Translations$history$panel$en {
	_Translations$history$panel$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get sessions => 'Sessioni';
	@override String get volume => 'Volume';
	@override String get time => 'Tempo';
}

// Path: history.detail
class _Translations$history$detail$it extends Translations$history$detail$en {
	_Translations$history$detail$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Sessione';
	@override String get dateFormat => 'EEEE d MMMM \'alle\' HH:mm';
	@override String get duration => 'Durata';
	@override String get tonnage => 'Tonnellaggio';
	@override String get sets => 'Serie';
	@override String get notes => 'Note';
	@override String get perExercise => 'Dettaglio per esercizio';
	@override String setsCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
		one: '${n} serie',
		other: '${n} serie',
	);
	@override String get bodyweight => 'Peso corporeo';
	@override String get colSet => 'Serie';
	@override String get colReps => 'Rip.';
	@override String get colLoad => 'Carico';
	@override String get colHeld => 'Tenuto';
	@override String get totalExercise => 'Totale esercizio';
	@override String get totalHeld => 'Totale tenuto';
	@override late final _Translations$history$detail$edit$it edit = _Translations$history$detail$edit$it._(_root);
}

// Path: profile.editSheet
class _Translations$profile$editSheet$it extends Translations$profile$editSheet$en {
	_Translations$profile$editSheet$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Modifica profilo';
}

// Path: profile.sections
class _Translations$profile$sections$it extends Translations$profile$sections$en {
	_Translations$profile$sections$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get badges => 'Badge';
}

// Path: profile.stats
class _Translations$profile$stats$it extends Translations$profile$stats$en {
	_Translations$profile$stats$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get sessions => 'Sessioni';
	@override String get tonnage => 'Tonnellaggio';
	@override String get sets => 'Serie';
}

// Path: profile.badges
class _Translations$profile$badges$it extends Translations$profile$badges$en {
	_Translations$profile$badges$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get empty => 'Inizia la tua prima sessione per sbloccare i badge!';
	@override String get firstSession => 'Prima sessione';
	@override String get tenSessions => '10 sessioni';
	@override String get tenTonnes => '10 tonnellate';
	@override String get planner => 'Pianificatore';
}

// Path: profile.avatar
class _Translations$profile$avatar$it extends Translations$profile$avatar$en {
	_Translations$profile$avatar$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get sheetTitle => 'Foto del profilo';
	@override String get takePhoto => 'Scatta una foto';
	@override String get gallery => 'Galleria foto';
	@override String get remove => 'Rimuovi la foto';
	@override String get openError => 'Impossibile aprire la foto.';
	@override String get updated => 'Foto aggiornata!';
	@override String get saveError => 'Impossibile salvare la foto.';
	@override String get removed => 'Foto rimossa.';
	@override String get removeError => 'Impossibile rimuovere la foto.';
}

// Path: profile.editForm
class _Translations$profile$editForm$it extends Translations$profile$editForm$en {
	_Translations$profile$editForm$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get saved => 'Profilo aggiornato.';
	@override String get pickDate => 'Scegli una data';
	@override late final _Translations$profile$editForm$sections$it sections = _Translations$profile$editForm$sections$it._(_root);
	@override late final _Translations$profile$editForm$fields$it fields = _Translations$profile$editForm$fields$it._(_root);
	@override late final _Translations$profile$editForm$validation$it validation = _Translations$profile$editForm$validation$it._(_root);
}

// Path: session.error
class _Translations$session$error$it extends Translations$session$error$en {
	_Translations$session$error$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get startFailed => 'Impossibile avviare la sessione.';
	@override String get saveFailed => 'Salvataggio non riuscito.';
	@override String get templateUpdateFailed => 'Sessione salvata, ma il programma non è stato aggiornato.';
}

// Path: session.live
class _Translations$session$live$it extends Translations$session$live$en {
	_Translations$session$live$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String exercisePosition({required Object current, required Object total}) => 'Esercizio ${current} / ${total}';
	@override String supersetPosition({required Object current, required Object total}) => 'Superserie ${current} / ${total}';
	@override String headerSubtitle({required Object completed, required Object total, required Object time}) => '${completed}/${total} serie · ${time}';
	@override String get totalTonnage => 'Tonnellaggio totale';
	@override String get nextExercise => 'Esercizio successivo';
	@override String get nextBlock => 'Blocco successivo';
	@override String get finishSession => 'Termina sessione';
}

// Path: session.confirm
class _Translations$session$confirm$it extends Translations$session$confirm$en {
	_Translations$session$confirm$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get quitTitle => 'Abbandonare la sessione?';
	@override String get quitMessage => 'Tutti i progressi andranno persi.';
	@override String get quitConfirm => 'Abbandona';
	@override String get inProgressTitle => 'Una sessione è già in corso';
	@override String inProgressMessage({required Object name, required Object date}) => '«${name}» è stata avviata ${date}. Avviarne una nuova eliminerà definitivamente i suoi progressi.';
	@override String get overwriteAndStart => 'Sovrascrivi e avvia';
	@override String deleteExerciseTitle({required Object name}) => 'Eliminare «${name}»?';
	@override String deleteExerciseMessage({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
		one: 'Questo esercizio ha già ${n} serie completata. Andrà persa.',
		other: 'Questo esercizio ha già ${n} serie completate. Andranno perse.',
	);
	@override String get removeSessionOnly => 'Solo in questa sessione';
	@override String get removeFromTemplate => 'Anche dal programma';
}

// Path: session.add
class _Translations$session$add$it extends Translations$session$add$en {
	_Translations$session$add$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Aggiungi un esercizio';
	@override String get subtitle => 'Aggiunto solo a questa sessione, senza modificare il programma.';
	@override String get addLabel => 'Aggiungi';
	@override String get addToSession => 'Aggiungi alla sessione';
	@override String get reps => 'Ripetizioni';
	@override String get time => 'Tempo';
	@override String get addAndTemplate => 'Aggiungi alla sessione e al programma';
}

// Path: session.swap
class _Translations$session$swap$it extends Translations$session$swap$en {
	_Translations$session$swap$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Modifica esercizio';
	@override String currently({required Object name}) => 'Attualmente: ${name}';
	@override String get sessionOnly => 'Queste modifiche valgono solo per questa sessione.';
	@override String get useLabel => 'Usa';
	@override String get adoptFormat => 'Riprendi il formato';
	@override String adoptFormatSummary({required Object summary, required Object name}) => '${summary} · da «${name}»';
	@override String get apply => 'Applica a questa sessione';
	@override String get applyAndTemplate => 'Applica e aggiorna il programma';
}

// Path: session.variants
class _Translations$session$variants$it extends Translations$session$variants$en {
	_Translations$session$variants$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Scegli una variante';
	@override String get lockedMessage => 'Una serie è già completata — termina l’esercizio o usa «Scambia» per regolare in corsa.';
	@override String get pickMessage => 'Scegli una variante per questa posizione. Sostituirà l’esercizio corrente.';
	@override String get empty => 'Nessuna variante definita per questo esercizio.';
	@override String get main => 'PRINCIPALE';
	@override String variantN({required Object n}) => 'Variante ${n}';
	@override String restSeconds({required Object n}) => '${n}s recupero';
	@override String tempoPart({required Object tempo}) => ' · tempo ${tempo}';
}

// Path: session.finish
class _Translations$session$finish$it extends Translations$session$finish$en {
	_Translations$session$finish$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Terminare la sessione?';
	@override String summaryReps({required Object completed, required Object total}) => '${completed}/${total} serie · ';
	@override String get summaryTonnageSuffix => ' di tonnellaggio';
	@override String get notesHint => 'Note sulla sessione (facoltativo)…';
	@override String get confirm => 'Termina';
	@override String unvalidatedSets({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
		one: '${n} SERIE NON VALIDATA',
		other: '${n} SERIE NON VALIDATE',
	);
	@override String get incompleteHint => 'Puoi tornare a validare le tue serie, oppure terminare comunque — verranno salvate solo le serie selezionate.';
	@override String get templateLabel => 'AGGIORNAMENTO DEL PROGRAMMA';
	@override String templateToggle({required Object name}) => 'Aggiorna “${name}”';
	@override String get templateHint => 'Le modifiche segnate durante la sessione. Disattiva per lasciare il programma com\'è.';
	@override String changeAdded({required Object name}) => '${name} · aggiunto';
	@override String changeModified({required Object name}) => '${name} · modificato';
	@override String changeRemoved({required Object name}) => '${name} · rimosso';
}

// Path: session.timer
class _Translations$session$timer$it extends Translations$session$timer$en {
	_Translations$session$timer$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get preparation => 'PREPARAZIONE';
	@override String get running => 'IN CORSO';
	@override String get done => 'COMPLETATO';
	@override String get go => 'VIA';
	@override String get stop => 'Ferma';
}

// Path: session.rest
class _Translations$session$rest$it extends Translations$session$rest$en {
	_Translations$session$rest$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'RECUPERO';
	@override String get sec => 'SEC';
	@override String get skip => 'Salta';
	@override String get minimize => 'Riduci';
}

// Path: session.set
class _Translations$session$set$it extends Translations$session$set$en {
	_Translations$session$set$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get addSet => 'Aggiungi una serie';
	@override String setLabel({required Object n}) => 'Serie ${n}';
	@override String get reps => 'Reps';
	@override String get load => 'Carico';
	@override String get duration => 'Durata';
	@override String get held => 'Tenuto';
	@override String get tonnage => 'TONNELLAGGIO';
	@override String targetReps({required Object n}) => 'obiettivo ${n} reps';
	@override String targetDuration({required Object value}) => 'obiettivo ${value}';
	@override String get validateWithoutTimer => 'Valida senza timer';
	@override String get cmpUp => 'Top';
}

// Path: session.exercise
class _Translations$session$exercise$it extends Translations$session$exercise$en {
	_Translations$session$exercise$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get timed => 'A tempo';
	@override String tempoChip({required Object tempo}) => 'Tempo ${tempo}';
	@override String restChip({required Object n}) => '${n}s recupero';
	@override String get modified => 'Modificato · solo questa sessione';
	@override String modifiedWas({required Object name}) => 'Modificato · solo questa sessione (era: ${name})';
	@override String get completedBadge => '✓ Fatto';
	@override String totalHeld({required Object value}) => 'Totale tenuto: ${value}';
	@override String exerciseVolume({required Object value}) => 'Volume esercizio: ${value} kg';
	@override String get lastTimeLabel => 'Ultima volta';
	@override String get otherWorkout => 'altra sessione';
	@override String targetWasReps({required Object n}) => 'obiettivo ${n} rip.';
	@override String targetWasSeconds({required Object n}) => 'obiettivo ${n}s';
	@override String morePerfs({required Object n}) => '+${n}';
	@override String get keptInTemplate => 'Modificato · sarà salvato nel programma';
	@override String keptInTemplateWas({required Object name}) => 'Modificato · sarà salvato nel programma (era: ${name})';
	@override String get keepInTemplateAction => 'Tocca per mantenere questa modifica nel programma';
}

// Path: session.overview
class _Translations$session$overview$it extends Translations$session$overview$en {
	_Translations$session$overview$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Esercizi';
	@override String get current => 'IN CORSO';
	@override String setsValidated({required Object completed, required Object total}) => '${completed}/${total} serie validate';
}

// Path: session.superset
class _Translations$session$superset$it extends Translations$session$superset$en {
	_Translations$session$superset$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String badge({required Object n}) => 'SUPERSERIE · ${n} ESERCIZI';
	@override String addSetTo({required Object letter, required Object name}) => 'Aggiungi una serie a ${letter} · ${name}';
}

// Path: session.duration
class _Translations$session$duration$it extends Translations$session$duration$en {
	_Translations$session$duration$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Durata per serie';
	@override String get hint => '45 o 1m30';
	@override String confirm({required Object value}) => 'Conferma — ${value}';
}

// Path: session.weight
class _Translations$session$weight$it extends Translations$session$weight$en {
	_Translations$session$weight$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get bodyweight => 'Peso corporeo';
	@override String get confirmBodyweight => 'Conferma — Peso corporeo';
	@override String confirmKg({required Object value}) => 'Conferma — ${value} kg';
}

// Path: session.search
class _Translations$session$search$it extends Translations$session$search$en {
	_Translations$session$search$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get hint => 'Cerca un esercizio…';
	@override String get loading => 'Caricamento esercizi…';
	@override String get noMatch => 'Nessun esercizio corrisponde.';
	@override String get certifiedBadge => 'Esercizio Repster';
}

// Path: session.history
class _Translations$session$history$it extends Translations$session$history$en {
	_Translations$session$history$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String title({required Object name}) => 'Cronologia · ${name}';
	@override String get empty => 'Nessuna cronologia per questo esercizio.';
	@override String get loading => 'Caricamento cronologia…';
	@override String setLabel({required Object n}) => 'Serie ${n}';
	@override String get dateFormat => 'd MMM yyyy';
}

// Path: session.fields
class _Translations$session$fields$it extends Translations$session$fields$en {
	_Translations$session$fields$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get exerciseName => 'Nome dell’esercizio';
	@override String get type => 'Tipo';
	@override String get sets => 'Serie';
	@override String get durationSec => 'Durata (sec)';
	@override String get targetReps => 'Reps obiettivo';
	@override String get restShort => 'Recupero (sec)';
	@override String get rest => 'Recupero (sec)';
	@override String get tempo => 'Tempo';
	@override String get notesOptional => 'Note (facoltativo)';
	@override String get notesHint => 'Consigli tecnici…';
	@override String get keepInTemplate => 'Salva anche nel programma';
	@override String get keepInTemplateHint => 'Per impostazione predefinita la modifica vale solo per questa sessione.';
}

// Path: session.toast
class _Translations$session$toast$it extends Translations$session$toast$en {
	_Translations$session$toast$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String exerciseAdded({required Object name}) => '${name} aggiunto alla sessione';
	@override String get validateOneSet => 'Valida almeno una serie prima di terminare.';
	@override String get sessionSaved => 'Sessione salvata! 🎉';
	@override String get finishOrSwap => 'Termina la serie corrente o usa «Scambia».';
}

// Path: session.notif
class _Translations$session$notif$it extends Translations$session$notif$en {
	_Translations$session$notif$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get countdownChannel => 'Conto alla rovescia recupero';
	@override String get doneChannel => 'Recupero terminato';
	@override String get doneTitle => 'Recupero finito';
}

// Path: settings.sections
class _Translations$settings$sections$it extends Translations$settings$sections$en {
	_Translations$settings$sections$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get profile => 'Profilo';
	@override String get data => 'I miei dati';
	@override String get preferences => 'Preferenze';
	@override String get account => 'Account';
}

// Path: settings.rows
class _Translations$settings$rows$it extends Translations$settings$rows$en {
	_Translations$settings$rows$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get templates => 'I miei programmi';
	@override String get history => 'Cronologia sessioni';
	@override String get stats => 'Statistiche';
	@override String get notifications => 'Notifiche';
	@override String get privacy => 'Privacy';
	@override String get terms => 'Condizioni d\'uso';
	@override String get contact => 'Contatti e feedback';
	@override String get language => 'Lingua';
	@override String get changePassword => 'Cambia la mia password';
}

// Path: settings.logout
class _Translations$settings$logout$it extends Translations$settings$logout$en {
	_Translations$settings$logout$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get action => 'Disconnetti';
	@override String get error => 'Disconnessione non riuscita.';
}

// Path: settings.language
class _Translations$settings$language$it extends Translations$settings$language$en {
	_Translations$settings$language$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Lingua';
	@override String get subtitle => 'Scegli la lingua dell\'app';
	@override String get system => 'Lingua di sistema';
}

// Path: stats.subtitle
class _Translations$stats$subtitle$it extends Translations$stats$subtitle$en {
	_Translations$stats$subtitle$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get empty => 'Nessuna sessione nel periodo';
}

// Path: stats.empty
class _Translations$stats$empty$it extends Translations$stats$empty$en {
	_Translations$stats$empty$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ancora nessun dato';
	@override String get message => 'Completa alcune sessioni per vedere le tue curve e i tuoi progressi.';
}

// Path: stats.range
class _Translations$stats$range$it extends Translations$stats$range$en {
	_Translations$stats$range$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override late final _Translations$stats$range$last4Weeks$it last4Weeks = _Translations$stats$range$last4Weeks$it._(_root);
	@override late final _Translations$stats$range$last3Months$it last3Months = _Translations$stats$range$last3Months$it._(_root);
	@override late final _Translations$stats$range$all$it all = _Translations$stats$range$all$it._(_root);
}

// Path: stats.kpi
class _Translations$stats$kpi$it extends Translations$stats$kpi$en {
	_Translations$stats$kpi$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get sessions => 'Sessioni';
	@override String get volume => 'Tonnellaggio';
	@override String get sets => 'Serie';
	@override String get avgDuration => 'Durata media';
	@override String get tension => 'Tempo sotto tensione';
}

// Path: stats.weeklyVolume
class _Translations$stats$weeklyVolume$it extends Translations$stats$weeklyVolume$en {
	_Translations$stats$weeklyVolume$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Volume settimanale';
	@override String get empty => 'Ancora poche sessioni nel periodo.';
	@override String get inProgress => 'in corso';
}

// Path: stats.exercise
class _Translations$stats$exercise$it extends Translations$stats$exercise$en {
	_Translations$stats$exercise$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Progressione per esercizio';
	@override String get empty => 'Registra almeno 2 sessioni con lo stesso esercizio caricato per vedere la tua curva di forza.';
	@override String get pickerTitle => 'Scegli un esercizio';
	@override String get noExercise => 'Nessun esercizio';
	@override String get searchHint => 'Cerca…';
	@override String get oneRmMax => '1RM stimato max';
	@override String get bestLoad => 'miglior carico';
	@override String get record => 'record';
	@override String get trendUnknown => 'Non ci sono ancora sessioni sufficienti per una tendenza';
	@override String get trendProgressing => 'In progresso';
	@override String trendPlateau({required Object n}) => 'Plateau · ${n} sessioni senza record';
	@override String get trendRegressing => 'In calo';
	@override String perMonth({required Object value}) => '${value} %/mese';
	@override String get plateauHint => 'Prova meno reps con più carico, o cambia esercizio.';
}

// Path: stats.records
class _Translations$stats$records$it extends Translations$stats$records$en {
	_Translations$stats$records$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Record';
	@override String get bestSession => 'Miglior sessione';
	@override String get heaviestLift => 'Carico massimo';
	@override String get bestOneRm => '1RM stimato';
	@override String get bestStreak => 'Serie più lunga';
	@override String get consecutiveWeeks => 'settimane consecutive';
}

// Path: stats.strength
class _Translations$stats$strength$it extends Translations$stats$strength$en {
	_Translations$stats$strength$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Forza';
	@override String get scope => 'tutto lo storico';
}

// Path: templates.list
class _Translations$templates$list$it extends Translations$templates$list$en {
	_Translations$templates$list$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Programmi';
	@override String subtitleActive({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
		one: '${n} sessione attiva',
		other: '${n} sessioni attive',
	);
	@override String get newAction => 'Crea';
	@override String get emptyTitle => 'Nessuna sessione';
	@override String get emptyMessage => 'Crea la tua prima sessione per comporre il tuo programma.';
	@override String get emptyAction => 'Crea una sessione';
	@override String get reorderError => 'Errore durante il riordino.';
	@override String get toggleError => 'Azione impossibile.';
	@override String get duplicated => 'Sessione copiata!';
	@override String get duplicateError => 'Duplicazione impossibile.';
	@override String get deleted => 'Sessione eliminata.';
	@override String get deleteError => 'Eliminazione impossibile.';
	@override String get copySuffix => '(copia)';
}

// Path: templates.card
class _Translations$templates$card$it extends Translations$templates$card$en {
	_Translations$templates$card$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String exerciseCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
		one: '${n} esercizio',
		other: '${n} esercizi',
	);
	@override String get activate => 'Attiva';
	@override String get deactivate => 'Disattiva';
}

// Path: templates.detail
class _Translations$templates$detail$it extends Translations$templates$detail$en {
	_Translations$templates$detail$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get noExercises => 'Nessun esercizio in questa sessione.';
	@override String get superset => 'Superserie';
	@override String setsCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
		one: '${n} serie',
		other: '${n} serie',
	);
	@override String seconds({required Object n}) => '${n} s';
	@override String tempo({required Object value}) => 'Tempo ${value}';
	@override String rest({required Object n}) => 'Riposo ${n}s';
	@override String get start => 'Avvia la sessione';
}

// Path: templates.editor
class _Translations$templates$editor$it extends Translations$templates$editor$en {
	_Translations$templates$editor$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get newTitle => 'Nuova sessione';
	@override String get editTitle => 'Modifica sessione';
	@override String exercisesHeader({required Object count}) => 'ESERCIZI (${count})';
	@override String get addExercise => 'Aggiungi un esercizio';
	@override String get save => 'Salva sessione';
	@override String get validationError => 'Inserisci un nome e almeno un esercizio con nome.';
}

// Path: templates.fields
class _Translations$templates$fields$it extends Translations$templates$fields$en {
	_Translations$templates$fields$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get name => 'Nome della sessione';
	@override String get nameHint => 'es.: Petto / Tricipiti / Spalle';
	@override String get description => 'Descrizione (opzionale)';
	@override String get descriptionHint => 'Descrivi la tua sessione…';
	@override String get emoji => 'Immagine';
	@override String get exerciseName => 'Nome dell’esercizio';
	@override String get exerciseNameHint => 'es.: Panca piana';
	@override String get type => 'Tipo';
	@override String get sets => 'Serie';
	@override String get duration => 'Durata (s)';
	@override String get targetReps => 'Rip. obiettivo';
	@override String get rest => 'Recupero (s)';
	@override String get tempo => 'Tempo';
	@override String get tempoHint => '3-1-X-0';
	@override String get notes => 'Note (opzionale)';
	@override String get notesHint => 'Consigli tecnici…';
}

// Path: templates.slot
class _Translations$templates$slot$it extends Translations$templates$slot$en {
	_Translations$templates$slot$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get newExercise => 'Nuovo esercizio';
	@override String variantN({required Object n}) => 'Variante ${n}';
	@override String get primary => 'PRINCIPALE';
	@override String get variant => 'Variante';
	@override String get addVariant => 'Aggiungi una variante';
	@override String get supersetNote => 'Concatenato in superserie con l’esercizio successivo';
	@override String get supersetLabel => 'SUPERSERIE';
	@override String get reps => 'Ripetizioni';
	@override String get time => 'Tempo';
}

// Path: templates.emojiPicker
class _Translations$templates$emojiPicker$it extends Translations$templates$emojiPicker$en {
	_Translations$templates$emojiPicker$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Immagine della sessione';
	@override String get searchHint => 'Cerca un emoji…';
	@override String get noResults => 'Nessun emoji corrisponde.';
	@override String get change => 'Cambia';
}

// Path: templates.programs
class _Translations$templates$programs$it extends Translations$templates$programs$en {
	_Translations$templates$programs$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get newSession => 'Una sessione';
	@override String get newProgram => 'Un programma';
	@override String get nameTitleNew => 'Nuovo programma';
	@override String get nameTitleRename => 'Rinomina il programma';
	@override String get nameHint => 'PPL, Full body, Vacanze…';
	@override String get createAction => 'Crea il programma';
	@override String sessionCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
		one: '${n} sessione',
		other: '${n} sessioni',
	);
	@override String get active => 'Attivo';
	@override String get empty => 'Vuoto';
	@override String get sessionInactive => 'Disattivata';
	@override String get emptyTitle => 'Nessuna sessione';
	@override String get emptyMessage => 'Aggiungi le sessioni che compongono questo programma.';
	@override String get switchOn => 'Programma attivo';
	@override String get switchOff => 'Attiva questo programma';
	@override String get switchHint => 'Le sue sessioni alimentano la tua home. Gli altri programmi vengono disattivati.';
	@override String get addSession => 'Aggiungi una sessione';
	@override String addSessionTitle({required Object name}) => 'Aggiungi a ${name}';
	@override String get createSession => 'Crea una nuova sessione';
	@override String get loose => 'Senza programma';
	@override String get moveTitle => 'Sposta in';
	@override String get start => 'Inizia';
	@override String get move => 'Sposta';
	@override String get duplicate => 'Duplica';
	@override String get rename => 'Rinomina';
	@override String get dragHint => 'Tieni premuta una sessione per trascinarla in un programma.';
	@override String deleteProgramTitle({required Object name}) => 'Eliminare «${name}»?';
	@override String get deleteProgramMessage => 'Le sue sessioni vengono conservate, senza programma.';
	@override String deleteSessionTitle({required Object name}) => 'Eliminare «${name}»?';
	@override String get deleteSessionMessage => 'La sessione viene eliminata definitivamente. La tua cronologia resta.';
	@override String moved({required Object name}) => 'Spostata in ${name}.';
	@override String get movedOut => 'Tolta dal suo programma.';
	@override String activated({required Object name}) => '${name} è ora attivo.';
	@override String deactivated({required Object name}) => '${name} è disattivato.';
	@override String get programDeleted => 'Programma eliminato.';
	@override String get error => 'Non ha funzionato. Riprova.';
}

// Path: auth.onboarding.goalDescriptions
class _Translations$auth$onboarding$goalDescriptions$it extends Translations$auth$onboarding$goalDescriptions$en {
	_Translations$auth$onboarding$goalDescriptions$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get hypertrophy => 'Aumentare i muscoli';
	@override String get strength => 'Sollevare di più';
	@override String get endurance => 'Cardio e resistenza';
	@override String get weightLoss => 'Bruciare calorie';
	@override String get maintenance => 'Restare in forma';
}

// Path: contact.categories.bug
class _Translations$contact$categories$bug$it extends Translations$contact$categories$bug$en {
	_Translations$contact$categories$bug$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get label => 'Bug';
	@override String get placeholder => 'Es.: dopo la mia serie, il timer di recupero non parte…';
	@override String get guidance => 'Indica i passaggi per riprodurlo, cosa ti aspettavi e il modello del tuo telefono: ci aiuta a correggere in fretta.';
	@override String get successLine => 'Preso nota — andiamo subito a guardare da vicino questo bug.';
}

// Path: contact.categories.feature
class _Translations$contact$categories$feature$it extends Translations$contact$categories$feature$en {
	_Translations$contact$categories$feature$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get label => 'Idea';
	@override String get placeholder => 'Es.: poter duplicare una sessione esistente…';
	@override String get guidance => 'Descrivi soprattutto il bisogno dietro l\'idea: cosa ti permetterebbe di fare?';
	@override String get successLine => 'Ottima idea, grazie! La aggiungiamo alle nostre riflessioni.';
}

// Path: contact.categories.general
class _Translations$contact$categories$general$it extends Translations$contact$categories$general$en {
	_Translations$contact$categories$general$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get label => 'Messaggio';
	@override String get placeholder => 'La tua domanda, la tua opinione o il tuo riscontro…';
	@override String get guidance => 'Una domanda, un\'osservazione, un incoraggiamento: leggiamo ogni messaggio.';
	@override String get successLine => 'Grazie per il tuo messaggio. Ci prendiamo il tempo di leggere ogni riscontro.';
}

// Path: contact.categories.other
class _Translations$contact$categories$other$it extends Translations$contact$categories$other$en {
	_Translations$contact$categories$other$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get label => 'Altro';
	@override String get placeholder => 'Raccontaci tutto…';
	@override String get guidance => 'Dacci il maggior contesto possibile per poterti aiutare al meglio.';
	@override String get successLine => 'Grazie per il tuo messaggio. Ti ricontattiamo se necessario.';
}

// Path: history.detail.edit
class _Translations$history$detail$edit$it extends Translations$history$detail$edit$en {
	_Translations$history$detail$edit$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get open => 'Modifica';
	@override String get title => 'Modifica sessione';
	@override String get name => 'Titolo';
	@override String get namePlaceholder => 'Nome della sessione';
	@override String get date => 'Data';
	@override String get time => 'Ora';
	@override String get durationLabel => 'Durata';
	@override String get hours => 'h';
	@override String get minutes => 'min';
	@override String get notesPlaceholder => 'Com\'è andata?';
	@override String get save => 'Salva';
	@override String get saved => 'Sessione aggiornata.';
	@override String get error => 'Modifica non riuscita.';
	@override String get nameRequired => 'Il titolo è obbligatorio.';
	@override String get dateFormat => 'd MMMM y';
}

// Path: profile.editForm.sections
class _Translations$profile$editForm$sections$it extends Translations$profile$editForm$sections$en {
	_Translations$profile$editForm$sections$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get identity => 'Identità';
	@override String get physique => 'Fisico';
	@override String get goal => 'Obiettivo';
}

// Path: profile.editForm.fields
class _Translations$profile$editForm$fields$it extends Translations$profile$editForm$fields$en {
	_Translations$profile$editForm$fields$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get name => 'Nome / Nickname';
	@override String get bio => 'Bio';
	@override String get birthdate => 'Data di nascita';
	@override String get weight => 'Peso (kg)';
	@override String get height => 'Altezza (cm)';
}

// Path: profile.editForm.validation
class _Translations$profile$editForm$validation$it extends Translations$profile$editForm$validation$en {
	_Translations$profile$editForm$validation$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get nameMin => 'Almeno 2 caratteri';
	@override String get nameMax => 'Massimo 60 caratteri';
	@override String get invalidNumber => 'Numero non valido';
	@override String get heightRange => 'Tra 80 e 260 cm';
	@override String get weightRange => 'Tra 30 e 350 kg';
}

// Path: stats.range.last4Weeks
class _Translations$stats$range$last4Weeks$it extends Translations$stats$range$last4Weeks$en {
	_Translations$stats$range$last4Weeks$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get label => '4 settimane';
	@override String get short => '4 sett.';
}

// Path: stats.range.last3Months
class _Translations$stats$range$last3Months$it extends Translations$stats$range$last3Months$en {
	_Translations$stats$range$last3Months$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get label => '3 mesi';
	@override String get short => '3 mesi';
}

// Path: stats.range.all
class _Translations$stats$range$all$it extends Translations$stats$range$all$en {
	_Translations$stats$range$all$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get label => 'Tutto';
	@override String get short => 'Tutto';
}

/// The flat map containing all translations for locale <it>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsIt {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'auth.fields.email' => 'Indirizzo email',
			'auth.fields.password' => 'Password',
			'auth.backToLogin' => 'Torna all\'accesso',
			'auth.login.welcomeTitle' => 'Bello rivederti',
			'auth.login.welcomeSubtitle' => 'Accedi per continuare.',
			'auth.login.forgotPassword' => 'Password dimenticata?',
			'auth.login.submit' => 'Accedi',
			'auth.login.submitLoading' => 'Accesso…',
			'auth.login.noAccount' => 'Non hai ancora un account?',
			'auth.login.createAccount' => 'Crea un account',
			'auth.signup.title' => 'Crea un account',
			'auth.signup.subtitle' => 'Unisciti a migliaia di atleti.',
			'auth.signup.passwordHint' => 'Password (min. 8 car.)',
			'auth.signup.submit' => 'Crea il mio account',
			'auth.signup.submitLoading' => 'Creazione…',
			'auth.signup.termsPrefix' => 'Creando un account, accetti le nostre ',
			'auth.signup.termsLink' => 'condizioni d\'uso',
			'auth.onboarding.step1Title' => 'Come ti\nchiami?',
			'auth.onboarding.step1Subtitle' => 'Per personalizzare la tua esperienza.',
			'auth.onboarding.nameHint' => 'Il tuo nome',
			'auth.onboarding.continueLabel' => 'Continua',
			'auth.onboarding.step2Title' => 'Qual è il tuo\nobiettivo?',
			'auth.onboarding.step2Subtitle' => 'Adatteremo le tue sessioni di conseguenza.',
			'auth.onboarding.step3Title' => 'Qualche informazione',
			'auth.onboarding.optional' => 'Facoltativo',
			'auth.onboarding.step3Subtitle' => 'Per raccomandazioni più precise.',
			'auth.onboarding.weightHint' => 'Peso (kg)',
			'auth.onboarding.heightHint' => 'Altezza (cm)',
			'auth.onboarding.birthdate' => 'Data di nascita',
			'auth.onboarding.submit' => 'Si parte!',
			'auth.onboarding.submitLoading' => 'Salvataggio…',
			'auth.onboarding.skip' => 'Salta questo passaggio',
			'auth.onboarding.goalDescriptions.hypertrophy' => 'Aumentare i muscoli',
			'auth.onboarding.goalDescriptions.strength' => 'Sollevare di più',
			'auth.onboarding.goalDescriptions.endurance' => 'Cardio e resistenza',
			'auth.onboarding.goalDescriptions.weightLoss' => 'Bruciare calorie',
			'auth.onboarding.goalDescriptions.maintenance' => 'Restare in forma',
			'auth.onboarding.nameRequired' => 'Il tuo nome è obbligatorio.',
			'auth.onboarding.nameTooLong' => 'Nome troppo lungo.',
			'auth.onboarding.goalRequired' => 'Scegli un obiettivo.',
			'auth.onboarding.weightInvalid' => 'Peso non valido',
			'auth.onboarding.heightInvalid' => 'Altezza non valida',
			'auth.verifyEmail.title' => 'Verifica la tua email',
			'auth.verifyEmail.subtitle' => 'Abbiamo inviato un codice a 6 cifre',
			'auth.verifyEmail.submitLoading' => 'Verifica…',
			'auth.verifyEmail.submitComplete' => 'Verifica il codice',
			'auth.verifyEmail.submitIncomplete' => 'Inserisci il codice ricevuto',
			'auth.verifyEmail.noCode' => 'Non hai ricevuto il codice?',
			'auth.verifyEmail.resent' => 'Codice inviato di nuovo!',
			'auth.verifyEmail.resendCooldown' => ({required Object n}) => 'Invia di nuovo tra ${n}s',
			'auth.verifyEmail.resending' => 'Invio…',
			'auth.verifyEmail.resend' => 'Invia di nuovo il codice',
			'auth.verifyEmail.emailMissing' => 'Email mancante. Torna alla registrazione.',
			'auth.forgotPassword.title' => 'Password dimenticata',
			'auth.forgotPassword.subtitle' => 'Ti inviamo un link di reimpostazione',
			'auth.forgotPassword.submit' => 'Invia il link',
			'auth.forgotPassword.submitLoading' => 'Invio…',
			'auth.forgotPassword.successMessage' => 'Un link di reimpostazione è stato inviato al tuo indirizzo email. Controlla la tua casella di posta.',
			'auth.updatePassword.title' => 'Nuova password',
			'auth.updatePassword.subtitle' => 'Scegli una password sicura',
			'auth.updatePassword.newHint' => 'Nuova password',
			'auth.updatePassword.confirmHint' => 'Conferma la password',
			'auth.updatePassword.submit' => 'Salva la password',
			'auth.updatePassword.submitLoading' => 'Salvataggio…',
			'auth.changePassword.title' => 'Cambia la password',
			'auth.changePassword.subtitle' => 'Per la tua sicurezza, conferma la password attuale prima di sceglierne una nuova.',
			'auth.changePassword.currentHint' => 'Password attuale',
			'auth.changePassword.newHint' => 'Nuova password',
			'auth.changePassword.confirmHint' => 'Conferma la nuova password',
			'auth.changePassword.submit' => 'Aggiorna la password',
			'auth.changePassword.submitLoading' => 'Aggiornamento…',
			'auth.changePassword.successToast' => 'Password aggiornata',
			'auth.changePassword.currentRequired' => 'Password attuale obbligatoria',
			'auth.changePassword.mustDiffer' => 'La nuova password deve essere diversa da quella attuale',
			'auth.changePassword.currentIncorrect' => 'Password attuale errata',
			'auth.validators.emailRequired' => 'Email obbligatoria',
			'auth.validators.emailInvalid' => 'Email non valida',
			'auth.validators.passwordRequired' => 'Password obbligatoria',
			'auth.validators.passwordMin' => 'Minimo 8 caratteri',
			'auth.validators.passwordMismatch' => 'Le password non corrispondono',
			'common.actions.cancel' => 'Annulla',
			'common.actions.confirm' => 'Conferma',
			'common.actions.save' => 'Salva',
			'common.actions.retry' => 'Riprova',
			'common.actions.delete' => 'Elimina',
			'common.actions.close' => 'Chiudi',
			'common.actions.edit' => 'Modifica',
			'common.actions.done' => 'Fatto',
			'common.actions.next' => 'Avanti',
			'common.actions.back' => 'Indietro',
			'common.unnamed' => '(senza nome)',
			'common.units.reps' => 'rip.',
			'common.date.justNow' => 'proprio ora',
			'common.date.minutesAgo' => ({required Object n}) => '${n} min fa',
			'common.date.hoursAgo' => ({required Object n}) => '${n} h fa',
			'common.date.yesterday' => 'ieri',
			'common.date.daysAgo' => ({required Object n}) => '${n} g fa',
			'common.date.today' => 'oggi',
			'common.date.weeksAgo' => ({required Object n}) => '${n} sett. fa',
			'common.date.monthsAgo' => ({required Object n}) => '${n} mesi fa',
			'common.language.en' => 'Inglese',
			'common.language.fr' => 'Francese',
			'common.language.es' => 'Spagnolo',
			'common.language.de' => 'Tedesco',
			'common.language.it' => 'Italiano',
			'contact.header.title' => 'Contatto & feedback',
			'contact.header.subtitle' => 'Un bug, un\'idea, una domanda? Scrivici, leggiamo tutto.',
			'contact.sections.type' => 'Tipo di richiesta',
			'contact.sections.yourInfo' => 'I tuoi dati',
			'contact.sections.message' => 'Messaggio',
			'contact.fields.nameHint' => 'Il tuo nome',
			'contact.fields.nameRequired' => 'Nome obbligatorio',
			'contact.fields.emailHint' => 'Il tuo indirizzo email',
			'contact.fields.emailInvalid' => 'Email non valida',
			'contact.fields.messageTooShort' => 'Messaggio troppo corto (10 caratteri min)',
			'contact.counter' => ({required Object current, required Object max}) => '${current} / ${max}',
			'contact.submit' => 'Invia',
			'contact.categories.bug.label' => 'Bug',
			'contact.categories.bug.placeholder' => 'Es.: dopo la mia serie, il timer di recupero non parte…',
			'contact.categories.bug.guidance' => 'Indica i passaggi per riprodurlo, cosa ti aspettavi e il modello del tuo telefono: ci aiuta a correggere in fretta.',
			'contact.categories.bug.successLine' => 'Preso nota — andiamo subito a guardare da vicino questo bug.',
			'contact.categories.feature.label' => 'Idea',
			'contact.categories.feature.placeholder' => 'Es.: poter duplicare una sessione esistente…',
			'contact.categories.feature.guidance' => 'Descrivi soprattutto il bisogno dietro l\'idea: cosa ti permetterebbe di fare?',
			'contact.categories.feature.successLine' => 'Ottima idea, grazie! La aggiungiamo alle nostre riflessioni.',
			'contact.categories.general.label' => 'Messaggio',
			'contact.categories.general.placeholder' => 'La tua domanda, la tua opinione o il tuo riscontro…',
			'contact.categories.general.guidance' => 'Una domanda, un\'osservazione, un incoraggiamento: leggiamo ogni messaggio.',
			'contact.categories.general.successLine' => 'Grazie per il tuo messaggio. Ci prendiamo il tempo di leggere ogni riscontro.',
			'contact.categories.other.label' => 'Altro',
			'contact.categories.other.placeholder' => 'Raccontaci tutto…',
			'contact.categories.other.guidance' => 'Dacci il maggior contesto possibile per poterti aiutare al meglio.',
			'contact.categories.other.successLine' => 'Grazie per il tuo messaggio. Ti ricontattiamo se necessario.',
			'contact.success.title' => 'Messaggio inviato',
			'contact.success.back' => 'Torna alle impostazioni',
			'dashboard.greeting.morning' => 'Buongiorno',
			'dashboard.greeting.afternoon' => 'Buon pomeriggio',
			'dashboard.greeting.evening' => 'Buonasera',
			'dashboard.defaultName' => 'Atleta',
			'dashboard.seeAll' => 'Vedi tutto',
			'dashboard.sections.templates' => 'Programma',
			'dashboard.sections.recentSessions' => 'Ultime sessioni',
			'dashboard.templates.empty' => 'Ancora nessuna sessione',
			'dashboard.templates.newLabel' => 'Nuovo',
			'dashboard.exerciseCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n, one: '${n} esercizio', other: '${n} esercizi', ), 
			'dashboard.hero.eyebrow' => 'PROSSIMA SESSIONE',
			'dashboard.hero.start' => 'Inizia la sessione',
			'dashboard.hero.emptyTitle' => 'Crea la tua prima sessione',
			'dashboard.hero.emptyMessage' => 'Configura i tuoi esercizi e via.',
			'dashboard.hero.create' => 'Crea una sessione',
			'dashboard.hero.duration' => ({required Object n}) => '≈ ${n} min',
			'dashboard.recent.emptyTitle' => 'Inizia la tua prima sessione!',
			'dashboard.recent.emptyMessage' => 'Scegli una sessione e via.',
			'dashboard.recent.tonnage' => 'tonnellaggio',
			'dashboard.inProgress.label' => 'SESSIONE IN CORSO',
			'dashboard.inProgress.startedAt' => ({required Object when}) => 'Iniziata ${when}',
			'dashboard.inProgress.resume' => 'Riprendi',
			'dashboard.inProgress.discard' => 'Abbandona',
			'dashboard.inProgress.discardTitle' => 'Abbandonare la sessione?',
			'dashboard.inProgress.discardMessage' => 'Tutti i dati in corso andranno persi.',
			'dashboard.inProgress.discardError' => 'Errore — riprova.',
			'dashboard.stats.sessions' => 'Sessioni',
			'dashboard.stats.volume' => 'Volume',
			'dashboard.stats.streak' => 'Serie',
			'dashboard.stats.thisWeek' => 'questa sett.',
			'dashboard.stats.weekCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n, one: 'settimana', other: 'settimane', ), 
			'dashboard.stats.streakLabel' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n, one: 'settimana\ndi fila', other: 'settimane\ndi fila', ), 
			'dashboard.stats.sessionsWeek' => 'sessioni\nquesta settimana',
			'dashboard.stats.volumeWeek' => 'volume\nquesta settimana',
			'dashboard.streakBadge' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n, one: '${n} settimana di fila', other: '${n} settimane di fila', ), 
			'dashboard.consistency.title' => 'Costanza',
			'dashboard.consistency.trainingDays' => 'giorni attivi',
			'dashboard.consistency.perWeek' => 'sessioni / sett.',
			'dashboard.consistency.bestStreak' => 'miglior serie',
			'dashboard.consistency.noStreak' => 'nessuna serie',
			'dashboard.consistency.weeksShort' => ({required Object n}) => '${n} sett.',
			'dashboard.consistency.notYet' => 'Il tuo ritmo di allenamento apparirà qui dopo la prima sessione.',
			'emoji.groups.sport' => 'Sport e allenamento',
			'emoji.groups.body' => 'Corpo e gesti',
			'emoji.groups.energy' => 'Energia e simboli',
			'emoji.groups.faces' => 'Facce',
			'emoji.groups.hearts' => 'Cuori',
			'emoji.groups.animals' => 'Animali',
			'emoji.groups.food' => 'Cibo e bevande',
			'emoji.groups.nature' => 'Natura e meteo',
			'emoji.groups.places' => 'Luoghi e viaggi',
			'emoji.groups.objects' => 'Oggetti e strumenti',
			'emoji.labels.person-lifting-weights' => 'Sollevamento pesi',
			'emoji.labels.man-lifting-weights' => 'Uomo che solleva pesi',
			'emoji.labels.woman-lifting-weights' => 'Donna che solleva pesi',
			'emoji.labels.flexed-biceps' => 'Bicipite',
			'emoji.labels.boxing-glove' => 'Guantone da boxe',
			'emoji.labels.martial-arts-uniform' => 'Kimono',
			'emoji.labels.person-wrestling' => 'Lottatori',
			'emoji.labels.person-running' => 'Corridore',
			'emoji.labels.man-running' => 'Uomo che corre',
			'emoji.labels.woman-running' => 'Donna che corre',
			'emoji.labels.running-shoe' => 'Scarpa da corsa',
			'emoji.labels.running-shirt' => 'Canotta da corsa',
			'emoji.labels.hiking-boot' => 'Scarpone da trekking',
			'emoji.labels.person-walking' => 'Persona che cammina',
			'emoji.labels.person-climbing' => 'Scalatore',
			'emoji.labels.person-biking' => 'Ciclista',
			'emoji.labels.person-mountain-biking' => 'Ciclista di montagna',
			'emoji.labels.bicycle' => 'Bicicletta',
			'emoji.labels.person-swimming' => 'Nuotatore',
			'emoji.labels.person-surfing' => 'Surfista',
			'emoji.labels.person-rowing-boat' => 'Canottaggio',
			'emoji.labels.canoe' => 'Canoa',
			'emoji.labels.person-in-lotus-position' => 'Posizione del loto',
			'emoji.labels.lotus' => 'Loto',
			'emoji.labels.person-cartwheeling' => 'Ruota',
			'emoji.labels.person-juggling' => 'Giocoliere',
			'emoji.labels.person-bouncing-ball' => 'Palleggio',
			'emoji.labels.person-playing-handball' => 'Pallamano',
			'emoji.labels.person-playing-water-polo' => 'Pallanuoto',
			'emoji.labels.person-fencing' => 'Scherma',
			'emoji.labels.person-golfing' => 'Golfista',
			'emoji.labels.horse-racing' => 'Ippica',
			'emoji.labels.skier' => 'Sciatore',
			'emoji.labels.snowboarder' => 'Snowboarder',
			'emoji.labels.ice-skate' => 'Pattino da ghiaccio',
			'emoji.labels.roller-skate' => 'Pattino a rotelle',
			'emoji.labels.skateboard' => 'Skateboard',
			'emoji.labels.basketball' => 'Palla da basket',
			'emoji.labels.soccer-ball' => 'Pallone da calcio',
			'emoji.labels.american-football' => 'Football americano',
			'emoji.labels.rugby-football' => 'Palla da rugby',
			'emoji.labels.tennis' => 'Tennis',
			'emoji.labels.volleyball' => 'Pallavolo',
			'emoji.labels.baseball' => 'Baseball',
			'emoji.labels.ping-pong' => 'Ping pong',
			'emoji.labels.badminton' => 'Badminton',
			'emoji.labels.field-hockey' => 'Hockey su prato',
			'emoji.labels.ice-hockey' => 'Hockey su ghiaccio',
			'emoji.labels.bowling' => 'Bowling',
			'emoji.labels.flying-disc' => 'Frisbee',
			'emoji.labels.bow-and-arrow' => 'Arco e freccia',
			'emoji.labels.bullseye' => 'Bersaglio',
			'emoji.labels.pool-8-ball' => 'Palla da biliardo',
			'emoji.labels.parachute' => 'Paracadute',
			'emoji.labels.trophy' => 'Trofeo',
			'emoji.labels.sports-medal' => 'Medaglia sportiva',
			'emoji.labels.1st-place-medal' => 'Medaglia d’oro',
			'emoji.labels.2nd-place-medal' => 'Medaglia d’argento',
			'emoji.labels.3rd-place-medal' => 'Medaglia di bronzo',
			'emoji.labels.military-medal' => 'Medaglia militare',
			'emoji.labels.chequered-flag' => 'Bandiera a scacchi',
			'emoji.labels.triangular-flag' => 'Bandierina',
			'emoji.labels.stadium' => 'Stadio',
			'emoji.labels.stopwatch' => 'Cronometro',
			'emoji.labels.timer-clock' => 'Timer',
			'emoji.labels.alarm-clock' => 'Sveglia',
			'emoji.labels.hourglass-not-done' => 'Clessidra',
			'emoji.labels.leg' => 'Gamba',
			'emoji.labels.foot' => 'Piede',
			'emoji.labels.anatomical-heart' => 'Cuore anatomico',
			'emoji.labels.lungs' => 'Polmoni',
			'emoji.labels.bone' => 'Osso',
			'emoji.labels.brain' => 'Cervello',
			'emoji.labels.footprints' => 'Impronte',
			'emoji.labels.eyes' => 'Occhi',
			'emoji.labels.raised-fist' => 'Pugno alzato',
			'emoji.labels.oncoming-fist' => 'Pugno frontale',
			'emoji.labels.left-facing-fist' => 'Pugno verso sinistra',
			'emoji.labels.right-facing-fist' => 'Pugno verso destra',
			'emoji.labels.thumbs-up' => 'Pollice in su',
			'emoji.labels.clapping-hands' => 'Applauso',
			'emoji.labels.raising-hands' => 'Mani alzate',
			'emoji.labels.heart-hands' => 'Mani a cuore',
			'emoji.labels.handshake' => 'Stretta di mano',
			'emoji.labels.folded-hands' => 'Mani giunte',
			'emoji.labels.victory-hand' => 'Segno di vittoria',
			'emoji.labels.ok-hand' => 'Segno OK',
			'emoji.labels.waving-hand' => 'Mano che saluta',
			'emoji.labels.pinched-fingers' => 'Mano a pigna',
			'emoji.labels.sign-of-the-horns' => 'Corna',
			'emoji.labels.call-me-hand' => 'Chiamami',
			'emoji.labels.crossed-fingers' => 'Dita incrociate',
			'emoji.labels.love-you-gesture' => 'Gesto ti amo',
			'emoji.labels.sweat-droplets' => 'Gocce di sudore',
			'emoji.labels.zzz' => 'Zzz',
			'emoji.labels.person-standing' => 'Persona in piedi',
			'emoji.labels.person-kneeling' => 'Persona in ginocchio',
			'emoji.labels.fire' => 'Fuoco',
			'emoji.labels.high-voltage' => 'Fulmine',
			'emoji.labels.collision' => 'Esplosione',
			'emoji.labels.dizzy' => 'Stordimento',
			'emoji.labels.sparkles' => 'Scintille',
			'emoji.labels.star' => 'Stella',
			'emoji.labels.shooting-star' => 'Stella cadente',
			'emoji.labels.rocket' => 'Razzo',
			'emoji.labels.flying-saucer' => 'Disco volante',
			'emoji.labels.hundred-points' => 'Cento punti',
			'emoji.labels.check-mark-button' => 'Spunta verde',
			'emoji.labels.battery' => 'Batteria',
			'emoji.labels.light-bulb' => 'Lampadina',
			'emoji.labels.bomb' => 'Bomba',
			'emoji.labels.fireworks' => 'Fuochi d’artificio',
			'emoji.labels.party-popper' => 'Spara coriandoli',
			'emoji.labels.confetti-ball' => 'Palla di coriandoli',
			'emoji.labels.mirror-ball' => 'Palla da discoteca',
			'emoji.labels.crown' => 'Corona',
			'emoji.labels.gem-stone' => 'Gemma',
			'emoji.labels.shield' => 'Scudo',
			'emoji.labels.crossed-swords' => 'Spade incrociate',
			'emoji.labels.infinity' => 'Infinito',
			'emoji.labels.skull' => 'Teschio',
			'emoji.labels.skull-and-crossbones' => 'Teschio con ossa',
			'emoji.labels.ghost' => 'Fantasma',
			'emoji.labels.alien' => 'Alieno',
			'emoji.labels.robot' => 'Robot',
			'emoji.labels.pile-of-poo' => 'Cacca',
			'emoji.labels.magic-wand' => 'Bacchetta magica',
			'emoji.labels.crystal-ball' => 'Sfera di cristallo',
			'emoji.labels.grinning-face' => 'Faccina sorridente',
			'emoji.labels.grinning-face-with-big-eyes' => 'Sorriso con occhi grandi',
			'emoji.labels.grinning-face-with-smiling-eyes' => 'Sorriso con occhi sorridenti',
			'emoji.labels.beaming-face-with-smiling-eyes' => 'Faccina raggiante',
			'emoji.labels.grinning-squinting-face' => 'Risata a occhi chiusi',
			'emoji.labels.grinning-face-with-sweat' => 'Sorriso con sudore',
			'emoji.labels.face-with-tears-of-joy' => 'Lacrime di gioia',
			'emoji.labels.rolling-on-the-floor-laughing' => 'Rotolarsi dalle risate',
			'emoji.labels.smiling-face-with-smiling-eyes' => 'Faccina con occhi sorridenti',
			'emoji.labels.smiling-face-with-halo' => 'Faccina con aureola',
			'emoji.labels.smiling-face-with-hearts' => 'Faccina con cuoricini',
			'emoji.labels.smiling-face-with-heart-eyes' => 'Occhi a cuore',
			'emoji.labels.star-struck' => 'Occhi a stella',
			'emoji.labels.face-blowing-a-kiss' => 'Faccina che manda un bacio',
			'emoji.labels.face-savoring-food' => 'Faccina golosa',
			'emoji.labels.face-with-tongue' => 'Faccina con la lingua fuori',
			'emoji.labels.winking-face' => 'Occhiolino',
			'emoji.labels.winking-face-with-tongue' => 'Occhiolino con la lingua',
			'emoji.labels.zany-face' => 'Faccina pazza',
			'emoji.labels.money-mouth-face' => 'Faccina con la bocca di dollari',
			'emoji.labels.hugging-face' => 'Faccina che abbraccia',
			'emoji.labels.face-with-hand-over-mouth' => 'Mano sulla bocca',
			'emoji.labels.face-with-peeking-eye' => 'Faccina che sbircia',
			'emoji.labels.shushing-face' => 'Faccina che fa silenzio',
			'emoji.labels.thinking-face' => 'Faccina pensierosa',
			'emoji.labels.saluting-face' => 'Faccina che saluta',
			'emoji.labels.zipper-mouth-face' => 'Bocca con cerniera',
			'emoji.labels.face-with-raised-eyebrow' => 'Sopracciglio alzato',
			'emoji.labels.neutral-face' => 'Faccina neutra',
			'emoji.labels.unamused-face' => 'Faccina scocciata',
			'emoji.labels.smirking-face' => 'Sorrisetto',
			'emoji.labels.drooling-face' => 'Faccina che sbava',
			'emoji.labels.sleeping-face' => 'Faccina addormentata',
			'emoji.labels.face-with-medical-mask' => 'Mascherina',
			'emoji.labels.hot-face' => 'Faccina accaldata',
			'emoji.labels.cold-face' => 'Faccina congelata',
			'emoji.labels.woozy-face' => 'Faccina stordita',
			'emoji.labels.face-with-spiral-eyes' => 'Occhi a spirale',
			'emoji.labels.exploding-head' => 'Testa che esplode',
			'emoji.labels.cowboy-hat-face' => 'Cappello da cowboy',
			'emoji.labels.partying-face' => 'Faccina in festa',
			'emoji.labels.disguised-face' => 'Faccina travestita',
			'emoji.labels.smiling-face-with-sunglasses' => 'Faccina con occhiali da sole',
			'emoji.labels.nerd-face' => 'Faccina da secchione',
			'emoji.labels.face-with-monocle' => 'Faccina con monocolo',
			'emoji.labels.slightly-smiling-face' => 'Sorriso leggero',
			'emoji.labels.upside-down-face' => 'Faccina capovolta',
			'emoji.labels.melting-face' => 'Faccina che si scioglie',
			'emoji.labels.flushed-face' => 'Faccina imbarazzata',
			'emoji.labels.pleading-face' => 'Faccina supplicante',
			'emoji.labels.face-holding-back-tears' => 'Faccina che trattiene le lacrime',
			'emoji.labels.loudly-crying-face' => 'Pianto a dirotto',
			'emoji.labels.face-screaming-in-fear' => 'Urlo di paura',
			'emoji.labels.downcast-face-with-sweat' => 'Faccina abbattuta e sudata',
			'emoji.labels.weary-face' => 'Faccina sfinita',
			'emoji.labels.tired-face' => 'Faccina stanca',
			'emoji.labels.yawning-face' => 'Sbadiglio',
			'emoji.labels.face-with-steam-from-nose' => 'Faccina che sbuffa',
			'emoji.labels.angry-face' => 'Faccina arrabbiata',
			'emoji.labels.smiling-face-with-horns' => 'Diavoletto',
			'emoji.labels.angry-face-with-horns' => 'Diavolo arrabbiato',
			'emoji.labels.red-heart' => 'Cuore rosso',
			'emoji.labels.orange-heart' => 'Cuore arancione',
			'emoji.labels.yellow-heart' => 'Cuore giallo',
			'emoji.labels.green-heart' => 'Cuore verde',
			'emoji.labels.blue-heart' => 'Cuore blu',
			'emoji.labels.purple-heart' => 'Cuore viola',
			'emoji.labels.black-heart' => 'Cuore nero',
			'emoji.labels.white-heart' => 'Cuore bianco',
			'emoji.labels.pink-heart' => 'Cuore rosa',
			'emoji.labels.sparkling-heart' => 'Cuore scintillante',
			'emoji.labels.growing-heart' => 'Cuore che cresce',
			'emoji.labels.beating-heart' => 'Cuore che batte',
			'emoji.labels.revolving-hearts' => 'Cuori che girano',
			'emoji.labels.two-hearts' => 'Due cuori',
			'emoji.labels.heart-on-fire' => 'Cuore in fiamme',
			'emoji.labels.mending-heart' => 'Cuore che guarisce',
			'emoji.labels.broken-heart' => 'Cuore spezzato',
			'emoji.labels.heart-with-arrow' => 'Cuore trafitto',
			'emoji.labels.heart-with-ribbon' => 'Cuore con fiocco',
			'emoji.labels.gorilla' => 'Gorilla',
			'emoji.labels.lion' => 'Leone',
			'emoji.labels.tiger' => 'Tigre',
			'emoji.labels.leopard' => 'Leopardo',
			'emoji.labels.bear' => 'Orso',
			'emoji.labels.polar-bear' => 'Orso polare',
			'emoji.labels.ox' => 'Bue',
			'emoji.labels.water-buffalo' => 'Bufalo',
			'emoji.labels.bison' => 'Bisonte',
			'emoji.labels.cow' => 'Mucca',
			'emoji.labels.rhinoceros' => 'Rinoceronte',
			'emoji.labels.elephant' => 'Elefante',
			'emoji.labels.hippopotamus' => 'Ippopotamo',
			'emoji.labels.mammoth' => 'Mammut',
			'emoji.labels.horse' => 'Cavallo',
			'emoji.labels.zebra' => 'Zebra',
			'emoji.labels.giraffe' => 'Giraffa',
			'emoji.labels.camel' => 'Cammello',
			'emoji.labels.deer' => 'Cervo',
			'emoji.labels.ram' => 'Ariete',
			'emoji.labels.goat' => 'Capra',
			'emoji.labels.pig' => 'Maiale',
			'emoji.labels.wolf' => 'Lupo',
			'emoji.labels.fox' => 'Volpe',
			'emoji.labels.dog' => 'Cane',
			'emoji.labels.cat' => 'Gatto',
			'emoji.labels.black-cat' => 'Gatto nero',
			'emoji.labels.monkey' => 'Scimmia',
			'emoji.labels.see-no-evil-monkey' => 'Scimmia che non vede',
			'emoji.labels.kangaroo' => 'Canguro',
			'emoji.labels.rabbit' => 'Coniglio',
			'emoji.labels.hedgehog' => 'Riccio',
			'emoji.labels.koala' => 'Koala',
			'emoji.labels.panda' => 'Panda',
			'emoji.labels.sloth' => 'Bradipo',
			'emoji.labels.otter' => 'Lontra',
			'emoji.labels.seal' => 'Foca',
			'emoji.labels.bat' => 'Pipistrello',
			'emoji.labels.eagle' => 'Aquila',
			'emoji.labels.owl' => 'Gufo',
			'emoji.labels.rooster' => 'Gallo',
			'emoji.labels.chicken' => 'Gallina',
			'emoji.labels.baby-chick' => 'Pulcino',
			'emoji.labels.duck' => 'Anatra',
			'emoji.labels.swan' => 'Cigno',
			'emoji.labels.flamingo' => 'Fenicottero',
			'emoji.labels.peacock' => 'Pavone',
			'emoji.labels.parrot' => 'Pappagallo',
			'emoji.labels.dove' => 'Colomba',
			'emoji.labels.penguin' => 'Pinguino',
			'emoji.labels.shark' => 'Squalo',
			'emoji.labels.whale' => 'Balena',
			'emoji.labels.dolphin' => 'Delfino',
			'emoji.labels.octopus' => 'Polpo',
			'emoji.labels.fish' => 'Pesce',
			'emoji.labels.tropical-fish' => 'Pesce tropicale',
			'emoji.labels.crab' => 'Granchio',
			'emoji.labels.lobster' => 'Aragosta',
			'emoji.labels.shrimp' => 'Gambero',
			'emoji.labels.turtle' => 'Tartaruga',
			'emoji.labels.crocodile' => 'Coccodrillo',
			'emoji.labels.snake' => 'Serpente',
			'emoji.labels.frog' => 'Rana',
			'emoji.labels.t-rex' => 'T-Rex',
			'emoji.labels.sauropod' => 'Sauropode',
			'emoji.labels.dragon' => 'Drago',
			'emoji.labels.unicorn' => 'Unicorno',
			'emoji.labels.butterfly' => 'Farfalla',
			'emoji.labels.honeybee' => 'Ape',
			'emoji.labels.scorpion' => 'Scorpione',
			'emoji.labels.cut-of-meat' => 'Bistecca',
			'emoji.labels.meat-on-bone' => 'Carne con osso',
			'emoji.labels.poultry-leg' => 'Coscia di pollo',
			'emoji.labels.bacon' => 'Pancetta',
			'emoji.labels.egg' => 'Uovo',
			'emoji.labels.cooked-rice' => 'Ciotola di riso',
			'emoji.labels.steaming-bowl' => 'Ciotola fumante',
			'emoji.labels.green-salad' => 'Insalata',
			'emoji.labels.broccoli' => 'Broccoli',
			'emoji.labels.avocado' => 'Avocado',
			'emoji.labels.banana' => 'Banana',
			'emoji.labels.red-apple' => 'Mela rossa',
			'emoji.labels.green-apple' => 'Mela verde',
			'emoji.labels.pear' => 'Pera',
			'emoji.labels.peach' => 'Pesca',
			'emoji.labels.cherries' => 'Ciliegie',
			'emoji.labels.strawberry' => 'Fragola',
			'emoji.labels.blueberries' => 'Mirtilli',
			'emoji.labels.grapes' => 'Uva',
			'emoji.labels.watermelon' => 'Anguria',
			'emoji.labels.pineapple' => 'Ananas',
			'emoji.labels.mango' => 'Mango',
			'emoji.labels.kiwi-fruit' => 'Kiwi',
			'emoji.labels.lemon' => 'Limone',
			'emoji.labels.coconut' => 'Noce di cocco',
			'emoji.labels.carrot' => 'Carota',
			'emoji.labels.potato' => 'Patata',
			'emoji.labels.tomato' => 'Pomodoro',
			'emoji.labels.bell-pepper' => 'Peperone',
			'emoji.labels.hot-pepper' => 'Peperoncino',
			'emoji.labels.eggplant' => 'Melanzana',
			'emoji.labels.bread' => 'Pane',
			'emoji.labels.croissant' => 'Croissant',
			'emoji.labels.glass-of-milk' => 'Bicchiere di latte',
			'emoji.labels.hot-beverage' => 'Caffè',
			'emoji.labels.honey-pot' => 'Vasetto di miele',
			'emoji.labels.chocolate-bar' => 'Tavoletta di cioccolato',
			'emoji.labels.cookie' => 'Biscotto',
			'emoji.labels.doughnut' => 'Ciambella',
			'emoji.labels.ice-cream' => 'Gelato',
			'emoji.labels.birthday-cake' => 'Torta di compleanno',
			'emoji.labels.pancakes' => 'Pancake',
			'emoji.labels.popcorn' => 'Popcorn',
			'emoji.labels.lollipop' => 'Lecca-lecca',
			'emoji.labels.pizza' => 'Pizza',
			'emoji.labels.hamburger' => 'Hamburger',
			'emoji.labels.french-fries' => 'Patatine fritte',
			_ => null,
		} ?? switch (path) {
			'emoji.labels.taco' => 'Taco',
			'emoji.labels.sushi' => 'Sushi',
			'emoji.labels.fork-and-knife' => 'Posate',
			'emoji.labels.bottle-with-popping-cork' => 'Bottiglia che si stappa',
			'emoji.labels.clinking-glasses' => 'Brindisi',
			'emoji.labels.wine-glass' => 'Calice di vino',
			'emoji.labels.beer-mug' => 'Boccale di birra',
			'emoji.labels.tropical-drink' => 'Cocktail tropicale',
			'emoji.labels.sun' => 'Sole',
			'emoji.labels.sun-with-face' => 'Sole con faccia',
			'emoji.labels.sunrise' => 'Alba',
			'emoji.labels.sunrise-over-mountains' => 'Alba in montagna',
			'emoji.labels.sunset' => 'Tramonto',
			'emoji.labels.cloud' => 'Nuvola',
			'emoji.labels.cloud-with-rain' => 'Pioggia',
			'emoji.labels.cloud-with-lightning' => 'Temporale',
			'emoji.labels.cloud-with-lightning-and-rain' => 'Temporale con pioggia',
			'emoji.labels.snowflake' => 'Fiocco di neve',
			'emoji.labels.rainbow' => 'Arcobaleno',
			'emoji.labels.crescent-moon' => 'Luna crescente',
			'emoji.labels.full-moon' => 'Luna piena',
			'emoji.labels.night-with-stars' => 'Notte stellata',
			'emoji.labels.milky-way' => 'Via Lattea',
			'emoji.labels.mountain' => 'Montagna',
			'emoji.labels.snow-capped-mountain' => 'Montagna innevata',
			'emoji.labels.volcano' => 'Vulcano',
			'emoji.labels.desert-island' => 'Isola deserta',
			'emoji.labels.beach-with-umbrella' => 'Spiaggia con ombrellone',
			'emoji.labels.water-wave' => 'Onda',
			'emoji.labels.droplet' => 'Goccia',
			'emoji.labels.tornado' => 'Tornado',
			'emoji.labels.palm-tree' => 'Palma',
			'emoji.labels.cactus' => 'Cactus',
			'emoji.labels.seedling' => 'Germoglio',
			'emoji.labels.four-leaf-clover' => 'Quadrifoglio',
			'emoji.labels.sunflower' => 'Girasole',
			'emoji.labels.rose' => 'Rosa',
			'emoji.labels.tulip' => 'Tulipano',
			'emoji.labels.cherry-blossom' => 'Fiore di ciliegio',
			'emoji.labels.maple-leaf' => 'Foglia d’acero',
			'emoji.labels.globe-showing-europe-africa' => 'Globo terrestre',
			'emoji.labels.globe-with-meridians' => 'Globo con meridiani',
			'emoji.labels.house' => 'Casa',
			'emoji.labels.cityscape' => 'Città',
			'emoji.labels.tent' => 'Tenda',
			'emoji.labels.hot-springs' => 'Terme',
			'emoji.labels.world-map' => 'Mappa del mondo',
			'emoji.labels.compass' => 'Bussola',
			'emoji.labels.airplane' => 'Aereo',
			'emoji.labels.automobile' => 'Automobile',
			'emoji.labels.racing-car' => 'Auto da corsa',
			'emoji.labels.motorcycle' => 'Moto',
			'emoji.labels.sailboat' => 'Barca a vela',
			'emoji.labels.gear' => 'Ingranaggio',
			'emoji.labels.hammer' => 'Martello',
			'emoji.labels.wrench' => 'Chiave inglese',
			'emoji.labels.hammer-and-wrench' => 'Martello e chiave',
			'emoji.labels.brick' => 'Mattone',
			'emoji.labels.puzzle-piece' => 'Pezzo di puzzle',
			'emoji.labels.game-die' => 'Dado',
			'emoji.labels.joystick' => 'Joystick',
			'emoji.labels.video-game' => 'Controller',
			'emoji.labels.headphone' => 'Cuffie',
			'emoji.labels.musical-note' => 'Nota musicale',
			'emoji.labels.musical-notes' => 'Note musicali',
			'emoji.labels.guitar' => 'Chitarra',
			'emoji.labels.calendar' => 'Calendario',
			'emoji.labels.mobile-phone' => 'Telefono',
			'emoji.labels.laptop' => 'Computer portatile',
			'emoji.labels.clipboard' => 'Blocco appunti',
			'emoji.labels.memo' => 'Promemoria',
			'emoji.labels.pencil' => 'Matita',
			'emoji.labels.chart-increasing' => 'Grafico in crescita',
			'emoji.labels.bar-chart' => 'Grafico a barre',
			'emoji.labels.balance-scale' => 'Bilancia',
			'emoji.labels.books' => 'Libri',
			'emoji.labels.open-book' => 'Libro aperto',
			'emoji.labels.graduation-cap' => 'Tocco di laurea',
			'emoji.labels.money-bag' => 'Sacco di soldi',
			'emoji.labels.coin' => 'Moneta',
			'emoji.labels.locked' => 'Lucchetto chiuso',
			'emoji.labels.unlocked' => 'Lucchetto aperto',
			'emoji.labels.key' => 'Chiave',
			'emoji.labels.dna' => 'DNA',
			'emoji.labels.pill' => 'Pillola',
			'emoji.labels.stethoscope' => 'Stetoscopio',
			'emoji.labels.adhesive-bandage' => 'Cerotto',
			'emoji.labels.speech-balloon' => 'Fumetto',
			'emoji.labels.thought-balloon' => 'Nuvoletta di pensiero',
			'errors.network' => 'Nessuna connessione di rete. Controlla la connessione.',
			'errors.notFound' => 'Elemento non trovato.',
			'errors.generic' => 'Si è verificato un errore. Riprova.',
			'errors.invalidCode' => 'Codice non valido o scaduto.',
			'errors.passwordSameAsOld' => 'La nuova password deve essere diversa dalla precedente.',
			'errors.auth.invalidCredentials' => 'Email o password non corretti.',
			'errors.auth.emailNotConfirmed' => 'Conferma la tua email prima di accedere.',
			'errors.auth.userAlreadyExists' => 'Esiste già un account con questa email.',
			'errors.auth.sessionExpired' => 'Sessione scaduta. Accedi di nuovo.',
			'errors.auth.notSignedIn' => 'Devi aver effettuato l\'accesso.',
			'goals.strength' => 'Forza',
			'goals.hypertrophy' => 'Ipertrofia',
			'goals.endurance' => 'Resistenza',
			'goals.weightLoss' => 'Perdita di peso',
			'goals.maintenance' => 'Mantenimento',
			'history.title' => 'Cronologia',
			'history.emptySubtitle' => 'Nessuna sessione',
			'history.emptyTitle' => 'Ancora nessuna sessione',
			'history.emptyMessage' => 'Avvia la tua prima sessione dalla schermata principale — comparirà qui.',
			'history.sessionCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n, one: '${n} sessione', other: '${n} sessioni', ), 
			'history.deleteError' => 'Eliminazione non riuscita.',
			'history.groups.thisWeek' => 'Questa settimana',
			'history.groups.lastWeek' => 'Settimana scorsa',
			'history.groups.weeksAgo' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n, one: '${n} settimana fa', other: '${n} settimane fa', ), 
			'history.panel.sessions' => 'Sessioni',
			'history.panel.volume' => 'Volume',
			'history.panel.time' => 'Tempo',
			'history.detail.title' => 'Sessione',
			'history.detail.dateFormat' => 'EEEE d MMMM \'alle\' HH:mm',
			'history.detail.duration' => 'Durata',
			'history.detail.tonnage' => 'Tonnellaggio',
			'history.detail.sets' => 'Serie',
			'history.detail.notes' => 'Note',
			'history.detail.perExercise' => 'Dettaglio per esercizio',
			'history.detail.setsCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n, one: '${n} serie', other: '${n} serie', ), 
			'history.detail.bodyweight' => 'Peso corporeo',
			'history.detail.colSet' => 'Serie',
			'history.detail.colReps' => 'Rip.',
			'history.detail.colLoad' => 'Carico',
			'history.detail.colHeld' => 'Tenuto',
			'history.detail.totalExercise' => 'Totale esercizio',
			'history.detail.totalHeld' => 'Totale tenuto',
			'history.detail.edit.open' => 'Modifica',
			'history.detail.edit.title' => 'Modifica sessione',
			'history.detail.edit.name' => 'Titolo',
			'history.detail.edit.namePlaceholder' => 'Nome della sessione',
			'history.detail.edit.date' => 'Data',
			'history.detail.edit.time' => 'Ora',
			'history.detail.edit.durationLabel' => 'Durata',
			'history.detail.edit.hours' => 'h',
			'history.detail.edit.minutes' => 'min',
			'history.detail.edit.notesPlaceholder' => 'Com\'è andata?',
			'history.detail.edit.save' => 'Salva',
			'history.detail.edit.saved' => 'Sessione aggiornata.',
			'history.detail.edit.error' => 'Modifica non riuscita.',
			'history.detail.edit.nameRequired' => 'Il titolo è obbligatorio.',
			'history.detail.edit.dateFormat' => 'd MMMM y',
			'legal.onlyInEnglish' => 'Questo documento è disponibile solo in inglese.',
			'nav.home' => 'Home',
			'nav.program' => 'Programmi',
			'nav.history' => 'Cronologia',
			'nav.stats' => 'Statistiche',
			'nav.settings' => 'Impostazioni',
			'profile.notConnected' => 'Non hai effettuato l\'accesso.',
			'profile.navTitle' => 'PROFILO',
			'profile.defaultName' => 'Atleta',
			'profile.since' => ({required Object month}) => 'Dal ${month}',
			'profile.editSheet.title' => 'Modifica profilo',
			'profile.sections.badges' => 'Badge',
			'profile.stats.sessions' => 'Sessioni',
			'profile.stats.tonnage' => 'Tonnellaggio',
			'profile.stats.sets' => 'Serie',
			'profile.sessionCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n, one: '${n} sessione', other: '${n} sessioni', ), 
			'profile.badges.empty' => 'Inizia la tua prima sessione per sbloccare i badge!',
			'profile.badges.firstSession' => 'Prima sessione',
			'profile.badges.tenSessions' => '10 sessioni',
			'profile.badges.tenTonnes' => '10 tonnellate',
			'profile.badges.planner' => 'Pianificatore',
			'profile.avatar.sheetTitle' => 'Foto del profilo',
			'profile.avatar.takePhoto' => 'Scatta una foto',
			'profile.avatar.gallery' => 'Galleria foto',
			'profile.avatar.remove' => 'Rimuovi la foto',
			'profile.avatar.openError' => 'Impossibile aprire la foto.',
			'profile.avatar.updated' => 'Foto aggiornata!',
			'profile.avatar.saveError' => 'Impossibile salvare la foto.',
			'profile.avatar.removed' => 'Foto rimossa.',
			'profile.avatar.removeError' => 'Impossibile rimuovere la foto.',
			'profile.editForm.saved' => 'Profilo aggiornato.',
			'profile.editForm.pickDate' => 'Scegli una data',
			'profile.editForm.sections.identity' => 'Identità',
			'profile.editForm.sections.physique' => 'Fisico',
			'profile.editForm.sections.goal' => 'Obiettivo',
			'profile.editForm.fields.name' => 'Nome / Nickname',
			'profile.editForm.fields.bio' => 'Bio',
			'profile.editForm.fields.birthdate' => 'Data di nascita',
			'profile.editForm.fields.weight' => 'Peso (kg)',
			'profile.editForm.fields.height' => 'Altezza (cm)',
			'profile.editForm.validation.nameMin' => 'Almeno 2 caratteri',
			'profile.editForm.validation.nameMax' => 'Massimo 60 caratteri',
			'profile.editForm.validation.invalidNumber' => 'Numero non valido',
			'profile.editForm.validation.heightRange' => 'Tra 80 e 260 cm',
			'profile.editForm.validation.weightRange' => 'Tra 30 e 350 kg',
			'session.bw' => 'PC',
			'session.continueLabel' => 'Continua',
			'session.error.startFailed' => 'Impossibile avviare la sessione.',
			'session.error.saveFailed' => 'Salvataggio non riuscito.',
			'session.error.templateUpdateFailed' => 'Sessione salvata, ma il programma non è stato aggiornato.',
			'session.live.exercisePosition' => ({required Object current, required Object total}) => 'Esercizio ${current} / ${total}',
			'session.live.supersetPosition' => ({required Object current, required Object total}) => 'Superserie ${current} / ${total}',
			'session.live.headerSubtitle' => ({required Object completed, required Object total, required Object time}) => '${completed}/${total} serie · ${time}',
			'session.live.totalTonnage' => 'Tonnellaggio totale',
			'session.live.nextExercise' => 'Esercizio successivo',
			'session.live.nextBlock' => 'Blocco successivo',
			'session.live.finishSession' => 'Termina sessione',
			'session.confirm.quitTitle' => 'Abbandonare la sessione?',
			'session.confirm.quitMessage' => 'Tutti i progressi andranno persi.',
			'session.confirm.quitConfirm' => 'Abbandona',
			'session.confirm.inProgressTitle' => 'Una sessione è già in corso',
			'session.confirm.inProgressMessage' => ({required Object name, required Object date}) => '«${name}» è stata avviata ${date}. Avviarne una nuova eliminerà definitivamente i suoi progressi.',
			'session.confirm.overwriteAndStart' => 'Sovrascrivi e avvia',
			'session.confirm.deleteExerciseTitle' => ({required Object name}) => 'Eliminare «${name}»?',
			'session.confirm.deleteExerciseMessage' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n, one: 'Questo esercizio ha già ${n} serie completata. Andrà persa.', other: 'Questo esercizio ha già ${n} serie completate. Andranno perse.', ), 
			'session.confirm.removeSessionOnly' => 'Solo in questa sessione',
			'session.confirm.removeFromTemplate' => 'Anche dal programma',
			'session.add.title' => 'Aggiungi un esercizio',
			'session.add.subtitle' => 'Aggiunto solo a questa sessione, senza modificare il programma.',
			'session.add.addLabel' => 'Aggiungi',
			'session.add.addToSession' => 'Aggiungi alla sessione',
			'session.add.reps' => 'Ripetizioni',
			'session.add.time' => 'Tempo',
			'session.add.addAndTemplate' => 'Aggiungi alla sessione e al programma',
			'session.swap.title' => 'Modifica esercizio',
			'session.swap.currently' => ({required Object name}) => 'Attualmente: ${name}',
			'session.swap.sessionOnly' => 'Queste modifiche valgono solo per questa sessione.',
			'session.swap.useLabel' => 'Usa',
			'session.swap.adoptFormat' => 'Riprendi il formato',
			'session.swap.adoptFormatSummary' => ({required Object summary, required Object name}) => '${summary} · da «${name}»',
			'session.swap.apply' => 'Applica a questa sessione',
			'session.swap.applyAndTemplate' => 'Applica e aggiorna il programma',
			'session.variants.title' => 'Scegli una variante',
			'session.variants.lockedMessage' => 'Una serie è già completata — termina l’esercizio o usa «Scambia» per regolare in corsa.',
			'session.variants.pickMessage' => 'Scegli una variante per questa posizione. Sostituirà l’esercizio corrente.',
			'session.variants.empty' => 'Nessuna variante definita per questo esercizio.',
			'session.variants.main' => 'PRINCIPALE',
			'session.variants.variantN' => ({required Object n}) => 'Variante ${n}',
			'session.variants.restSeconds' => ({required Object n}) => '${n}s recupero',
			'session.variants.tempoPart' => ({required Object tempo}) => ' · tempo ${tempo}',
			'session.finish.title' => 'Terminare la sessione?',
			'session.finish.summaryReps' => ({required Object completed, required Object total}) => '${completed}/${total} serie · ',
			'session.finish.summaryTonnageSuffix' => ' di tonnellaggio',
			'session.finish.notesHint' => 'Note sulla sessione (facoltativo)…',
			'session.finish.confirm' => 'Termina',
			'session.finish.unvalidatedSets' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n, one: '${n} SERIE NON VALIDATA', other: '${n} SERIE NON VALIDATE', ), 
			'session.finish.incompleteHint' => 'Puoi tornare a validare le tue serie, oppure terminare comunque — verranno salvate solo le serie selezionate.',
			'session.finish.templateLabel' => 'AGGIORNAMENTO DEL PROGRAMMA',
			'session.finish.templateToggle' => ({required Object name}) => 'Aggiorna “${name}”',
			'session.finish.templateHint' => 'Le modifiche segnate durante la sessione. Disattiva per lasciare il programma com\'è.',
			'session.finish.changeAdded' => ({required Object name}) => '${name} · aggiunto',
			'session.finish.changeModified' => ({required Object name}) => '${name} · modificato',
			'session.finish.changeRemoved' => ({required Object name}) => '${name} · rimosso',
			'session.timer.preparation' => 'PREPARAZIONE',
			'session.timer.running' => 'IN CORSO',
			'session.timer.done' => 'COMPLETATO',
			'session.timer.go' => 'VIA',
			'session.timer.stop' => 'Ferma',
			'session.rest.title' => 'RECUPERO',
			'session.rest.sec' => 'SEC',
			'session.rest.skip' => 'Salta',
			'session.rest.minimize' => 'Riduci',
			'session.set.addSet' => 'Aggiungi una serie',
			'session.set.setLabel' => ({required Object n}) => 'Serie ${n}',
			'session.set.reps' => 'Reps',
			'session.set.load' => 'Carico',
			'session.set.duration' => 'Durata',
			'session.set.held' => 'Tenuto',
			'session.set.tonnage' => 'TONNELLAGGIO',
			'session.set.targetReps' => ({required Object n}) => 'obiettivo ${n} reps',
			'session.set.targetDuration' => ({required Object value}) => 'obiettivo ${value}',
			'session.set.validateWithoutTimer' => 'Valida senza timer',
			'session.set.cmpUp' => 'Top',
			'session.exercise.timed' => 'A tempo',
			'session.exercise.tempoChip' => ({required Object tempo}) => 'Tempo ${tempo}',
			'session.exercise.restChip' => ({required Object n}) => '${n}s recupero',
			'session.exercise.modified' => 'Modificato · solo questa sessione',
			'session.exercise.modifiedWas' => ({required Object name}) => 'Modificato · solo questa sessione (era: ${name})',
			'session.exercise.completedBadge' => '✓ Fatto',
			'session.exercise.totalHeld' => ({required Object value}) => 'Totale tenuto: ${value}',
			'session.exercise.exerciseVolume' => ({required Object value}) => 'Volume esercizio: ${value} kg',
			'session.exercise.lastTimeLabel' => 'Ultima volta',
			'session.exercise.otherWorkout' => 'altra sessione',
			'session.exercise.targetWasReps' => ({required Object n}) => 'obiettivo ${n} rip.',
			'session.exercise.targetWasSeconds' => ({required Object n}) => 'obiettivo ${n}s',
			'session.exercise.morePerfs' => ({required Object n}) => '+${n}',
			'session.exercise.keptInTemplate' => 'Modificato · sarà salvato nel programma',
			'session.exercise.keptInTemplateWas' => ({required Object name}) => 'Modificato · sarà salvato nel programma (era: ${name})',
			'session.exercise.keepInTemplateAction' => 'Tocca per mantenere questa modifica nel programma',
			'session.overview.title' => 'Esercizi',
			'session.overview.current' => 'IN CORSO',
			'session.overview.setsValidated' => ({required Object completed, required Object total}) => '${completed}/${total} serie validate',
			'session.superset.badge' => ({required Object n}) => 'SUPERSERIE · ${n} ESERCIZI',
			'session.superset.addSetTo' => ({required Object letter, required Object name}) => 'Aggiungi una serie a ${letter} · ${name}',
			'session.duration.title' => 'Durata per serie',
			'session.duration.hint' => '45 o 1m30',
			'session.duration.confirm' => ({required Object value}) => 'Conferma — ${value}',
			'session.weight.bodyweight' => 'Peso corporeo',
			'session.weight.confirmBodyweight' => 'Conferma — Peso corporeo',
			'session.weight.confirmKg' => ({required Object value}) => 'Conferma — ${value} kg',
			'session.search.hint' => 'Cerca un esercizio…',
			'session.search.loading' => 'Caricamento esercizi…',
			'session.search.noMatch' => 'Nessun esercizio corrisponde.',
			'session.search.certifiedBadge' => 'Esercizio Repster',
			'session.history.title' => ({required Object name}) => 'Cronologia · ${name}',
			'session.history.empty' => 'Nessuna cronologia per questo esercizio.',
			'session.history.loading' => 'Caricamento cronologia…',
			'session.history.setLabel' => ({required Object n}) => 'Serie ${n}',
			'session.history.dateFormat' => 'd MMM yyyy',
			'session.fields.exerciseName' => 'Nome dell’esercizio',
			'session.fields.type' => 'Tipo',
			'session.fields.sets' => 'Serie',
			'session.fields.durationSec' => 'Durata (sec)',
			'session.fields.targetReps' => 'Reps obiettivo',
			'session.fields.restShort' => 'Recupero (sec)',
			'session.fields.rest' => 'Recupero (sec)',
			'session.fields.tempo' => 'Tempo',
			'session.fields.notesOptional' => 'Note (facoltativo)',
			'session.fields.notesHint' => 'Consigli tecnici…',
			'session.fields.keepInTemplate' => 'Salva anche nel programma',
			'session.fields.keepInTemplateHint' => 'Per impostazione predefinita la modifica vale solo per questa sessione.',
			'session.toast.exerciseAdded' => ({required Object name}) => '${name} aggiunto alla sessione',
			'session.toast.validateOneSet' => 'Valida almeno una serie prima di terminare.',
			'session.toast.sessionSaved' => 'Sessione salvata! 🎉',
			'session.toast.finishOrSwap' => 'Termina la serie corrente o usa «Scambia».',
			'session.notif.countdownChannel' => 'Conto alla rovescia recupero',
			'session.notif.doneChannel' => 'Recupero terminato',
			'session.notif.doneTitle' => 'Recupero finito',
			'settings.title' => 'Impostazioni',
			'settings.sections.profile' => 'Profilo',
			'settings.sections.data' => 'I miei dati',
			'settings.sections.preferences' => 'Preferenze',
			'settings.sections.account' => 'Account',
			'settings.defaultName' => 'Atleta',
			'settings.editProfile' => 'MODIFICA',
			'settings.profileUnavailable' => 'Profilo non disponibile',
			'settings.rows.templates' => 'I miei programmi',
			'settings.rows.history' => 'Cronologia sessioni',
			'settings.rows.stats' => 'Statistiche',
			'settings.rows.notifications' => 'Notifiche',
			'settings.rows.privacy' => 'Privacy',
			'settings.rows.terms' => 'Condizioni d\'uso',
			'settings.rows.contact' => 'Contatti e feedback',
			'settings.rows.language' => 'Lingua',
			'settings.rows.changePassword' => 'Cambia la mia password',
			'settings.soon' => 'Presto',
			'settings.soonToast' => 'Presto disponibile',
			'settings.logout.action' => 'Disconnetti',
			'settings.logout.error' => 'Disconnessione non riuscita.',
			'settings.version' => 'Repster v1.0 · Allenati, progredisci, ripeti.',
			'settings.language.title' => 'Lingua',
			'settings.language.subtitle' => 'Scegli la lingua dell\'app',
			'settings.language.system' => 'Lingua di sistema',
			'stats.title' => 'Statistiche',
			'stats.sessionsCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n, one: '${n} sessione', other: '${n} sessioni', ), 
			'stats.weeksShort' => ({required Object n}) => '${n} sett.',
			'stats.subtitle.empty' => 'Nessuna sessione nel periodo',
			'stats.empty.title' => 'Ancora nessun dato',
			'stats.empty.message' => 'Completa alcune sessioni per vedere le tue curve e i tuoi progressi.',
			'stats.range.last4Weeks.label' => '4 settimane',
			'stats.range.last4Weeks.short' => '4 sett.',
			'stats.range.last3Months.label' => '3 mesi',
			'stats.range.last3Months.short' => '3 mesi',
			'stats.range.all.label' => 'Tutto',
			'stats.range.all.short' => 'Tutto',
			'stats.kpi.sessions' => 'Sessioni',
			'stats.kpi.volume' => 'Tonnellaggio',
			'stats.kpi.sets' => 'Serie',
			'stats.kpi.avgDuration' => 'Durata media',
			'stats.kpi.tension' => 'Tempo sotto tensione',
			'stats.weeklyVolume.title' => 'Volume settimanale',
			'stats.weeklyVolume.empty' => 'Ancora poche sessioni nel periodo.',
			'stats.weeklyVolume.inProgress' => 'in corso',
			'stats.exercise.title' => 'Progressione per esercizio',
			'stats.exercise.empty' => 'Registra almeno 2 sessioni con lo stesso esercizio caricato per vedere la tua curva di forza.',
			'stats.exercise.pickerTitle' => 'Scegli un esercizio',
			'stats.exercise.noExercise' => 'Nessun esercizio',
			'stats.exercise.searchHint' => 'Cerca…',
			'stats.exercise.oneRmMax' => '1RM stimato max',
			'stats.exercise.bestLoad' => 'miglior carico',
			'stats.exercise.record' => 'record',
			'stats.exercise.trendUnknown' => 'Non ci sono ancora sessioni sufficienti per una tendenza',
			'stats.exercise.trendProgressing' => 'In progresso',
			'stats.exercise.trendPlateau' => ({required Object n}) => 'Plateau · ${n} sessioni senza record',
			'stats.exercise.trendRegressing' => 'In calo',
			'stats.exercise.perMonth' => ({required Object value}) => '${value} %/mese',
			'stats.exercise.plateauHint' => 'Prova meno reps con più carico, o cambia esercizio.',
			'stats.records.title' => 'Record',
			'stats.records.bestSession' => 'Miglior sessione',
			'stats.records.heaviestLift' => 'Carico massimo',
			'stats.records.bestOneRm' => '1RM stimato',
			'stats.records.bestStreak' => 'Serie più lunga',
			'stats.records.consecutiveWeeks' => 'settimane consecutive',
			'stats.strength.title' => 'Forza',
			'stats.strength.scope' => 'tutto lo storico',
			'templates.list.title' => 'Programmi',
			'templates.list.subtitleActive' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n, one: '${n} sessione attiva', other: '${n} sessioni attive', ), 
			'templates.list.newAction' => 'Crea',
			'templates.list.emptyTitle' => 'Nessuna sessione',
			'templates.list.emptyMessage' => 'Crea la tua prima sessione per comporre il tuo programma.',
			'templates.list.emptyAction' => 'Crea una sessione',
			'templates.list.reorderError' => 'Errore durante il riordino.',
			'templates.list.toggleError' => 'Azione impossibile.',
			'templates.list.duplicated' => 'Sessione copiata!',
			'templates.list.duplicateError' => 'Duplicazione impossibile.',
			'templates.list.deleted' => 'Sessione eliminata.',
			'templates.list.deleteError' => 'Eliminazione impossibile.',
			'templates.list.copySuffix' => '(copia)',
			'templates.card.exerciseCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n, one: '${n} esercizio', other: '${n} esercizi', ), 
			'templates.card.activate' => 'Attiva',
			'templates.card.deactivate' => 'Disattiva',
			'templates.detail.noExercises' => 'Nessun esercizio in questa sessione.',
			'templates.detail.superset' => 'Superserie',
			'templates.detail.setsCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n, one: '${n} serie', other: '${n} serie', ), 
			'templates.detail.seconds' => ({required Object n}) => '${n} s',
			'templates.detail.tempo' => ({required Object value}) => 'Tempo ${value}',
			'templates.detail.rest' => ({required Object n}) => 'Riposo ${n}s',
			'templates.detail.start' => 'Avvia la sessione',
			'templates.editor.newTitle' => 'Nuova sessione',
			'templates.editor.editTitle' => 'Modifica sessione',
			'templates.editor.exercisesHeader' => ({required Object count}) => 'ESERCIZI (${count})',
			'templates.editor.addExercise' => 'Aggiungi un esercizio',
			'templates.editor.save' => 'Salva sessione',
			'templates.editor.validationError' => 'Inserisci un nome e almeno un esercizio con nome.',
			'templates.fields.name' => 'Nome della sessione',
			'templates.fields.nameHint' => 'es.: Petto / Tricipiti / Spalle',
			'templates.fields.description' => 'Descrizione (opzionale)',
			'templates.fields.descriptionHint' => 'Descrivi la tua sessione…',
			'templates.fields.emoji' => 'Immagine',
			'templates.fields.exerciseName' => 'Nome dell’esercizio',
			'templates.fields.exerciseNameHint' => 'es.: Panca piana',
			'templates.fields.type' => 'Tipo',
			'templates.fields.sets' => 'Serie',
			'templates.fields.duration' => 'Durata (s)',
			'templates.fields.targetReps' => 'Rip. obiettivo',
			'templates.fields.rest' => 'Recupero (s)',
			'templates.fields.tempo' => 'Tempo',
			'templates.fields.tempoHint' => '3-1-X-0',
			'templates.fields.notes' => 'Note (opzionale)',
			'templates.fields.notesHint' => 'Consigli tecnici…',
			'templates.slot.newExercise' => 'Nuovo esercizio',
			'templates.slot.variantN' => ({required Object n}) => 'Variante ${n}',
			'templates.slot.primary' => 'PRINCIPALE',
			'templates.slot.variant' => 'Variante',
			'templates.slot.addVariant' => 'Aggiungi una variante',
			'templates.slot.supersetNote' => 'Concatenato in superserie con l’esercizio successivo',
			'templates.slot.supersetLabel' => 'SUPERSERIE',
			'templates.slot.reps' => 'Ripetizioni',
			'templates.slot.time' => 'Tempo',
			'templates.emojiPicker.title' => 'Immagine della sessione',
			'templates.emojiPicker.searchHint' => 'Cerca un emoji…',
			'templates.emojiPicker.noResults' => 'Nessun emoji corrisponde.',
			'templates.emojiPicker.change' => 'Cambia',
			'templates.programs.newSession' => 'Una sessione',
			'templates.programs.newProgram' => 'Un programma',
			'templates.programs.nameTitleNew' => 'Nuovo programma',
			'templates.programs.nameTitleRename' => 'Rinomina il programma',
			'templates.programs.nameHint' => 'PPL, Full body, Vacanze…',
			'templates.programs.createAction' => 'Crea il programma',
			'templates.programs.sessionCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n, one: '${n} sessione', other: '${n} sessioni', ), 
			'templates.programs.active' => 'Attivo',
			'templates.programs.empty' => 'Vuoto',
			'templates.programs.sessionInactive' => 'Disattivata',
			'templates.programs.emptyTitle' => 'Nessuna sessione',
			'templates.programs.emptyMessage' => 'Aggiungi le sessioni che compongono questo programma.',
			'templates.programs.switchOn' => 'Programma attivo',
			'templates.programs.switchOff' => 'Attiva questo programma',
			'templates.programs.switchHint' => 'Le sue sessioni alimentano la tua home. Gli altri programmi vengono disattivati.',
			'templates.programs.addSession' => 'Aggiungi una sessione',
			'templates.programs.addSessionTitle' => ({required Object name}) => 'Aggiungi a ${name}',
			'templates.programs.createSession' => 'Crea una nuova sessione',
			'templates.programs.loose' => 'Senza programma',
			'templates.programs.moveTitle' => 'Sposta in',
			'templates.programs.start' => 'Inizia',
			'templates.programs.move' => 'Sposta',
			'templates.programs.duplicate' => 'Duplica',
			'templates.programs.rename' => 'Rinomina',
			'templates.programs.dragHint' => 'Tieni premuta una sessione per trascinarla in un programma.',
			'templates.programs.deleteProgramTitle' => ({required Object name}) => 'Eliminare «${name}»?',
			'templates.programs.deleteProgramMessage' => 'Le sue sessioni vengono conservate, senza programma.',
			'templates.programs.deleteSessionTitle' => ({required Object name}) => 'Eliminare «${name}»?',
			'templates.programs.deleteSessionMessage' => 'La sessione viene eliminata definitivamente. La tua cronologia resta.',
			'templates.programs.moved' => ({required Object name}) => 'Spostata in ${name}.',
			'templates.programs.movedOut' => 'Tolta dal suo programma.',
			'templates.programs.activated' => ({required Object name}) => '${name} è ora attivo.',
			'templates.programs.deactivated' => ({required Object name}) => '${name} è disattivato.',
			'templates.programs.programDeleted' => 'Programma eliminato.',
			'templates.programs.error' => 'Non ha funzionato. Riprova.',
			'tempo.helper' => 'Eccentrica — pausa — concentrica — pausa (in s)',
			'tempo.formatError' => 'Formato previsto: 3-1-X-0',
			_ => null,
		};
	}
}
