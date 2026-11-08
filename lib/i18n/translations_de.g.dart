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
class TranslationsDe extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsDe({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.de,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <de>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	late final TranslationsDe _root = this; // ignore: unused_field

	@override 
	TranslationsDe $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsDe(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$auth$de auth = _Translations$auth$de._(_root);
	@override late final _Translations$common$de common = _Translations$common$de._(_root);
	@override late final _Translations$contact$de contact = _Translations$contact$de._(_root);
	@override late final _Translations$dashboard$de dashboard = _Translations$dashboard$de._(_root);
	@override late final _Translations$emoji$de emoji = _Translations$emoji$de._(_root);
	@override late final _Translations$errors$de errors = _Translations$errors$de._(_root);
	@override late final _Translations$goals$de goals = _Translations$goals$de._(_root);
	@override late final _Translations$history$de history = _Translations$history$de._(_root);
	@override late final _Translations$legal$de legal = _Translations$legal$de._(_root);
	@override late final _Translations$muscleGroups$de muscleGroups = _Translations$muscleGroups$de._(_root);
	@override late final _Translations$nav$de nav = _Translations$nav$de._(_root);
	@override late final _Translations$profile$de profile = _Translations$profile$de._(_root);
	@override late final _Translations$session$de session = _Translations$session$de._(_root);
	@override late final _Translations$settings$de settings = _Translations$settings$de._(_root);
	@override late final _Translations$stats$de stats = _Translations$stats$de._(_root);
	@override late final _Translations$templates$de templates = _Translations$templates$de._(_root);
	@override late final _Translations$tempo$de tempo = _Translations$tempo$de._(_root);
}

// Path: auth
class _Translations$auth$de extends Translations$auth$en {
	_Translations$auth$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final _Translations$auth$fields$de fields = _Translations$auth$fields$de._(_root);
	@override String get backToLogin => 'Zurück zur Anmeldung';
	@override late final _Translations$auth$login$de login = _Translations$auth$login$de._(_root);
	@override late final _Translations$auth$signup$de signup = _Translations$auth$signup$de._(_root);
	@override late final _Translations$auth$onboarding$de onboarding = _Translations$auth$onboarding$de._(_root);
	@override late final _Translations$auth$verifyEmail$de verifyEmail = _Translations$auth$verifyEmail$de._(_root);
	@override late final _Translations$auth$forgotPassword$de forgotPassword = _Translations$auth$forgotPassword$de._(_root);
	@override late final _Translations$auth$updatePassword$de updatePassword = _Translations$auth$updatePassword$de._(_root);
	@override late final _Translations$auth$changePassword$de changePassword = _Translations$auth$changePassword$de._(_root);
	@override late final _Translations$auth$validators$de validators = _Translations$auth$validators$de._(_root);
}

// Path: common
class _Translations$common$de extends Translations$common$en {
	_Translations$common$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final _Translations$common$actions$de actions = _Translations$common$actions$de._(_root);
	@override String get all => 'Alle';
	@override String get unnamed => '(ohne Namen)';
	@override late final _Translations$common$units$de units = _Translations$common$units$de._(_root);
	@override late final _Translations$common$date$de date = _Translations$common$date$de._(_root);
	@override late final _Translations$common$language$de language = _Translations$common$language$de._(_root);
}

// Path: contact
class _Translations$contact$de extends Translations$contact$en {
	_Translations$contact$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final _Translations$contact$header$de header = _Translations$contact$header$de._(_root);
	@override late final _Translations$contact$sections$de sections = _Translations$contact$sections$de._(_root);
	@override late final _Translations$contact$fields$de fields = _Translations$contact$fields$de._(_root);
	@override String counter({required Object current, required Object max}) => '${current} / ${max}';
	@override String get submit => 'Senden';
	@override late final _Translations$contact$categories$de categories = _Translations$contact$categories$de._(_root);
	@override late final _Translations$contact$success$de success = _Translations$contact$success$de._(_root);
}

// Path: dashboard
class _Translations$dashboard$de extends Translations$dashboard$en {
	_Translations$dashboard$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final _Translations$dashboard$greeting$de greeting = _Translations$dashboard$greeting$de._(_root);
	@override String get defaultName => 'Athlet';
	@override String get seeAll => 'Alle ansehen';
	@override late final _Translations$dashboard$sections$de sections = _Translations$dashboard$sections$de._(_root);
	@override late final _Translations$dashboard$templates$de templates = _Translations$dashboard$templates$de._(_root);
	@override String exerciseCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Übung',
		other: '${n} Übungen',
	);
	@override late final _Translations$dashboard$hero$de hero = _Translations$dashboard$hero$de._(_root);
	@override late final _Translations$dashboard$recent$de recent = _Translations$dashboard$recent$de._(_root);
	@override late final _Translations$dashboard$inProgress$de inProgress = _Translations$dashboard$inProgress$de._(_root);
	@override late final _Translations$dashboard$stats$de stats = _Translations$dashboard$stats$de._(_root);
	@override String streakBadge({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Woche in Folge',
		other: '${n} Wochen in Folge',
	);
	@override late final _Translations$dashboard$consistency$de consistency = _Translations$dashboard$consistency$de._(_root);
}

// Path: emoji
class _Translations$emoji$de extends Translations$emoji$en {
	_Translations$emoji$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override Map<String, String> get groups => {
		'sport': 'Sport & Training',
		'body': 'Körper & Gesten',
		'energy': 'Energie & Symbole',
		'faces': 'Gesichter',
		'hearts': 'Herzen',
		'animals': 'Tiere',
		'food': 'Essen & Trinken',
		'nature': 'Natur & Wetter',
		'places': 'Orte & Reisen',
		'objects': 'Objekte & Werkzeuge',
	};
	@override Map<String, String> get labels => {
		'person-lifting-weights': 'Gewichtheber',
		'man-lifting-weights': 'Gewichtheber (Mann)',
		'woman-lifting-weights': 'Gewichtheberin',
		'flexed-biceps': 'Angespannter Bizeps',
		'boxing-glove': 'Boxhandschuh',
		'martial-arts-uniform': 'Kampfsportanzug',
		'person-wrestling': 'Ringer',
		'person-running': 'Läufer',
		'man-running': 'Laufender Mann',
		'woman-running': 'Laufende Frau',
		'running-shoe': 'Laufschuh',
		'running-shirt': 'Laufshirt',
		'hiking-boot': 'Wanderstiefel',
		'person-walking': 'Fußgänger',
		'person-climbing': 'Kletterer',
		'person-biking': 'Radfahrer',
		'person-mountain-biking': 'Mountainbiker',
		'bicycle': 'Fahrrad',
		'person-swimming': 'Schwimmer',
		'person-surfing': 'Surfer',
		'person-rowing-boat': 'Ruderer',
		'canoe': 'Kanu',
		'person-in-lotus-position': 'Lotussitz',
		'lotus': 'Lotus',
		'person-cartwheeling': 'Rad schlagen',
		'person-juggling': 'Jongleur',
		'person-bouncing-ball': 'Basketballspieler',
		'person-playing-handball': 'Handballspieler',
		'person-playing-water-polo': 'Wasserballspieler',
		'person-fencing': 'Fechter',
		'person-golfing': 'Golfer',
		'horse-racing': 'Pferderennen',
		'skier': 'Skifahrer',
		'snowboarder': 'Snowboarder',
		'ice-skate': 'Schlittschuh',
		'roller-skate': 'Rollschuh',
		'skateboard': 'Skateboard',
		'basketball': 'Basketball',
		'soccer-ball': 'Fußball',
		'american-football': 'American Football',
		'rugby-football': 'Rugbyball',
		'tennis': 'Tennis',
		'volleyball': 'Volleyball',
		'baseball': 'Baseball',
		'ping-pong': 'Tischtennis',
		'badminton': 'Badminton',
		'field-hockey': 'Feldhockey',
		'ice-hockey': 'Eishockey',
		'bowling': 'Bowling',
		'flying-disc': 'Frisbee',
		'bow-and-arrow': 'Pfeil und Bogen',
		'bullseye': 'Zielscheibe',
		'pool-8-ball': 'Billardkugel',
		'parachute': 'Fallschirm',
		'trophy': 'Pokal',
		'sports-medal': 'Sportmedaille',
		'1st-place-medal': 'Goldmedaille',
		'2nd-place-medal': 'Silbermedaille',
		'3rd-place-medal': 'Bronzemedaille',
		'military-medal': 'Militärmedaille',
		'chequered-flag': 'Zielflagge',
		'triangular-flag': 'Wimpel',
		'stadium': 'Stadion',
		'stopwatch': 'Stoppuhr',
		'timer-clock': 'Timer',
		'alarm-clock': 'Wecker',
		'hourglass-not-done': 'Sanduhr',
		'leg': 'Bein',
		'foot': 'Fuß',
		'anatomical-heart': 'Anatomisches Herz',
		'lungs': 'Lunge',
		'bone': 'Knochen',
		'brain': 'Gehirn',
		'footprints': 'Fußspuren',
		'eyes': 'Augen',
		'raised-fist': 'Erhobene Faust',
		'oncoming-fist': 'Faust von vorne',
		'left-facing-fist': 'Faust nach links',
		'right-facing-fist': 'Faust nach rechts',
		'thumbs-up': 'Daumen hoch',
		'clapping-hands': 'Klatschende Hände',
		'raising-hands': 'Erhobene Hände',
		'heart-hands': 'Herz-Hände',
		'handshake': 'Handschlag',
		'folded-hands': 'Gefaltete Hände',
		'victory-hand': 'Victory-Zeichen',
		'ok-hand': 'OK-Zeichen',
		'waving-hand': 'Winkende Hand',
		'pinched-fingers': 'Zusammengedrückte Finger',
		'sign-of-the-horns': 'Teufelsgruß',
		'call-me-hand': 'Ruf-mich-an-Hand',
		'crossed-fingers': 'Gekreuzte Finger',
		'love-you-gesture': 'Ich-liebe-dich-Geste',
		'sweat-droplets': 'Schweißtropfen',
		'zzz': 'Zzz',
		'person-standing': 'Stehende Person',
		'person-kneeling': 'Kniende Person',
		'fire': 'Feuer',
		'high-voltage': 'Blitz',
		'collision': 'Kollision',
		'dizzy': 'Schwindel',
		'sparkles': 'Funkeln',
		'star': 'Stern',
		'shooting-star': 'Sternschnuppe',
		'rocket': 'Rakete',
		'flying-saucer': 'Fliegende Untertasse',
		'hundred-points': 'Hundert Punkte',
		'check-mark-button': 'Grünes Häkchen',
		'battery': 'Batterie',
		'light-bulb': 'Glühbirne',
		'bomb': 'Bombe',
		'fireworks': 'Feuerwerk',
		'party-popper': 'Partytröte',
		'confetti-ball': 'Konfettiball',
		'mirror-ball': 'Discokugel',
		'crown': 'Krone',
		'gem-stone': 'Edelstein',
		'shield': 'Schild',
		'crossed-swords': 'Gekreuzte Schwerter',
		'infinity': 'Unendlich',
		'skull': 'Totenkopf',
		'skull-and-crossbones': 'Totenkopf mit Knochen',
		'ghost': 'Geist',
		'alien': 'Außerirdischer',
		'robot': 'Roboter',
		'pile-of-poo': 'Kackhaufen',
		'magic-wand': 'Zauberstab',
		'crystal-ball': 'Kristallkugel',
		'grinning-face': 'Grinsendes Gesicht',
		'grinning-face-with-big-eyes': 'Grinsen mit großen Augen',
		'grinning-face-with-smiling-eyes': 'Grinsen mit lachenden Augen',
		'beaming-face-with-smiling-eyes': 'Strahlendes Gesicht',
		'grinning-squinting-face': 'Lachen mit zusammengekniffenen Augen',
		'grinning-face-with-sweat': 'Grinsen mit Schweiß',
		'face-with-tears-of-joy': 'Freudentränen',
		'rolling-on-the-floor-laughing': 'Lachkrampf',
		'smiling-face-with-smiling-eyes': 'Lächeln mit lachenden Augen',
		'smiling-face-with-halo': 'Gesicht mit Heiligenschein',
		'smiling-face-with-hearts': 'Lächeln mit Herzen',
		'smiling-face-with-heart-eyes': 'Herzaugen',
		'star-struck': 'Sternaugen',
		'face-blowing-a-kiss': 'Kuss zuwerfen',
		'face-savoring-food': 'Genießendes Gesicht',
		'face-with-tongue': 'Gesicht mit Zunge',
		'winking-face': 'Zwinkern',
		'winking-face-with-tongue': 'Zwinkern mit Zunge',
		'zany-face': 'Verrücktes Gesicht',
		'money-mouth-face': 'Geldgesicht',
		'hugging-face': 'Umarmendes Gesicht',
		'face-with-hand-over-mouth': 'Hand vor dem Mund',
		'face-with-peeking-eye': 'Gesicht mit lugendem Auge',
		'shushing-face': 'Pssst-Gesicht',
		'thinking-face': 'Nachdenkliches Gesicht',
		'saluting-face': 'Salutierendes Gesicht',
		'zipper-mouth-face': 'Reißverschlussmund',
		'face-with-raised-eyebrow': 'Hochgezogene Augenbraue',
		'neutral-face': 'Neutrales Gesicht',
		'unamused-face': 'Unamüsiertes Gesicht',
		'smirking-face': 'Grinsendes Gesicht mit Augenaufschlag',
		'drooling-face': 'Sabberndes Gesicht',
		'sleeping-face': 'Schlafendes Gesicht',
		'face-with-medical-mask': 'Gesicht mit Mundschutz',
		'hot-face': 'Hitzegesicht',
		'cold-face': 'Frostgesicht',
		'woozy-face': 'Benommenes Gesicht',
		'face-with-spiral-eyes': 'Spiralaugen',
		'exploding-head': 'Explodierender Kopf',
		'cowboy-hat-face': 'Cowboyhut',
		'partying-face': 'Partygesicht',
		'disguised-face': 'Verkleidetes Gesicht',
		'smiling-face-with-sunglasses': 'Sonnenbrillengesicht',
		'nerd-face': 'Nerd-Gesicht',
		'face-with-monocle': 'Monokel',
		'slightly-smiling-face': 'Leichtes Lächeln',
		'upside-down-face': 'Umgedrehtes Gesicht',
		'melting-face': 'Schmelzendes Gesicht',
		'flushed-face': 'Errötetes Gesicht',
		'pleading-face': 'Flehendes Gesicht',
		'face-holding-back-tears': 'Tränen zurückhalten',
		'loudly-crying-face': 'Heulendes Gesicht',
		'face-screaming-in-fear': 'Angstschrei',
		'downcast-face-with-sweat': 'Bedrücktes Gesicht mit Schweiß',
		'weary-face': 'Erschöpftes Gesicht',
		'tired-face': 'Müdes Gesicht',
		'yawning-face': 'Gähnendes Gesicht',
		'face-with-steam-from-nose': 'Schnaubendes Gesicht',
		'angry-face': 'Wütendes Gesicht',
		'smiling-face-with-horns': 'Grinsender Teufel',
		'angry-face-with-horns': 'Wütender Teufel',
		'red-heart': 'Rotes Herz',
		'orange-heart': 'Oranges Herz',
		'yellow-heart': 'Gelbes Herz',
		'green-heart': 'Grünes Herz',
		'blue-heart': 'Blaues Herz',
		'purple-heart': 'Lila Herz',
		'black-heart': 'Schwarzes Herz',
		'white-heart': 'Weißes Herz',
		'pink-heart': 'Rosa Herz',
		'sparkling-heart': 'Funkelndes Herz',
		'growing-heart': 'Wachsendes Herz',
		'beating-heart': 'Schlagendes Herz',
		'revolving-hearts': 'Kreisende Herzen',
		'two-hearts': 'Zwei Herzen',
		'heart-on-fire': 'Brennendes Herz',
		'mending-heart': 'Heilendes Herz',
		'broken-heart': 'Gebrochenes Herz',
		'heart-with-arrow': 'Herz mit Pfeil',
		'heart-with-ribbon': 'Herz mit Schleife',
		'gorilla': 'Gorilla',
		'lion': 'Löwe',
		'tiger': 'Tiger',
		'leopard': 'Leopard',
		'bear': 'Bär',
		'polar-bear': 'Eisbär',
		'ox': 'Ochse',
		'water-buffalo': 'Wasserbüffel',
		'bison': 'Bison',
		'cow': 'Kuh',
		'rhinoceros': 'Nashorn',
		'elephant': 'Elefant',
		'hippopotamus': 'Nilpferd',
		'mammoth': 'Mammut',
		'horse': 'Pferd',
		'zebra': 'Zebra',
		'giraffe': 'Giraffe',
		'camel': 'Kamel',
		'deer': 'Hirsch',
		'ram': 'Widder',
		'goat': 'Ziege',
		'pig': 'Schwein',
		'wolf': 'Wolf',
		'fox': 'Fuchs',
		'dog': 'Hund',
		'cat': 'Katze',
		'black-cat': 'Schwarze Katze',
		'monkey': 'Affe',
		'see-no-evil-monkey': 'Nichts-sehen-Affe',
		'kangaroo': 'Känguru',
		'rabbit': 'Hase',
		'hedgehog': 'Igel',
		'koala': 'Koala',
		'panda': 'Panda',
		'sloth': 'Faultier',
		'otter': 'Otter',
		'seal': 'Robbe',
		'bat': 'Fledermaus',
		'eagle': 'Adler',
		'owl': 'Eule',
		'rooster': 'Hahn',
		'chicken': 'Huhn',
		'baby-chick': 'Küken',
		'duck': 'Ente',
		'swan': 'Schwan',
		'flamingo': 'Flamingo',
		'peacock': 'Pfau',
		'parrot': 'Papagei',
		'dove': 'Taube',
		'penguin': 'Pinguin',
		'shark': 'Hai',
		'whale': 'Wal',
		'dolphin': 'Delfin',
		'octopus': 'Oktopus',
		'fish': 'Fisch',
		'tropical-fish': 'Tropenfisch',
		'crab': 'Krabbe',
		'lobster': 'Hummer',
		'shrimp': 'Garnele',
		'turtle': 'Schildkröte',
		'crocodile': 'Krokodil',
		'snake': 'Schlange',
		'frog': 'Frosch',
		't-rex': 'T-Rex',
		'sauropod': 'Sauropode',
		'dragon': 'Drache',
		'unicorn': 'Einhorn',
		'butterfly': 'Schmetterling',
		'honeybee': 'Biene',
		'scorpion': 'Skorpion',
		'cut-of-meat': 'Steak',
		'meat-on-bone': 'Fleischhaxe',
		'poultry-leg': 'Hähnchenschenkel',
		'bacon': 'Speck',
		'egg': 'Ei',
		'cooked-rice': 'Gekochter Reis',
		'steaming-bowl': 'Dampfende Schüssel',
		'green-salad': 'Grüner Salat',
		'broccoli': 'Brokkoli',
		'avocado': 'Avocado',
		'banana': 'Banane',
		'red-apple': 'Roter Apfel',
		'green-apple': 'Grüner Apfel',
		'pear': 'Birne',
		'peach': 'Pfirsich',
		'cherries': 'Kirschen',
		'strawberry': 'Erdbeere',
		'blueberries': 'Blaubeeren',
		'grapes': 'Weintrauben',
		'watermelon': 'Wassermelone',
		'pineapple': 'Ananas',
		'mango': 'Mango',
		'kiwi-fruit': 'Kiwi',
		'lemon': 'Zitrone',
		'coconut': 'Kokosnuss',
		'carrot': 'Karotte',
		'potato': 'Kartoffel',
		'tomato': 'Tomate',
		'bell-pepper': 'Paprika',
		'hot-pepper': 'Chili',
		'eggplant': 'Aubergine',
		'bread': 'Brot',
		'croissant': 'Croissant',
		'glass-of-milk': 'Glas Milch',
		'hot-beverage': 'Kaffee',
		'honey-pot': 'Honigtopf',
		'chocolate-bar': 'Schokolade',
		'cookie': 'Keks',
		'doughnut': 'Donut',
		'ice-cream': 'Eis',
		'birthday-cake': 'Geburtstagskuchen',
		'pancakes': 'Pfannkuchen',
		'popcorn': 'Popcorn',
		'lollipop': 'Lutscher',
		'pizza': 'Pizza',
		'hamburger': 'Burger',
		'french-fries': 'Pommes',
		'taco': 'Taco',
		'sushi': 'Sushi',
		'fork-and-knife': 'Besteck',
		'bottle-with-popping-cork': 'Sektflasche',
		'clinking-glasses': 'Anstoßende Gläser',
		'wine-glass': 'Weinglas',
		'beer-mug': 'Bierkrug',
		'tropical-drink': 'Tropischer Cocktail',
		'sun': 'Sonne',
		'sun-with-face': 'Sonne mit Gesicht',
		'sunrise': 'Sonnenaufgang',
		'sunrise-over-mountains': 'Sonnenaufgang über Bergen',
		'sunset': 'Sonnenuntergang',
		'cloud': 'Wolke',
		'cloud-with-rain': 'Regenwolke',
		'cloud-with-lightning': 'Gewitterwolke',
		'cloud-with-lightning-and-rain': 'Gewitter mit Regen',
		'snowflake': 'Schneeflocke',
		'rainbow': 'Regenbogen',
		'crescent-moon': 'Mondsichel',
		'full-moon': 'Vollmond',
		'night-with-stars': 'Sternennacht',
		'milky-way': 'Milchstraße',
		'mountain': 'Berg',
		'snow-capped-mountain': 'Schneebedeckter Berg',
		'volcano': 'Vulkan',
		'desert-island': 'Einsame Insel',
		'beach-with-umbrella': 'Strand mit Sonnenschirm',
		'water-wave': 'Welle',
		'droplet': 'Tropfen',
		'tornado': 'Tornado',
		'palm-tree': 'Palme',
		'cactus': 'Kaktus',
		'seedling': 'Sämling',
		'four-leaf-clover': 'Vierblättriges Kleeblatt',
		'sunflower': 'Sonnenblume',
		'rose': 'Rose',
		'tulip': 'Tulpe',
		'cherry-blossom': 'Kirschblüte',
		'maple-leaf': 'Ahornblatt',
		'globe-showing-europe-africa': 'Globus',
		'globe-with-meridians': 'Globus mit Meridianen',
		'house': 'Haus',
		'cityscape': 'Stadt',
		'tent': 'Zelt',
		'hot-springs': 'Heiße Quelle',
		'world-map': 'Weltkarte',
		'compass': 'Kompass',
		'airplane': 'Flugzeug',
		'automobile': 'Auto',
		'racing-car': 'Rennwagen',
		'motorcycle': 'Motorrad',
		'sailboat': 'Segelboot',
		'gear': 'Zahnrad',
		'hammer': 'Hammer',
		'wrench': 'Schraubenschlüssel',
		'hammer-and-wrench': 'Hammer und Schraubenschlüssel',
		'brick': 'Ziegelstein',
		'puzzle-piece': 'Puzzleteil',
		'game-die': 'Würfel',
		'joystick': 'Joystick',
		'video-game': 'Gamecontroller',
		'headphone': 'Kopfhörer',
		'musical-note': 'Musiknote',
		'musical-notes': 'Musiknoten',
		'guitar': 'Gitarre',
		'calendar': 'Kalender',
		'mobile-phone': 'Smartphone',
		'laptop': 'Laptop',
		'clipboard': 'Klemmbrett',
		'memo': 'Notiz',
		'pencil': 'Bleistift',
		'chart-increasing': 'Steigender Graph',
		'bar-chart': 'Balkendiagramm',
		'balance-scale': 'Waage',
		'books': 'Bücher',
		'open-book': 'Offenes Buch',
		'graduation-cap': 'Doktorhut',
		'money-bag': 'Geldsack',
		'coin': 'Münze',
		'locked': 'Geschlossenes Schloss',
		'unlocked': 'Offenes Schloss',
		'key': 'Schlüssel',
		'dna': 'DNA',
		'pill': 'Pille',
		'stethoscope': 'Stethoskop',
		'adhesive-bandage': 'Pflaster',
		'speech-balloon': 'Sprechblase',
		'thought-balloon': 'Gedankenblase',
	};
}

// Path: errors
class _Translations$errors$de extends Translations$errors$en {
	_Translations$errors$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get network => 'Keine Netzwerkverbindung. Überprüfe deine Verbindung.';
	@override String get notFound => 'Element nicht gefunden.';
	@override String get generic => 'Ein Fehler ist aufgetreten. Versuche es erneut.';
	@override String get invalidCode => 'Ungültiger oder abgelaufener Code.';
	@override String get passwordSameAsOld => 'Das neue Passwort muss sich vom alten unterscheiden.';
	@override late final _Translations$errors$auth$de auth = _Translations$errors$auth$de._(_root);
}

// Path: goals
class _Translations$goals$de extends Translations$goals$en {
	_Translations$goals$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get strength => 'Kraft';
	@override String get hypertrophy => 'Hypertrophie';
	@override String get endurance => 'Ausdauer';
	@override String get weightLoss => 'Gewichtsverlust';
	@override String get maintenance => 'Erhaltung';
}

// Path: history
class _Translations$history$de extends Translations$history$en {
	_Translations$history$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Verlauf';
	@override String get emptySubtitle => 'Keine Einheiten';
	@override String get emptyTitle => 'Noch keine Einheiten';
	@override String get emptyMessage => 'Starte deine erste Einheit über den Startbildschirm — sie erscheint dann hier.';
	@override String sessionCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Einheit',
		other: '${n} Einheiten',
	);
	@override String get deleteError => 'Löschen fehlgeschlagen.';
	@override String get noResult => 'Keine Einheiten für diese Gruppe';
	@override late final _Translations$history$groups$de groups = _Translations$history$groups$de._(_root);
	@override late final _Translations$history$panel$de panel = _Translations$history$panel$de._(_root);
	@override late final _Translations$history$detail$de detail = _Translations$history$detail$de._(_root);
}

// Path: legal
class _Translations$legal$de extends Translations$legal$en {
	_Translations$legal$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get onlyInEnglish => 'Dieses Dokument ist nur auf Englisch verfügbar.';
}

// Path: muscleGroups
class _Translations$muscleGroups$de extends Translations$muscleGroups$en {
	_Translations$muscleGroups$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get chest => 'Brust';
	@override String get back => 'Rücken';
	@override String get shoulders => 'Schultern';
	@override String get biceps => 'Bizeps';
	@override String get triceps => 'Trizeps';
	@override String get forearms => 'Unterarme';
	@override String get quads => 'Quadrizeps';
	@override String get hamstrings => 'Beinbeuger';
	@override String get glutes => 'Gesäß';
	@override String get calves => 'Waden';
	@override String get abs => 'Bauch';
	@override String get custom => 'Andere';
	@override late final _Translations$muscleGroups$sections$de sections = _Translations$muscleGroups$sections$de._(_root);
}

// Path: nav
class _Translations$nav$de extends Translations$nav$en {
	_Translations$nav$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get home => 'Start';
	@override String get program => 'Programm';
	@override String get history => 'Verlauf';
	@override String get stats => 'Statistik';
	@override String get settings => 'Einstellungen';
}

// Path: profile
class _Translations$profile$de extends Translations$profile$en {
	_Translations$profile$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get notConnected => 'Nicht angemeldet.';
	@override String get navTitle => 'PROFIL';
	@override String get defaultName => 'Athlet';
	@override String since({required Object month}) => 'Seit ${month}';
	@override late final _Translations$profile$editSheet$de editSheet = _Translations$profile$editSheet$de._(_root);
	@override late final _Translations$profile$sections$de sections = _Translations$profile$sections$de._(_root);
	@override late final _Translations$profile$stats$de stats = _Translations$profile$stats$de._(_root);
	@override String sessionCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Einheit',
		other: '${n} Einheiten',
	);
	@override late final _Translations$profile$badges$de badges = _Translations$profile$badges$de._(_root);
	@override late final _Translations$profile$avatar$de avatar = _Translations$profile$avatar$de._(_root);
	@override late final _Translations$profile$editForm$de editForm = _Translations$profile$editForm$de._(_root);
}

