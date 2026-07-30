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
class TranslationsFr extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsFr({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.fr,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <fr>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	late final TranslationsFr _root = this; // ignore: unused_field

	@override 
	TranslationsFr $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsFr(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$auth$fr auth = _Translations$auth$fr._(_root);
	@override late final _Translations$common$fr common = _Translations$common$fr._(_root);
	@override late final _Translations$contact$fr contact = _Translations$contact$fr._(_root);
	@override late final _Translations$dashboard$fr dashboard = _Translations$dashboard$fr._(_root);
	@override late final _Translations$errors$fr errors = _Translations$errors$fr._(_root);
	@override late final _Translations$goals$fr goals = _Translations$goals$fr._(_root);
	@override late final _Translations$history$fr history = _Translations$history$fr._(_root);
	@override late final _Translations$legal$fr legal = _Translations$legal$fr._(_root);
	@override late final _Translations$muscleGroups$fr muscleGroups = _Translations$muscleGroups$fr._(_root);
	@override late final _Translations$nav$fr nav = _Translations$nav$fr._(_root);
	@override late final _Translations$profile$fr profile = _Translations$profile$fr._(_root);
	@override late final _Translations$session$fr session = _Translations$session$fr._(_root);
	@override late final _Translations$settings$fr settings = _Translations$settings$fr._(_root);
	@override late final _Translations$stats$fr stats = _Translations$stats$fr._(_root);
	@override late final _Translations$templates$fr templates = _Translations$templates$fr._(_root);
	@override late final _Translations$tempo$fr tempo = _Translations$tempo$fr._(_root);
}

// Path: auth
class _Translations$auth$fr extends Translations$auth$en {
	_Translations$auth$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final _Translations$auth$fields$fr fields = _Translations$auth$fields$fr._(_root);
	@override String get backToLogin => 'Retour à la connexion';
	@override late final _Translations$auth$login$fr login = _Translations$auth$login$fr._(_root);
	@override late final _Translations$auth$signup$fr signup = _Translations$auth$signup$fr._(_root);
	@override late final _Translations$auth$onboarding$fr onboarding = _Translations$auth$onboarding$fr._(_root);
	@override late final _Translations$auth$verifyEmail$fr verifyEmail = _Translations$auth$verifyEmail$fr._(_root);
	@override late final _Translations$auth$forgotPassword$fr forgotPassword = _Translations$auth$forgotPassword$fr._(_root);
	@override late final _Translations$auth$updatePassword$fr updatePassword = _Translations$auth$updatePassword$fr._(_root);
	@override late final _Translations$auth$changePassword$fr changePassword = _Translations$auth$changePassword$fr._(_root);
	@override late final _Translations$auth$validators$fr validators = _Translations$auth$validators$fr._(_root);
}

// Path: common
class _Translations$common$fr extends Translations$common$en {
	_Translations$common$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final _Translations$common$actions$fr actions = _Translations$common$actions$fr._(_root);
	@override String get all => 'Tous';
	@override String get unnamed => '(sans nom)';
	@override late final _Translations$common$units$fr units = _Translations$common$units$fr._(_root);
	@override late final _Translations$common$date$fr date = _Translations$common$date$fr._(_root);
	@override late final _Translations$common$language$fr language = _Translations$common$language$fr._(_root);
}

// Path: contact
class _Translations$contact$fr extends Translations$contact$en {
	_Translations$contact$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final _Translations$contact$header$fr header = _Translations$contact$header$fr._(_root);
	@override late final _Translations$contact$sections$fr sections = _Translations$contact$sections$fr._(_root);
	@override late final _Translations$contact$fields$fr fields = _Translations$contact$fields$fr._(_root);
	@override String counter({required Object current, required Object max}) => '${current} / ${max}';
	@override String get submit => 'Envoyer';
	@override late final _Translations$contact$categories$fr categories = _Translations$contact$categories$fr._(_root);
	@override late final _Translations$contact$success$fr success = _Translations$contact$success$fr._(_root);
}

// Path: dashboard
class _Translations$dashboard$fr extends Translations$dashboard$en {
	_Translations$dashboard$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final _Translations$dashboard$greeting$fr greeting = _Translations$dashboard$greeting$fr._(_root);
	@override String get defaultName => 'Athlète';
	@override String get seeAll => 'Tout voir';
	@override late final _Translations$dashboard$sections$fr sections = _Translations$dashboard$sections$fr._(_root);
	@override late final _Translations$dashboard$templates$fr templates = _Translations$dashboard$templates$fr._(_root);
	@override String exerciseCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} exercice',
		other: '${n} exercices',
	);
	@override late final _Translations$dashboard$hero$fr hero = _Translations$dashboard$hero$fr._(_root);
	@override late final _Translations$dashboard$recent$fr recent = _Translations$dashboard$recent$fr._(_root);
	@override late final _Translations$dashboard$inProgress$fr inProgress = _Translations$dashboard$inProgress$fr._(_root);
	@override late final _Translations$dashboard$stats$fr stats = _Translations$dashboard$stats$fr._(_root);
	@override String streakBadge({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} semaine de suite',
		other: '${n} semaines de suite',
	);
	@override late final _Translations$dashboard$consistency$fr consistency = _Translations$dashboard$consistency$fr._(_root);
}

// Path: errors
class _Translations$errors$fr extends Translations$errors$en {
	_Translations$errors$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get network => 'Pas de connexion réseau. Vérifie ta connexion.';
	@override String get notFound => 'Élément introuvable.';
	@override String get generic => 'Une erreur est survenue. Réessaie.';
	@override String get invalidCode => 'Code invalide ou expiré.';
	@override String get passwordSameAsOld => 'Le nouveau mot de passe doit être différent de l\'ancien.';
	@override late final _Translations$errors$auth$fr auth = _Translations$errors$auth$fr._(_root);
}

// Path: goals
class _Translations$goals$fr extends Translations$goals$en {
	_Translations$goals$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get strength => 'Force';
	@override String get hypertrophy => 'Hypertrophie';
	@override String get endurance => 'Endurance';
	@override String get weightLoss => 'Perte de poids';
	@override String get maintenance => 'Entretien';
}

// Path: history
class _Translations$history$fr extends Translations$history$en {
	_Translations$history$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Historique';
	@override String get emptySubtitle => 'Aucune séance';
	@override String get emptyTitle => 'Aucune séance pour l\'instant';
	@override String get emptyMessage => 'Lance ta première séance depuis l\'accueil — elle apparaîtra ici.';
	@override String sessionCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} séance',
		other: '${n} séances',
	);
	@override String get deleteError => 'Échec de la suppression.';
	@override String get noResult => 'Aucune séance pour ce groupe';
	@override late final _Translations$history$groups$fr groups = _Translations$history$groups$fr._(_root);
	@override late final _Translations$history$panel$fr panel = _Translations$history$panel$fr._(_root);
	@override late final _Translations$history$detail$fr detail = _Translations$history$detail$fr._(_root);
}

// Path: legal
class _Translations$legal$fr extends Translations$legal$en {
	_Translations$legal$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get onlyInEnglish => 'Ce document n\'est disponible qu\'en anglais.';
}

// Path: muscleGroups
class _Translations$muscleGroups$fr extends Translations$muscleGroups$en {
	_Translations$muscleGroups$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get chest => 'Pectoraux';
	@override String get back => 'Dos';
	@override String get shoulders => 'Épaules';
	@override String get biceps => 'Biceps';
	@override String get triceps => 'Triceps';
	@override String get forearms => 'Avant-bras';
	@override String get quads => 'Quadriceps';
	@override String get hamstrings => 'Ischio-jambiers';
	@override String get glutes => 'Fessiers';
	@override String get calves => 'Mollets';
	@override String get abs => 'Abdominaux';
	@override String get custom => 'Autre';
	@override late final _Translations$muscleGroups$sections$fr sections = _Translations$muscleGroups$sections$fr._(_root);
}

// Path: nav
class _Translations$nav$fr extends Translations$nav$en {
	_Translations$nav$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get home => 'Accueil';
	@override String get program => 'Programme';
	@override String get history => 'Historique';
	@override String get stats => 'Stats';
	@override String get settings => 'Réglages';
}

// Path: profile
class _Translations$profile$fr extends Translations$profile$en {
	_Translations$profile$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get notConnected => 'Non connecté.';
	@override String get navTitle => 'PROFIL';
	@override String get defaultName => 'Athlète';
	@override String since({required Object month}) => 'Depuis ${month}';
	@override late final _Translations$profile$editSheet$fr editSheet = _Translations$profile$editSheet$fr._(_root);
	@override late final _Translations$profile$sections$fr sections = _Translations$profile$sections$fr._(_root);
	@override late final _Translations$profile$stats$fr stats = _Translations$profile$stats$fr._(_root);
	@override String sessionCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} séance',
		other: '${n} séances',
	);
	@override late final _Translations$profile$badges$fr badges = _Translations$profile$badges$fr._(_root);
	@override late final _Translations$profile$avatar$fr avatar = _Translations$profile$avatar$fr._(_root);
	@override late final _Translations$profile$editForm$fr editForm = _Translations$profile$editForm$fr._(_root);
}

// Path: session
class _Translations$session$fr extends Translations$session$en {
	_Translations$session$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get bw => 'PC';
	@override String get continueLabel => 'Continuer';
	@override late final _Translations$session$error$fr error = _Translations$session$error$fr._(_root);
	@override late final _Translations$session$live$fr live = _Translations$session$live$fr._(_root);
	@override late final _Translations$session$confirm$fr confirm = _Translations$session$confirm$fr._(_root);
	@override late final _Translations$session$add$fr add = _Translations$session$add$fr._(_root);
	@override late final _Translations$session$swap$fr swap = _Translations$session$swap$fr._(_root);
	@override late final _Translations$session$variants$fr variants = _Translations$session$variants$fr._(_root);
	@override late final _Translations$session$finish$fr finish = _Translations$session$finish$fr._(_root);
	@override late final _Translations$session$timer$fr timer = _Translations$session$timer$fr._(_root);
	@override late final _Translations$session$rest$fr rest = _Translations$session$rest$fr._(_root);
	@override late final _Translations$session$set$fr set = _Translations$session$set$fr._(_root);
	@override late final _Translations$session$exercise$fr exercise = _Translations$session$exercise$fr._(_root);
	@override late final _Translations$session$overview$fr overview = _Translations$session$overview$fr._(_root);
	@override late final _Translations$session$superset$fr superset = _Translations$session$superset$fr._(_root);
	@override late final _Translations$session$duration$fr duration = _Translations$session$duration$fr._(_root);
	@override late final _Translations$session$weight$fr weight = _Translations$session$weight$fr._(_root);
	@override late final _Translations$session$search$fr search = _Translations$session$search$fr._(_root);
	@override late final _Translations$session$history$fr history = _Translations$session$history$fr._(_root);
	@override late final _Translations$session$fields$fr fields = _Translations$session$fields$fr._(_root);
	@override late final _Translations$session$toast$fr toast = _Translations$session$toast$fr._(_root);
	@override late final _Translations$session$notif$fr notif = _Translations$session$notif$fr._(_root);
}

// Path: settings
class _Translations$settings$fr extends Translations$settings$en {
	_Translations$settings$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Réglages';
	@override late final _Translations$settings$sections$fr sections = _Translations$settings$sections$fr._(_root);
	@override String get defaultName => 'Athlète';
	@override String get editProfile => 'MODIFIER';
	@override String get profileUnavailable => 'Profil indisponible';
	@override late final _Translations$settings$rows$fr rows = _Translations$settings$rows$fr._(_root);
	@override String get soon => 'Bientôt';
	@override String get soonToast => 'Bientôt disponible';
	@override late final _Translations$settings$logout$fr logout = _Translations$settings$logout$fr._(_root);
	@override String get version => 'Repster v1.0 · Entraîne-toi, progresse, répète.';
	@override late final _Translations$settings$language$fr language = _Translations$settings$language$fr._(_root);
}