// Path: session
class _Translations$session$de extends Translations$session$en {
	_Translations$session$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get bw => 'KG';
	@override String get continueLabel => 'Weiter';
	@override late final _Translations$session$error$de error = _Translations$session$error$de._(_root);
	@override late final _Translations$session$live$de live = _Translations$session$live$de._(_root);
	@override late final _Translations$session$confirm$de confirm = _Translations$session$confirm$de._(_root);
	@override late final _Translations$session$add$de add = _Translations$session$add$de._(_root);
	@override late final _Translations$session$swap$de swap = _Translations$session$swap$de._(_root);
	@override late final _Translations$session$variants$de variants = _Translations$session$variants$de._(_root);
	@override late final _Translations$session$finish$de finish = _Translations$session$finish$de._(_root);
	@override late final _Translations$session$timer$de timer = _Translations$session$timer$de._(_root);
	@override late final _Translations$session$rest$de rest = _Translations$session$rest$de._(_root);
	@override late final _Translations$session$set$de set = _Translations$session$set$de._(_root);
	@override late final _Translations$session$exercise$de exercise = _Translations$session$exercise$de._(_root);
	@override late final _Translations$session$overview$de overview = _Translations$session$overview$de._(_root);
	@override late final _Translations$session$superset$de superset = _Translations$session$superset$de._(_root);
	@override late final _Translations$session$duration$de duration = _Translations$session$duration$de._(_root);
	@override late final _Translations$session$weight$de weight = _Translations$session$weight$de._(_root);
	@override late final _Translations$session$search$de search = _Translations$session$search$de._(_root);
	@override late final _Translations$session$history$de history = _Translations$session$history$de._(_root);
	@override late final _Translations$session$fields$de fields = _Translations$session$fields$de._(_root);
	@override late final _Translations$session$toast$de toast = _Translations$session$toast$de._(_root);
	@override late final _Translations$session$notif$de notif = _Translations$session$notif$de._(_root);
}

// Path: settings
class _Translations$settings$de extends Translations$settings$en {
	_Translations$settings$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Einstellungen';
	@override late final _Translations$settings$sections$de sections = _Translations$settings$sections$de._(_root);
	@override String get defaultName => 'Athlet';
	@override String get editProfile => 'BEARBEITEN';
	@override String get profileUnavailable => 'Profil nicht verfügbar';
	@override late final _Translations$settings$rows$de rows = _Translations$settings$rows$de._(_root);
	@override String get soon => 'Bald';
	@override String get soonToast => 'Demnächst verfügbar';
	@override late final _Translations$settings$logout$de logout = _Translations$settings$logout$de._(_root);
	@override String get version => 'Repster v1.0 · Trainiere, wachse, wiederhole.';
	@override late final _Translations$settings$language$de language = _Translations$settings$language$de._(_root);
}

// Path: stats
class _Translations$stats$de extends Translations$stats$en {
	_Translations$stats$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Statistiken';
	@override String sessionsCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Einheit',
		other: '${n} Einheiten',
	);
	@override String weeksShort({required Object n}) => '${n} Wo.';
	@override late final _Translations$stats$subtitle$de subtitle = _Translations$stats$subtitle$de._(_root);
	@override late final _Translations$stats$empty$de empty = _Translations$stats$empty$de._(_root);
	@override late final _Translations$stats$range$de range = _Translations$stats$range$de._(_root);
	@override late final _Translations$stats$kpi$de kpi = _Translations$stats$kpi$de._(_root);
	@override late final _Translations$stats$weeklyVolume$de weeklyVolume = _Translations$stats$weeklyVolume$de._(_root);
	@override late final _Translations$stats$exercise$de exercise = _Translations$stats$exercise$de._(_root);
	@override late final _Translations$stats$muscleBalance$de muscleBalance = _Translations$stats$muscleBalance$de._(_root);
	@override late final _Translations$stats$records$de records = _Translations$stats$records$de._(_root);
	@override late final _Translations$stats$strength$de strength = _Translations$stats$strength$de._(_root);
}

// Path: templates
class _Translations$templates$de extends Translations$templates$en {
	_Translations$templates$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final _Translations$templates$list$de list = _Translations$templates$list$de._(_root);
	@override late final _Translations$templates$card$de card = _Translations$templates$card$de._(_root);
	@override late final _Translations$templates$detail$de detail = _Translations$templates$detail$de._(_root);
	@override late final _Translations$templates$editor$de editor = _Translations$templates$editor$de._(_root);
	@override late final _Translations$templates$fields$de fields = _Translations$templates$fields$de._(_root);
	@override late final _Translations$templates$slot$de slot = _Translations$templates$slot$de._(_root);
	@override late final _Translations$templates$emojiPicker$de emojiPicker = _Translations$templates$emojiPicker$de._(_root);
}

// Path: tempo
class _Translations$tempo$de extends Translations$tempo$en {
	_Translations$tempo$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get helper => 'Exzentrisch — Pause — konzentrisch — Pause (in s)';
	@override String get formatError => 'Erwartetes Format: 3-1-X-0';
}

// Path: auth.fields
class _Translations$auth$fields$de extends Translations$auth$fields$en {
	_Translations$auth$fields$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get email => 'E-Mail-Adresse';
	@override String get password => 'Passwort';
}

// Path: auth.login
class _Translations$auth$login$de extends Translations$auth$login$en {
	_Translations$auth$login$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get welcomeTitle => 'Schön, dich wiederzusehen';
	@override String get welcomeSubtitle => 'Melde dich an, um fortzufahren.';
	@override String get forgotPassword => 'Passwort vergessen?';
	@override String get submit => 'Anmelden';
	@override String get submitLoading => 'Anmeldung…';
	@override String get noAccount => 'Noch kein Konto?';
	@override String get createAccount => 'Konto erstellen';
}

// Path: auth.signup
class _Translations$auth$signup$de extends Translations$auth$signup$en {
	_Translations$auth$signup$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Konto erstellen';
	@override String get subtitle => 'Schließe dich Tausenden von Athleten an.';
	@override String get passwordHint => 'Passwort (mind. 8 Zeichen)';
	@override String get submit => 'Mein Konto erstellen';
	@override String get submitLoading => 'Wird erstellt…';
	@override String get termsPrefix => 'Mit der Erstellung eines Kontos akzeptierst du unsere ';
	@override String get termsLink => 'Nutzungsbedingungen';
}

// Path: auth.onboarding
class _Translations$auth$onboarding$de extends Translations$auth$onboarding$en {
	_Translations$auth$onboarding$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get step1Title => 'Wie heißt\ndu?';
	@override String get step1Subtitle => 'Um dein Erlebnis zu personalisieren.';
	@override String get nameHint => 'Dein Vorname';
	@override String get continueLabel => 'Weiter';
	@override String get step2Title => 'Was ist dein\nZiel?';
	@override String get step2Subtitle => 'Wir passen deine Einheiten entsprechend an.';
	@override String get step3Title => 'Ein paar Infos';
	@override String get optional => 'Optional';
	@override String get step3Subtitle => 'Für genauere Empfehlungen.';
	@override String get weightHint => 'Gewicht (kg)';
	@override String get heightHint => 'Größe (cm)';
	@override String get birthdate => 'Geburtsdatum';
	@override String get submit => 'Los geht\'s!';
	@override String get submitLoading => 'Wird gespeichert…';
	@override String get skip => 'Diesen Schritt überspringen';
	@override late final _Translations$auth$onboarding$goalDescriptions$de goalDescriptions = _Translations$auth$onboarding$goalDescriptions$de._(_root);
	@override String get nameRequired => 'Dein Vorname ist erforderlich.';
	@override String get nameTooLong => 'Vorname zu lang.';
	@override String get goalRequired => 'Wähle ein Ziel.';
	@override String get weightInvalid => 'Ungültiges Gewicht';
	@override String get heightInvalid => 'Ungültige Größe';
}

// Path: auth.verifyEmail
class _Translations$auth$verifyEmail$de extends Translations$auth$verifyEmail$en {
	_Translations$auth$verifyEmail$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Bestätige deine E-Mail';
	@override String get subtitle => 'Wir haben einen 6-stelligen Code gesendet';
	@override String get submitLoading => 'Wird überprüft…';
	@override String get submitComplete => 'Code bestätigen';
	@override String get submitIncomplete => 'Gib den erhaltenen Code ein';
	@override String get noCode => 'Keinen Code erhalten?';
	@override String get resent => 'Code erneut gesendet!';
	@override String resendCooldown({required Object n}) => 'Erneut senden in ${n}s';
	@override String get resending => 'Wird gesendet…';
	@override String get resend => 'Code erneut senden';
	@override String get emailMissing => 'E-Mail fehlt. Kehre zur Registrierung zurück.';
}

// Path: auth.forgotPassword
class _Translations$auth$forgotPassword$de extends Translations$auth$forgotPassword$en {
	_Translations$auth$forgotPassword$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Passwort vergessen';
	@override String get subtitle => 'Wir senden dir einen Link zum Zurücksetzen';
	@override String get submit => 'Link senden';
	@override String get submitLoading => 'Wird gesendet…';
	@override String get successMessage => 'Ein Link zum Zurücksetzen wurde an deine E-Mail-Adresse gesendet. Prüfe deinen Posteingang.';
}

// Path: auth.updatePassword
class _Translations$auth$updatePassword$de extends Translations$auth$updatePassword$en {
	_Translations$auth$updatePassword$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Neues Passwort';
	@override String get subtitle => 'Wähle ein sicheres Passwort';
	@override String get newHint => 'Neues Passwort';
	@override String get confirmHint => 'Passwort bestätigen';
	@override String get submit => 'Passwort speichern';
	@override String get submitLoading => 'Wird gespeichert…';
}

// Path: auth.changePassword
class _Translations$auth$changePassword$de extends Translations$auth$changePassword$en {
	_Translations$auth$changePassword$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Passwort ändern';
	@override String get subtitle => 'Bestätige zu deiner Sicherheit dein aktuelles Passwort, bevor du ein neues wählst.';
	@override String get currentHint => 'Aktuelles Passwort';
	@override String get newHint => 'Neues Passwort';
	@override String get confirmHint => 'Neues Passwort bestätigen';
	@override String get submit => 'Passwort aktualisieren';
	@override String get submitLoading => 'Wird aktualisiert…';
	@override String get successToast => 'Passwort aktualisiert';
	@override String get currentRequired => 'Aktuelles Passwort erforderlich';
	@override String get mustDiffer => 'Das neue Passwort muss sich vom aktuellen unterscheiden';
	@override String get currentIncorrect => 'Aktuelles Passwort falsch';
}

// Path: auth.validators
class _Translations$auth$validators$de extends Translations$auth$validators$en {
	_Translations$auth$validators$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get emailRequired => 'E-Mail erforderlich';
	@override String get emailInvalid => 'Ungültige E-Mail';
	@override String get passwordRequired => 'Passwort erforderlich';
	@override String get passwordMin => 'Mindestens 8 Zeichen';
	@override String get passwordMismatch => 'Die Passwörter stimmen nicht überein';
}

// Path: common.actions
class _Translations$common$actions$de extends Translations$common$actions$en {
	_Translations$common$actions$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get cancel => 'Abbrechen';
	@override String get confirm => 'Bestätigen';
	@override String get save => 'Speichern';
	@override String get retry => 'Erneut versuchen';
	@override String get delete => 'Löschen';
	@override String get close => 'Schließen';
	@override String get edit => 'Bearbeiten';
	@override String get done => 'Fertig';
	@override String get next => 'Weiter';
	@override String get back => 'Zurück';
}

// Path: common.units
class _Translations$common$units$de extends Translations$common$units$en {
	_Translations$common$units$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get reps => 'Wdh.';
}

// Path: common.date
class _Translations$common$date$de extends Translations$common$date$en {
	_Translations$common$date$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get justNow => 'gerade eben';
	@override String minutesAgo({required Object n}) => 'vor ${n} Min.';
	@override String hoursAgo({required Object n}) => 'vor ${n} Std.';
	@override String get yesterday => 'gestern';
	@override String daysAgo({required Object n}) => 'vor ${n} T.';
	@override String get today => 'heute';
	@override String weeksAgo({required Object n}) => 'vor ${n} Wo.';
	@override String monthsAgo({required Object n}) => 'vor ${n} Mon.';
}

// Path: common.language
class _Translations$common$language$de extends Translations$common$language$en {
	_Translations$common$language$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get en => 'Englisch';
	@override String get fr => 'Französisch';
	@override String get es => 'Spanisch';
	@override String get de => 'Deutsch';
	@override String get it => 'Italienisch';
}

// Path: contact.header
class _Translations$contact$header$de extends Translations$contact$header$en {
	_Translations$contact$header$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Kontakt & Feedback';
	@override String get subtitle => 'Ein Bug, eine Idee, eine Frage? Schreib uns, wir lesen alles.';
}

// Path: contact.sections
class _Translations$contact$sections$de extends Translations$contact$sections$en {
	_Translations$contact$sections$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get type => 'Art der Anfrage';
	@override String get yourInfo => 'Deine Angaben';
	@override String get message => 'Nachricht';
}

// Path: contact.fields
class _Translations$contact$fields$de extends Translations$contact$fields$en {
	_Translations$contact$fields$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get nameHint => 'Dein Vorname';
	@override String get nameRequired => 'Name erforderlich';
	@override String get emailHint => 'Deine E-Mail-Adresse';
	@override String get emailInvalid => 'Ungültige E-Mail';
	@override String get messageTooShort => 'Nachricht zu kurz (mind. 10 Zeichen)';
}

// Path: contact.categories
class _Translations$contact$categories$de extends Translations$contact$categories$en {
	_Translations$contact$categories$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final _Translations$contact$categories$bug$de bug = _Translations$contact$categories$bug$de._(_root);
	@override late final _Translations$contact$categories$feature$de feature = _Translations$contact$categories$feature$de._(_root);
	@override late final _Translations$contact$categories$general$de general = _Translations$contact$categories$general$de._(_root);
	@override late final _Translations$contact$categories$other$de other = _Translations$contact$categories$other$de._(_root);
}

// Path: contact.success
class _Translations$contact$success$de extends Translations$contact$success$en {
	_Translations$contact$success$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Nachricht gesendet';
	@override String get back => 'Zurück zu den Einstellungen';
}

// Path: dashboard.greeting
class _Translations$dashboard$greeting$de extends Translations$dashboard$greeting$en {
	_Translations$dashboard$greeting$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get morning => 'Guten Morgen';
	@override String get afternoon => 'Guten Tag';
	@override String get evening => 'Guten Abend';
}

// Path: dashboard.sections
class _Translations$dashboard$sections$de extends Translations$dashboard$sections$en {
	_Translations$dashboard$sections$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get templates => 'Vorlagen';
	@override String get recentSessions => 'Letzte Einheiten';
}

// Path: dashboard.templates
class _Translations$dashboard$templates$de extends Translations$dashboard$templates$en {
	_Translations$dashboard$templates$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get empty => 'Noch keine Vorlagen';
	@override String get newLabel => 'Neu';
}

// Path: dashboard.hero
class _Translations$dashboard$hero$de extends Translations$dashboard$hero$en {
	_Translations$dashboard$hero$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get eyebrow => 'NÄCHSTE EINHEIT';
	@override String get start => 'Einheit starten';
	@override String get emptyTitle => 'Erstelle deine erste Vorlage';
	@override String get emptyMessage => 'Richte deine Übungen ein und los geht’s.';
	@override String get create => 'Vorlage erstellen';
	@override String duration({required Object n}) => '≈ ${n} Min';
}

// Path: dashboard.recent
class _Translations$dashboard$recent$de extends Translations$dashboard$recent$en {
	_Translations$dashboard$recent$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get emptyTitle => 'Starte deine erste Einheit!';
	@override String get emptyMessage => 'Wähle eine Vorlage und los geht’s.';
	@override String get tonnage => 'Tonnage';
}

// Path: dashboard.inProgress
class _Translations$dashboard$inProgress$de extends Translations$dashboard$inProgress$en {
	_Translations$dashboard$inProgress$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get label => 'EINHEIT LÄUFT';
	@override String startedAt({required Object when}) => 'Gestartet ${when}';
	@override String get resume => 'Fortsetzen';
	@override String get discard => 'Verwerfen';
	@override String get discardTitle => 'Einheit verwerfen?';
	@override String get discardMessage => 'Alle aktuellen Eingaben gehen verloren.';
	@override String get discardError => 'Fehlgeschlagen — versuch es erneut.';
}

// Path: dashboard.stats
class _Translations$dashboard$stats$de extends Translations$dashboard$stats$en {
	_Translations$dashboard$stats$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get sessions => 'Einheiten';
	@override String get volume => 'Volumen';
	@override String get streak => 'Serie';
	@override String get thisWeek => 'diese Wo.';
	@override String weekCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: 'Woche',
		other: 'Wochen',
	);
	@override String streakLabel({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: 'Woche\nin Folge',
		other: 'Wochen\nin Folge',
	);
	@override String get sessionsWeek => 'Einheiten\ndiese Woche';
	@override String get volumeWeek => 'Volumen\ndiese Woche';
}

// Path: dashboard.consistency
class _Translations$dashboard$consistency$de extends Translations$dashboard$consistency$en {
	_Translations$dashboard$consistency$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Beständigkeit';
	@override String get trainingDays => 'aktive Tage';
	@override String get perWeek => 'Einheiten / Wo.';
	@override String get bestStreak => 'beste Serie';
	@override String get noStreak => 'keine Serie';
	@override String weeksShort({required Object n}) => '${n} Wo.';
	@override String get notYet => 'Dein Trainingsrhythmus erscheint hier nach der ersten Einheit.';
}

// Path: errors.auth
class _Translations$errors$auth$de extends Translations$errors$auth$en {
	_Translations$errors$auth$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get invalidCredentials => 'E-Mail oder Passwort falsch.';
	@override String get emailNotConfirmed => 'Bestätige deine E-Mail vor der Anmeldung.';
	@override String get userAlreadyExists => 'Mit dieser E-Mail existiert bereits ein Konto.';
	@override String get sessionExpired => 'Sitzung abgelaufen. Melde dich erneut an.';
	@override String get notSignedIn => 'Du musst angemeldet sein.';
}

// Path: history.groups
class _Translations$history$groups$de extends Translations$history$groups$en {
	_Translations$history$groups$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get thisWeek => 'Diese Woche';
	@override String get lastWeek => 'Letzte Woche';
	@override String weeksAgo({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: 'vor ${n} Woche',
		other: 'vor ${n} Wochen',
	);
}

// Path: history.panel
class _Translations$history$panel$de extends Translations$history$panel$en {
	_Translations$history$panel$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get sessions => 'Einheiten';
	@override String get volume => 'Volumen';
	@override String get time => 'Zeit';
}

// Path: history.detail
class _Translations$history$detail$de extends Translations$history$detail$en {
	_Translations$history$detail$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Einheit';
	@override String get dateFormat => 'EEEE, d. MMMM \'um\' HH:mm';
	@override String get duration => 'Dauer';
	@override String get tonnage => 'Tonnage';
	@override String get sets => 'Sätze';
	@override String get notes => 'Notizen';
	@override String get perExercise => 'Details pro Übung';
	@override String setsCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Satz',
		other: '${n} Sätze',
	);
	@override String get bodyweight => 'Körpergewicht';
	@override String get colSet => 'Satz';
	@override String get colReps => 'Wdh.';
	@override String get colLoad => 'Last';
	@override String get colHeld => 'Gehalten';
	@override String get totalExercise => 'Übung gesamt';
	@override String get totalHeld => 'Gesamt gehalten';
	@override late final _Translations$history$detail$edit$de edit = _Translations$history$detail$edit$de._(_root);
}

// Path: muscleGroups.sections
class _Translations$muscleGroups$sections$de extends Translations$muscleGroups$sections$en {
	_Translations$muscleGroups$sections$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get chestBack => 'Brust & Rücken';
	@override String get shouldersArms => 'Schultern & Arme';
	@override String get legsGlutes => 'Beine & Gesäß';
	@override String get abs => 'Bauch';
	@override String get other => 'Andere';
}

// Path: profile.editSheet
class _Translations$profile$editSheet$de extends Translations$profile$editSheet$en {
	_Translations$profile$editSheet$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Profil bearbeiten';
}

// Path: profile.sections
class _Translations$profile$sections$de extends Translations$profile$sections$en {
	_Translations$profile$sections$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get favoriteMuscleGroup => 'Bevorzugte Muskelgruppe';
	@override String get badges => 'Abzeichen';
}

// Path: profile.stats
class _Translations$profile$stats$de extends Translations$profile$stats$en {
	_Translations$profile$stats$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get sessions => 'Einheiten';
	@override String get tonnage => 'Tonnage';
	@override String get sets => 'Sätze';
}

// Path: profile.badges
class _Translations$profile$badges$de extends Translations$profile$badges$en {
	_Translations$profile$badges$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get empty => 'Starte deine erste Einheit, um Abzeichen freizuschalten!';
	@override String get firstSession => 'Erste Einheit';
	@override String get tenSessions => '10 Einheiten';
	@override String get tenTonnes => '10 Tonnen';
	@override String get planner => 'Planer';
}

// Path: profile.avatar
class _Translations$profile$avatar$de extends Translations$profile$avatar$en {
	_Translations$profile$avatar$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get sheetTitle => 'Profilfoto';
	@override String get takePhoto => 'Foto aufnehmen';
	@override String get gallery => 'Fotogalerie';
	@override String get remove => 'Foto entfernen';
	@override String get openError => 'Das Foto konnte nicht geöffnet werden.';
	@override String get updated => 'Foto aktualisiert!';
	@override String get saveError => 'Das Foto konnte nicht gespeichert werden.';
	@override String get removed => 'Foto entfernt.';
	@override String get removeError => 'Das Foto konnte nicht entfernt werden.';
}

// Path: profile.editForm
class _Translations$profile$editForm$de extends Translations$profile$editForm$en {
	_Translations$profile$editForm$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get saved => 'Profil aktualisiert.';
	@override String get pickDate => 'Datum wählen';
	@override late final _Translations$profile$editForm$sections$de sections = _Translations$profile$editForm$sections$de._(_root);
	@override late final _Translations$profile$editForm$fields$de fields = _Translations$profile$editForm$fields$de._(_root);
	@override late final _Translations$profile$editForm$validation$de validation = _Translations$profile$editForm$validation$de._(_root);
}

// Path: session.error
class _Translations$session$error$de extends Translations$session$error$en {
	_Translations$session$error$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get startFailed => 'Training konnte nicht gestartet werden.';
	@override String get saveFailed => 'Speichern fehlgeschlagen.';
	@override String get templateUpdateFailed => 'Einheit gespeichert, aber die Vorlage konnte nicht aktualisiert werden.';
}

// Path: session.live
class _Translations$session$live$de extends Translations$session$live$en {
	_Translations$session$live$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String exercisePosition({required Object current, required Object total}) => 'Übung ${current} / ${total}';
	@override String supersetPosition({required Object current, required Object total}) => 'Supersatz ${current} / ${total}';
	@override String headerSubtitle({required Object completed, required Object total, required Object time}) => '${completed}/${total} Sätze · ${time}';
	@override String get totalTonnage => 'Gesamttonnage';
	@override String get nextExercise => 'Nächste Übung';
	@override String get nextBlock => 'Nächster Block';
	@override String get finishSession => 'Training beenden';
}