// Path: stats
class _Translations$stats$fr extends Translations$stats$en {
	_Translations$stats$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Stats';
	@override String sessionsCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} séance',
		other: '${n} séances',
	);
	@override String weeksShort({required Object n}) => '${n} sem.';
	@override late final _Translations$stats$subtitle$fr subtitle = _Translations$stats$subtitle$fr._(_root);
	@override late final _Translations$stats$empty$fr empty = _Translations$stats$empty$fr._(_root);
	@override late final _Translations$stats$range$fr range = _Translations$stats$range$fr._(_root);
	@override late final _Translations$stats$kpi$fr kpi = _Translations$stats$kpi$fr._(_root);
	@override late final _Translations$stats$weeklyVolume$fr weeklyVolume = _Translations$stats$weeklyVolume$fr._(_root);
	@override late final _Translations$stats$exercise$fr exercise = _Translations$stats$exercise$fr._(_root);
	@override late final _Translations$stats$muscleBalance$fr muscleBalance = _Translations$stats$muscleBalance$fr._(_root);
	@override late final _Translations$stats$records$fr records = _Translations$stats$records$fr._(_root);
	@override late final _Translations$stats$strength$fr strength = _Translations$stats$strength$fr._(_root);
}

// Path: templates
class _Translations$templates$fr extends Translations$templates$en {
	_Translations$templates$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final _Translations$templates$list$fr list = _Translations$templates$list$fr._(_root);
	@override late final _Translations$templates$card$fr card = _Translations$templates$card$fr._(_root);
	@override late final _Translations$templates$detail$fr detail = _Translations$templates$detail$fr._(_root);
	@override late final _Translations$templates$editor$fr editor = _Translations$templates$editor$fr._(_root);
	@override late final _Translations$templates$fields$fr fields = _Translations$templates$fields$fr._(_root);
	@override late final _Translations$templates$slot$fr slot = _Translations$templates$slot$fr._(_root);
}

// Path: tempo
class _Translations$tempo$fr extends Translations$tempo$en {
	_Translations$tempo$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get helper => 'Excentrique — pause — concentrique — pause (en s)';
	@override String get formatError => 'Format attendu : 3-1-X-0';
}

// Path: auth.fields
class _Translations$auth$fields$fr extends Translations$auth$fields$en {
	_Translations$auth$fields$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get email => 'Adresse email';
	@override String get password => 'Mot de passe';
}

// Path: auth.login
class _Translations$auth$login$fr extends Translations$auth$login$en {
	_Translations$auth$login$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get welcomeTitle => 'Content de te revoir';
	@override String get welcomeSubtitle => 'Connecte-toi pour continuer.';
	@override String get forgotPassword => 'Mot de passe oublié ?';
	@override String get submit => 'Se connecter';
	@override String get submitLoading => 'Connexion…';
	@override String get noAccount => 'Pas encore de compte ?';
	@override String get createAccount => 'Créer un compte';
}

// Path: auth.signup
class _Translations$auth$signup$fr extends Translations$auth$signup$en {
	_Translations$auth$signup$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Créer un compte';
	@override String get subtitle => 'Rejoins des milliers d’athlètes.';
	@override String get passwordHint => 'Mot de passe (8 car. min.)';
	@override String get submit => 'Créer mon compte';
	@override String get submitLoading => 'Création…';
	@override String get termsPrefix => 'En créant un compte, tu acceptes nos ';
	@override String get termsLink => 'conditions d’utilisation';
}

// Path: auth.onboarding
class _Translations$auth$onboarding$fr extends Translations$auth$onboarding$en {
	_Translations$auth$onboarding$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get step1Title => 'Comment tu\nt’appelles ?';
	@override String get step1Subtitle => 'Pour personnaliser ton expérience.';
	@override String get nameHint => 'Ton prénom';
	@override String get continueLabel => 'Continuer';
	@override String get step2Title => 'Quel est ton\nobjectif ?';
	@override String get step2Subtitle => 'On adaptera tes séances en conséquence.';
	@override String get step3Title => 'Quelques infos';
	@override String get optional => 'Optionnel';
	@override String get step3Subtitle => 'Pour des recommandations plus précises.';
	@override String get weightHint => 'Poids (kg)';
	@override String get heightHint => 'Taille (cm)';
	@override String get birthdate => 'Date de naissance';
	@override String get submit => 'C\'est parti !';
	@override String get submitLoading => 'Enregistrement…';
	@override String get skip => 'Passer cette étape';
	@override late final _Translations$auth$onboarding$goalDescriptions$fr goalDescriptions = _Translations$auth$onboarding$goalDescriptions$fr._(_root);
	@override String get nameRequired => 'Ton prénom est requis.';
	@override String get nameTooLong => 'Prénom trop long.';
	@override String get goalRequired => 'Choisis un objectif.';
	@override String get weightInvalid => 'Poids invalide';
	@override String get heightInvalid => 'Taille invalide';
}

// Path: auth.verifyEmail
class _Translations$auth$verifyEmail$fr extends Translations$auth$verifyEmail$en {
	_Translations$auth$verifyEmail$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Vérifie ton email';
	@override String get subtitle => 'On a envoyé un code à 6 chiffres';
	@override String get submitLoading => 'Vérification…';
	@override String get submitComplete => 'Vérifier le code';
	@override String get submitIncomplete => 'Entre le code reçu';
	@override String get noCode => 'Tu n’as pas reçu le code ?';
	@override String get resent => 'Code renvoyé !';
	@override String resendCooldown({required Object n}) => 'Renvoyer dans ${n}s';
	@override String get resending => 'Envoi…';
	@override String get resend => 'Renvoyer le code';
	@override String get emailMissing => 'Email manquant. Reviens à l\'inscription.';
}

// Path: auth.forgotPassword
class _Translations$auth$forgotPassword$fr extends Translations$auth$forgotPassword$en {
	_Translations$auth$forgotPassword$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Mot de passe oublié';
	@override String get subtitle => 'On t’envoie un lien de réinitialisation';
	@override String get submit => 'Envoyer le lien';
	@override String get submitLoading => 'Envoi…';
	@override String get successMessage => 'Un lien de réinitialisation a été envoyé à ton adresse email. Vérifie ta boîte de réception.';
}

// Path: auth.updatePassword
class _Translations$auth$updatePassword$fr extends Translations$auth$updatePassword$en {
	_Translations$auth$updatePassword$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Nouveau mot de passe';
	@override String get subtitle => 'Choisis un mot de passe sécurisé';
	@override String get newHint => 'Nouveau mot de passe';
	@override String get confirmHint => 'Confirmer le mot de passe';
	@override String get submit => 'Enregistrer le mot de passe';
	@override String get submitLoading => 'Enregistrement…';
}

// Path: auth.changePassword
class _Translations$auth$changePassword$fr extends Translations$auth$changePassword$en {
	_Translations$auth$changePassword$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Changer le mot de passe';
	@override String get subtitle => 'Pour ta sécurité, confirme ton mot de passe actuel avant d\'en choisir un nouveau.';
	@override String get currentHint => 'Mot de passe actuel';
	@override String get newHint => 'Nouveau mot de passe';
	@override String get confirmHint => 'Confirmer le nouveau mot de passe';
	@override String get submit => 'Mettre à jour le mot de passe';
	@override String get submitLoading => 'Mise à jour…';
	@override String get successToast => 'Mot de passe mis à jour';
	@override String get currentRequired => 'Mot de passe actuel requis';
	@override String get mustDiffer => 'Le nouveau mot de passe doit être différent de l\'actuel';
	@override String get currentIncorrect => 'Mot de passe actuel incorrect';
}

// Path: auth.validators
class _Translations$auth$validators$fr extends Translations$auth$validators$en {
	_Translations$auth$validators$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get emailRequired => 'Email requis';
	@override String get emailInvalid => 'Email invalide';
	@override String get passwordRequired => 'Mot de passe requis';
	@override String get passwordMin => 'Minimum 8 caractères';
	@override String get passwordMismatch => 'Les mots de passe ne correspondent pas';
}

// Path: common.actions
class _Translations$common$actions$fr extends Translations$common$actions$en {
	_Translations$common$actions$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get cancel => 'Annuler';
	@override String get confirm => 'Confirmer';
	@override String get save => 'Enregistrer';
	@override String get retry => 'Réessayer';
	@override String get delete => 'Supprimer';
	@override String get close => 'Fermer';
	@override String get edit => 'Modifier';
	@override String get done => 'Terminé';
	@override String get next => 'Suivant';
	@override String get back => 'Retour';
}

// Path: common.units
class _Translations$common$units$fr extends Translations$common$units$en {
	_Translations$common$units$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get reps => 'reps';
}

// Path: common.date
class _Translations$common$date$fr extends Translations$common$date$en {
	_Translations$common$date$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get justNow => 'à l’instant';
	@override String minutesAgo({required Object n}) => 'il y a ${n} min';
	@override String hoursAgo({required Object n}) => 'il y a ${n} h';
	@override String get yesterday => 'hier';
	@override String daysAgo({required Object n}) => 'il y a ${n} j';
	@override String get today => 'aujourd’hui';
	@override String weeksAgo({required Object n}) => 'il y a ${n} sem';
	@override String monthsAgo({required Object n}) => 'il y a ${n} mois';
}

// Path: common.language
class _Translations$common$language$fr extends Translations$common$language$en {
	_Translations$common$language$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get en => 'Anglais';
	@override String get fr => 'Français';
	@override String get es => 'Espagnol';
	@override String get de => 'Allemand';
	@override String get it => 'Italien';
}

// Path: contact.header
class _Translations$contact$header$fr extends Translations$contact$header$en {
	_Translations$contact$header$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Contact & feedback';
	@override String get subtitle => 'Un bug, une idée, une question ? Écris-nous, on lit tout.';
}

// Path: contact.sections
class _Translations$contact$sections$fr extends Translations$contact$sections$en {
	_Translations$contact$sections$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get type => 'Type de demande';
	@override String get yourInfo => 'Tes infos';
	@override String get message => 'Message';
}

// Path: contact.fields
class _Translations$contact$fields$fr extends Translations$contact$fields$en {
	_Translations$contact$fields$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get nameHint => 'Ton prénom';
	@override String get nameRequired => 'Nom requis';
	@override String get emailHint => 'Ton adresse email';
	@override String get emailInvalid => 'Email invalide';
	@override String get messageTooShort => 'Message trop court (10 caractères min)';
}

// Path: contact.categories
class _Translations$contact$categories$fr extends Translations$contact$categories$en {
	_Translations$contact$categories$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final _Translations$contact$categories$bug$fr bug = _Translations$contact$categories$bug$fr._(_root);
	@override late final _Translations$contact$categories$feature$fr feature = _Translations$contact$categories$feature$fr._(_root);
	@override late final _Translations$contact$categories$general$fr general = _Translations$contact$categories$general$fr._(_root);
	@override late final _Translations$contact$categories$other$fr other = _Translations$contact$categories$other$fr._(_root);
}

// Path: contact.success
class _Translations$contact$success$fr extends Translations$contact$success$en {
	_Translations$contact$success$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Message envoyé';
	@override String get back => 'Retour aux réglages';
}

// Path: dashboard.greeting
class _Translations$dashboard$greeting$fr extends Translations$dashboard$greeting$en {
	_Translations$dashboard$greeting$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get morning => 'Bonjour';
	@override String get afternoon => 'Bon après-midi';
	@override String get evening => 'Bonsoir';
}