// Path: session.confirm
class _Translations$session$confirm$de extends Translations$session$confirm$en {
	_Translations$session$confirm$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get quitTitle => 'Training verwerfen?';
	@override String get quitMessage => 'Der gesamte Fortschritt geht verloren.';
	@override String get quitConfirm => 'Verwerfen';
	@override String get inProgressTitle => 'Ein Training läuft bereits';
	@override String inProgressMessage({required Object name, required Object date}) => '„${name}“ wurde ${date} gestartet. Ein neues zu starten löscht seinen Fortschritt endgültig.';
	@override String get overwriteAndStart => 'Überschreiben und starten';
	@override String deleteExerciseTitle({required Object name}) => '„${name}“ löschen?';
	@override String deleteExerciseMessage({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: 'Diese Übung hat bereits ${n} abgeschlossenen Satz. Er geht verloren.',
		other: 'Diese Übung hat bereits ${n} abgeschlossene Sätze. Sie gehen verloren.',
	);
	@override String get removeSessionOnly => 'Nur in dieser Einheit';
	@override String get removeFromTemplate => 'Auch aus der Vorlage';
}

// Path: session.add
class _Translations$session$add$de extends Translations$session$add$en {
	_Translations$session$add$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Übung hinzufügen';
	@override String get subtitle => 'Nur zu diesem Training hinzugefügt, ohne die Vorlage zu ändern.';
	@override String get addLabel => 'Hinzufügen';
	@override String get addToSession => 'Zum Training hinzufügen';
	@override String get reps => 'Wiederholungen';
	@override String get time => 'Zeit';
	@override String get addAndTemplate => 'Zur Einheit und zur Vorlage hinzufügen';
}

// Path: session.swap
class _Translations$session$swap$de extends Translations$session$swap$en {
	_Translations$session$swap$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Übung bearbeiten';
	@override String currently({required Object name}) => 'Aktuell: ${name}';
	@override String get sessionOnly => 'Diese Änderungen gelten nur für dieses Training.';
	@override String get useLabel => 'Verwenden';
	@override String get adoptFormat => 'Format übernehmen';
	@override String adoptFormatSummary({required Object summary, required Object name}) => '${summary} · nach „${name}“';
	@override String get apply => 'Für dieses Training anwenden';
	@override String get applyAndTemplate => 'Anwenden und Vorlage aktualisieren';
}

// Path: session.variants
class _Translations$session$variants$de extends Translations$session$variants$en {
	_Translations$session$variants$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Variante wählen';
	@override String get lockedMessage => 'Ein Satz ist bereits abgeschlossen — beende die Übung oder nutze „Tauschen“, um unterwegs anzupassen.';
	@override String get pickMessage => 'Wähle eine Variante für diesen Platz. Sie ersetzt die aktuelle Übung.';
	@override String get empty => 'Für diese Übung ist keine Variante definiert.';
	@override String get main => 'HAUPT';
	@override String variantN({required Object n}) => 'Variante ${n}';
	@override String restSeconds({required Object n}) => '${n}s Pause';
	@override String tempoPart({required Object tempo}) => ' · Tempo ${tempo}';
}

// Path: session.finish
class _Translations$session$finish$de extends Translations$session$finish$en {
	_Translations$session$finish$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Training beenden?';
	@override String summaryReps({required Object completed, required Object total}) => '${completed}/${total} Sätze · ';
	@override String get summaryTonnageSuffix => ' Tonnage';
	@override String get notesHint => 'Notizen zum Training (optional)…';
	@override String get confirm => 'Beenden';
	@override String unvalidatedSets({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} NICHT BESTÄTIGTER SATZ',
		other: '${n} NICHT BESTÄTIGTE SÄTZE',
	);
	@override String get incompleteHint => 'Du kannst zurückgehen und deine Sätze bestätigen oder trotzdem beenden — nur markierte Sätze werden gespeichert.';
	@override String get templateLabel => 'VORLAGE AKTUALISIEREN';
	@override String templateToggle({required Object name}) => '„${name}“ aktualisieren';
	@override String get templateHint => 'Die während der Einheit markierten Änderungen. Ausschalten, um die Vorlage unverändert zu lassen.';
	@override String changeAdded({required Object name}) => '${name} · hinzugefügt';
	@override String changeModified({required Object name}) => '${name} · geändert';
	@override String changeRemoved({required Object name}) => '${name} · entfernt';
}

// Path: session.timer
class _Translations$session$timer$de extends Translations$session$timer$en {
	_Translations$session$timer$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get preparation => 'BEREIT MACHEN';
	@override String get running => 'LÄUFT';
	@override String get done => 'FERTIG';
	@override String get go => 'LOS';
	@override String get stop => 'Stopp';
}

// Path: session.rest
class _Translations$session$rest$de extends Translations$session$rest$en {
	_Translations$session$rest$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'PAUSE';
	@override String get sec => 'SEK';
	@override String get skip => 'Überspringen';
	@override String get minimize => 'Verkleinern';
}

// Path: session.set
class _Translations$session$set$de extends Translations$session$set$en {
	_Translations$session$set$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get addSet => 'Satz hinzufügen';
	@override String setLabel({required Object n}) => 'Satz ${n}';
	@override String get reps => 'Wdh.';
	@override String get load => 'Gewicht';
	@override String get duration => 'Dauer';
	@override String get held => 'Gehalten';
	@override String get tonnage => 'TONNAGE';
	@override String targetReps({required Object n}) => 'Ziel ${n} Wdh.';
	@override String targetDuration({required Object value}) => 'Ziel ${value}';
	@override String get validateWithoutTimer => 'Ohne Timer bestätigen';
	@override String get cmpUp => 'Top';
}

// Path: session.exercise
class _Translations$session$exercise$de extends Translations$session$exercise$en {
	_Translations$session$exercise$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get timed => 'Auf Zeit';
	@override String tempoChip({required Object tempo}) => 'Tempo ${tempo}';
	@override String restChip({required Object n}) => '${n}s Pause';
	@override String get modified => 'Geändert · nur dieses Training';
	@override String modifiedWas({required Object name}) => 'Geändert · nur dieses Training (war: ${name})';
	@override String get completedBadge => '✓ Fertig';
	@override String totalHeld({required Object value}) => 'Gesamt gehalten: ${value}';
	@override String exerciseVolume({required Object value}) => 'Übungsvolumen: ${value} kg';
	@override String get lastTimeLabel => 'Letztes Mal';
	@override String get otherWorkout => 'anderes Workout';
	@override String targetWasReps({required Object n}) => 'Ziel war ${n} Wdh.';
	@override String targetWasSeconds({required Object n}) => 'Ziel war ${n}s';
	@override String morePerfs({required Object n}) => '+${n}';
	@override String get keptInTemplate => 'Geändert · wird in der Vorlage gespeichert';
	@override String keptInTemplateWas({required Object name}) => 'Geändert · wird in der Vorlage gespeichert (vorher: ${name})';
	@override String get keepInTemplateAction => 'Antippen, um diese Änderung in der Vorlage zu behalten';
}

// Path: session.overview
class _Translations$session$overview$de extends Translations$session$overview$en {
	_Translations$session$overview$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Übungen';
	@override String get current => 'AKTUELL';
	@override String setsValidated({required Object completed, required Object total}) => '${completed}/${total} Sätze bestätigt';
}

// Path: session.superset
class _Translations$session$superset$de extends Translations$session$superset$en {
	_Translations$session$superset$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String badge({required Object n}) => 'SUPERSATZ · ${n} ÜBUNGEN';
	@override String addSetTo({required Object letter, required Object name}) => 'Satz zu ${letter} hinzufügen · ${name}';
}

// Path: session.duration
class _Translations$session$duration$de extends Translations$session$duration$en {
	_Translations$session$duration$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Dauer pro Satz';
	@override String get hint => '45 oder 1m30';
	@override String confirm({required Object value}) => 'Bestätigen — ${value}';
}

// Path: session.weight
class _Translations$session$weight$de extends Translations$session$weight$en {
	_Translations$session$weight$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get bodyweight => 'Körpergewicht';
	@override String get confirmBodyweight => 'Bestätigen — Körpergewicht';
	@override String confirmKg({required Object value}) => 'Bestätigen — ${value} kg';
}

// Path: session.search
class _Translations$session$search$de extends Translations$session$search$en {
	_Translations$session$search$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get hint => 'Übung suchen…';
	@override String get loading => 'Übungen werden geladen…';
	@override String get noMatch => 'Keine Übung passt.';
	@override String get certifiedBadge => 'Repster-Übung';
}

// Path: session.history
class _Translations$session$history$de extends Translations$session$history$en {
	_Translations$session$history$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String title({required Object name}) => 'Verlauf · ${name}';
	@override String get empty => 'Noch kein Verlauf für diese Übung.';
	@override String get loading => 'Verlauf wird geladen…';
	@override String setLabel({required Object n}) => 'Satz ${n}';
	@override String get dateFormat => 'd. MMM yyyy';
}

// Path: session.fields
class _Translations$session$fields$de extends Translations$session$fields$en {
	_Translations$session$fields$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get exerciseName => 'Name der Übung';
	@override String get type => 'Typ';
	@override String get sets => 'Sätze';
	@override String get durationSec => 'Dauer (Sek.)';
	@override String get targetReps => 'Ziel-Wdh.';
	@override String get restShort => 'Pause (Sek.)';
	@override String get rest => 'Pause (Sek.)';
	@override String get tempo => 'Tempo';
	@override String get notesOptional => 'Notizen (optional)';
	@override String get notesHint => 'Technik-Tipps…';
	@override String get keepInTemplate => 'Auch in der Vorlage speichern';
	@override String get keepInTemplateHint => 'Standardmäßig gilt die Änderung nur für diese Einheit.';
}

// Path: session.toast
class _Translations$session$toast$de extends Translations$session$toast$en {
	_Translations$session$toast$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String exerciseAdded({required Object name}) => '${name} zum Training hinzugefügt';
	@override String get validateOneSet => 'Bestätige mindestens einen Satz, bevor du beendest.';
	@override String get sessionSaved => 'Training gespeichert! 🎉';
	@override String get finishOrSwap => 'Beende den aktuellen Satz oder nutze „Tauschen“.';
}

// Path: session.notif
class _Translations$session$notif$de extends Translations$session$notif$en {
	_Translations$session$notif$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get countdownChannel => 'Erholungs-Countdown';
	@override String get doneChannel => 'Erholung beendet';
	@override String get doneTitle => 'Erholung vorbei';
}

// Path: settings.sections
class _Translations$settings$sections$de extends Translations$settings$sections$en {
	_Translations$settings$sections$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get profile => 'Profil';
	@override String get data => 'Meine Daten';
	@override String get preferences => 'Einstellungen';
	@override String get account => 'Konto';
}

// Path: settings.rows
class _Translations$settings$rows$de extends Translations$settings$rows$en {
	_Translations$settings$rows$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get templates => 'Meine Vorlagen';
	@override String get history => 'Trainingsverlauf';
	@override String get stats => 'Statistiken';
	@override String get notifications => 'Benachrichtigungen';
	@override String get privacy => 'Datenschutz';
	@override String get terms => 'Nutzungsbedingungen';
	@override String get contact => 'Kontakt & Feedback';
	@override String get language => 'Sprache';
	@override String get changePassword => 'Passwort ändern';
}

// Path: settings.logout
class _Translations$settings$logout$de extends Translations$settings$logout$en {
	_Translations$settings$logout$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get action => 'Abmelden';
	@override String get error => 'Abmeldung fehlgeschlagen.';
}

// Path: settings.language
class _Translations$settings$language$de extends Translations$settings$language$en {
	_Translations$settings$language$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Sprache';
	@override String get subtitle => 'Wähle die App-Sprache';
	@override String get system => 'Systemsprache';
}

// Path: stats.subtitle
class _Translations$stats$subtitle$de extends Translations$stats$subtitle$en {
	_Translations$stats$subtitle$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get empty => 'Keine Einheiten im Zeitraum';
}

// Path: stats.empty
class _Translations$stats$empty$de extends Translations$stats$empty$en {
	_Translations$stats$empty$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Noch keine Daten';
	@override String get message => 'Absolviere ein paar Einheiten, um deine Kurven und Fortschritte zu sehen.';
}

// Path: stats.range
class _Translations$stats$range$de extends Translations$stats$range$en {
	_Translations$stats$range$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final _Translations$stats$range$last4Weeks$de last4Weeks = _Translations$stats$range$last4Weeks$de._(_root);
	@override late final _Translations$stats$range$last3Months$de last3Months = _Translations$stats$range$last3Months$de._(_root);
	@override late final _Translations$stats$range$all$de all = _Translations$stats$range$all$de._(_root);
}

// Path: stats.kpi
class _Translations$stats$kpi$de extends Translations$stats$kpi$en {
	_Translations$stats$kpi$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get sessions => 'Einheiten';
	@override String get volume => 'Tonnage';
	@override String get sets => 'Sätze';
	@override String get avgDuration => 'Ø Dauer';
	@override String get tension => 'Zeit unter Spannung';
}

// Path: stats.weeklyVolume
class _Translations$stats$weeklyVolume$de extends Translations$stats$weeklyVolume$en {
	_Translations$stats$weeklyVolume$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Volumen pro Woche';
	@override String get empty => 'Noch nicht genug Einheiten im Zeitraum.';
	@override String get inProgress => 'laufend';
}

// Path: stats.exercise
class _Translations$stats$exercise$de extends Translations$stats$exercise$en {
	_Translations$stats$exercise$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Fortschritt pro Übung';
	@override String get empty => 'Absolviere mindestens 2 Einheiten mit derselben belasteten Übung, um deine Kraftkurve zu sehen.';
	@override String get pickerTitle => 'Übung auswählen';
	@override String get noExercise => 'Keine Übung';
	@override String get searchHint => 'Suchen…';
	@override String get oneRmMax => 'max. geschätztes 1RM';
	@override String get bestLoad => 'beste Last';
	@override String get record => 'Rekord';
	@override String get trendUnknown => 'Noch nicht genug Einheiten für einen Trend';
	@override String get trendProgressing => 'Fortschritt';
	@override String trendPlateau({required Object n}) => 'Plateau · ${n} Einheiten ohne Bestwert';
	@override String get trendRegressing => 'Rückschritt';
	@override String perMonth({required Object value}) => '${value} %/Monat';
	@override String get plateauHint => 'Weniger Wdh. mit mehr Gewicht, oder Übung wechseln.';
}

// Path: stats.muscleBalance
class _Translations$stats$muscleBalance$de extends Translations$stats$muscleBalance$en {
	_Translations$stats$muscleBalance$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Muskelbalance';
	@override String neglected({required Object days, required Object emoji}) => '— seit ${days} T. nicht trainiert ${emoji}';
	@override late final _Translations$stats$muscleBalance$since$de since = _Translations$stats$muscleBalance$since$de._(_root);
}

// Path: stats.records
class _Translations$stats$records$de extends Translations$stats$records$en {
	_Translations$stats$records$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Rekorde';
	@override String get bestSession => 'Beste Einheit';
	@override String get heaviestLift => 'Schwerste Last';
	@override String get bestOneRm => 'Geschätztes 1RM';
	@override String get bestStreak => 'Längste Serie';
	@override String get consecutiveWeeks => 'aufeinanderfolgende Wochen';
}

// Path: stats.strength
class _Translations$stats$strength$de extends Translations$stats$strength$en {
	_Translations$stats$strength$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Kraft';
	@override String get scope => 'gesamte Historie';
}

// Path: templates.list
class _Translations$templates$list$de extends Translations$templates$list$en {
	_Translations$templates$list$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Programm';
	@override String subtitleActive({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} aktive Einheit',
		other: '${n} aktive Einheiten',
	);
	@override String subtitleManage({required num n, required Object total}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} / ${total} aktiv',
		other: '${n} / ${total} aktiv',
	);
	@override String get manage => 'Verwalten';
	@override String get newAction => 'Erstellen';
	@override String get emptyTitle => 'Keine Einheiten';
	@override String get emptyMessage => 'Erstelle deine erste Einheit, um dein Programm aufzubauen.';
	@override String get emptyAction => 'Einheit erstellen';
	@override String get emptyActiveTitle => 'Keine Einheiten im Programm';
	@override String get emptyActiveMessage => 'Aktiviere Einheiten, um sie deinem Programm hinzuzufügen.';
	@override String get emptyActiveAction => 'Einheiten verwalten';
	@override String get noResult => 'Keine Ergebnisse';
	@override String get searchHint => 'Einheit suchen…';
	@override String get manageHint => 'Ziehen zum Umsortieren · tippe auf den Kreis, um eine Einheit aus-/einzublenden';
	@override String get savedChanges => 'Änderungen gespeichert ✓';
	@override String get reorderError => 'Umsortieren fehlgeschlagen.';
	@override String get toggleError => 'Aktion nicht möglich.';
	@override String get duplicated => 'Einheit kopiert!';
	@override String get duplicateError => 'Duplizieren fehlgeschlagen.';
	@override String get deleted => 'Einheit gelöscht.';
	@override String get deleteError => 'Löschen fehlgeschlagen.';
	@override String get copySuffix => '(Kopie)';
}

// Path: templates.card
class _Translations$templates$card$de extends Translations$templates$card$en {
	_Translations$templates$card$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String exerciseCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Übung',
		other: '${n} Übungen',
	);
	@override String get details => 'Details';
	@override String get copy => 'Kopieren';
	@override String get deleteShort => 'Löschen';
	@override String get activate => 'Aktivieren';
	@override String get deactivate => 'Deaktivieren';
}

// Path: templates.detail
class _Translations$templates$detail$de extends Translations$templates$detail$en {
	_Translations$templates$detail$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Vorlage';
	@override String get noExercises => 'Keine Übungen in dieser Vorlage.';
	@override String get superset => 'Supersatz';
	@override String setsCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Satz',
		other: '${n} Sätze',
	);
	@override String seconds({required Object n}) => '${n} s';
	@override String tempo({required Object value}) => 'Tempo ${value}';
	@override String rest({required Object n}) => 'Pause ${n}s';
	@override String variantsMore({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '+${n} Variante',
		other: '+${n} Varianten',
	);
	@override String get start => 'Einheit starten';
}

// Path: templates.editor
class _Translations$templates$editor$de extends Translations$templates$editor$en {
	_Translations$templates$editor$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get newTitle => 'Neue Einheit';
	@override String get editTitle => 'Einheit bearbeiten';
	@override String exercisesHeader({required Object count}) => 'ÜBUNGEN (${count})';
	@override String get addExercise => 'Übung hinzufügen';
	@override String get save => 'Einheit speichern';
	@override String get validationError => 'Gib einen Namen und mindestens eine benannte Übung ein.';
}

// Path: templates.fields
class _Translations$templates$fields$de extends Translations$templates$fields$en {
	_Translations$templates$fields$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Name der Einheit';
	@override String get nameHint => 'z. B. Brust / Trizeps / Schultern';
	@override String get description => 'Beschreibung (optional)';
	@override String get descriptionHint => 'Beschreibe deine Einheit…';
	@override String get emoji => 'Bild';
	@override String get muscleGroups => 'Muskelgruppen';
	@override String selectedCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} ausgewählt',
		other: '${n} ausgewählt',
	);
	@override String get exerciseName => 'Name der Übung';
	@override String get exerciseNameHint => 'z. B. Bankdrücken';
	@override String get type => 'Typ';
	@override String get sets => 'Sätze';
	@override String get duration => 'Dauer (s)';
	@override String get targetReps => 'Ziel-Wdh.';
	@override String get rest => 'Pause (s)';
	@override String get tempo => 'Tempo';
	@override String get tempoHint => '3-1-X-0';
	@override String get notes => 'Notizen (optional)';
	@override String get notesHint => 'Technische Tipps…';
}

// Path: templates.slot
class _Translations$templates$slot$de extends Translations$templates$slot$en {
	_Translations$templates$slot$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get newExercise => 'Neue Übung';
	@override String variantN({required Object n}) => 'Variante ${n}';
	@override String get primary => 'PRIMÄR';
	@override String get variant => 'Variante';
	@override String get addVariant => 'Variante hinzufügen';
	@override String get supersetNote => 'Als Supersatz mit der nächsten Übung verkettet';
	@override String get supersetLabel => 'SUPERSATZ';
	@override String get reps => 'Wiederholungen';
	@override String get time => 'Zeit';
}

// Path: templates.emojiPicker
class _Translations$templates$emojiPicker$de extends Translations$templates$emojiPicker$en {
	_Translations$templates$emojiPicker$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Bild der Einheit';
	@override String get searchHint => 'Emoji suchen…';
	@override String get noResults => 'Kein Emoji passt.';
	@override String get change => 'Ändern';
}

// Path: auth.onboarding.goalDescriptions
class _Translations$auth$onboarding$goalDescriptions$de extends Translations$auth$onboarding$goalDescriptions$en {
	_Translations$auth$onboarding$goalDescriptions$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get hypertrophy => 'Muskeln aufbauen';
	@override String get strength => 'Schwerer heben';
	@override String get endurance => 'Cardio & Ausdauer';
	@override String get weightLoss => 'Kalorien verbrennen';
	@override String get maintenance => 'In Form bleiben';
}

// Path: contact.categories.bug
class _Translations$contact$categories$bug$de extends Translations$contact$categories$bug$en {
	_Translations$contact$categories$bug$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get label => 'Bug';
	@override String get placeholder => 'Z. B.: Nach meinem Satz startet der Pausen-Timer nicht…';
	@override String get guidance => 'Nenne die Schritte zum Reproduzieren, was du erwartet hast, und dein Telefonmodell — das hilft uns, es schnell zu beheben.';
	@override String get successLine => 'Notiert — wir schauen uns diesen Bug gleich genau an.';
}

// Path: contact.categories.feature
class _Translations$contact$categories$feature$de extends Translations$contact$categories$feature$en {
	_Translations$contact$categories$feature$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get label => 'Idee';
	@override String get placeholder => 'Z. B.: eine bestehende Vorlage duplizieren können…';
	@override String get guidance => 'Beschreibe vor allem den Bedarf hinter der Idee: Was würde es dir ermöglichen?';
	@override String get successLine => 'Tolle Idee, danke! Wir nehmen sie in unsere Überlegungen auf.';
}