// Path: dashboard.sections
class _Translations$dashboard$sections$fr extends Translations$dashboard$sections$en {
	_Translations$dashboard$sections$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get templates => 'Templates';
	@override String get recentSessions => 'Dernières séances';
}

// Path: dashboard.templates
class _Translations$dashboard$templates$fr extends Translations$dashboard$templates$en {
	_Translations$dashboard$templates$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get empty => 'Aucun template encore';
	@override String get newLabel => 'Nouveau';
}

// Path: dashboard.hero
class _Translations$dashboard$hero$fr extends Translations$dashboard$hero$en {
	_Translations$dashboard$hero$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get eyebrow => 'PROCHAINE SÉANCE';
	@override String get start => 'Démarrer la séance';
	@override String get emptyTitle => 'Crée ton premier template';
	@override String get emptyMessage => 'Configure tes exercices et c’est parti.';
	@override String get create => 'Créer un template';
}

// Path: dashboard.recent
class _Translations$dashboard$recent$fr extends Translations$dashboard$recent$en {
	_Translations$dashboard$recent$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get emptyTitle => 'Lance ta première séance !';
	@override String get emptyMessage => 'Choisis un template et c’est parti.';
	@override String get tonnage => 'tonnage';
}

// Path: dashboard.inProgress
class _Translations$dashboard$inProgress$fr extends Translations$dashboard$inProgress$en {
	_Translations$dashboard$inProgress$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get label => 'SÉANCE EN COURS';
	@override String startedAt({required Object when}) => 'Démarrée ${when}';
	@override String get resume => 'Reprendre';
	@override String get discard => 'Abandonner';
	@override String get discardTitle => 'Abandonner la séance ?';
	@override String get discardMessage => 'Toutes les saisies en cours seront perdues.';
	@override String get discardError => 'Échec — réessaie.';
}

// Path: dashboard.stats
class _Translations$dashboard$stats$fr extends Translations$dashboard$stats$en {
	_Translations$dashboard$stats$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get sessions => 'Séances';
	@override String get volume => 'Volume';
	@override String get streak => 'Streak';
	@override String get thisWeek => 'cette sem.';
	@override String weekCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: 'semaine',
		other: 'semaines',
	);
}

// Path: dashboard.consistency
class _Translations$dashboard$consistency$fr extends Translations$dashboard$consistency$en {
	_Translations$dashboard$consistency$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Consistance';
	@override String get trainingDays => 'jours actifs';
	@override String get perWeek => 'séances / sem.';
	@override String get bestStreak => 'meilleur streak';
	@override String get noStreak => 'aucun streak';
	@override String weeksShort({required Object n}) => '${n} sem.';
	@override String get notYet => 'Ton rythme d’entraînement apparaîtra ici après ta première séance.';
}

// Path: errors.auth
class _Translations$errors$auth$fr extends Translations$errors$auth$en {
	_Translations$errors$auth$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get invalidCredentials => 'Email ou mot de passe incorrect.';
	@override String get emailNotConfirmed => 'Confirme ton email avant de te connecter.';
	@override String get userAlreadyExists => 'Un compte existe déjà avec cet email.';
	@override String get sessionExpired => 'Session expirée. Reconnecte-toi.';
	@override String get notSignedIn => 'Tu dois être connecté.';
}

// Path: history.groups
class _Translations$history$groups$fr extends Translations$history$groups$en {
	_Translations$history$groups$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get thisWeek => 'Cette semaine';
	@override String get lastWeek => 'Semaine dernière';
	@override String weeksAgo({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: 'il y a ${n} semaine',
		other: 'il y a ${n} semaines',
	);
}

// Path: history.panel
class _Translations$history$panel$fr extends Translations$history$panel$en {
	_Translations$history$panel$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get sessions => 'Séances';
	@override String get volume => 'Volume';
	@override String get time => 'Temps';
}

// Path: history.detail
class _Translations$history$detail$fr extends Translations$history$detail$en {
	_Translations$history$detail$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Séance';
	@override String get dateFormat => 'EEEE d MMMM \'à\' HH:mm';
	@override String get duration => 'Durée';
	@override String get tonnage => 'Tonnage';
	@override String get sets => 'Séries';
	@override String get notes => 'Notes';
	@override String get perExercise => 'Détail par exercice';
	@override String setsCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} série',
		other: '${n} séries',
	);
	@override String get bodyweight => 'Poids de corps';
	@override String get colSet => 'Série';
	@override String get colReps => 'Reps';
	@override String get colLoad => 'Charge';
	@override String get colHeld => 'Tenu';
	@override String get totalExercise => 'Total exercice';
	@override String get totalHeld => 'Total tenu';
	@override late final _Translations$history$detail$edit$fr edit = _Translations$history$detail$edit$fr._(_root);
}

// Path: muscleGroups.sections
class _Translations$muscleGroups$sections$fr extends Translations$muscleGroups$sections$en {
	_Translations$muscleGroups$sections$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get chestBack => 'Poitrine & Dos';
	@override String get shouldersArms => 'Épaules & Bras';
	@override String get legsGlutes => 'Jambes & Fessiers';
	@override String get abs => 'Abdominaux';
	@override String get other => 'Autre';
}

// Path: profile.editSheet
class _Translations$profile$editSheet$fr extends Translations$profile$editSheet$en {
	_Translations$profile$editSheet$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Modifier le profil';
}

// Path: profile.sections
class _Translations$profile$sections$fr extends Translations$profile$sections$en {
	_Translations$profile$sections$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get favoriteMuscleGroup => 'Groupe musculaire préféré';
	@override String get badges => 'Badges';
}

// Path: profile.stats
class _Translations$profile$stats$fr extends Translations$profile$stats$en {
	_Translations$profile$stats$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get sessions => 'Séances';
	@override String get tonnage => 'Tonnage';
	@override String get sets => 'Séries';
}

// Path: profile.badges
class _Translations$profile$badges$fr extends Translations$profile$badges$en {
	_Translations$profile$badges$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get empty => 'Lance ta première séance pour débloquer des badges !';
	@override String get firstSession => 'Première séance';
	@override String get tenSessions => '10 séances';
	@override String get tenTonnes => '10 tonnes';
	@override String get planner => 'Planificateur';
}

// Path: profile.avatar
class _Translations$profile$avatar$fr extends Translations$profile$avatar$en {
	_Translations$profile$avatar$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get sheetTitle => 'Photo de profil';
	@override String get takePhoto => 'Prendre une photo';
	@override String get gallery => 'Galerie photo';
	@override String get remove => 'Supprimer la photo';
	@override String get openError => 'Impossible d’ouvrir la photo.';
	@override String get updated => 'Photo mise à jour !';
	@override String get saveError => 'Impossible de sauvegarder la photo.';
	@override String get removed => 'Photo supprimée.';
	@override String get removeError => 'Impossible de supprimer la photo.';
}

// Path: profile.editForm
class _Translations$profile$editForm$fr extends Translations$profile$editForm$en {
	_Translations$profile$editForm$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get saved => 'Profil mis à jour.';
	@override String get pickDate => 'Choisir une date';
	@override late final _Translations$profile$editForm$sections$fr sections = _Translations$profile$editForm$sections$fr._(_root);
	@override late final _Translations$profile$editForm$fields$fr fields = _Translations$profile$editForm$fields$fr._(_root);
	@override late final _Translations$profile$editForm$validation$fr validation = _Translations$profile$editForm$validation$fr._(_root);
}

// Path: session.error
class _Translations$session$error$fr extends Translations$session$error$en {
	_Translations$session$error$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get startFailed => 'Impossible de démarrer la séance.';
	@override String get saveFailed => 'Échec de la sauvegarde.';
}

// Path: session.live
class _Translations$session$live$fr extends Translations$session$live$en {
	_Translations$session$live$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String exercisePosition({required Object current, required Object total}) => 'Exercice ${current} / ${total}';
	@override String supersetPosition({required Object current, required Object total}) => 'Superset ${current} / ${total}';
	@override String headerSubtitle({required Object completed, required Object total, required Object time}) => '${completed}/${total} séries · ${time}';
	@override String get totalTonnage => 'Tonnage total';
	@override String get nextExercise => 'Exercice suivant';
	@override String get nextBlock => 'Bloc suivant';
	@override String get finishSession => 'Terminer la séance';
}