// Path: contact.categories.general
class _Translations$contact$categories$general$de extends Translations$contact$categories$general$en {
	_Translations$contact$categories$general$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get label => 'Nachricht';
	@override String get placeholder => 'Deine Frage, deine Meinung oder dein Feedback…';
	@override String get guidance => 'Eine Frage, eine Anmerkung, ein Ansporn: Wir lesen jede Nachricht.';
	@override String get successLine => 'Danke für deine Nachricht. Wir nehmen uns Zeit, jedes Feedback zu lesen.';
}

// Path: contact.categories.other
class _Translations$contact$categories$other$de extends Translations$contact$categories$other$en {
	_Translations$contact$categories$other$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get label => 'Sonstiges';
	@override String get placeholder => 'Erzähl uns alles…';
	@override String get guidance => 'Gib uns möglichst viel Kontext, damit wir dir bestmöglich helfen können.';
	@override String get successLine => 'Danke für deine Nachricht. Wir melden uns bei Bedarf.';
}

// Path: history.detail.edit
class _Translations$history$detail$edit$de extends Translations$history$detail$edit$en {
	_Translations$history$detail$edit$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get open => 'Bearbeiten';
	@override String get title => 'Einheit bearbeiten';
	@override String get name => 'Titel';
	@override String get namePlaceholder => 'Name der Einheit';
	@override String get date => 'Datum';
	@override String get time => 'Uhrzeit';
	@override String get durationLabel => 'Dauer';
	@override String get hours => 'Std.';
	@override String get minutes => 'Min.';
	@override String get notesPlaceholder => 'Wie ist es gelaufen?';
	@override String get save => 'Speichern';
	@override String get saved => 'Einheit aktualisiert.';
	@override String get error => 'Aktualisierung fehlgeschlagen.';
	@override String get nameRequired => 'Ein Titel ist erforderlich.';
	@override String get dateFormat => 'd. MMMM y';
}

// Path: profile.editForm.sections
class _Translations$profile$editForm$sections$de extends Translations$profile$editForm$sections$en {
	_Translations$profile$editForm$sections$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get identity => 'Identität';
	@override String get physique => 'Körperbau';
	@override String get goal => 'Ziel';
}

// Path: profile.editForm.fields
class _Translations$profile$editForm$fields$de extends Translations$profile$editForm$fields$en {
	_Translations$profile$editForm$fields$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Name / Spitzname';
	@override String get bio => 'Bio';
	@override String get birthdate => 'Geburtsdatum';
	@override String get weight => 'Gewicht (kg)';
	@override String get height => 'Größe (cm)';
}

// Path: profile.editForm.validation
class _Translations$profile$editForm$validation$de extends Translations$profile$editForm$validation$en {
	_Translations$profile$editForm$validation$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get nameMin => 'Mindestens 2 Zeichen';
	@override String get nameMax => 'Maximal 60 Zeichen';
	@override String get invalidNumber => 'Ungültige Zahl';
	@override String get heightRange => 'Zwischen 80 und 260 cm';
	@override String get weightRange => 'Zwischen 30 und 350 kg';
}

// Path: stats.range.last4Weeks
class _Translations$stats$range$last4Weeks$de extends Translations$stats$range$last4Weeks$en {
	_Translations$stats$range$last4Weeks$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get label => '4 Wochen';
	@override String get short => '4 Wo.';
}

// Path: stats.range.last3Months
class _Translations$stats$range$last3Months$de extends Translations$stats$range$last3Months$en {
	_Translations$stats$range$last3Months$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get label => '3 Monate';
	@override String get short => '3 Mon.';
}

// Path: stats.range.all
class _Translations$stats$range$all$de extends Translations$stats$range$all$en {
	_Translations$stats$range$all$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get label => 'Alles';
	@override String get short => 'Alles';
}

// Path: stats.muscleBalance.since
class _Translations$stats$muscleBalance$since$de extends Translations$stats$muscleBalance$since$en {
	_Translations$stats$muscleBalance$since$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get none => '–';
	@override String get today => 'heute';
	@override String get yesterday => 'gestern';
	@override String daysShort({required Object n}) => '${n}T';
}

/// The flat map containing all translations for locale <de>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsDe {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'auth.fields.email' => 'E-Mail-Adresse',
			'auth.fields.password' => 'Passwort',
			'auth.backToLogin' => 'Zurück zur Anmeldung',
			'auth.login.welcomeTitle' => 'Schön, dich wiederzusehen',
			'auth.login.welcomeSubtitle' => 'Melde dich an, um fortzufahren.',
			'auth.login.forgotPassword' => 'Passwort vergessen?',
			'auth.login.submit' => 'Anmelden',
			'auth.login.submitLoading' => 'Anmeldung…',
			'auth.login.noAccount' => 'Noch kein Konto?',
			'auth.login.createAccount' => 'Konto erstellen',
			'auth.signup.title' => 'Konto erstellen',
			'auth.signup.subtitle' => 'Schließe dich Tausenden von Athleten an.',
			'auth.signup.passwordHint' => 'Passwort (mind. 8 Zeichen)',
			'auth.signup.submit' => 'Mein Konto erstellen',
			'auth.signup.submitLoading' => 'Wird erstellt…',
			'auth.signup.termsPrefix' => 'Mit der Erstellung eines Kontos akzeptierst du unsere ',
			'auth.signup.termsLink' => 'Nutzungsbedingungen',
			'auth.onboarding.step1Title' => 'Wie heißt\ndu?',
			'auth.onboarding.step1Subtitle' => 'Um dein Erlebnis zu personalisieren.',
			'auth.onboarding.nameHint' => 'Dein Vorname',
			'auth.onboarding.continueLabel' => 'Weiter',
			'auth.onboarding.step2Title' => 'Was ist dein\nZiel?',
			'auth.onboarding.step2Subtitle' => 'Wir passen deine Einheiten entsprechend an.',
			'auth.onboarding.step3Title' => 'Ein paar Infos',
			'auth.onboarding.optional' => 'Optional',
			'auth.onboarding.step3Subtitle' => 'Für genauere Empfehlungen.',
			'auth.onboarding.weightHint' => 'Gewicht (kg)',
			'auth.onboarding.heightHint' => 'Größe (cm)',
			'auth.onboarding.birthdate' => 'Geburtsdatum',
			'auth.onboarding.submit' => 'Los geht\'s!',
			'auth.onboarding.submitLoading' => 'Wird gespeichert…',
			'auth.onboarding.skip' => 'Diesen Schritt überspringen',
			'auth.onboarding.goalDescriptions.hypertrophy' => 'Muskeln aufbauen',
			'auth.onboarding.goalDescriptions.strength' => 'Schwerer heben',
			'auth.onboarding.goalDescriptions.endurance' => 'Cardio & Ausdauer',
			'auth.onboarding.goalDescriptions.weightLoss' => 'Kalorien verbrennen',
			'auth.onboarding.goalDescriptions.maintenance' => 'In Form bleiben',
			'auth.onboarding.nameRequired' => 'Dein Vorname ist erforderlich.',
			'auth.onboarding.nameTooLong' => 'Vorname zu lang.',
			'auth.onboarding.goalRequired' => 'Wähle ein Ziel.',
			'auth.onboarding.weightInvalid' => 'Ungültiges Gewicht',
			'auth.onboarding.heightInvalid' => 'Ungültige Größe',
			'auth.verifyEmail.title' => 'Bestätige deine E-Mail',
			'auth.verifyEmail.subtitle' => 'Wir haben einen 6-stelligen Code gesendet',
			'auth.verifyEmail.submitLoading' => 'Wird überprüft…',
			'auth.verifyEmail.submitComplete' => 'Code bestätigen',
			'auth.verifyEmail.submitIncomplete' => 'Gib den erhaltenen Code ein',
			'auth.verifyEmail.noCode' => 'Keinen Code erhalten?',
			'auth.verifyEmail.resent' => 'Code erneut gesendet!',
			'auth.verifyEmail.resendCooldown' => ({required Object n}) => 'Erneut senden in ${n}s',
			'auth.verifyEmail.resending' => 'Wird gesendet…',
			'auth.verifyEmail.resend' => 'Code erneut senden',
			'auth.verifyEmail.emailMissing' => 'E-Mail fehlt. Kehre zur Registrierung zurück.',
			'auth.forgotPassword.title' => 'Passwort vergessen',
			'auth.forgotPassword.subtitle' => 'Wir senden dir einen Link zum Zurücksetzen',
			'auth.forgotPassword.submit' => 'Link senden',
			'auth.forgotPassword.submitLoading' => 'Wird gesendet…',
			'auth.forgotPassword.successMessage' => 'Ein Link zum Zurücksetzen wurde an deine E-Mail-Adresse gesendet. Prüfe deinen Posteingang.',
			'auth.updatePassword.title' => 'Neues Passwort',
			'auth.updatePassword.subtitle' => 'Wähle ein sicheres Passwort',
			'auth.updatePassword.newHint' => 'Neues Passwort',
			'auth.updatePassword.confirmHint' => 'Passwort bestätigen',
			'auth.updatePassword.submit' => 'Passwort speichern',
			'auth.updatePassword.submitLoading' => 'Wird gespeichert…',
			'auth.changePassword.title' => 'Passwort ändern',
			'auth.changePassword.subtitle' => 'Bestätige zu deiner Sicherheit dein aktuelles Passwort, bevor du ein neues wählst.',
			'auth.changePassword.currentHint' => 'Aktuelles Passwort',
			'auth.changePassword.newHint' => 'Neues Passwort',
			'auth.changePassword.confirmHint' => 'Neues Passwort bestätigen',
			'auth.changePassword.submit' => 'Passwort aktualisieren',
			'auth.changePassword.submitLoading' => 'Wird aktualisiert…',
			'auth.changePassword.successToast' => 'Passwort aktualisiert',
			'auth.changePassword.currentRequired' => 'Aktuelles Passwort erforderlich',
			'auth.changePassword.mustDiffer' => 'Das neue Passwort muss sich vom aktuellen unterscheiden',
			'auth.changePassword.currentIncorrect' => 'Aktuelles Passwort falsch',
			'auth.validators.emailRequired' => 'E-Mail erforderlich',
			'auth.validators.emailInvalid' => 'Ungültige E-Mail',
			'auth.validators.passwordRequired' => 'Passwort erforderlich',
			'auth.validators.passwordMin' => 'Mindestens 8 Zeichen',
			'auth.validators.passwordMismatch' => 'Die Passwörter stimmen nicht überein',
			'common.actions.cancel' => 'Abbrechen',
			'common.actions.confirm' => 'Bestätigen',
			'common.actions.save' => 'Speichern',
			'common.actions.retry' => 'Erneut versuchen',
			'common.actions.delete' => 'Löschen',
			'common.actions.close' => 'Schließen',
			'common.actions.edit' => 'Bearbeiten',
			'common.actions.done' => 'Fertig',
			'common.actions.next' => 'Weiter',
			'common.actions.back' => 'Zurück',
			'common.all' => 'Alle',
			'common.unnamed' => '(ohne Namen)',
			'common.units.reps' => 'Wdh.',
			'common.date.justNow' => 'gerade eben',
			'common.date.minutesAgo' => ({required Object n}) => 'vor ${n} Min.',
			'common.date.hoursAgo' => ({required Object n}) => 'vor ${n} Std.',
			'common.date.yesterday' => 'gestern',
			'common.date.daysAgo' => ({required Object n}) => 'vor ${n} T.',
			'common.date.today' => 'heute',
			'common.date.weeksAgo' => ({required Object n}) => 'vor ${n} Wo.',
			'common.date.monthsAgo' => ({required Object n}) => 'vor ${n} Mon.',
			'common.language.en' => 'Englisch',
			'common.language.fr' => 'Französisch',
			'common.language.es' => 'Spanisch',
			'common.language.de' => 'Deutsch',
			'common.language.it' => 'Italienisch',
			'contact.header.title' => 'Kontakt & Feedback',
			'contact.header.subtitle' => 'Ein Bug, eine Idee, eine Frage? Schreib uns, wir lesen alles.',
			'contact.sections.type' => 'Art der Anfrage',
			'contact.sections.yourInfo' => 'Deine Angaben',
			'contact.sections.message' => 'Nachricht',
			'contact.fields.nameHint' => 'Dein Vorname',
			'contact.fields.nameRequired' => 'Name erforderlich',
			'contact.fields.emailHint' => 'Deine E-Mail-Adresse',
			'contact.fields.emailInvalid' => 'Ungültige E-Mail',
			'contact.fields.messageTooShort' => 'Nachricht zu kurz (mind. 10 Zeichen)',
			'contact.counter' => ({required Object current, required Object max}) => '${current} / ${max}',
			'contact.submit' => 'Senden',
			'contact.categories.bug.label' => 'Bug',
			'contact.categories.bug.placeholder' => 'Z. B.: Nach meinem Satz startet der Pausen-Timer nicht…',
			'contact.categories.bug.guidance' => 'Nenne die Schritte zum Reproduzieren, was du erwartet hast, und dein Telefonmodell — das hilft uns, es schnell zu beheben.',
			'contact.categories.bug.successLine' => 'Notiert — wir schauen uns diesen Bug gleich genau an.',
			'contact.categories.feature.label' => 'Idee',
			'contact.categories.feature.placeholder' => 'Z. B.: eine bestehende Vorlage duplizieren können…',
			'contact.categories.feature.guidance' => 'Beschreibe vor allem den Bedarf hinter der Idee: Was würde es dir ermöglichen?',
			'contact.categories.feature.successLine' => 'Tolle Idee, danke! Wir nehmen sie in unsere Überlegungen auf.',
			'contact.categories.general.label' => 'Nachricht',
			'contact.categories.general.placeholder' => 'Deine Frage, deine Meinung oder dein Feedback…',
			'contact.categories.general.guidance' => 'Eine Frage, eine Anmerkung, ein Ansporn: Wir lesen jede Nachricht.',
			'contact.categories.general.successLine' => 'Danke für deine Nachricht. Wir nehmen uns Zeit, jedes Feedback zu lesen.',
			'contact.categories.other.label' => 'Sonstiges',
			'contact.categories.other.placeholder' => 'Erzähl uns alles…',
			'contact.categories.other.guidance' => 'Gib uns möglichst viel Kontext, damit wir dir bestmöglich helfen können.',
			'contact.categories.other.successLine' => 'Danke für deine Nachricht. Wir melden uns bei Bedarf.',
			'contact.success.title' => 'Nachricht gesendet',
			'contact.success.back' => 'Zurück zu den Einstellungen',
			'dashboard.greeting.morning' => 'Guten Morgen',
			'dashboard.greeting.afternoon' => 'Guten Tag',
			'dashboard.greeting.evening' => 'Guten Abend',
			'dashboard.defaultName' => 'Athlet',
			'dashboard.seeAll' => 'Alle ansehen',
			'dashboard.sections.templates' => 'Vorlagen',
			'dashboard.sections.recentSessions' => 'Letzte Einheiten',
			'dashboard.templates.empty' => 'Noch keine Vorlagen',
			'dashboard.templates.newLabel' => 'Neu',
			'dashboard.exerciseCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} Übung', other: '${n} Übungen', ), 
			'dashboard.hero.eyebrow' => 'NÄCHSTE EINHEIT',
			'dashboard.hero.start' => 'Einheit starten',
			'dashboard.hero.emptyTitle' => 'Erstelle deine erste Vorlage',
			'dashboard.hero.emptyMessage' => 'Richte deine Übungen ein und los geht’s.',
			'dashboard.hero.create' => 'Vorlage erstellen',
			'dashboard.hero.duration' => ({required Object n}) => '≈ ${n} Min',
			'dashboard.recent.emptyTitle' => 'Starte deine erste Einheit!',
			'dashboard.recent.emptyMessage' => 'Wähle eine Vorlage und los geht’s.',
			'dashboard.recent.tonnage' => 'Tonnage',
			'dashboard.inProgress.label' => 'EINHEIT LÄUFT',
			'dashboard.inProgress.startedAt' => ({required Object when}) => 'Gestartet ${when}',
			'dashboard.inProgress.resume' => 'Fortsetzen',
			'dashboard.inProgress.discard' => 'Verwerfen',
			'dashboard.inProgress.discardTitle' => 'Einheit verwerfen?',
			'dashboard.inProgress.discardMessage' => 'Alle aktuellen Eingaben gehen verloren.',
			'dashboard.inProgress.discardError' => 'Fehlgeschlagen — versuch es erneut.',
			'dashboard.stats.sessions' => 'Einheiten',
			'dashboard.stats.volume' => 'Volumen',
			'dashboard.stats.streak' => 'Serie',
			'dashboard.stats.thisWeek' => 'diese Wo.',
			'dashboard.stats.weekCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: 'Woche', other: 'Wochen', ), 
			'dashboard.stats.streakLabel' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: 'Woche\nin Folge', other: 'Wochen\nin Folge', ), 
			'dashboard.stats.sessionsWeek' => 'Einheiten\ndiese Woche',
			'dashboard.stats.volumeWeek' => 'Volumen\ndiese Woche',
			'dashboard.streakBadge' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} Woche in Folge', other: '${n} Wochen in Folge', ), 
			'dashboard.consistency.title' => 'Beständigkeit',
			'dashboard.consistency.trainingDays' => 'aktive Tage',
			'dashboard.consistency.perWeek' => 'Einheiten / Wo.',
			'dashboard.consistency.bestStreak' => 'beste Serie',
			'dashboard.consistency.noStreak' => 'keine Serie',
			'dashboard.consistency.weeksShort' => ({required Object n}) => '${n} Wo.',
			'dashboard.consistency.notYet' => 'Dein Trainingsrhythmus erscheint hier nach der ersten Einheit.',
			'emoji.groups.sport' => 'Sport & Training',
			'emoji.groups.body' => 'Körper & Gesten',
			'emoji.groups.energy' => 'Energie & Symbole',
			'emoji.groups.faces' => 'Gesichter',
			'emoji.groups.hearts' => 'Herzen',
			'emoji.groups.animals' => 'Tiere',
			'emoji.groups.food' => 'Essen & Trinken',
			'emoji.groups.nature' => 'Natur & Wetter',
			'emoji.groups.places' => 'Orte & Reisen',
			'emoji.groups.objects' => 'Objekte & Werkzeuge',
			'emoji.labels.person-lifting-weights' => 'Gewichtheber',
			'emoji.labels.man-lifting-weights' => 'Gewichtheber (Mann)',
			'emoji.labels.woman-lifting-weights' => 'Gewichtheberin',
			'emoji.labels.flexed-biceps' => 'Angespannter Bizeps',
			'emoji.labels.boxing-glove' => 'Boxhandschuh',
			'emoji.labels.martial-arts-uniform' => 'Kampfsportanzug',
			'emoji.labels.person-wrestling' => 'Ringer',
			'emoji.labels.person-running' => 'Läufer',
			'emoji.labels.man-running' => 'Laufender Mann',
			'emoji.labels.woman-running' => 'Laufende Frau',
			'emoji.labels.running-shoe' => 'Laufschuh',
			'emoji.labels.running-shirt' => 'Laufshirt',
			'emoji.labels.hiking-boot' => 'Wanderstiefel',
			'emoji.labels.person-walking' => 'Fußgänger',
			'emoji.labels.person-climbing' => 'Kletterer',
			'emoji.labels.person-biking' => 'Radfahrer',
			'emoji.labels.person-mountain-biking' => 'Mountainbiker',
			'emoji.labels.bicycle' => 'Fahrrad',
			'emoji.labels.person-swimming' => 'Schwimmer',
			'emoji.labels.person-surfing' => 'Surfer',
			'emoji.labels.person-rowing-boat' => 'Ruderer',
			'emoji.labels.canoe' => 'Kanu',
			'emoji.labels.person-in-lotus-position' => 'Lotussitz',
			'emoji.labels.lotus' => 'Lotus',
			'emoji.labels.person-cartwheeling' => 'Rad schlagen',
			'emoji.labels.person-juggling' => 'Jongleur',
			'emoji.labels.person-bouncing-ball' => 'Basketballspieler',
			'emoji.labels.person-playing-handball' => 'Handballspieler',
			'emoji.labels.person-playing-water-polo' => 'Wasserballspieler',
			'emoji.labels.person-fencing' => 'Fechter',
			'emoji.labels.person-golfing' => 'Golfer',
			'emoji.labels.horse-racing' => 'Pferderennen',
			'emoji.labels.skier' => 'Skifahrer',
			'emoji.labels.snowboarder' => 'Snowboarder',
			'emoji.labels.ice-skate' => 'Schlittschuh',
			'emoji.labels.roller-skate' => 'Rollschuh',
			'emoji.labels.skateboard' => 'Skateboard',
			'emoji.labels.basketball' => 'Basketball',
			'emoji.labels.soccer-ball' => 'Fußball',
			'emoji.labels.american-football' => 'American Football',
			'emoji.labels.rugby-football' => 'Rugbyball',
			'emoji.labels.tennis' => 'Tennis',
			'emoji.labels.volleyball' => 'Volleyball',
			'emoji.labels.baseball' => 'Baseball',
			'emoji.labels.ping-pong' => 'Tischtennis',
			'emoji.labels.badminton' => 'Badminton',
			'emoji.labels.field-hockey' => 'Feldhockey',
			'emoji.labels.ice-hockey' => 'Eishockey',
			'emoji.labels.bowling' => 'Bowling',
			'emoji.labels.flying-disc' => 'Frisbee',
			'emoji.labels.bow-and-arrow' => 'Pfeil und Bogen',
			'emoji.labels.bullseye' => 'Zielscheibe',
			'emoji.labels.pool-8-ball' => 'Billardkugel',
			'emoji.labels.parachute' => 'Fallschirm',
			'emoji.labels.trophy' => 'Pokal',
			'emoji.labels.sports-medal' => 'Sportmedaille',
			'emoji.labels.1st-place-medal' => 'Goldmedaille',
			'emoji.labels.2nd-place-medal' => 'Silbermedaille',
			'emoji.labels.3rd-place-medal' => 'Bronzemedaille',
			'emoji.labels.military-medal' => 'Militärmedaille',
			'emoji.labels.chequered-flag' => 'Zielflagge',
			'emoji.labels.triangular-flag' => 'Wimpel',
			'emoji.labels.stadium' => 'Stadion',
			'emoji.labels.stopwatch' => 'Stoppuhr',
			'emoji.labels.timer-clock' => 'Timer',
			'emoji.labels.alarm-clock' => 'Wecker',
			'emoji.labels.hourglass-not-done' => 'Sanduhr',
			'emoji.labels.leg' => 'Bein',
			'emoji.labels.foot' => 'Fuß',
			'emoji.labels.anatomical-heart' => 'Anatomisches Herz',
			'emoji.labels.lungs' => 'Lunge',
			'emoji.labels.bone' => 'Knochen',
			'emoji.labels.brain' => 'Gehirn',
			'emoji.labels.footprints' => 'Fußspuren',
			'emoji.labels.eyes' => 'Augen',
			'emoji.labels.raised-fist' => 'Erhobene Faust',
			'emoji.labels.oncoming-fist' => 'Faust von vorne',
			'emoji.labels.left-facing-fist' => 'Faust nach links',
			'emoji.labels.right-facing-fist' => 'Faust nach rechts',
			'emoji.labels.thumbs-up' => 'Daumen hoch',
			'emoji.labels.clapping-hands' => 'Klatschende Hände',
			'emoji.labels.raising-hands' => 'Erhobene Hände',
			'emoji.labels.heart-hands' => 'Herz-Hände',
			'emoji.labels.handshake' => 'Handschlag',
			'emoji.labels.folded-hands' => 'Gefaltete Hände',
			'emoji.labels.victory-hand' => 'Victory-Zeichen',
			'emoji.labels.ok-hand' => 'OK-Zeichen',
			'emoji.labels.waving-hand' => 'Winkende Hand',
			'emoji.labels.pinched-fingers' => 'Zusammengedrückte Finger',
			'emoji.labels.sign-of-the-horns' => 'Teufelsgruß',
			'emoji.labels.call-me-hand' => 'Ruf-mich-an-Hand',
			'emoji.labels.crossed-fingers' => 'Gekreuzte Finger',
			'emoji.labels.love-you-gesture' => 'Ich-liebe-dich-Geste',
			'emoji.labels.sweat-droplets' => 'Schweißtropfen',
			'emoji.labels.zzz' => 'Zzz',
			'emoji.labels.person-standing' => 'Stehende Person',
			'emoji.labels.person-kneeling' => 'Kniende Person',
			'emoji.labels.fire' => 'Feuer',
			'emoji.labels.high-voltage' => 'Blitz',
			'emoji.labels.collision' => 'Kollision',
			'emoji.labels.dizzy' => 'Schwindel',
			'emoji.labels.sparkles' => 'Funkeln',
			'emoji.labels.star' => 'Stern',
			'emoji.labels.shooting-star' => 'Sternschnuppe',
			'emoji.labels.rocket' => 'Rakete',
			'emoji.labels.flying-saucer' => 'Fliegende Untertasse',
			'emoji.labels.hundred-points' => 'Hundert Punkte',
			'emoji.labels.check-mark-button' => 'Grünes Häkchen',
			'emoji.labels.battery' => 'Batterie',
			'emoji.labels.light-bulb' => 'Glühbirne',
			'emoji.labels.bomb' => 'Bombe',
			'emoji.labels.fireworks' => 'Feuerwerk',
			'emoji.labels.party-popper' => 'Partytröte',
			'emoji.labels.confetti-ball' => 'Konfettiball',
			'emoji.labels.mirror-ball' => 'Discokugel',
			'emoji.labels.crown' => 'Krone',
			'emoji.labels.gem-stone' => 'Edelstein',
			'emoji.labels.shield' => 'Schild',
			'emoji.labels.crossed-swords' => 'Gekreuzte Schwerter',
			'emoji.labels.infinity' => 'Unendlich',
			'emoji.labels.skull' => 'Totenkopf',
			'emoji.labels.skull-and-crossbones' => 'Totenkopf mit Knochen',
			'emoji.labels.ghost' => 'Geist',
			'emoji.labels.alien' => 'Außerirdischer',
			'emoji.labels.robot' => 'Roboter',
			'emoji.labels.pile-of-poo' => 'Kackhaufen',
			'emoji.labels.magic-wand' => 'Zauberstab',
			'emoji.labels.crystal-ball' => 'Kristallkugel',
			'emoji.labels.grinning-face' => 'Grinsendes Gesicht',
			'emoji.labels.grinning-face-with-big-eyes' => 'Grinsen mit großen Augen',
			'emoji.labels.grinning-face-with-smiling-eyes' => 'Grinsen mit lachenden Augen',
			'emoji.labels.beaming-face-with-smiling-eyes' => 'Strahlendes Gesicht',
			'emoji.labels.grinning-squinting-face' => 'Lachen mit zusammengekniffenen Augen',
			'emoji.labels.grinning-face-with-sweat' => 'Grinsen mit Schweiß',
			'emoji.labels.face-with-tears-of-joy' => 'Freudentränen',
			'emoji.labels.rolling-on-the-floor-laughing' => 'Lachkrampf',
			'emoji.labels.smiling-face-with-smiling-eyes' => 'Lächeln mit lachenden Augen',
			'emoji.labels.smiling-face-with-halo' => 'Gesicht mit Heiligenschein',
			'emoji.labels.smiling-face-with-hearts' => 'Lächeln mit Herzen',
			'emoji.labels.smiling-face-with-heart-eyes' => 'Herzaugen',
			'emoji.labels.star-struck' => 'Sternaugen',
			'emoji.labels.face-blowing-a-kiss' => 'Kuss zuwerfen',
			'emoji.labels.face-savoring-food' => 'Genießendes Gesicht',
			'emoji.labels.face-with-tongue' => 'Gesicht mit Zunge',
			'emoji.labels.winking-face' => 'Zwinkern',
			'emoji.labels.winking-face-with-tongue' => 'Zwinkern mit Zunge',
			'emoji.labels.zany-face' => 'Verrücktes Gesicht',
			'emoji.labels.money-mouth-face' => 'Geldgesicht',
			'emoji.labels.hugging-face' => 'Umarmendes Gesicht',
			'emoji.labels.face-with-hand-over-mouth' => 'Hand vor dem Mund',
			'emoji.labels.face-with-peeking-eye' => 'Gesicht mit lugendem Auge',
			'emoji.labels.shushing-face' => 'Pssst-Gesicht',
			'emoji.labels.thinking-face' => 'Nachdenkliches Gesicht',
			'emoji.labels.saluting-face' => 'Salutierendes Gesicht',
			'emoji.labels.zipper-mouth-face' => 'Reißverschlussmund',
			'emoji.labels.face-with-raised-eyebrow' => 'Hochgezogene Augenbraue',
			'emoji.labels.neutral-face' => 'Neutrales Gesicht',
			'emoji.labels.unamused-face' => 'Unamüsiertes Gesicht',
			'emoji.labels.smirking-face' => 'Grinsendes Gesicht mit Augenaufschlag',
			'emoji.labels.drooling-face' => 'Sabberndes Gesicht',
			'emoji.labels.sleeping-face' => 'Schlafendes Gesicht',
			'emoji.labels.face-with-medical-mask' => 'Gesicht mit Mundschutz',
			'emoji.labels.hot-face' => 'Hitzegesicht',
			'emoji.labels.cold-face' => 'Frostgesicht',
			'emoji.labels.woozy-face' => 'Benommenes Gesicht',
			'emoji.labels.face-with-spiral-eyes' => 'Spiralaugen',
			'emoji.labels.exploding-head' => 'Explodierender Kopf',
			'emoji.labels.cowboy-hat-face' => 'Cowboyhut',
			'emoji.labels.partying-face' => 'Partygesicht',
			'emoji.labels.disguised-face' => 'Verkleidetes Gesicht',
			'emoji.labels.smiling-face-with-sunglasses' => 'Sonnenbrillengesicht',
			'emoji.labels.nerd-face' => 'Nerd-Gesicht',
			'emoji.labels.face-with-monocle' => 'Monokel',
			'emoji.labels.slightly-smiling-face' => 'Leichtes Lächeln',
			'emoji.labels.upside-down-face' => 'Umgedrehtes Gesicht',
			'emoji.labels.melting-face' => 'Schmelzendes Gesicht',
			'emoji.labels.flushed-face' => 'Errötetes Gesicht',
			'emoji.labels.pleading-face' => 'Flehendes Gesicht',
			'emoji.labels.face-holding-back-tears' => 'Tränen zurückhalten',
			'emoji.labels.loudly-crying-face' => 'Heulendes Gesicht',
			'emoji.labels.face-screaming-in-fear' => 'Angstschrei',
			'emoji.labels.downcast-face-with-sweat' => 'Bedrücktes Gesicht mit Schweiß',
			'emoji.labels.weary-face' => 'Erschöpftes Gesicht',
			'emoji.labels.tired-face' => 'Müdes Gesicht',
			'emoji.labels.yawning-face' => 'Gähnendes Gesicht',
			'emoji.labels.face-with-steam-from-nose' => 'Schnaubendes Gesicht',
			'emoji.labels.angry-face' => 'Wütendes Gesicht',
			'emoji.labels.smiling-face-with-horns' => 'Grinsender Teufel',
			'emoji.labels.angry-face-with-horns' => 'Wütender Teufel',
			'emoji.labels.red-heart' => 'Rotes Herz',
			'emoji.labels.orange-heart' => 'Oranges Herz',
			'emoji.labels.yellow-heart' => 'Gelbes Herz',
			'emoji.labels.green-heart' => 'Grünes Herz',
			'emoji.labels.blue-heart' => 'Blaues Herz',
			'emoji.labels.purple-heart' => 'Lila Herz',
			'emoji.labels.black-heart' => 'Schwarzes Herz',
			'emoji.labels.white-heart' => 'Weißes Herz',
			'emoji.labels.pink-heart' => 'Rosa Herz',
			'emoji.labels.sparkling-heart' => 'Funkelndes Herz',
			'emoji.labels.growing-heart' => 'Wachsendes Herz',
			'emoji.labels.beating-heart' => 'Schlagendes Herz',
			'emoji.labels.revolving-hearts' => 'Kreisende Herzen',
			'emoji.labels.two-hearts' => 'Zwei Herzen',
			'emoji.labels.heart-on-fire' => 'Brennendes Herz',
			'emoji.labels.mending-heart' => 'Heilendes Herz',
			'emoji.labels.broken-heart' => 'Gebrochenes Herz',
			'emoji.labels.heart-with-arrow' => 'Herz mit Pfeil',
			'emoji.labels.heart-with-ribbon' => 'Herz mit Schleife',
			'emoji.labels.gorilla' => 'Gorilla',
			'emoji.labels.lion' => 'Löwe',
			'emoji.labels.tiger' => 'Tiger',
			'emoji.labels.leopard' => 'Leopard',
			'emoji.labels.bear' => 'Bär',
			'emoji.labels.polar-bear' => 'Eisbär',
			'emoji.labels.ox' => 'Ochse',
			'emoji.labels.water-buffalo' => 'Wasserbüffel',
			'emoji.labels.bison' => 'Bison',
			'emoji.labels.cow' => 'Kuh',
			'emoji.labels.rhinoceros' => 'Nashorn',
			'emoji.labels.elephant' => 'Elefant',
			'emoji.labels.hippopotamus' => 'Nilpferd',
			'emoji.labels.mammoth' => 'Mammut',
			'emoji.labels.horse' => 'Pferd',
			'emoji.labels.zebra' => 'Zebra',
			'emoji.labels.giraffe' => 'Giraffe',
			'emoji.labels.camel' => 'Kamel',
			'emoji.labels.deer' => 'Hirsch',
			'emoji.labels.ram' => 'Widder',
			'emoji.labels.goat' => 'Ziege',
			'emoji.labels.pig' => 'Schwein',
			'emoji.labels.wolf' => 'Wolf',
			'emoji.labels.fox' => 'Fuchs',
			'emoji.labels.dog' => 'Hund',
			'emoji.labels.cat' => 'Katze',
			'emoji.labels.black-cat' => 'Schwarze Katze',
			'emoji.labels.monkey' => 'Affe',
			'emoji.labels.see-no-evil-monkey' => 'Nichts-sehen-Affe',
			'emoji.labels.kangaroo' => 'Känguru',
			'emoji.labels.rabbit' => 'Hase',
			'emoji.labels.hedgehog' => 'Igel',
			'emoji.labels.koala' => 'Koala',
			'emoji.labels.panda' => 'Panda',
			'emoji.labels.sloth' => 'Faultier',
			'emoji.labels.otter' => 'Otter',
			'emoji.labels.seal' => 'Robbe',
			'emoji.labels.bat' => 'Fledermaus',
			'emoji.labels.eagle' => 'Adler',
			'emoji.labels.owl' => 'Eule',
			'emoji.labels.rooster' => 'Hahn',
			'emoji.labels.chicken' => 'Huhn',
			'emoji.labels.baby-chick' => 'Küken',
			'emoji.labels.duck' => 'Ente',
			'emoji.labels.swan' => 'Schwan',
			'emoji.labels.flamingo' => 'Flamingo',
			'emoji.labels.peacock' => 'Pfau',
			'emoji.labels.parrot' => 'Papagei',
			'emoji.labels.dove' => 'Taube',
			'emoji.labels.penguin' => 'Pinguin',
			'emoji.labels.shark' => 'Hai',
			'emoji.labels.whale' => 'Wal',
			'emoji.labels.dolphin' => 'Delfin',
			'emoji.labels.octopus' => 'Oktopus',
			'emoji.labels.fish' => 'Fisch',
			'emoji.labels.tropical-fish' => 'Tropenfisch',
			'emoji.labels.crab' => 'Krabbe',
			'emoji.labels.lobster' => 'Hummer',
			'emoji.labels.shrimp' => 'Garnele',
			'emoji.labels.turtle' => 'Schildkröte',
			'emoji.labels.crocodile' => 'Krokodil',
			'emoji.labels.snake' => 'Schlange',
			'emoji.labels.frog' => 'Frosch',
			'emoji.labels.t-rex' => 'T-Rex',
			'emoji.labels.sauropod' => 'Sauropode',
			'emoji.labels.dragon' => 'Drache',
			'emoji.labels.unicorn' => 'Einhorn',
			'emoji.labels.butterfly' => 'Schmetterling',
			'emoji.labels.honeybee' => 'Biene',
			'emoji.labels.scorpion' => 'Skorpion',
			'emoji.labels.cut-of-meat' => 'Steak',
			'emoji.labels.meat-on-bone' => 'Fleischhaxe',
			'emoji.labels.poultry-leg' => 'Hähnchenschenkel',
			'emoji.labels.bacon' => 'Speck',
			'emoji.labels.egg' => 'Ei',
			'emoji.labels.cooked-rice' => 'Gekochter Reis',
			'emoji.labels.steaming-bowl' => 'Dampfende Schüssel',
			'emoji.labels.green-salad' => 'Grüner Salat',
			'emoji.labels.broccoli' => 'Brokkoli',
			'emoji.labels.avocado' => 'Avocado',
			'emoji.labels.banana' => 'Banane',
			'emoji.labels.red-apple' => 'Roter Apfel',
			'emoji.labels.green-apple' => 'Grüner Apfel',
			'emoji.labels.pear' => 'Birne',
			'emoji.labels.peach' => 'Pfirsich',
			'emoji.labels.cherries' => 'Kirschen',
			'emoji.labels.strawberry' => 'Erdbeere',
			'emoji.labels.blueberries' => 'Blaubeeren',
			'emoji.labels.grapes' => 'Weintrauben',
			'emoji.labels.watermelon' => 'Wassermelone',
			'emoji.labels.pineapple' => 'Ananas',
			'emoji.labels.mango' => 'Mango',
			'emoji.labels.kiwi-fruit' => 'Kiwi',
			'emoji.labels.lemon' => 'Zitrone',
			'emoji.labels.coconut' => 'Kokosnuss',
			'emoji.labels.carrot' => 'Karotte',
			'emoji.labels.potato' => 'Kartoffel',
			'emoji.labels.tomato' => 'Tomate',
			'emoji.labels.bell-pepper' => 'Paprika',
			'emoji.labels.hot-pepper' => 'Chili',
			'emoji.labels.eggplant' => 'Aubergine',
			'emoji.labels.bread' => 'Brot',
			'emoji.labels.croissant' => 'Croissant',
			'emoji.labels.glass-of-milk' => 'Glas Milch',
			'emoji.labels.hot-beverage' => 'Kaffee',
			'emoji.labels.honey-pot' => 'Honigtopf',
			'emoji.labels.chocolate-bar' => 'Schokolade',
			'emoji.labels.cookie' => 'Keks',
			'emoji.labels.doughnut' => 'Donut',
			'emoji.labels.ice-cream' => 'Eis',
			'emoji.labels.birthday-cake' => 'Geburtstagskuchen',
			'emoji.labels.pancakes' => 'Pfannkuchen',
			'emoji.labels.popcorn' => 'Popcorn',
			'emoji.labels.lollipop' => 'Lutscher',
			'emoji.labels.pizza' => 'Pizza',
			'emoji.labels.hamburger' => 'Burger',
			_ => null,
		} ?? switch (path) {
			'emoji.labels.french-fries' => 'Pommes',
			'emoji.labels.taco' => 'Taco',
			'emoji.labels.sushi' => 'Sushi',
			'emoji.labels.fork-and-knife' => 'Besteck',
			'emoji.labels.bottle-with-popping-cork' => 'Sektflasche',
			'emoji.labels.clinking-glasses' => 'Anstoßende Gläser',
			'emoji.labels.wine-glass' => 'Weinglas',
			'emoji.labels.beer-mug' => 'Bierkrug',
			'emoji.labels.tropical-drink' => 'Tropischer Cocktail',
			'emoji.labels.sun' => 'Sonne',
			'emoji.labels.sun-with-face' => 'Sonne mit Gesicht',
			'emoji.labels.sunrise' => 'Sonnenaufgang',
			'emoji.labels.sunrise-over-mountains' => 'Sonnenaufgang über Bergen',
			'emoji.labels.sunset' => 'Sonnenuntergang',
			'emoji.labels.cloud' => 'Wolke',
			'emoji.labels.cloud-with-rain' => 'Regenwolke',
			'emoji.labels.cloud-with-lightning' => 'Gewitterwolke',
			'emoji.labels.cloud-with-lightning-and-rain' => 'Gewitter mit Regen',
			'emoji.labels.snowflake' => 'Schneeflocke',
			'emoji.labels.rainbow' => 'Regenbogen',
			'emoji.labels.crescent-moon' => 'Mondsichel',
			'emoji.labels.full-moon' => 'Vollmond',
			'emoji.labels.night-with-stars' => 'Sternennacht',
			'emoji.labels.milky-way' => 'Milchstraße',
			'emoji.labels.mountain' => 'Berg',
			'emoji.labels.snow-capped-mountain' => 'Schneebedeckter Berg',
			'emoji.labels.volcano' => 'Vulkan',
			'emoji.labels.desert-island' => 'Einsame Insel',
			'emoji.labels.beach-with-umbrella' => 'Strand mit Sonnenschirm',
			'emoji.labels.water-wave' => 'Welle',
			'emoji.labels.droplet' => 'Tropfen',
			'emoji.labels.tornado' => 'Tornado',
			'emoji.labels.palm-tree' => 'Palme',
			'emoji.labels.cactus' => 'Kaktus',
			'emoji.labels.seedling' => 'Sämling',
			'emoji.labels.four-leaf-clover' => 'Vierblättriges Kleeblatt',
			'emoji.labels.sunflower' => 'Sonnenblume',
			'emoji.labels.rose' => 'Rose',
			'emoji.labels.tulip' => 'Tulpe',
			'emoji.labels.cherry-blossom' => 'Kirschblüte',
			'emoji.labels.maple-leaf' => 'Ahornblatt',
			'emoji.labels.globe-showing-europe-africa' => 'Globus',
			'emoji.labels.globe-with-meridians' => 'Globus mit Meridianen',
			'emoji.labels.house' => 'Haus',
			'emoji.labels.cityscape' => 'Stadt',
			'emoji.labels.tent' => 'Zelt',
			'emoji.labels.hot-springs' => 'Heiße Quelle',
			'emoji.labels.world-map' => 'Weltkarte',
			'emoji.labels.compass' => 'Kompass',
			'emoji.labels.airplane' => 'Flugzeug',
			'emoji.labels.automobile' => 'Auto',
			'emoji.labels.racing-car' => 'Rennwagen',
			'emoji.labels.motorcycle' => 'Motorrad',
			'emoji.labels.sailboat' => 'Segelboot',
			'emoji.labels.gear' => 'Zahnrad',
			'emoji.labels.hammer' => 'Hammer',
			'emoji.labels.wrench' => 'Schraubenschlüssel',
			'emoji.labels.hammer-and-wrench' => 'Hammer und Schraubenschlüssel',
			'emoji.labels.brick' => 'Ziegelstein',
			'emoji.labels.puzzle-piece' => 'Puzzleteil',
			'emoji.labels.game-die' => 'Würfel',
			'emoji.labels.joystick' => 'Joystick',
			'emoji.labels.video-game' => 'Gamecontroller',
			'emoji.labels.headphone' => 'Kopfhörer',
			'emoji.labels.musical-note' => 'Musiknote',
			'emoji.labels.musical-notes' => 'Musiknoten',
			'emoji.labels.guitar' => 'Gitarre',
			'emoji.labels.calendar' => 'Kalender',
			'emoji.labels.mobile-phone' => 'Smartphone',
			'emoji.labels.laptop' => 'Laptop',
			'emoji.labels.clipboard' => 'Klemmbrett',
			'emoji.labels.memo' => 'Notiz',
			'emoji.labels.pencil' => 'Bleistift',
			'emoji.labels.chart-increasing' => 'Steigender Graph',
			'emoji.labels.bar-chart' => 'Balkendiagramm',
			'emoji.labels.balance-scale' => 'Waage',
			'emoji.labels.books' => 'Bücher',
			'emoji.labels.open-book' => 'Offenes Buch',
			'emoji.labels.graduation-cap' => 'Doktorhut',
			'emoji.labels.money-bag' => 'Geldsack',
			'emoji.labels.coin' => 'Münze',
			'emoji.labels.locked' => 'Geschlossenes Schloss',
			'emoji.labels.unlocked' => 'Offenes Schloss',
			'emoji.labels.key' => 'Schlüssel',
			'emoji.labels.dna' => 'DNA',
			'emoji.labels.pill' => 'Pille',
			'emoji.labels.stethoscope' => 'Stethoskop',
			'emoji.labels.adhesive-bandage' => 'Pflaster',
			'emoji.labels.speech-balloon' => 'Sprechblase',
			'emoji.labels.thought-balloon' => 'Gedankenblase',
			'errors.network' => 'Keine Netzwerkverbindung. Überprüfe deine Verbindung.',
			'errors.notFound' => 'Element nicht gefunden.',
			'errors.generic' => 'Ein Fehler ist aufgetreten. Versuche es erneut.',
			'errors.invalidCode' => 'Ungültiger oder abgelaufener Code.',
			'errors.passwordSameAsOld' => 'Das neue Passwort muss sich vom alten unterscheiden.',
			'errors.auth.invalidCredentials' => 'E-Mail oder Passwort falsch.',
			'errors.auth.emailNotConfirmed' => 'Bestätige deine E-Mail vor der Anmeldung.',
			'errors.auth.userAlreadyExists' => 'Mit dieser E-Mail existiert bereits ein Konto.',
			'errors.auth.sessionExpired' => 'Sitzung abgelaufen. Melde dich erneut an.',
			'errors.auth.notSignedIn' => 'Du musst angemeldet sein.',
			'goals.strength' => 'Kraft',
			'goals.hypertrophy' => 'Hypertrophie',
			'goals.endurance' => 'Ausdauer',
			'goals.weightLoss' => 'Gewichtsverlust',
			'goals.maintenance' => 'Erhaltung',
			'history.title' => 'Verlauf',
			'history.emptySubtitle' => 'Keine Einheiten',
			'history.emptyTitle' => 'Noch keine Einheiten',
			'history.emptyMessage' => 'Starte deine erste Einheit über den Startbildschirm — sie erscheint dann hier.',
			'history.sessionCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} Einheit', other: '${n} Einheiten', ), 
			'history.deleteError' => 'Löschen fehlgeschlagen.',
			'history.noResult' => 'Keine Einheiten für diese Gruppe',
			'history.groups.thisWeek' => 'Diese Woche',
			'history.groups.lastWeek' => 'Letzte Woche',
			'history.groups.weeksAgo' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: 'vor ${n} Woche', other: 'vor ${n} Wochen', ), 
			'history.panel.sessions' => 'Einheiten',
			'history.panel.volume' => 'Volumen',
			'history.panel.time' => 'Zeit',
			'history.detail.title' => 'Einheit',
			'history.detail.dateFormat' => 'EEEE, d. MMMM \'um\' HH:mm',
			'history.detail.duration' => 'Dauer',
			'history.detail.tonnage' => 'Tonnage',
			'history.detail.sets' => 'Sätze',
			'history.detail.notes' => 'Notizen',
			'history.detail.perExercise' => 'Details pro Übung',
			'history.detail.setsCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} Satz', other: '${n} Sätze', ), 
			'history.detail.bodyweight' => 'Körpergewicht',
			'history.detail.colSet' => 'Satz',
			'history.detail.colReps' => 'Wdh.',
			'history.detail.colLoad' => 'Last',
			'history.detail.colHeld' => 'Gehalten',
			'history.detail.totalExercise' => 'Übung gesamt',
			'history.detail.totalHeld' => 'Gesamt gehalten',
			'history.detail.edit.open' => 'Bearbeiten',
			'history.detail.edit.title' => 'Einheit bearbeiten',
			'history.detail.edit.name' => 'Titel',
			'history.detail.edit.namePlaceholder' => 'Name der Einheit',
			'history.detail.edit.date' => 'Datum',
			'history.detail.edit.time' => 'Uhrzeit',
			'history.detail.edit.durationLabel' => 'Dauer',
			'history.detail.edit.hours' => 'Std.',
			'history.detail.edit.minutes' => 'Min.',
			'history.detail.edit.notesPlaceholder' => 'Wie ist es gelaufen?',
			'history.detail.edit.save' => 'Speichern',
			'history.detail.edit.saved' => 'Einheit aktualisiert.',
			'history.detail.edit.error' => 'Aktualisierung fehlgeschlagen.',
			'history.detail.edit.nameRequired' => 'Ein Titel ist erforderlich.',
			'history.detail.edit.dateFormat' => 'd. MMMM y',
			'legal.onlyInEnglish' => 'Dieses Dokument ist nur auf Englisch verfügbar.',
			'muscleGroups.chest' => 'Brust',
			'muscleGroups.back' => 'Rücken',
			'muscleGroups.shoulders' => 'Schultern',
			'muscleGroups.biceps' => 'Bizeps',
			'muscleGroups.triceps' => 'Trizeps',
			'muscleGroups.forearms' => 'Unterarme',
			'muscleGroups.quads' => 'Quadrizeps',
			'muscleGroups.hamstrings' => 'Beinbeuger',
			'muscleGroups.glutes' => 'Gesäß',
			'muscleGroups.calves' => 'Waden',
			'muscleGroups.abs' => 'Bauch',
			'muscleGroups.custom' => 'Andere',
			'muscleGroups.sections.chestBack' => 'Brust & Rücken',
			'muscleGroups.sections.shouldersArms' => 'Schultern & Arme',
			'muscleGroups.sections.legsGlutes' => 'Beine & Gesäß',
			'muscleGroups.sections.abs' => 'Bauch',
			'muscleGroups.sections.other' => 'Andere',
			'nav.home' => 'Start',
			'nav.program' => 'Programm',
			'nav.history' => 'Verlauf',
			'nav.stats' => 'Statistik',
			'nav.settings' => 'Einstellungen',
			'profile.notConnected' => 'Nicht angemeldet.',
			'profile.navTitle' => 'PROFIL',
			'profile.defaultName' => 'Athlet',
			'profile.since' => ({required Object month}) => 'Seit ${month}',
			'profile.editSheet.title' => 'Profil bearbeiten',
			'profile.sections.favoriteMuscleGroup' => 'Bevorzugte Muskelgruppe',
			'profile.sections.badges' => 'Abzeichen',
			'profile.stats.sessions' => 'Einheiten',
			'profile.stats.tonnage' => 'Tonnage',
			'profile.stats.sets' => 'Sätze',
			'profile.sessionCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} Einheit', other: '${n} Einheiten', ), 
			'profile.badges.empty' => 'Starte deine erste Einheit, um Abzeichen freizuschalten!',
			'profile.badges.firstSession' => 'Erste Einheit',
			'profile.badges.tenSessions' => '10 Einheiten',
			'profile.badges.tenTonnes' => '10 Tonnen',
			'profile.badges.planner' => 'Planer',
			'profile.avatar.sheetTitle' => 'Profilfoto',
			'profile.avatar.takePhoto' => 'Foto aufnehmen',
			'profile.avatar.gallery' => 'Fotogalerie',
			'profile.avatar.remove' => 'Foto entfernen',
			'profile.avatar.openError' => 'Das Foto konnte nicht geöffnet werden.',
			'profile.avatar.updated' => 'Foto aktualisiert!',
			'profile.avatar.saveError' => 'Das Foto konnte nicht gespeichert werden.',
			'profile.avatar.removed' => 'Foto entfernt.',
			'profile.avatar.removeError' => 'Das Foto konnte nicht entfernt werden.',
			'profile.editForm.saved' => 'Profil aktualisiert.',
			'profile.editForm.pickDate' => 'Datum wählen',
			'profile.editForm.sections.identity' => 'Identität',
			'profile.editForm.sections.physique' => 'Körperbau',
			'profile.editForm.sections.goal' => 'Ziel',
			'profile.editForm.fields.name' => 'Name / Spitzname',
			'profile.editForm.fields.bio' => 'Bio',
			'profile.editForm.fields.birthdate' => 'Geburtsdatum',
			'profile.editForm.fields.weight' => 'Gewicht (kg)',
			'profile.editForm.fields.height' => 'Größe (cm)',
			'profile.editForm.validation.nameMin' => 'Mindestens 2 Zeichen',
			'profile.editForm.validation.nameMax' => 'Maximal 60 Zeichen',
			'profile.editForm.validation.invalidNumber' => 'Ungültige Zahl',
			'profile.editForm.validation.heightRange' => 'Zwischen 80 und 260 cm',
			'profile.editForm.validation.weightRange' => 'Zwischen 30 und 350 kg',
			'session.bw' => 'KG',
			'session.continueLabel' => 'Weiter',
			'session.error.startFailed' => 'Training konnte nicht gestartet werden.',
			'session.error.saveFailed' => 'Speichern fehlgeschlagen.',
			'session.error.templateUpdateFailed' => 'Einheit gespeichert, aber die Vorlage konnte nicht aktualisiert werden.',
			'session.live.exercisePosition' => ({required Object current, required Object total}) => 'Übung ${current} / ${total}',
			'session.live.supersetPosition' => ({required Object current, required Object total}) => 'Supersatz ${current} / ${total}',
			'session.live.headerSubtitle' => ({required Object completed, required Object total, required Object time}) => '${completed}/${total} Sätze · ${time}',
			'session.live.totalTonnage' => 'Gesamttonnage',
			'session.live.nextExercise' => 'Nächste Übung',
			'session.live.nextBlock' => 'Nächster Block',
			'session.live.finishSession' => 'Training beenden',
			'session.confirm.quitTitle' => 'Training verwerfen?',
			'session.confirm.quitMessage' => 'Der gesamte Fortschritt geht verloren.',
			'session.confirm.quitConfirm' => 'Verwerfen',
			'session.confirm.inProgressTitle' => 'Ein Training läuft bereits',
			'session.confirm.inProgressMessage' => ({required Object name, required Object date}) => '„${name}“ wurde ${date} gestartet. Ein neues zu starten löscht seinen Fortschritt endgültig.',
			'session.confirm.overwriteAndStart' => 'Überschreiben und starten',
			'session.confirm.deleteExerciseTitle' => ({required Object name}) => '„${name}“ löschen?',
			'session.confirm.deleteExerciseMessage' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: 'Diese Übung hat bereits ${n} abgeschlossenen Satz. Er geht verloren.', other: 'Diese Übung hat bereits ${n} abgeschlossene Sätze. Sie gehen verloren.', ), 
			'session.confirm.removeSessionOnly' => 'Nur in dieser Einheit',
			'session.confirm.removeFromTemplate' => 'Auch aus der Vorlage',
			'session.add.title' => 'Übung hinzufügen',
			'session.add.subtitle' => 'Nur zu diesem Training hinzugefügt, ohne die Vorlage zu ändern.',
			'session.add.addLabel' => 'Hinzufügen',
			'session.add.addToSession' => 'Zum Training hinzufügen',
			'session.add.reps' => 'Wiederholungen',
			'session.add.time' => 'Zeit',
			'session.add.addAndTemplate' => 'Zur Einheit und zur Vorlage hinzufügen',
			'session.swap.title' => 'Übung bearbeiten',
			'session.swap.currently' => ({required Object name}) => 'Aktuell: ${name}',
			'session.swap.sessionOnly' => 'Diese Änderungen gelten nur für dieses Training.',
			'session.swap.useLabel' => 'Verwenden',
			'session.swap.adoptFormat' => 'Format übernehmen',
			'session.swap.adoptFormatSummary' => ({required Object summary, required Object name}) => '${summary} · nach „${name}“',
			'session.swap.apply' => 'Für dieses Training anwenden',
			'session.swap.applyAndTemplate' => 'Anwenden und Vorlage aktualisieren',
			'session.variants.title' => 'Variante wählen',
			'session.variants.lockedMessage' => 'Ein Satz ist bereits abgeschlossen — beende die Übung oder nutze „Tauschen“, um unterwegs anzupassen.',
			'session.variants.pickMessage' => 'Wähle eine Variante für diesen Platz. Sie ersetzt die aktuelle Übung.',
			'session.variants.empty' => 'Für diese Übung ist keine Variante definiert.',
			'session.variants.main' => 'HAUPT',
			'session.variants.variantN' => ({required Object n}) => 'Variante ${n}',
			'session.variants.restSeconds' => ({required Object n}) => '${n}s Pause',
			'session.variants.tempoPart' => ({required Object tempo}) => ' · Tempo ${tempo}',
			'session.finish.title' => 'Training beenden?',
			'session.finish.summaryReps' => ({required Object completed, required Object total}) => '${completed}/${total} Sätze · ',
			'session.finish.summaryTonnageSuffix' => ' Tonnage',
			'session.finish.notesHint' => 'Notizen zum Training (optional)…',
			'session.finish.confirm' => 'Beenden',
			'session.finish.unvalidatedSets' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} NICHT BESTÄTIGTER SATZ', other: '${n} NICHT BESTÄTIGTE SÄTZE', ), 
			'session.finish.incompleteHint' => 'Du kannst zurückgehen und deine Sätze bestätigen oder trotzdem beenden — nur markierte Sätze werden gespeichert.',
			'session.finish.templateLabel' => 'VORLAGE AKTUALISIEREN',
			'session.finish.templateToggle' => ({required Object name}) => '„${name}“ aktualisieren',
			'session.finish.templateHint' => 'Die während der Einheit markierten Änderungen. Ausschalten, um die Vorlage unverändert zu lassen.',
			'session.finish.changeAdded' => ({required Object name}) => '${name} · hinzugefügt',
			'session.finish.changeModified' => ({required Object name}) => '${name} · geändert',
			'session.finish.changeRemoved' => ({required Object name}) => '${name} · entfernt',
			'session.timer.preparation' => 'BEREIT MACHEN',
			'session.timer.running' => 'LÄUFT',
			'session.timer.done' => 'FERTIG',
			'session.timer.go' => 'LOS',
			'session.timer.stop' => 'Stopp',
			'session.rest.title' => 'PAUSE',
			'session.rest.sec' => 'SEK',
			'session.rest.skip' => 'Überspringen',
			'session.rest.minimize' => 'Verkleinern',
			'session.set.addSet' => 'Satz hinzufügen',
			'session.set.setLabel' => ({required Object n}) => 'Satz ${n}',
			'session.set.reps' => 'Wdh.',
			'session.set.load' => 'Gewicht',
			'session.set.duration' => 'Dauer',
			'session.set.held' => 'Gehalten',
			'session.set.tonnage' => 'TONNAGE',
			'session.set.targetReps' => ({required Object n}) => 'Ziel ${n} Wdh.',
			'session.set.targetDuration' => ({required Object value}) => 'Ziel ${value}',
			'session.set.validateWithoutTimer' => 'Ohne Timer bestätigen',
			'session.set.cmpUp' => 'Top',
			'session.exercise.timed' => 'Auf Zeit',
			'session.exercise.tempoChip' => ({required Object tempo}) => 'Tempo ${tempo}',
			'session.exercise.restChip' => ({required Object n}) => '${n}s Pause',
			'session.exercise.modified' => 'Geändert · nur dieses Training',
			'session.exercise.modifiedWas' => ({required Object name}) => 'Geändert · nur dieses Training (war: ${name})',
			'session.exercise.completedBadge' => '✓ Fertig',
			'session.exercise.totalHeld' => ({required Object value}) => 'Gesamt gehalten: ${value}',
			'session.exercise.exerciseVolume' => ({required Object value}) => 'Übungsvolumen: ${value} kg',
			'session.exercise.lastTimeLabel' => 'Letztes Mal',
			'session.exercise.otherWorkout' => 'anderes Workout',
			'session.exercise.targetWasReps' => ({required Object n}) => 'Ziel war ${n} Wdh.',
			'session.exercise.targetWasSeconds' => ({required Object n}) => 'Ziel war ${n}s',
			'session.exercise.morePerfs' => ({required Object n}) => '+${n}',
			'session.exercise.keptInTemplate' => 'Geändert · wird in der Vorlage gespeichert',
			'session.exercise.keptInTemplateWas' => ({required Object name}) => 'Geändert · wird in der Vorlage gespeichert (vorher: ${name})',
			'session.exercise.keepInTemplateAction' => 'Antippen, um diese Änderung in der Vorlage zu behalten',
			'session.overview.title' => 'Übungen',
			'session.overview.current' => 'AKTUELL',
			'session.overview.setsValidated' => ({required Object completed, required Object total}) => '${completed}/${total} Sätze bestätigt',
			'session.superset.badge' => ({required Object n}) => 'SUPERSATZ · ${n} ÜBUNGEN',
			'session.superset.addSetTo' => ({required Object letter, required Object name}) => 'Satz zu ${letter} hinzufügen · ${name}',
			'session.duration.title' => 'Dauer pro Satz',
			'session.duration.hint' => '45 oder 1m30',
			'session.duration.confirm' => ({required Object value}) => 'Bestätigen — ${value}',
			'session.weight.bodyweight' => 'Körpergewicht',
			'session.weight.confirmBodyweight' => 'Bestätigen — Körpergewicht',
			'session.weight.confirmKg' => ({required Object value}) => 'Bestätigen — ${value} kg',
			'session.search.hint' => 'Übung suchen…',
			'session.search.loading' => 'Übungen werden geladen…',
			'session.search.noMatch' => 'Keine Übung passt.',
			'session.search.certifiedBadge' => 'Repster-Übung',
			'session.history.title' => ({required Object name}) => 'Verlauf · ${name}',
			'session.history.empty' => 'Noch kein Verlauf für diese Übung.',
			'session.history.loading' => 'Verlauf wird geladen…',
			'session.history.setLabel' => ({required Object n}) => 'Satz ${n}',
			'session.history.dateFormat' => 'd. MMM yyyy',
			'session.fields.exerciseName' => 'Name der Übung',
			'session.fields.type' => 'Typ',
			'session.fields.sets' => 'Sätze',
			'session.fields.durationSec' => 'Dauer (Sek.)',
			'session.fields.targetReps' => 'Ziel-Wdh.',
			'session.fields.restShort' => 'Pause (Sek.)',
			'session.fields.rest' => 'Pause (Sek.)',
			'session.fields.tempo' => 'Tempo',
			'session.fields.notesOptional' => 'Notizen (optional)',
			'session.fields.notesHint' => 'Technik-Tipps…',
			'session.fields.keepInTemplate' => 'Auch in der Vorlage speichern',
			'session.fields.keepInTemplateHint' => 'Standardmäßig gilt die Änderung nur für diese Einheit.',
			'session.toast.exerciseAdded' => ({required Object name}) => '${name} zum Training hinzugefügt',
			'session.toast.validateOneSet' => 'Bestätige mindestens einen Satz, bevor du beendest.',
			'session.toast.sessionSaved' => 'Training gespeichert! 🎉',
			'session.toast.finishOrSwap' => 'Beende den aktuellen Satz oder nutze „Tauschen“.',
			'session.notif.countdownChannel' => 'Erholungs-Countdown',
			'session.notif.doneChannel' => 'Erholung beendet',
			'session.notif.doneTitle' => 'Erholung vorbei',
			'settings.title' => 'Einstellungen',
			'settings.sections.profile' => 'Profil',
			'settings.sections.data' => 'Meine Daten',
			'settings.sections.preferences' => 'Einstellungen',
			'settings.sections.account' => 'Konto',
			'settings.defaultName' => 'Athlet',
			'settings.editProfile' => 'BEARBEITEN',
			'settings.profileUnavailable' => 'Profil nicht verfügbar',
			'settings.rows.templates' => 'Meine Vorlagen',
			'settings.rows.history' => 'Trainingsverlauf',
			'settings.rows.stats' => 'Statistiken',
			'settings.rows.notifications' => 'Benachrichtigungen',
			'settings.rows.privacy' => 'Datenschutz',
			'settings.rows.terms' => 'Nutzungsbedingungen',
			'settings.rows.contact' => 'Kontakt & Feedback',
			'settings.rows.language' => 'Sprache',
			'settings.rows.changePassword' => 'Passwort ändern',
			'settings.soon' => 'Bald',
			'settings.soonToast' => 'Demnächst verfügbar',
			'settings.logout.action' => 'Abmelden',
			'settings.logout.error' => 'Abmeldung fehlgeschlagen.',
			'settings.version' => 'Repster v1.0 · Trainiere, wachse, wiederhole.',
			'settings.language.title' => 'Sprache',
			'settings.language.subtitle' => 'Wähle die App-Sprache',
			'settings.language.system' => 'Systemsprache',
			'stats.title' => 'Statistiken',
			'stats.sessionsCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} Einheit', other: '${n} Einheiten', ), 
			'stats.weeksShort' => ({required Object n}) => '${n} Wo.',
			'stats.subtitle.empty' => 'Keine Einheiten im Zeitraum',
			'stats.empty.title' => 'Noch keine Daten',
			'stats.empty.message' => 'Absolviere ein paar Einheiten, um deine Kurven und Fortschritte zu sehen.',
			'stats.range.last4Weeks.label' => '4 Wochen',
			'stats.range.last4Weeks.short' => '4 Wo.',
			'stats.range.last3Months.label' => '3 Monate',
			'stats.range.last3Months.short' => '3 Mon.',
			'stats.range.all.label' => 'Alles',
			'stats.range.all.short' => 'Alles',
			'stats.kpi.sessions' => 'Einheiten',
			'stats.kpi.volume' => 'Tonnage',
			'stats.kpi.sets' => 'Sätze',
			'stats.kpi.avgDuration' => 'Ø Dauer',
			'stats.kpi.tension' => 'Zeit unter Spannung',
			'stats.weeklyVolume.title' => 'Volumen pro Woche',
			'stats.weeklyVolume.empty' => 'Noch nicht genug Einheiten im Zeitraum.',
			'stats.weeklyVolume.inProgress' => 'laufend',
			'stats.exercise.title' => 'Fortschritt pro Übung',
			'stats.exercise.empty' => 'Absolviere mindestens 2 Einheiten mit derselben belasteten Übung, um deine Kraftkurve zu sehen.',
			'stats.exercise.pickerTitle' => 'Übung auswählen',
			'stats.exercise.noExercise' => 'Keine Übung',
			'stats.exercise.searchHint' => 'Suchen…',
			'stats.exercise.oneRmMax' => 'max. geschätztes 1RM',
			'stats.exercise.bestLoad' => 'beste Last',
			'stats.exercise.record' => 'Rekord',
			'stats.exercise.trendUnknown' => 'Noch nicht genug Einheiten für einen Trend',
			'stats.exercise.trendProgressing' => 'Fortschritt',
			'stats.exercise.trendPlateau' => ({required Object n}) => 'Plateau · ${n} Einheiten ohne Bestwert',
			'stats.exercise.trendRegressing' => 'Rückschritt',
			'stats.exercise.perMonth' => ({required Object value}) => '${value} %/Monat',
			'stats.exercise.plateauHint' => 'Weniger Wdh. mit mehr Gewicht, oder Übung wechseln.',
			'stats.muscleBalance.title' => 'Muskelbalance',
			'stats.muscleBalance.neglected' => ({required Object days, required Object emoji}) => '— seit ${days} T. nicht trainiert ${emoji}',
			'stats.muscleBalance.since.none' => '–',
			'stats.muscleBalance.since.today' => 'heute',
			'stats.muscleBalance.since.yesterday' => 'gestern',
			'stats.muscleBalance.since.daysShort' => ({required Object n}) => '${n}T',
			'stats.records.title' => 'Rekorde',
			'stats.records.bestSession' => 'Beste Einheit',
			'stats.records.heaviestLift' => 'Schwerste Last',
			'stats.records.bestOneRm' => 'Geschätztes 1RM',
			'stats.records.bestStreak' => 'Längste Serie',
			'stats.records.consecutiveWeeks' => 'aufeinanderfolgende Wochen',
			'stats.strength.title' => 'Kraft',
			'stats.strength.scope' => 'gesamte Historie',
			'templates.list.title' => 'Programm',
			'templates.list.subtitleActive' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} aktive Einheit', other: '${n} aktive Einheiten', ), 
			'templates.list.subtitleManage' => ({required num n, required Object total}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} / ${total} aktiv', other: '${n} / ${total} aktiv', ), 
			'templates.list.manage' => 'Verwalten',
			'templates.list.newAction' => 'Erstellen',
			'templates.list.emptyTitle' => 'Keine Einheiten',
			'templates.list.emptyMessage' => 'Erstelle deine erste Einheit, um dein Programm aufzubauen.',
			'templates.list.emptyAction' => 'Einheit erstellen',
			'templates.list.emptyActiveTitle' => 'Keine Einheiten im Programm',
			'templates.list.emptyActiveMessage' => 'Aktiviere Einheiten, um sie deinem Programm hinzuzufügen.',
			'templates.list.emptyActiveAction' => 'Einheiten verwalten',
			'templates.list.noResult' => 'Keine Ergebnisse',
			'templates.list.searchHint' => 'Einheit suchen…',
			'templates.list.manageHint' => 'Ziehen zum Umsortieren · tippe auf den Kreis, um eine Einheit aus-/einzublenden',
			'templates.list.savedChanges' => 'Änderungen gespeichert ✓',
			'templates.list.reorderError' => 'Umsortieren fehlgeschlagen.',
			'templates.list.toggleError' => 'Aktion nicht möglich.',
			'templates.list.duplicated' => 'Einheit kopiert!',
			'templates.list.duplicateError' => 'Duplizieren fehlgeschlagen.',
			'templates.list.deleted' => 'Einheit gelöscht.',
			'templates.list.deleteError' => 'Löschen fehlgeschlagen.',
			'templates.list.copySuffix' => '(Kopie)',
			'templates.card.exerciseCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} Übung', other: '${n} Übungen', ), 
			'templates.card.details' => 'Details',
			'templates.card.copy' => 'Kopieren',
			'templates.card.deleteShort' => 'Löschen',
			'templates.card.activate' => 'Aktivieren',
			'templates.card.deactivate' => 'Deaktivieren',
			'templates.detail.title' => 'Vorlage',
			'templates.detail.noExercises' => 'Keine Übungen in dieser Vorlage.',
			'templates.detail.superset' => 'Supersatz',
			'templates.detail.setsCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} Satz', other: '${n} Sätze', ), 
			'templates.detail.seconds' => ({required Object n}) => '${n} s',
			'templates.detail.tempo' => ({required Object value}) => 'Tempo ${value}',
			'templates.detail.rest' => ({required Object n}) => 'Pause ${n}s',
			'templates.detail.variantsMore' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '+${n} Variante', other: '+${n} Varianten', ), 
			'templates.detail.start' => 'Einheit starten',
			'templates.editor.newTitle' => 'Neue Einheit',
			'templates.editor.editTitle' => 'Einheit bearbeiten',
			'templates.editor.exercisesHeader' => ({required Object count}) => 'ÜBUNGEN (${count})',
			'templates.editor.addExercise' => 'Übung hinzufügen',
			'templates.editor.save' => 'Einheit speichern',
			'templates.editor.validationError' => 'Gib einen Namen und mindestens eine benannte Übung ein.',
			'templates.fields.name' => 'Name der Einheit',
			'templates.fields.nameHint' => 'z. B. Brust / Trizeps / Schultern',
			'templates.fields.description' => 'Beschreibung (optional)',
			'templates.fields.descriptionHint' => 'Beschreibe deine Einheit…',
			'templates.fields.emoji' => 'Bild',
			'templates.fields.muscleGroups' => 'Muskelgruppen',
			'templates.fields.selectedCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} ausgewählt', other: '${n} ausgewählt', ), 
			'templates.fields.exerciseName' => 'Name der Übung',
			'templates.fields.exerciseNameHint' => 'z. B. Bankdrücken',
			'templates.fields.type' => 'Typ',
			'templates.fields.sets' => 'Sätze',
			'templates.fields.duration' => 'Dauer (s)',
			'templates.fields.targetReps' => 'Ziel-Wdh.',
			'templates.fields.rest' => 'Pause (s)',
			'templates.fields.tempo' => 'Tempo',
			'templates.fields.tempoHint' => '3-1-X-0',
			'templates.fields.notes' => 'Notizen (optional)',
			'templates.fields.notesHint' => 'Technische Tipps…',
			'templates.slot.newExercise' => 'Neue Übung',
			'templates.slot.variantN' => ({required Object n}) => 'Variante ${n}',
			'templates.slot.primary' => 'PRIMÄR',
			'templates.slot.variant' => 'Variante',
			'templates.slot.addVariant' => 'Variante hinzufügen',
			'templates.slot.supersetNote' => 'Als Supersatz mit der nächsten Übung verkettet',
			'templates.slot.supersetLabel' => 'SUPERSATZ',
			'templates.slot.reps' => 'Wiederholungen',
			'templates.slot.time' => 'Zeit',
			'templates.emojiPicker.title' => 'Bild der Einheit',
			'templates.emojiPicker.searchHint' => 'Emoji suchen…',
			'templates.emojiPicker.noResults' => 'Kein Emoji passt.',
			'templates.emojiPicker.change' => 'Ändern',
			'tempo.helper' => 'Exzentrisch — Pause — konzentrisch — Pause (in s)',
			'tempo.formatError' => 'Erwartetes Format: 3-1-X-0',
			_ => null,
		};
	}
}