// Path: session.confirm
class _Translations$session$confirm$fr extends Translations$session$confirm$en {
	_Translations$session$confirm$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get quitTitle => 'Abandonner la séance ?';
	@override String get quitMessage => 'Toute la progression sera perdue.';
	@override String get quitConfirm => 'Abandonner';
	@override String get inProgressTitle => 'Une séance est déjà en cours';
	@override String inProgressMessage({required Object name, required Object date}) => '« ${name} » a été démarrée ${date}. En démarrer une nouvelle supprimera définitivement sa progression.';
	@override String get overwriteAndStart => 'Écraser et démarrer';
	@override String deleteExerciseTitle({required Object name}) => 'Supprimer « ${name} » ?';
	@override String deleteExerciseMessage({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: 'Cet exercice a déjà ${n} série validée. Elles seront perdues.',
		other: 'Cet exercice a déjà ${n} séries validées. Elles seront perdues.',
	);
}

// Path: session.add
class _Translations$session$add$fr extends Translations$session$add$en {
	_Translations$session$add$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ajouter un exercice';
	@override String get subtitle => 'Ajouté uniquement à cette séance, sans toucher au template.';
	@override String get addLabel => 'Ajouter';
	@override String get addToSession => 'Ajouter à la séance';
	@override String get reps => 'Répétitions';
	@override String get time => 'Temps';
}

// Path: session.swap
class _Translations$session$swap$fr extends Translations$session$swap$en {
	_Translations$session$swap$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Modifier l\'exercice';
	@override String currently({required Object name}) => 'Actuellement : ${name}';
	@override String get sessionOnly => 'Ces changements ne s’appliquent qu’à cette séance.';
	@override String get useLabel => 'Utiliser';
	@override String get adoptFormat => 'Reprendre le format';
	@override String adoptFormatSummary({required Object summary, required Object name}) => '${summary} · d’après « ${name} »';
	@override String get apply => 'Appliquer pour cette séance';
}

// Path: session.variants
class _Translations$session$variants$fr extends Translations$session$variants$en {
	_Translations$session$variants$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Choisir une variante';
	@override String get lockedMessage => 'Une série est déjà validée — termine l’exercice ou utilise « Échanger » pour ajuster en cours de route.';
	@override String get pickMessage => 'Sélectionne une variante pour cet emplacement. Elle remplacera l’exercice courant.';
	@override String get empty => 'Aucune variante définie pour cet exercice.';
	@override String get main => 'PRINCIPAL';
	@override String variantN({required Object n}) => 'Variante ${n}';
	@override String restSeconds({required Object n}) => '${n}s repos';
	@override String tempoPart({required Object tempo}) => ' · tempo ${tempo}';
}

// Path: session.finish
class _Translations$session$finish$fr extends Translations$session$finish$en {
	_Translations$session$finish$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Terminer la séance ?';
	@override String summaryReps({required Object completed, required Object total}) => '${completed}/${total} séries · ';
	@override String get summaryTonnageSuffix => ' de tonnage';
	@override String get notesHint => 'Notes sur la séance (optionnel)…';
	@override String get confirm => 'Terminer';
	@override String unvalidatedSets({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} SÉRIE NON VALIDÉE',
		other: '${n} SÉRIES NON VALIDÉES',
	);
	@override String get incompleteHint => 'Tu peux revenir valider tes séries, ou terminer quand même — seules les séries cochées seront enregistrées.';
}

// Path: session.timer
class _Translations$session$timer$fr extends Translations$session$timer$en {
	_Translations$session$timer$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get preparation => 'PRÉPARATION';
	@override String get running => 'EN COURS';
	@override String get done => 'TERMINÉ';
	@override String get go => 'GO';
	@override String get stop => 'Arrêter';
}

// Path: session.rest
class _Translations$session$rest$fr extends Translations$session$rest$en {
	_Translations$session$rest$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'RÉCUPÉRATION';
	@override String get sec => 'SEC';
	@override String get skip => 'Passer';
	@override String get minimize => 'Réduire';
}

// Path: session.set
class _Translations$session$set$fr extends Translations$session$set$en {
	_Translations$session$set$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get addSet => 'Ajouter une série';
	@override String setLabel({required Object n}) => 'Série ${n}';
	@override String get reps => 'Reps';
	@override String get load => 'Charge';
	@override String get duration => 'Durée';
	@override String get held => 'Tenu';
	@override String get tonnage => 'TONNAGE';
	@override String targetReps({required Object n}) => 'objectif ${n} reps';
	@override String targetDuration({required Object value}) => 'objectif ${value}';
	@override String get validateWithoutTimer => 'Valider sans timer';
	@override String get cmpUp => 'Top';
}

// Path: session.exercise
class _Translations$session$exercise$fr extends Translations$session$exercise$en {
	_Translations$session$exercise$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get timed => 'Chronométré';
	@override String tempoChip({required Object tempo}) => 'Tempo ${tempo}';
	@override String restChip({required Object n}) => '${n}s récup';
	@override String get modified => 'Modifié · séance uniquement';
	@override String modifiedWas({required Object name}) => 'Modifié · séance uniquement (était : ${name})';
	@override String get completedBadge => '✓ Terminé';
	@override String totalHeld({required Object value}) => 'Total tenu : ${value}';
	@override String exerciseVolume({required Object value}) => 'Volume exercice : ${value} kg';
	@override String get lastTimeLabel => 'Dernière fois';
	@override String get otherWorkout => 'autre séance';
	@override String targetWasReps({required Object n}) => 'visait ${n} reps';
	@override String targetWasSeconds({required Object n}) => 'visait ${n}s';
	@override String morePerfs({required Object n}) => '+${n}';
}

// Path: session.overview
class _Translations$session$overview$fr extends Translations$session$overview$en {
	_Translations$session$overview$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Exercices';
	@override String get current => 'EN COURS';
	@override String setsValidated({required Object completed, required Object total}) => '${completed}/${total} séries validées';
}

// Path: session.superset
class _Translations$session$superset$fr extends Translations$session$superset$en {
	_Translations$session$superset$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String badge({required Object n}) => 'SUPERSET · ${n} EXOS';
	@override String addSetTo({required Object letter, required Object name}) => 'Ajouter une série à ${letter} · ${name}';
}

// Path: session.duration
class _Translations$session$duration$fr extends Translations$session$duration$en {
	_Translations$session$duration$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Durée par série';
	@override String get hint => '45 ou 1m30';
	@override String confirm({required Object value}) => 'Confirmer — ${value}';
}

// Path: session.weight
class _Translations$session$weight$fr extends Translations$session$weight$en {
	_Translations$session$weight$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get bodyweight => 'Poids de corps';
	@override String get confirmBodyweight => 'Confirmer — Poids de corps';
	@override String confirmKg({required Object value}) => 'Confirmer — ${value} kg';
}

// Path: session.search
class _Translations$session$search$fr extends Translations$session$search$en {
	_Translations$session$search$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get hint => 'Rechercher un exercice…';
	@override String get loading => 'Chargement des exercices…';
	@override String get noMatch => 'Aucun exercice ne correspond.';
	@override String get certifiedBadge => 'Exercice Repster';
}

// Path: session.history
class _Translations$session$history$fr extends Translations$session$history$en {
	_Translations$session$history$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String title({required Object name}) => 'Historique · ${name}';
	@override String get empty => 'Pas encore d’historique pour cet exercice.';
	@override String get loading => 'Chargement de l’historique…';
	@override String setLabel({required Object n}) => 'Série ${n}';
	@override String get dateFormat => 'd MMM yyyy';
}

// Path: session.fields
class _Translations$session$fields$fr extends Translations$session$fields$en {
	_Translations$session$fields$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get exerciseName => 'Nom de l’exercice';
	@override String get type => 'Type';
	@override String get sets => 'Séries';
	@override String get durationSec => 'Durée (sec)';
	@override String get targetReps => 'Reps cibles';
	@override String get restShort => 'Récup. (sec)';
	@override String get rest => 'Récupération (sec)';
	@override String get tempo => 'Tempo';
	@override String get notesOptional => 'Notes (optionnel)';
	@override String get notesHint => 'Conseils techniques…';
}

// Path: session.toast
class _Translations$session$toast$fr extends Translations$session$toast$en {
	_Translations$session$toast$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String exerciseAdded({required Object name}) => '${name} ajouté à la séance';
	@override String get validateOneSet => 'Valide au moins une série avant de finir.';
	@override String get sessionSaved => 'Séance enregistrée ! 🎉';
	@override String get finishOrSwap => 'Termine la série en cours ou utilise « Échanger ».';
}

// Path: session.notif
class _Translations$session$notif$fr extends Translations$session$notif$en {
	_Translations$session$notif$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get countdownChannel => 'Compte à rebours de récup';
	@override String get doneChannel => 'Fin de récupération';
	@override String get doneTitle => 'Récupération terminée';
}

// Path: settings.sections
class _Translations$settings$sections$fr extends Translations$settings$sections$en {
	_Translations$settings$sections$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get profile => 'Profil';
	@override String get data => 'Mes données';
	@override String get preferences => 'Préférences';
	@override String get account => 'Compte';
}

// Path: settings.rows
class _Translations$settings$rows$fr extends Translations$settings$rows$en {
	_Translations$settings$rows$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get templates => 'Mes templates';
	@override String get history => 'Historique des séances';
	@override String get stats => 'Statistiques';
	@override String get notifications => 'Notifications';
	@override String get privacy => 'Confidentialité';
	@override String get terms => 'Conditions d’utilisation';
	@override String get contact => 'Contact & Feedback';
	@override String get language => 'Langue';
	@override String get changePassword => 'Changer mon mot de passe';
}

// Path: settings.logout
class _Translations$settings$logout$fr extends Translations$settings$logout$en {
	_Translations$settings$logout$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get action => 'Se déconnecter';
	@override String get error => 'Échec de la déconnexion.';
}

// Path: settings.language
class _Translations$settings$language$fr extends Translations$settings$language$en {
	_Translations$settings$language$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Langue';
	@override String get subtitle => 'Choisis la langue de l\'application';
	@override String get system => 'Langue du système';
}

// Path: stats.subtitle
class _Translations$stats$subtitle$fr extends Translations$stats$subtitle$en {
	_Translations$stats$subtitle$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get empty => 'Aucune séance sur la période';
}

// Path: stats.empty
class _Translations$stats$empty$fr extends Translations$stats$empty$en {
	_Translations$stats$empty$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Pas encore de données';
	@override String get message => 'Effectue quelques séances pour voir tes courbes et ta progression.';
}

// Path: stats.range
class _Translations$stats$range$fr extends Translations$stats$range$en {
	_Translations$stats$range$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final _Translations$stats$range$last4Weeks$fr last4Weeks = _Translations$stats$range$last4Weeks$fr._(_root);
	@override late final _Translations$stats$range$last3Months$fr last3Months = _Translations$stats$range$last3Months$fr._(_root);
	@override late final _Translations$stats$range$all$fr all = _Translations$stats$range$all$fr._(_root);
}

// Path: stats.kpi
class _Translations$stats$kpi$fr extends Translations$stats$kpi$en {
	_Translations$stats$kpi$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get sessions => 'Séances';
	@override String get volume => 'Tonnage';
	@override String get sets => 'Séries';
	@override String get avgDuration => 'Durée moy.';
	@override String get tension => 'Temps sous tension';
}

// Path: stats.weeklyVolume
class _Translations$stats$weeklyVolume$fr extends Translations$stats$weeklyVolume$en {
	_Translations$stats$weeklyVolume$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Volume par semaine';
	@override String get empty => 'Pas encore assez de séances sur la période.';
	@override String get inProgress => 'en cours';
}

// Path: stats.exercise
class _Translations$stats$exercise$fr extends Translations$stats$exercise$en {
	_Translations$stats$exercise$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Progression par exercice';
	@override String get empty => 'Enchaîne au moins 2 séances avec un même exercice chargé pour voir ta courbe de force.';
	@override String get pickerTitle => 'Choisir un exercice';
	@override String get noExercise => 'Aucun exercice';
	@override String get searchHint => 'Rechercher…';
	@override String get oneRmMax => '1RM estimé max';
	@override String get bestLoad => 'meilleure charge';
	@override String get record => 'record';
	@override String get trendUnknown => 'Pas encore assez de séances pour lire une tendance';
	@override String get trendProgressing => 'En progression';
	@override String trendPlateau({required Object n}) => 'Plateau · ${n} séances sans record';
	@override String get trendRegressing => 'En recul';
	@override String perMonth({required Object value}) => '${value} %/mois';
	@override String get plateauHint => 'Essaie moins de reps plus lourd, ou change de mouvement.';
}

// Path: stats.muscleBalance
class _Translations$stats$muscleBalance$fr extends Translations$stats$muscleBalance$en {
	_Translations$stats$muscleBalance$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Équilibre musculaire';
	@override String neglected({required Object days, required Object emoji}) => '— pas travaillé depuis ${days} j ${emoji}';
	@override late final _Translations$stats$muscleBalance$since$fr since = _Translations$stats$muscleBalance$since$fr._(_root);
}

// Path: stats.records
class _Translations$stats$records$fr extends Translations$stats$records$en {
	_Translations$stats$records$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Records';
	@override String get bestSession => 'Meilleure séance';
	@override String get heaviestLift => 'Charge max';
	@override String get bestOneRm => '1RM estimé';
	@override String get bestStreak => 'Plus long streak';
	@override String get consecutiveWeeks => 'semaines consécutives';
}

// Path: stats.strength
class _Translations$stats$strength$fr extends Translations$stats$strength$en {
	_Translations$stats$strength$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Force';
	@override String get scope => 'tout l’historique';
}

// Path: templates.list
class _Translations$templates$list$fr extends Translations$templates$list$en {
	_Translations$templates$list$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Programme';
	@override String subtitleActive({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} séance active',
		other: '${n} séances actives',
	);
	@override String subtitleManage({required num n, required Object total}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} / ${total} active',
		other: '${n} / ${total} actives',
	);
	@override String get manage => 'Gérer';
	@override String get newAction => 'Créer';
	@override String get emptyTitle => 'Aucune séance';
	@override String get emptyMessage => 'Crée ta première séance pour composer ton programme.';
	@override String get emptyAction => 'Créer une séance';
	@override String get emptyActiveTitle => 'Aucune séance dans le programme';
	@override String get emptyActiveMessage => 'Active des séances pour les ajouter à ton programme.';
	@override String get emptyActiveAction => 'Gérer les séances';
	@override String get noResult => 'Aucun résultat';
	@override String get searchHint => 'Rechercher une séance…';
	@override String get manageHint => 'Glisse pour réorganiser · touche le cercle pour masquer/afficher une séance';
	@override String get savedChanges => 'Modifications sauvegardées ✓';
	@override String get reorderError => 'Erreur lors du réordonnancement.';
	@override String get toggleError => 'Action impossible.';
	@override String get duplicated => 'Séance copiée !';
	@override String get duplicateError => 'Duplication impossible.';
	@override String get deleted => 'Séance supprimée.';
	@override String get deleteError => 'Suppression impossible.';
	@override String get copySuffix => '(copie)';
}

// Path: templates.card
class _Translations$templates$card$fr extends Translations$templates$card$en {
	_Translations$templates$card$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String exerciseCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} exercice',
		other: '${n} exercices',
	);
	@override String get details => 'Détails';
	@override String get copy => 'Copier';
	@override String get deleteShort => 'Suppr.';
	@override String get activate => 'Activer';
	@override String get deactivate => 'Désactiver';
}

// Path: templates.detail
class _Translations$templates$detail$fr extends Translations$templates$detail$en {
	_Translations$templates$detail$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Template';
	@override String get noExercises => 'Aucun exercice dans ce template.';
	@override String get superset => 'Superset';
	@override String setsCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} série',
		other: '${n} séries',
	);
	@override String seconds({required Object n}) => '${n} s';
	@override String tempo({required Object value}) => 'Tempo ${value}';
	@override String rest({required Object n}) => 'Repos ${n}s';
	@override String variantsMore({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '+${n} variante',
		other: '+${n} variantes',
	);
	@override String get start => 'Démarrer la séance';
}

// Path: templates.editor
class _Translations$templates$editor$fr extends Translations$templates$editor$en {
	_Translations$templates$editor$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get newTitle => 'Nouvelle séance';
	@override String get editTitle => 'Modifier la séance';
	@override String exercisesHeader({required Object count}) => 'EXERCICES (${count})';
	@override String get addExercise => 'Ajouter un exercice';
	@override String get save => 'Enregistrer la séance';
	@override String get validationError => 'Renseigne un nom et au moins un exercice nommé.';
}

// Path: templates.fields
class _Translations$templates$fields$fr extends Translations$templates$fields$en {
	_Translations$templates$fields$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get name => 'Nom de la séance';
	@override String get nameHint => 'ex : Pec / Triceps / Épaules';
	@override String get description => 'Description (optionnel)';
	@override String get descriptionHint => 'Décris ta séance…';
	@override String get muscleGroups => 'Groupes musculaires';
	@override String selectedCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} sélectionné',
		other: '${n} sélectionnés',
	);
	@override String get exerciseName => 'Nom de l’exercice';
	@override String get exerciseNameHint => 'ex : Développé couché';
	@override String get type => 'Type';
	@override String get sets => 'Séries';
	@override String get duration => 'Durée (s)';
	@override String get targetReps => 'Reps cibles';
	@override String get rest => 'Récup. (s)';
	@override String get tempo => 'Tempo';
	@override String get tempoHint => '3-1-X-0';
	@override String get notes => 'Notes (optionnel)';
	@override String get notesHint => 'Conseils techniques…';
}

// Path: templates.slot
class _Translations$templates$slot$fr extends Translations$templates$slot$en {
	_Translations$templates$slot$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get newExercise => 'Nouvel exercice';
	@override String variantN({required Object n}) => 'Variante ${n}';
	@override String get primary => 'PRINCIPAL';
	@override String get variant => 'Variante';
	@override String get addVariant => 'Ajouter une variante';
	@override String get supersetNote => 'Enchaîné en superset avec l’exercice suivant';
	@override String get supersetLabel => 'SUPERSET';
	@override String get reps => 'Répétitions';
	@override String get time => 'Temps';
}

// Path: auth.onboarding.goalDescriptions
class _Translations$auth$onboarding$goalDescriptions$fr extends Translations$auth$onboarding$goalDescriptions$en {
	_Translations$auth$onboarding$goalDescriptions$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get hypertrophy => 'Gagner du muscle';
	@override String get strength => 'Augmenter les charges';
	@override String get endurance => 'Cardio & résistance';
	@override String get weightLoss => 'Brûler les calories';
	@override String get maintenance => 'Garder la forme';
}

// Path: contact.categories.bug
class _Translations$contact$categories$bug$fr extends Translations$contact$categories$bug$en {
	_Translations$contact$categories$bug$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get label => 'Bug';
	@override String get placeholder => 'Ex : après ma série, le chrono de repos ne démarre pas…';
	@override String get guidance => 'Précise les étapes pour reproduire, ce que tu attendais, et ton modèle de téléphone — ça nous aide à corriger vite.';
	@override String get successLine => 'C\'est noté — on file regarder ce bug de près.';
}

// Path: contact.categories.feature
class _Translations$contact$categories$feature$fr extends Translations$contact$categories$feature$en {
	_Translations$contact$categories$feature$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get label => 'Idée';
	@override String get placeholder => 'Ex : pouvoir dupliquer un template existant…';
	@override String get guidance => 'Décris surtout le besoin derrière l\'idée : qu\'est-ce que ça te permettrait de faire ?';
	@override String get successLine => 'Super idée, merci ! On l\'ajoute à notre réflexion.';
}

// Path: contact.categories.general
class _Translations$contact$categories$general$fr extends Translations$contact$categories$general$en {
	_Translations$contact$categories$general$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get label => 'Message';
	@override String get placeholder => 'Ta question, ton avis ou ton retour…';
	@override String get guidance => 'Une question, une remarque, un encouragement : on lit chaque message.';
	@override String get successLine => 'Merci pour ton message. On prend le temps de lire chaque retour.';
}

// Path: contact.categories.other
class _Translations$contact$categories$other$fr extends Translations$contact$categories$other$en {
	_Translations$contact$categories$other$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get label => 'Autre';
	@override String get placeholder => 'Dis-nous tout…';
	@override String get guidance => 'Donne-nous un maximum de contexte pour qu\'on puisse t\'aider au mieux.';
	@override String get successLine => 'Merci pour ton message. On revient vers toi si besoin.';
}

// Path: history.detail.edit
class _Translations$history$detail$edit$fr extends Translations$history$detail$edit$en {
	_Translations$history$detail$edit$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get open => 'Modifier';
	@override String get title => 'Modifier la séance';
	@override String get name => 'Titre';
	@override String get namePlaceholder => 'Nom de la séance';
	@override String get date => 'Date';
	@override String get time => 'Heure';
	@override String get durationLabel => 'Durée';
	@override String get hours => 'h';
	@override String get minutes => 'min';
	@override String get notesPlaceholder => 'Comment ça s\'est passé ?';
	@override String get save => 'Enregistrer';
	@override String get saved => 'Séance mise à jour.';
	@override String get error => 'Échec de la modification.';
	@override String get nameRequired => 'Un titre est requis.';
	@override String get dateFormat => 'd MMMM y';
}

// Path: profile.editForm.sections
class _Translations$profile$editForm$sections$fr extends Translations$profile$editForm$sections$en {
	_Translations$profile$editForm$sections$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get identity => 'Identité';
	@override String get physique => 'Physique';
	@override String get goal => 'Objectif';
}

// Path: profile.editForm.fields
class _Translations$profile$editForm$fields$fr extends Translations$profile$editForm$fields$en {
	_Translations$profile$editForm$fields$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get name => 'Nom / Pseudo';
	@override String get bio => 'Bio';
	@override String get birthdate => 'Date de naissance';
	@override String get weight => 'Poids (kg)';
	@override String get height => 'Taille (cm)';
}

// Path: profile.editForm.validation
class _Translations$profile$editForm$validation$fr extends Translations$profile$editForm$validation$en {
	_Translations$profile$editForm$validation$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get nameMin => 'Au moins 2 caractères';
	@override String get nameMax => 'Maximum 60 caractères';
	@override String get invalidNumber => 'Nombre invalide';
	@override String get heightRange => 'Entre 80 et 260 cm';
	@override String get weightRange => 'Entre 30 et 350 kg';
}

// Path: stats.range.last4Weeks
class _Translations$stats$range$last4Weeks$fr extends Translations$stats$range$last4Weeks$en {
	_Translations$stats$range$last4Weeks$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get label => '4 semaines';
	@override String get short => '4 sem.';
}

// Path: stats.range.last3Months
class _Translations$stats$range$last3Months$fr extends Translations$stats$range$last3Months$en {
	_Translations$stats$range$last3Months$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get label => '3 mois';
	@override String get short => '3 mois';
}

// Path: stats.range.all
class _Translations$stats$range$all$fr extends Translations$stats$range$all$en {
	_Translations$stats$range$all$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get label => 'Tout';
	@override String get short => 'Tout';
}

// Path: stats.muscleBalance.since
class _Translations$stats$muscleBalance$since$fr extends Translations$stats$muscleBalance$since$en {
	_Translations$stats$muscleBalance$since$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get none => '–';
	@override String get today => 'auj.';
	@override String get yesterday => 'hier';
	@override String daysShort({required Object n}) => '${n}j';
}

/// The flat map containing all translations for locale <fr>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsFr {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'auth.fields.email' => 'Adresse email',
			'auth.fields.password' => 'Mot de passe',
			'auth.backToLogin' => 'Retour à la connexion',
			'auth.login.welcomeTitle' => 'Content de te revoir',
			'auth.login.welcomeSubtitle' => 'Connecte-toi pour continuer.',
			'auth.login.forgotPassword' => 'Mot de passe oublié ?',
			'auth.login.submit' => 'Se connecter',
			'auth.login.submitLoading' => 'Connexion…',
			'auth.login.noAccount' => 'Pas encore de compte ?',
			'auth.login.createAccount' => 'Créer un compte',
			'auth.signup.title' => 'Créer un compte',
			'auth.signup.subtitle' => 'Rejoins des milliers d’athlètes.',
			'auth.signup.passwordHint' => 'Mot de passe (8 car. min.)',
			'auth.signup.submit' => 'Créer mon compte',
			'auth.signup.submitLoading' => 'Création…',
			'auth.signup.termsPrefix' => 'En créant un compte, tu acceptes nos ',
			'auth.signup.termsLink' => 'conditions d’utilisation',
			'auth.onboarding.step1Title' => 'Comment tu\nt’appelles ?',
			'auth.onboarding.step1Subtitle' => 'Pour personnaliser ton expérience.',
			'auth.onboarding.nameHint' => 'Ton prénom',
			'auth.onboarding.continueLabel' => 'Continuer',
			'auth.onboarding.step2Title' => 'Quel est ton\nobjectif ?',
			'auth.onboarding.step2Subtitle' => 'On adaptera tes séances en conséquence.',
			'auth.onboarding.step3Title' => 'Quelques infos',
			'auth.onboarding.optional' => 'Optionnel',
			'auth.onboarding.step3Subtitle' => 'Pour des recommandations plus précises.',
			'auth.onboarding.weightHint' => 'Poids (kg)',
			'auth.onboarding.heightHint' => 'Taille (cm)',
			'auth.onboarding.birthdate' => 'Date de naissance',
			'auth.onboarding.submit' => 'C\'est parti !',
			'auth.onboarding.submitLoading' => 'Enregistrement…',
			'auth.onboarding.skip' => 'Passer cette étape',
			'auth.onboarding.goalDescriptions.hypertrophy' => 'Gagner du muscle',
			'auth.onboarding.goalDescriptions.strength' => 'Augmenter les charges',
			'auth.onboarding.goalDescriptions.endurance' => 'Cardio & résistance',
			'auth.onboarding.goalDescriptions.weightLoss' => 'Brûler les calories',
			'auth.onboarding.goalDescriptions.maintenance' => 'Garder la forme',
			'auth.onboarding.nameRequired' => 'Ton prénom est requis.',
			'auth.onboarding.nameTooLong' => 'Prénom trop long.',
			'auth.onboarding.goalRequired' => 'Choisis un objectif.',
			'auth.onboarding.weightInvalid' => 'Poids invalide',
			'auth.onboarding.heightInvalid' => 'Taille invalide',
			'auth.verifyEmail.title' => 'Vérifie ton email',
			'auth.verifyEmail.subtitle' => 'On a envoyé un code à 6 chiffres',
			'auth.verifyEmail.submitLoading' => 'Vérification…',
			'auth.verifyEmail.submitComplete' => 'Vérifier le code',
			'auth.verifyEmail.submitIncomplete' => 'Entre le code reçu',
			'auth.verifyEmail.noCode' => 'Tu n’as pas reçu le code ?',
			'auth.verifyEmail.resent' => 'Code renvoyé !',
			'auth.verifyEmail.resendCooldown' => ({required Object n}) => 'Renvoyer dans ${n}s',
			'auth.verifyEmail.resending' => 'Envoi…',
			'auth.verifyEmail.resend' => 'Renvoyer le code',
			'auth.verifyEmail.emailMissing' => 'Email manquant. Reviens à l\'inscription.',
			'auth.forgotPassword.title' => 'Mot de passe oublié',
			'auth.forgotPassword.subtitle' => 'On t’envoie un lien de réinitialisation',
			'auth.forgotPassword.submit' => 'Envoyer le lien',
			'auth.forgotPassword.submitLoading' => 'Envoi…',
			'auth.forgotPassword.successMessage' => 'Un lien de réinitialisation a été envoyé à ton adresse email. Vérifie ta boîte de réception.',
			'auth.updatePassword.title' => 'Nouveau mot de passe',
			'auth.updatePassword.subtitle' => 'Choisis un mot de passe sécurisé',
			'auth.updatePassword.newHint' => 'Nouveau mot de passe',
			'auth.updatePassword.confirmHint' => 'Confirmer le mot de passe',
			'auth.updatePassword.submit' => 'Enregistrer le mot de passe',
			'auth.updatePassword.submitLoading' => 'Enregistrement…',
			'auth.changePassword.title' => 'Changer le mot de passe',
			'auth.changePassword.subtitle' => 'Pour ta sécurité, confirme ton mot de passe actuel avant d\'en choisir un nouveau.',
			'auth.changePassword.currentHint' => 'Mot de passe actuel',
			'auth.changePassword.newHint' => 'Nouveau mot de passe',
			'auth.changePassword.confirmHint' => 'Confirmer le nouveau mot de passe',
			'auth.changePassword.submit' => 'Mettre à jour le mot de passe',
			'auth.changePassword.submitLoading' => 'Mise à jour…',
			'auth.changePassword.successToast' => 'Mot de passe mis à jour',
			'auth.changePassword.currentRequired' => 'Mot de passe actuel requis',
			'auth.changePassword.mustDiffer' => 'Le nouveau mot de passe doit être différent de l\'actuel',
			'auth.changePassword.currentIncorrect' => 'Mot de passe actuel incorrect',
			'auth.validators.emailRequired' => 'Email requis',
			'auth.validators.emailInvalid' => 'Email invalide',
			'auth.validators.passwordRequired' => 'Mot de passe requis',
			'auth.validators.passwordMin' => 'Minimum 8 caractères',
			'auth.validators.passwordMismatch' => 'Les mots de passe ne correspondent pas',
			'common.actions.cancel' => 'Annuler',
			'common.actions.confirm' => 'Confirmer',
			'common.actions.save' => 'Enregistrer',
			'common.actions.retry' => 'Réessayer',
			'common.actions.delete' => 'Supprimer',
			'common.actions.close' => 'Fermer',
			'common.actions.edit' => 'Modifier',
			'common.actions.done' => 'Terminé',
			'common.actions.next' => 'Suivant',
			'common.actions.back' => 'Retour',
			'common.all' => 'Tous',
			'common.unnamed' => '(sans nom)',
			'common.units.reps' => 'reps',
			'common.date.justNow' => 'à l’instant',
			'common.date.minutesAgo' => ({required Object n}) => 'il y a ${n} min',
			'common.date.hoursAgo' => ({required Object n}) => 'il y a ${n} h',
			'common.date.yesterday' => 'hier',
			'common.date.daysAgo' => ({required Object n}) => 'il y a ${n} j',
			'common.date.today' => 'aujourd’hui',
			'common.date.weeksAgo' => ({required Object n}) => 'il y a ${n} sem',
			'common.date.monthsAgo' => ({required Object n}) => 'il y a ${n} mois',
			'common.language.en' => 'Anglais',
			'common.language.fr' => 'Français',
			'common.language.es' => 'Espagnol',
			'common.language.de' => 'Allemand',
			'common.language.it' => 'Italien',
			'contact.header.title' => 'Contact & feedback',
			'contact.header.subtitle' => 'Un bug, une idée, une question ? Écris-nous, on lit tout.',
			'contact.sections.type' => 'Type de demande',
			'contact.sections.yourInfo' => 'Tes infos',
			'contact.sections.message' => 'Message',
			'contact.fields.nameHint' => 'Ton prénom',
			'contact.fields.nameRequired' => 'Nom requis',
			'contact.fields.emailHint' => 'Ton adresse email',
			'contact.fields.emailInvalid' => 'Email invalide',
			'contact.fields.messageTooShort' => 'Message trop court (10 caractères min)',
			'contact.counter' => ({required Object current, required Object max}) => '${current} / ${max}',
			'contact.submit' => 'Envoyer',
			'contact.categories.bug.label' => 'Bug',
			'contact.categories.bug.placeholder' => 'Ex : après ma série, le chrono de repos ne démarre pas…',
			'contact.categories.bug.guidance' => 'Précise les étapes pour reproduire, ce que tu attendais, et ton modèle de téléphone — ça nous aide à corriger vite.',
			'contact.categories.bug.successLine' => 'C\'est noté — on file regarder ce bug de près.',
			'contact.categories.feature.label' => 'Idée',
			'contact.categories.feature.placeholder' => 'Ex : pouvoir dupliquer un template existant…',
			'contact.categories.feature.guidance' => 'Décris surtout le besoin derrière l\'idée : qu\'est-ce que ça te permettrait de faire ?',
			'contact.categories.feature.successLine' => 'Super idée, merci ! On l\'ajoute à notre réflexion.',
			'contact.categories.general.label' => 'Message',
			'contact.categories.general.placeholder' => 'Ta question, ton avis ou ton retour…',
			'contact.categories.general.guidance' => 'Une question, une remarque, un encouragement : on lit chaque message.',
			'contact.categories.general.successLine' => 'Merci pour ton message. On prend le temps de lire chaque retour.',
			'contact.categories.other.label' => 'Autre',
			'contact.categories.other.placeholder' => 'Dis-nous tout…',
			'contact.categories.other.guidance' => 'Donne-nous un maximum de contexte pour qu\'on puisse t\'aider au mieux.',
			'contact.categories.other.successLine' => 'Merci pour ton message. On revient vers toi si besoin.',
			'contact.success.title' => 'Message envoyé',
			'contact.success.back' => 'Retour aux réglages',
			'dashboard.greeting.morning' => 'Bonjour',
			'dashboard.greeting.afternoon' => 'Bon après-midi',
			'dashboard.greeting.evening' => 'Bonsoir',
			'dashboard.defaultName' => 'Athlète',
			'dashboard.seeAll' => 'Tout voir',
			'dashboard.sections.templates' => 'Templates',
			'dashboard.sections.recentSessions' => 'Dernières séances',
			'dashboard.templates.empty' => 'Aucun template encore',
			'dashboard.templates.newLabel' => 'Nouveau',
			'dashboard.exerciseCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} exercice', other: '${n} exercices', ), 
			'dashboard.hero.eyebrow' => 'PROCHAINE SÉANCE',
			'dashboard.hero.start' => 'Démarrer la séance',
			'dashboard.hero.emptyTitle' => 'Crée ton premier template',
			'dashboard.hero.emptyMessage' => 'Configure tes exercices et c’est parti.',
			'dashboard.hero.create' => 'Créer un template',
			'dashboard.recent.emptyTitle' => 'Lance ta première séance !',
			'dashboard.recent.emptyMessage' => 'Choisis un template et c’est parti.',
			'dashboard.recent.tonnage' => 'tonnage',
			'dashboard.inProgress.label' => 'SÉANCE EN COURS',
			'dashboard.inProgress.startedAt' => ({required Object when}) => 'Démarrée ${when}',
			'dashboard.inProgress.resume' => 'Reprendre',
			'dashboard.inProgress.discard' => 'Abandonner',
			'dashboard.inProgress.discardTitle' => 'Abandonner la séance ?',
			'dashboard.inProgress.discardMessage' => 'Toutes les saisies en cours seront perdues.',
			'dashboard.inProgress.discardError' => 'Échec — réessaie.',
			'dashboard.stats.sessions' => 'Séances',
			'dashboard.stats.volume' => 'Volume',
			'dashboard.stats.streak' => 'Streak',
			'dashboard.stats.thisWeek' => 'cette sem.',
			'dashboard.stats.weekCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: 'semaine', other: 'semaines', ), 
			'dashboard.streakBadge' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} semaine de suite', other: '${n} semaines de suite', ), 
			'dashboard.consistency.title' => 'Consistance',
			'dashboard.consistency.trainingDays' => 'jours actifs',
			'dashboard.consistency.perWeek' => 'séances / sem.',
			'dashboard.consistency.bestStreak' => 'meilleur streak',
			'dashboard.consistency.noStreak' => 'aucun streak',
			'dashboard.consistency.weeksShort' => ({required Object n}) => '${n} sem.',
			'dashboard.consistency.notYet' => 'Ton rythme d’entraînement apparaîtra ici après ta première séance.',
			'errors.network' => 'Pas de connexion réseau. Vérifie ta connexion.',
			'errors.notFound' => 'Élément introuvable.',
			'errors.generic' => 'Une erreur est survenue. Réessaie.',
			'errors.invalidCode' => 'Code invalide ou expiré.',
			'errors.passwordSameAsOld' => 'Le nouveau mot de passe doit être différent de l\'ancien.',
			'errors.auth.invalidCredentials' => 'Email ou mot de passe incorrect.',
			'errors.auth.emailNotConfirmed' => 'Confirme ton email avant de te connecter.',
			'errors.auth.userAlreadyExists' => 'Un compte existe déjà avec cet email.',
			'errors.auth.sessionExpired' => 'Session expirée. Reconnecte-toi.',
			'errors.auth.notSignedIn' => 'Tu dois être connecté.',
			'goals.strength' => 'Force',
			'goals.hypertrophy' => 'Hypertrophie',
			'goals.endurance' => 'Endurance',
			'goals.weightLoss' => 'Perte de poids',
			'goals.maintenance' => 'Entretien',
			'history.title' => 'Historique',
			'history.emptySubtitle' => 'Aucune séance',
			'history.emptyTitle' => 'Aucune séance pour l\'instant',
			'history.emptyMessage' => 'Lance ta première séance depuis l\'accueil — elle apparaîtra ici.',
			'history.sessionCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} séance', other: '${n} séances', ), 
			'history.deleteError' => 'Échec de la suppression.',
			'history.noResult' => 'Aucune séance pour ce groupe',
			'history.groups.thisWeek' => 'Cette semaine',
			'history.groups.lastWeek' => 'Semaine dernière',
			'history.groups.weeksAgo' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: 'il y a ${n} semaine', other: 'il y a ${n} semaines', ), 
			'history.panel.sessions' => 'Séances',
			'history.panel.volume' => 'Volume',
			'history.panel.time' => 'Temps',
			'history.detail.title' => 'Séance',
			'history.detail.dateFormat' => 'EEEE d MMMM \'à\' HH:mm',
			'history.detail.duration' => 'Durée',
			'history.detail.tonnage' => 'Tonnage',
			'history.detail.sets' => 'Séries',
			'history.detail.notes' => 'Notes',
			'history.detail.perExercise' => 'Détail par exercice',
			'history.detail.setsCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} série', other: '${n} séries', ), 
			'history.detail.bodyweight' => 'Poids de corps',
			'history.detail.colSet' => 'Série',
			'history.detail.colReps' => 'Reps',
			'history.detail.colLoad' => 'Charge',
			'history.detail.colHeld' => 'Tenu',
			'history.detail.totalExercise' => 'Total exercice',
			'history.detail.totalHeld' => 'Total tenu',
			'history.detail.edit.open' => 'Modifier',
			'history.detail.edit.title' => 'Modifier la séance',
			'history.detail.edit.name' => 'Titre',
			'history.detail.edit.namePlaceholder' => 'Nom de la séance',
			'history.detail.edit.date' => 'Date',
			'history.detail.edit.time' => 'Heure',
			'history.detail.edit.durationLabel' => 'Durée',
			'history.detail.edit.hours' => 'h',
			'history.detail.edit.minutes' => 'min',
			'history.detail.edit.notesPlaceholder' => 'Comment ça s\'est passé ?',
			'history.detail.edit.save' => 'Enregistrer',
			'history.detail.edit.saved' => 'Séance mise à jour.',
			'history.detail.edit.error' => 'Échec de la modification.',
			'history.detail.edit.nameRequired' => 'Un titre est requis.',
			'history.detail.edit.dateFormat' => 'd MMMM y',
			'legal.onlyInEnglish' => 'Ce document n\'est disponible qu\'en anglais.',
			'muscleGroups.chest' => 'Pectoraux',
			'muscleGroups.back' => 'Dos',
			'muscleGroups.shoulders' => 'Épaules',
			'muscleGroups.biceps' => 'Biceps',
			'muscleGroups.triceps' => 'Triceps',
			'muscleGroups.forearms' => 'Avant-bras',
			'muscleGroups.quads' => 'Quadriceps',
			'muscleGroups.hamstrings' => 'Ischio-jambiers',
			'muscleGroups.glutes' => 'Fessiers',
			'muscleGroups.calves' => 'Mollets',
			'muscleGroups.abs' => 'Abdominaux',
			'muscleGroups.custom' => 'Autre',
			'muscleGroups.sections.chestBack' => 'Poitrine & Dos',
			'muscleGroups.sections.shouldersArms' => 'Épaules & Bras',
			'muscleGroups.sections.legsGlutes' => 'Jambes & Fessiers',
			'muscleGroups.sections.abs' => 'Abdominaux',
			'muscleGroups.sections.other' => 'Autre',
			'nav.home' => 'Accueil',
			'nav.program' => 'Programme',
			'nav.history' => 'Historique',
			'nav.stats' => 'Stats',
			'nav.settings' => 'Réglages',
			'profile.notConnected' => 'Non connecté.',
			'profile.navTitle' => 'PROFIL',
			'profile.defaultName' => 'Athlète',
			'profile.since' => ({required Object month}) => 'Depuis ${month}',
			'profile.editSheet.title' => 'Modifier le profil',
			'profile.sections.favoriteMuscleGroup' => 'Groupe musculaire préféré',
			'profile.sections.badges' => 'Badges',
			'profile.stats.sessions' => 'Séances',
			'profile.stats.tonnage' => 'Tonnage',
			'profile.stats.sets' => 'Séries',
			'profile.sessionCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} séance', other: '${n} séances', ), 
			'profile.badges.empty' => 'Lance ta première séance pour débloquer des badges !',
			'profile.badges.firstSession' => 'Première séance',
			'profile.badges.tenSessions' => '10 séances',
			'profile.badges.tenTonnes' => '10 tonnes',
			'profile.badges.planner' => 'Planificateur',
			'profile.avatar.sheetTitle' => 'Photo de profil',
			'profile.avatar.takePhoto' => 'Prendre une photo',
			'profile.avatar.gallery' => 'Galerie photo',
			'profile.avatar.remove' => 'Supprimer la photo',
			'profile.avatar.openError' => 'Impossible d’ouvrir la photo.',
			'profile.avatar.updated' => 'Photo mise à jour !',
			'profile.avatar.saveError' => 'Impossible de sauvegarder la photo.',
			'profile.avatar.removed' => 'Photo supprimée.',
			'profile.avatar.removeError' => 'Impossible de supprimer la photo.',
			'profile.editForm.saved' => 'Profil mis à jour.',
			'profile.editForm.pickDate' => 'Choisir une date',
			'profile.editForm.sections.identity' => 'Identité',
			'profile.editForm.sections.physique' => 'Physique',
			'profile.editForm.sections.goal' => 'Objectif',
			'profile.editForm.fields.name' => 'Nom / Pseudo',
			'profile.editForm.fields.bio' => 'Bio',
			'profile.editForm.fields.birthdate' => 'Date de naissance',
			'profile.editForm.fields.weight' => 'Poids (kg)',
			'profile.editForm.fields.height' => 'Taille (cm)',
			'profile.editForm.validation.nameMin' => 'Au moins 2 caractères',
			'profile.editForm.validation.nameMax' => 'Maximum 60 caractères',
			'profile.editForm.validation.invalidNumber' => 'Nombre invalide',
			'profile.editForm.validation.heightRange' => 'Entre 80 et 260 cm',
			'profile.editForm.validation.weightRange' => 'Entre 30 et 350 kg',
			'session.bw' => 'PC',
			'session.continueLabel' => 'Continuer',
			'session.error.startFailed' => 'Impossible de démarrer la séance.',
			'session.error.saveFailed' => 'Échec de la sauvegarde.',
			'session.live.exercisePosition' => ({required Object current, required Object total}) => 'Exercice ${current} / ${total}',
			'session.live.supersetPosition' => ({required Object current, required Object total}) => 'Superset ${current} / ${total}',
			'session.live.headerSubtitle' => ({required Object completed, required Object total, required Object time}) => '${completed}/${total} séries · ${time}',
			'session.live.totalTonnage' => 'Tonnage total',
			'session.live.nextExercise' => 'Exercice suivant',
			'session.live.nextBlock' => 'Bloc suivant',
			'session.live.finishSession' => 'Terminer la séance',
			'session.confirm.quitTitle' => 'Abandonner la séance ?',
			'session.confirm.quitMessage' => 'Toute la progression sera perdue.',
			'session.confirm.quitConfirm' => 'Abandonner',
			'session.confirm.inProgressTitle' => 'Une séance est déjà en cours',
			'session.confirm.inProgressMessage' => ({required Object name, required Object date}) => '« ${name} » a été démarrée ${date}. En démarrer une nouvelle supprimera définitivement sa progression.',
			'session.confirm.overwriteAndStart' => 'Écraser et démarrer',
			'session.confirm.deleteExerciseTitle' => ({required Object name}) => 'Supprimer « ${name} » ?',
			'session.confirm.deleteExerciseMessage' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: 'Cet exercice a déjà ${n} série validée. Elles seront perdues.', other: 'Cet exercice a déjà ${n} séries validées. Elles seront perdues.', ), 
			'session.add.title' => 'Ajouter un exercice',
			'session.add.subtitle' => 'Ajouté uniquement à cette séance, sans toucher au template.',
			'session.add.addLabel' => 'Ajouter',
			'session.add.addToSession' => 'Ajouter à la séance',
			'session.add.reps' => 'Répétitions',
			'session.add.time' => 'Temps',
			'session.swap.title' => 'Modifier l\'exercice',
			'session.swap.currently' => ({required Object name}) => 'Actuellement : ${name}',
			'session.swap.sessionOnly' => 'Ces changements ne s’appliquent qu’à cette séance.',
			'session.swap.useLabel' => 'Utiliser',
			'session.swap.adoptFormat' => 'Reprendre le format',
			'session.swap.adoptFormatSummary' => ({required Object summary, required Object name}) => '${summary} · d’après « ${name} »',
			'session.swap.apply' => 'Appliquer pour cette séance',
			'session.variants.title' => 'Choisir une variante',
			'session.variants.lockedMessage' => 'Une série est déjà validée — termine l’exercice ou utilise « Échanger » pour ajuster en cours de route.',
			'session.variants.pickMessage' => 'Sélectionne une variante pour cet emplacement. Elle remplacera l’exercice courant.',
			'session.variants.empty' => 'Aucune variante définie pour cet exercice.',
			'session.variants.main' => 'PRINCIPAL',
			'session.variants.variantN' => ({required Object n}) => 'Variante ${n}',
			'session.variants.restSeconds' => ({required Object n}) => '${n}s repos',
			'session.variants.tempoPart' => ({required Object tempo}) => ' · tempo ${tempo}',
			'session.finish.title' => 'Terminer la séance ?',
			'session.finish.summaryReps' => ({required Object completed, required Object total}) => '${completed}/${total} séries · ',
			'session.finish.summaryTonnageSuffix' => ' de tonnage',
			'session.finish.notesHint' => 'Notes sur la séance (optionnel)…',
			'session.finish.confirm' => 'Terminer',
			'session.finish.unvalidatedSets' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} SÉRIE NON VALIDÉE', other: '${n} SÉRIES NON VALIDÉES', ), 
			'session.finish.incompleteHint' => 'Tu peux revenir valider tes séries, ou terminer quand même — seules les séries cochées seront enregistrées.',
			'session.timer.preparation' => 'PRÉPARATION',
			'session.timer.running' => 'EN COURS',
			'session.timer.done' => 'TERMINÉ',
			'session.timer.go' => 'GO',
			'session.timer.stop' => 'Arrêter',
			'session.rest.title' => 'RÉCUPÉRATION',
			'session.rest.sec' => 'SEC',
			'session.rest.skip' => 'Passer',
			'session.rest.minimize' => 'Réduire',
			'session.set.addSet' => 'Ajouter une série',
			'session.set.setLabel' => ({required Object n}) => 'Série ${n}',
			'session.set.reps' => 'Reps',
			'session.set.load' => 'Charge',
			'session.set.duration' => 'Durée',
			'session.set.held' => 'Tenu',
			'session.set.tonnage' => 'TONNAGE',
			'session.set.targetReps' => ({required Object n}) => 'objectif ${n} reps',
			'session.set.targetDuration' => ({required Object value}) => 'objectif ${value}',
			'session.set.validateWithoutTimer' => 'Valider sans timer',
			'session.set.cmpUp' => 'Top',
			'session.exercise.timed' => 'Chronométré',
			'session.exercise.tempoChip' => ({required Object tempo}) => 'Tempo ${tempo}',
			'session.exercise.restChip' => ({required Object n}) => '${n}s récup',
			'session.exercise.modified' => 'Modifié · séance uniquement',
			'session.exercise.modifiedWas' => ({required Object name}) => 'Modifié · séance uniquement (était : ${name})',
			'session.exercise.completedBadge' => '✓ Terminé',
			'session.exercise.totalHeld' => ({required Object value}) => 'Total tenu : ${value}',
			'session.exercise.exerciseVolume' => ({required Object value}) => 'Volume exercice : ${value} kg',
			'session.exercise.lastTimeLabel' => 'Dernière fois',
			'session.exercise.otherWorkout' => 'autre séance',
			'session.exercise.targetWasReps' => ({required Object n}) => 'visait ${n} reps',
			'session.exercise.targetWasSeconds' => ({required Object n}) => 'visait ${n}s',
			'session.exercise.morePerfs' => ({required Object n}) => '+${n}',
			'session.overview.title' => 'Exercices',
			'session.overview.current' => 'EN COURS',
			'session.overview.setsValidated' => ({required Object completed, required Object total}) => '${completed}/${total} séries validées',
			'session.superset.badge' => ({required Object n}) => 'SUPERSET · ${n} EXOS',
			'session.superset.addSetTo' => ({required Object letter, required Object name}) => 'Ajouter une série à ${letter} · ${name}',
			'session.duration.title' => 'Durée par série',
			'session.duration.hint' => '45 ou 1m30',
			'session.duration.confirm' => ({required Object value}) => 'Confirmer — ${value}',
			'session.weight.bodyweight' => 'Poids de corps',
			'session.weight.confirmBodyweight' => 'Confirmer — Poids de corps',
			'session.weight.confirmKg' => ({required Object value}) => 'Confirmer — ${value} kg',
			'session.search.hint' => 'Rechercher un exercice…',
			'session.search.loading' => 'Chargement des exercices…',
			'session.search.noMatch' => 'Aucun exercice ne correspond.',
			'session.search.certifiedBadge' => 'Exercice Repster',
			'session.history.title' => ({required Object name}) => 'Historique · ${name}',
			'session.history.empty' => 'Pas encore d’historique pour cet exercice.',
			'session.history.loading' => 'Chargement de l’historique…',
			'session.history.setLabel' => ({required Object n}) => 'Série ${n}',
			'session.history.dateFormat' => 'd MMM yyyy',
			'session.fields.exerciseName' => 'Nom de l’exercice',
			'session.fields.type' => 'Type',
			'session.fields.sets' => 'Séries',
			'session.fields.durationSec' => 'Durée (sec)',
			'session.fields.targetReps' => 'Reps cibles',
			'session.fields.restShort' => 'Récup. (sec)',
			'session.fields.rest' => 'Récupération (sec)',
			'session.fields.tempo' => 'Tempo',
			'session.fields.notesOptional' => 'Notes (optionnel)',
			'session.fields.notesHint' => 'Conseils techniques…',
			'session.toast.exerciseAdded' => ({required Object name}) => '${name} ajouté à la séance',
			'session.toast.validateOneSet' => 'Valide au moins une série avant de finir.',
			'session.toast.sessionSaved' => 'Séance enregistrée ! 🎉',
			'session.toast.finishOrSwap' => 'Termine la série en cours ou utilise « Échanger ».',
			'session.notif.countdownChannel' => 'Compte à rebours de récup',
			'session.notif.doneChannel' => 'Fin de récupération',
			'session.notif.doneTitle' => 'Récupération terminée',
			'settings.title' => 'Réglages',
			'settings.sections.profile' => 'Profil',
			'settings.sections.data' => 'Mes données',
			'settings.sections.preferences' => 'Préférences',
			'settings.sections.account' => 'Compte',
			'settings.defaultName' => 'Athlète',
			'settings.editProfile' => 'MODIFIER',
			'settings.profileUnavailable' => 'Profil indisponible',
			'settings.rows.templates' => 'Mes templates',
			'settings.rows.history' => 'Historique des séances',
			'settings.rows.stats' => 'Statistiques',
			'settings.rows.notifications' => 'Notifications',
			'settings.rows.privacy' => 'Confidentialité',
			'settings.rows.terms' => 'Conditions d’utilisation',
			'settings.rows.contact' => 'Contact & Feedback',
			'settings.rows.language' => 'Langue',
			'settings.rows.changePassword' => 'Changer mon mot de passe',
			'settings.soon' => 'Bientôt',
			'settings.soonToast' => 'Bientôt disponible',
			'settings.logout.action' => 'Se déconnecter',
			'settings.logout.error' => 'Échec de la déconnexion.',
			'settings.version' => 'Repster v1.0 · Entraîne-toi, progresse, répète.',
			'settings.language.title' => 'Langue',
			'settings.language.subtitle' => 'Choisis la langue de l\'application',
			'settings.language.system' => 'Langue du système',
			'stats.title' => 'Stats',
			'stats.sessionsCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} séance', other: '${n} séances', ), 
			'stats.weeksShort' => ({required Object n}) => '${n} sem.',
			'stats.subtitle.empty' => 'Aucune séance sur la période',
			'stats.empty.title' => 'Pas encore de données',
			'stats.empty.message' => 'Effectue quelques séances pour voir tes courbes et ta progression.',
			'stats.range.last4Weeks.label' => '4 semaines',
			'stats.range.last4Weeks.short' => '4 sem.',
			'stats.range.last3Months.label' => '3 mois',
			'stats.range.last3Months.short' => '3 mois',
			'stats.range.all.label' => 'Tout',
			'stats.range.all.short' => 'Tout',
			'stats.kpi.sessions' => 'Séances',
			'stats.kpi.volume' => 'Tonnage',
			'stats.kpi.sets' => 'Séries',
			'stats.kpi.avgDuration' => 'Durée moy.',
			'stats.kpi.tension' => 'Temps sous tension',
			'stats.weeklyVolume.title' => 'Volume par semaine',
			'stats.weeklyVolume.empty' => 'Pas encore assez de séances sur la période.',
			'stats.weeklyVolume.inProgress' => 'en cours',
			'stats.exercise.title' => 'Progression par exercice',
			'stats.exercise.empty' => 'Enchaîne au moins 2 séances avec un même exercice chargé pour voir ta courbe de force.',
			'stats.exercise.pickerTitle' => 'Choisir un exercice',
			'stats.exercise.noExercise' => 'Aucun exercice',
			'stats.exercise.searchHint' => 'Rechercher…',
			'stats.exercise.oneRmMax' => '1RM estimé max',
			'stats.exercise.bestLoad' => 'meilleure charge',
			'stats.exercise.record' => 'record',
			'stats.exercise.trendUnknown' => 'Pas encore assez de séances pour lire une tendance',
			'stats.exercise.trendProgressing' => 'En progression',
			'stats.exercise.trendPlateau' => ({required Object n}) => 'Plateau · ${n} séances sans record',
			'stats.exercise.trendRegressing' => 'En recul',
			'stats.exercise.perMonth' => ({required Object value}) => '${value} %/mois',
			'stats.exercise.plateauHint' => 'Essaie moins de reps plus lourd, ou change de mouvement.',
			'stats.muscleBalance.title' => 'Équilibre musculaire',
			'stats.muscleBalance.neglected' => ({required Object days, required Object emoji}) => '— pas travaillé depuis ${days} j ${emoji}',
			'stats.muscleBalance.since.none' => '–',
			'stats.muscleBalance.since.today' => 'auj.',
			'stats.muscleBalance.since.yesterday' => 'hier',
			'stats.muscleBalance.since.daysShort' => ({required Object n}) => '${n}j',
			'stats.records.title' => 'Records',
			'stats.records.bestSession' => 'Meilleure séance',
			'stats.records.heaviestLift' => 'Charge max',
			'stats.records.bestOneRm' => '1RM estimé',
			'stats.records.bestStreak' => 'Plus long streak',
			'stats.records.consecutiveWeeks' => 'semaines consécutives',
			'stats.strength.title' => 'Force',
			'stats.strength.scope' => 'tout l’historique',
			'templates.list.title' => 'Programme',
			'templates.list.subtitleActive' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} séance active', other: '${n} séances actives', ), 
			'templates.list.subtitleManage' => ({required num n, required Object total}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} / ${total} active', other: '${n} / ${total} actives', ), 
			'templates.list.manage' => 'Gérer',
			'templates.list.newAction' => 'Créer',
			'templates.list.emptyTitle' => 'Aucune séance',
			'templates.list.emptyMessage' => 'Crée ta première séance pour composer ton programme.',
			'templates.list.emptyAction' => 'Créer une séance',
			'templates.list.emptyActiveTitle' => 'Aucune séance dans le programme',
			'templates.list.emptyActiveMessage' => 'Active des séances pour les ajouter à ton programme.',
			'templates.list.emptyActiveAction' => 'Gérer les séances',
			'templates.list.noResult' => 'Aucun résultat',
			'templates.list.searchHint' => 'Rechercher une séance…',
			'templates.list.manageHint' => 'Glisse pour réorganiser · touche le cercle pour masquer/afficher une séance',
			'templates.list.savedChanges' => 'Modifications sauvegardées ✓',
			'templates.list.reorderError' => 'Erreur lors du réordonnancement.',
			'templates.list.toggleError' => 'Action impossible.',
			'templates.list.duplicated' => 'Séance copiée !',
			'templates.list.duplicateError' => 'Duplication impossible.',
			'templates.list.deleted' => 'Séance supprimée.',
			'templates.list.deleteError' => 'Suppression impossible.',
			'templates.list.copySuffix' => '(copie)',
			'templates.card.exerciseCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} exercice', other: '${n} exercices', ), 
			'templates.card.details' => 'Détails',
			'templates.card.copy' => 'Copier',
			'templates.card.deleteShort' => 'Suppr.',
			'templates.card.activate' => 'Activer',
			_ => null,
		} ?? switch (path) {
			'templates.card.deactivate' => 'Désactiver',
			'templates.detail.title' => 'Template',
			'templates.detail.noExercises' => 'Aucun exercice dans ce template.',
			'templates.detail.superset' => 'Superset',
			'templates.detail.setsCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} série', other: '${n} séries', ), 
			'templates.detail.seconds' => ({required Object n}) => '${n} s',
			'templates.detail.tempo' => ({required Object value}) => 'Tempo ${value}',
			'templates.detail.rest' => ({required Object n}) => 'Repos ${n}s',
			'templates.detail.variantsMore' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '+${n} variante', other: '+${n} variantes', ), 
			'templates.detail.start' => 'Démarrer la séance',
			'templates.editor.newTitle' => 'Nouvelle séance',
			'templates.editor.editTitle' => 'Modifier la séance',
			'templates.editor.exercisesHeader' => ({required Object count}) => 'EXERCICES (${count})',
			'templates.editor.addExercise' => 'Ajouter un exercice',
			'templates.editor.save' => 'Enregistrer la séance',
			'templates.editor.validationError' => 'Renseigne un nom et au moins un exercice nommé.',
			'templates.fields.name' => 'Nom de la séance',
			'templates.fields.nameHint' => 'ex : Pec / Triceps / Épaules',
			'templates.fields.description' => 'Description (optionnel)',
			'templates.fields.descriptionHint' => 'Décris ta séance…',
			'templates.fields.muscleGroups' => 'Groupes musculaires',
			'templates.fields.selectedCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} sélectionné', other: '${n} sélectionnés', ), 
			'templates.fields.exerciseName' => 'Nom de l’exercice',
			'templates.fields.exerciseNameHint' => 'ex : Développé couché',
			'templates.fields.type' => 'Type',
			'templates.fields.sets' => 'Séries',
			'templates.fields.duration' => 'Durée (s)',
			'templates.fields.targetReps' => 'Reps cibles',
			'templates.fields.rest' => 'Récup. (s)',
			'templates.fields.tempo' => 'Tempo',
			'templates.fields.tempoHint' => '3-1-X-0',
			'templates.fields.notes' => 'Notes (optionnel)',
			'templates.fields.notesHint' => 'Conseils techniques…',
			'templates.slot.newExercise' => 'Nouvel exercice',
			'templates.slot.variantN' => ({required Object n}) => 'Variante ${n}',
			'templates.slot.primary' => 'PRINCIPAL',
			'templates.slot.variant' => 'Variante',
			'templates.slot.addVariant' => 'Ajouter une variante',
			'templates.slot.supersetNote' => 'Enchaîné en superset avec l’exercice suivant',
			'templates.slot.supersetLabel' => 'SUPERSET',
			'templates.slot.reps' => 'Répétitions',
			'templates.slot.time' => 'Temps',
			'tempo.helper' => 'Excentrique — pause — concentrique — pause (en s)',
			'tempo.formatError' => 'Format attendu : 3-1-X-0',
			_ => null,
		};
	}
}
