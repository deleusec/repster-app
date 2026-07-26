///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'translations.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	late final Translations$auth$en auth = Translations$auth$en.internal(_root);
	late final Translations$common$en common = Translations$common$en.internal(_root);
	late final Translations$contact$en contact = Translations$contact$en.internal(_root);
	late final Translations$dashboard$en dashboard = Translations$dashboard$en.internal(_root);
	late final Translations$errors$en errors = Translations$errors$en.internal(_root);
	late final Translations$goals$en goals = Translations$goals$en.internal(_root);
	late final Translations$history$en history = Translations$history$en.internal(_root);
	late final Translations$legal$en legal = Translations$legal$en.internal(_root);
	late final Translations$muscleGroups$en muscleGroups = Translations$muscleGroups$en.internal(_root);
	late final Translations$nav$en nav = Translations$nav$en.internal(_root);
	late final Translations$profile$en profile = Translations$profile$en.internal(_root);
	late final Translations$session$en session = Translations$session$en.internal(_root);
	late final Translations$settings$en settings = Translations$settings$en.internal(_root);
	late final Translations$stats$en stats = Translations$stats$en.internal(_root);
	late final Translations$templates$en templates = Translations$templates$en.internal(_root);
	late final Translations$tempo$en tempo = Translations$tempo$en.internal(_root);
}

// Path: auth
class Translations$auth$en {
	Translations$auth$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$auth$fields$en fields = Translations$auth$fields$en.internal(_root);

	/// en: 'Back to sign in'
	String get backToLogin => 'Back to sign in';

	late final Translations$auth$login$en login = Translations$auth$login$en.internal(_root);
	late final Translations$auth$signup$en signup = Translations$auth$signup$en.internal(_root);
	late final Translations$auth$onboarding$en onboarding = Translations$auth$onboarding$en.internal(_root);
	late final Translations$auth$verifyEmail$en verifyEmail = Translations$auth$verifyEmail$en.internal(_root);
	late final Translations$auth$forgotPassword$en forgotPassword = Translations$auth$forgotPassword$en.internal(_root);
	late final Translations$auth$updatePassword$en updatePassword = Translations$auth$updatePassword$en.internal(_root);
	late final Translations$auth$changePassword$en changePassword = Translations$auth$changePassword$en.internal(_root);
	late final Translations$auth$validators$en validators = Translations$auth$validators$en.internal(_root);
}

// Path: common
class Translations$common$en {
	Translations$common$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Repster'
	String get appName => 'Repster';

	late final Translations$common$actions$en actions = Translations$common$actions$en.internal(_root);

	/// en: 'All'
	String get all => 'All';

	/// en: '(unnamed)'
	String get unnamed => '(unnamed)';

	late final Translations$common$units$en units = Translations$common$units$en.internal(_root);
	late final Translations$common$date$en date = Translations$common$date$en.internal(_root);
	late final Translations$common$language$en language = Translations$common$language$en.internal(_root);
}

// Path: contact
class Translations$contact$en {
	Translations$contact$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$contact$header$en header = Translations$contact$header$en.internal(_root);
	late final Translations$contact$sections$en sections = Translations$contact$sections$en.internal(_root);
	late final Translations$contact$fields$en fields = Translations$contact$fields$en.internal(_root);

	/// en: '{{current}} / {{max}}'
	String counter({required Object current, required Object max}) => '${current} / ${max}';

	/// en: 'Send'
	String get submit => 'Send';

	late final Translations$contact$categories$en categories = Translations$contact$categories$en.internal(_root);
	late final Translations$contact$success$en success = Translations$contact$success$en.internal(_root);
}

// Path: dashboard
class Translations$dashboard$en {
	Translations$dashboard$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$dashboard$greeting$en greeting = Translations$dashboard$greeting$en.internal(_root);

	/// en: 'Athlete'
	String get defaultName => 'Athlete';

	/// en: 'See all'
	String get seeAll => 'See all';

	late final Translations$dashboard$sections$en sections = Translations$dashboard$sections$en.internal(_root);
	late final Translations$dashboard$templates$en templates = Translations$dashboard$templates$en.internal(_root);

	/// en: '(one) {{{n}} exercise} (other) {{{n}} exercises}'
	String exerciseCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} exercise',
		other: '${n} exercises',
	);

	late final Translations$dashboard$hero$en hero = Translations$dashboard$hero$en.internal(_root);
	late final Translations$dashboard$recent$en recent = Translations$dashboard$recent$en.internal(_root);
	late final Translations$dashboard$inProgress$en inProgress = Translations$dashboard$inProgress$en.internal(_root);
	late final Translations$dashboard$stats$en stats = Translations$dashboard$stats$en.internal(_root);

	/// en: '(one) {{{n}} week streak} (other) {{{n}} weeks streak}'
	String streakBadge({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} week streak',
		other: '${n} weeks streak',
	);
}

// Path: errors
class Translations$errors$en {
	Translations$errors$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'No network connection. Check your connection.'
	String get network => 'No network connection. Check your connection.';

	/// en: 'Item not found.'
	String get notFound => 'Item not found.';

	/// en: 'Something went wrong. Try again.'
	String get generic => 'Something went wrong. Try again.';

	/// en: 'Invalid or expired code.'
	String get invalidCode => 'Invalid or expired code.';

	/// en: 'The new password must be different from the old one.'
	String get passwordSameAsOld => 'The new password must be different from the old one.';

	late final Translations$errors$auth$en auth = Translations$errors$auth$en.internal(_root);
}

// Path: goals
class Translations$goals$en {
	Translations$goals$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Strength'
	String get strength => 'Strength';

	/// en: 'Hypertrophy'
	String get hypertrophy => 'Hypertrophy';

	/// en: 'Endurance'
	String get endurance => 'Endurance';

	/// en: 'Weight loss'
	String get weightLoss => 'Weight loss';

	/// en: 'Maintenance'
	String get maintenance => 'Maintenance';
}

// Path: history
class Translations$history$en {
	Translations$history$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'History'
	String get title => 'History';

	/// en: 'No sessions'
	String get emptySubtitle => 'No sessions';

	/// en: 'No sessions yet'
	String get emptyTitle => 'No sessions yet';

	/// en: 'Start your first session from the home screen — it will show up here.'
	String get emptyMessage => 'Start your first session from the home screen — it will show up here.';

	/// en: '(one) {{{n}} session} (other) {{{n}} sessions}'
	String sessionCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} session',
		other: '${n} sessions',
	);

	/// en: 'Delete failed.'
	String get deleteError => 'Delete failed.';

	/// en: 'No sessions for this group'
	String get noResult => 'No sessions for this group';

	late final Translations$history$groups$en groups = Translations$history$groups$en.internal(_root);
	late final Translations$history$panel$en panel = Translations$history$panel$en.internal(_root);
	late final Translations$history$detail$en detail = Translations$history$detail$en.internal(_root);
}

// Path: legal
class Translations$legal$en {
	Translations$legal$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'This document is available in English only.'
	String get onlyInEnglish => 'This document is available in English only.';
}

// Path: muscleGroups
class Translations$muscleGroups$en {
	Translations$muscleGroups$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Chest'
	String get chest => 'Chest';

	/// en: 'Back'
	String get back => 'Back';

	/// en: 'Shoulders'
	String get shoulders => 'Shoulders';

	/// en: 'Biceps'
	String get biceps => 'Biceps';

	/// en: 'Triceps'
	String get triceps => 'Triceps';

	/// en: 'Forearms'
	String get forearms => 'Forearms';

	/// en: 'Quads'
	String get quads => 'Quads';

	/// en: 'Hamstrings'
	String get hamstrings => 'Hamstrings';

	/// en: 'Glutes'
	String get glutes => 'Glutes';

	/// en: 'Calves'
	String get calves => 'Calves';

	/// en: 'Abs'
	String get abs => 'Abs';

	/// en: 'Other'
	String get custom => 'Other';

	late final Translations$muscleGroups$sections$en sections = Translations$muscleGroups$sections$en.internal(_root);
}

// Path: nav
class Translations$nav$en {
	Translations$nav$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Home'
	String get home => 'Home';

	/// en: 'Program'
	String get program => 'Program';

	/// en: 'History'
	String get history => 'History';

	/// en: 'Stats'
	String get stats => 'Stats';

	/// en: 'Settings'
	String get settings => 'Settings';
}

// Path: profile
class Translations$profile$en {
	Translations$profile$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Not signed in.'
	String get notConnected => 'Not signed in.';

	/// en: 'PROFILE'
	String get navTitle => 'PROFILE';

	/// en: 'Athlete'
	String get defaultName => 'Athlete';

	/// en: 'Since {{month}}'
	String since({required Object month}) => 'Since ${month}';

	late final Translations$profile$editSheet$en editSheet = Translations$profile$editSheet$en.internal(_root);
	late final Translations$profile$sections$en sections = Translations$profile$sections$en.internal(_root);
	late final Translations$profile$stats$en stats = Translations$profile$stats$en.internal(_root);

	/// en: '(one) {{{n}} session} (other) {{{n}} sessions}'
	String sessionCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} session',
		other: '${n} sessions',
	);

	late final Translations$profile$badges$en badges = Translations$profile$badges$en.internal(_root);
	late final Translations$profile$avatar$en avatar = Translations$profile$avatar$en.internal(_root);
	late final Translations$profile$editForm$en editForm = Translations$profile$editForm$en.internal(_root);
}

// Path: session
class Translations$session$en {
	Translations$session$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'BW'
	String get bw => 'BW';

	/// en: 'Continue'
	String get continueLabel => 'Continue';

	late final Translations$session$error$en error = Translations$session$error$en.internal(_root);
	late final Translations$session$live$en live = Translations$session$live$en.internal(_root);
	late final Translations$session$confirm$en confirm = Translations$session$confirm$en.internal(_root);
	late final Translations$session$add$en add = Translations$session$add$en.internal(_root);
	late final Translations$session$swap$en swap = Translations$session$swap$en.internal(_root);
	late final Translations$session$variants$en variants = Translations$session$variants$en.internal(_root);
	late final Translations$session$finish$en finish = Translations$session$finish$en.internal(_root);
	late final Translations$session$timer$en timer = Translations$session$timer$en.internal(_root);
	late final Translations$session$rest$en rest = Translations$session$rest$en.internal(_root);
	late final Translations$session$set$en set = Translations$session$set$en.internal(_root);
	late final Translations$session$exercise$en exercise = Translations$session$exercise$en.internal(_root);
	late final Translations$session$overview$en overview = Translations$session$overview$en.internal(_root);
	late final Translations$session$superset$en superset = Translations$session$superset$en.internal(_root);
	late final Translations$session$duration$en duration = Translations$session$duration$en.internal(_root);
	late final Translations$session$weight$en weight = Translations$session$weight$en.internal(_root);
	late final Translations$session$search$en search = Translations$session$search$en.internal(_root);
	late final Translations$session$history$en history = Translations$session$history$en.internal(_root);
	late final Translations$session$fields$en fields = Translations$session$fields$en.internal(_root);
	late final Translations$session$toast$en toast = Translations$session$toast$en.internal(_root);
	late final Translations$session$notif$en notif = Translations$session$notif$en.internal(_root);
}

// Path: settings
class Translations$settings$en {
	Translations$settings$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Settings'
	String get title => 'Settings';

	late final Translations$settings$sections$en sections = Translations$settings$sections$en.internal(_root);

	/// en: 'Athlete'
	String get defaultName => 'Athlete';

	/// en: 'EDIT'
	String get editProfile => 'EDIT';

	late final Translations$settings$rows$en rows = Translations$settings$rows$en.internal(_root);

	/// en: 'Soon'
	String get soon => 'Soon';

	/// en: 'Coming soon'
	String get soonToast => 'Coming soon';

	late final Translations$settings$logout$en logout = Translations$settings$logout$en.internal(_root);

	/// en: 'Repster v1.0 · Train, progress, repeat.'
	String get version => 'Repster v1.0 · Train, progress, repeat.';

	late final Translations$settings$language$en language = Translations$settings$language$en.internal(_root);
}

// Path: stats
class Translations$stats$en {
	Translations$stats$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Stats'
	String get title => 'Stats';

	/// en: '(one) {{{n}} session} (other) {{{n}} sessions}'
	String sessionsCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} session',
		other: '${n} sessions',
	);

	/// en: '{{n}} wk'
	String weeksShort({required Object n}) => '${n} wk';

	late final Translations$stats$subtitle$en subtitle = Translations$stats$subtitle$en.internal(_root);
	late final Translations$stats$empty$en empty = Translations$stats$empty$en.internal(_root);
	late final Translations$stats$range$en range = Translations$stats$range$en.internal(_root);
	late final Translations$stats$kpi$en kpi = Translations$stats$kpi$en.internal(_root);
	late final Translations$stats$consistency$en consistency = Translations$stats$consistency$en.internal(_root);
	late final Translations$stats$weeklyVolume$en weeklyVolume = Translations$stats$weeklyVolume$en.internal(_root);
	late final Translations$stats$exercise$en exercise = Translations$stats$exercise$en.internal(_root);
	late final Translations$stats$muscleBalance$en muscleBalance = Translations$stats$muscleBalance$en.internal(_root);
	late final Translations$stats$records$en records = Translations$stats$records$en.internal(_root);
}

// Path: templates
class Translations$templates$en {
	Translations$templates$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$templates$list$en list = Translations$templates$list$en.internal(_root);
	late final Translations$templates$card$en card = Translations$templates$card$en.internal(_root);
	late final Translations$templates$detail$en detail = Translations$templates$detail$en.internal(_root);
	late final Translations$templates$editor$en editor = Translations$templates$editor$en.internal(_root);
	late final Translations$templates$fields$en fields = Translations$templates$fields$en.internal(_root);
	late final Translations$templates$slot$en slot = Translations$templates$slot$en.internal(_root);
}

// Path: tempo
class Translations$tempo$en {
	Translations$tempo$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Eccentric — pause — concentric — pause (in s)'
	String get helper => 'Eccentric — pause — concentric — pause (in s)';

	/// en: 'Expected format: 3-1-X-0'
	String get formatError => 'Expected format: 3-1-X-0';
}

// Path: auth.fields
class Translations$auth$fields$en {
	Translations$auth$fields$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Email address'
	String get email => 'Email address';

	/// en: 'Password'
	String get password => 'Password';
}

// Path: auth.login
class Translations$auth$login$en {
	Translations$auth$login$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Good to see you again'
	String get welcomeTitle => 'Good to see you again';

	/// en: 'Sign in to continue.'
	String get welcomeSubtitle => 'Sign in to continue.';

	/// en: 'Forgot password?'
	String get forgotPassword => 'Forgot password?';

	/// en: 'Sign in'
	String get submit => 'Sign in';

	/// en: 'Signing in…'
	String get submitLoading => 'Signing in…';

	/// en: 'No account yet?'
	String get noAccount => 'No account yet?';

	/// en: 'Create an account'
	String get createAccount => 'Create an account';
}

// Path: auth.signup
class Translations$auth$signup$en {
	Translations$auth$signup$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Create an account'
	String get title => 'Create an account';

	/// en: 'Join thousands of athletes.'
	String get subtitle => 'Join thousands of athletes.';

	/// en: 'Password (8 char. min.)'
	String get passwordHint => 'Password (8 char. min.)';

	/// en: 'Create my account'
	String get submit => 'Create my account';

	/// en: 'Creating…'
	String get submitLoading => 'Creating…';

	/// en: 'By creating an account, you accept our terms of use.'
	String get terms => 'By creating an account, you accept our terms of use.';
}

// Path: auth.onboarding
class Translations$auth$onboarding$en {
	Translations$auth$onboarding$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'What's your name?'
	String get step1Title => 'What\'s your\nname?';

	/// en: 'To personalize your experience.'
	String get step1Subtitle => 'To personalize your experience.';

	/// en: 'Your first name'
	String get nameHint => 'Your first name';

	/// en: 'Continue'
	String get continueLabel => 'Continue';

	/// en: 'What's your goal?'
	String get step2Title => 'What\'s your\ngoal?';

	/// en: 'We'll adapt your sessions accordingly.'
	String get step2Subtitle => 'We\'ll adapt your sessions accordingly.';

	/// en: 'A few details'
	String get step3Title => 'A few details';

	/// en: 'Optional'
	String get optional => 'Optional';

	/// en: 'For more accurate recommendations.'
	String get step3Subtitle => 'For more accurate recommendations.';

	/// en: 'Weight (kg)'
	String get weightHint => 'Weight (kg)';

	/// en: 'Height (cm)'
	String get heightHint => 'Height (cm)';

	/// en: 'Date of birth'
	String get birthdate => 'Date of birth';

	/// en: 'Let's go!'
	String get submit => 'Let\'s go!';

	/// en: 'Saving…'
	String get submitLoading => 'Saving…';

	/// en: 'Skip this step'
	String get skip => 'Skip this step';

	late final Translations$auth$onboarding$goalDescriptions$en goalDescriptions = Translations$auth$onboarding$goalDescriptions$en.internal(_root);

	/// en: 'Your first name is required.'
	String get nameRequired => 'Your first name is required.';

	/// en: 'First name too long.'
	String get nameTooLong => 'First name too long.';

	/// en: 'Choose a goal.'
	String get goalRequired => 'Choose a goal.';

	/// en: 'Invalid weight'
	String get weightInvalid => 'Invalid weight';

	/// en: 'Invalid height'
	String get heightInvalid => 'Invalid height';
}

// Path: auth.verifyEmail
class Translations$auth$verifyEmail$en {
	Translations$auth$verifyEmail$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Verify your email'
	String get title => 'Verify your email';

	/// en: 'We sent a 6-digit code'
	String get subtitle => 'We sent a 6-digit code';

	/// en: 'Verifying…'
	String get submitLoading => 'Verifying…';

	/// en: 'Verify the code'
	String get submitComplete => 'Verify the code';

	/// en: 'Enter the code you received'
	String get submitIncomplete => 'Enter the code you received';

	/// en: 'Didn't receive the code?'
	String get noCode => 'Didn\'t receive the code?';

	/// en: 'Code resent!'
	String get resent => 'Code resent!';

	/// en: 'Resend in {{n}}s'
	String resendCooldown({required Object n}) => 'Resend in ${n}s';

	/// en: 'Sending…'
	String get resending => 'Sending…';

	/// en: 'Resend the code'
	String get resend => 'Resend the code';

	/// en: 'Missing email. Go back to sign up.'
	String get emailMissing => 'Missing email. Go back to sign up.';
}

// Path: auth.forgotPassword
class Translations$auth$forgotPassword$en {
	Translations$auth$forgotPassword$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Forgot password'
	String get title => 'Forgot password';

	/// en: 'We'll send you a reset link'
	String get subtitle => 'We\'ll send you a reset link';

	/// en: 'Send the link'
	String get submit => 'Send the link';

	/// en: 'Sending…'
	String get submitLoading => 'Sending…';

	/// en: 'A reset link has been sent to your email address. Check your inbox.'
	String get successMessage => 'A reset link has been sent to your email address. Check your inbox.';
}

// Path: auth.updatePassword
class Translations$auth$updatePassword$en {
	Translations$auth$updatePassword$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'New password'
	String get title => 'New password';

	/// en: 'Choose a secure password'
	String get subtitle => 'Choose a secure password';

	/// en: 'New password'
	String get newHint => 'New password';

	/// en: 'Confirm the password'
	String get confirmHint => 'Confirm the password';

	/// en: 'Save the password'
	String get submit => 'Save the password';

	/// en: 'Saving…'
	String get submitLoading => 'Saving…';
}

// Path: auth.changePassword
class Translations$auth$changePassword$en {
	Translations$auth$changePassword$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Change password'
	String get title => 'Change password';

	/// en: 'For your security, confirm your current password before choosing a new one.'
	String get subtitle => 'For your security, confirm your current password before choosing a new one.';

	/// en: 'Current password'
	String get currentHint => 'Current password';

	/// en: 'New password'
	String get newHint => 'New password';

	/// en: 'Confirm the new password'
	String get confirmHint => 'Confirm the new password';

	/// en: 'Update the password'
	String get submit => 'Update the password';

	/// en: 'Updating…'
	String get submitLoading => 'Updating…';

	/// en: 'Password updated'
	String get successToast => 'Password updated';

	/// en: 'Current password required'
	String get currentRequired => 'Current password required';

	/// en: 'The new password must differ from the current one'
	String get mustDiffer => 'The new password must differ from the current one';

	/// en: 'Current password incorrect'
	String get currentIncorrect => 'Current password incorrect';
}

// Path: auth.validators
class Translations$auth$validators$en {
	Translations$auth$validators$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Email required'
	String get emailRequired => 'Email required';

	/// en: 'Invalid email'
	String get emailInvalid => 'Invalid email';

	/// en: 'Password required'
	String get passwordRequired => 'Password required';

	/// en: 'Minimum 8 characters'
	String get passwordMin => 'Minimum 8 characters';

	/// en: 'Passwords do not match'
	String get passwordMismatch => 'Passwords do not match';
}

// Path: common.actions
class Translations$common$actions$en {
	Translations$common$actions$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Confirm'
	String get confirm => 'Confirm';

	/// en: 'Save'
	String get save => 'Save';

	/// en: 'Retry'
	String get retry => 'Retry';

	/// en: 'Delete'
	String get delete => 'Delete';

	/// en: 'Close'
	String get close => 'Close';

	/// en: 'Edit'
	String get edit => 'Edit';

	/// en: 'Done'
	String get done => 'Done';

	/// en: 'Next'
	String get next => 'Next';

	/// en: 'Back'
	String get back => 'Back';
}

// Path: common.units
class Translations$common$units$en {
	Translations$common$units$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'reps'
	String get reps => 'reps';
}

// Path: common.date
class Translations$common$date$en {
	Translations$common$date$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'just now'
	String get justNow => 'just now';

	/// en: '{{n}} min ago'
	String minutesAgo({required Object n}) => '${n} min ago';

	/// en: '{{n}} h ago'
	String hoursAgo({required Object n}) => '${n} h ago';

	/// en: 'yesterday'
	String get yesterday => 'yesterday';

	/// en: '{{n}} d ago'
	String daysAgo({required Object n}) => '${n} d ago';

	/// en: 'today'
	String get today => 'today';

	/// en: '{{n}} w ago'
	String weeksAgo({required Object n}) => '${n} w ago';

	/// en: '{{n}} mo ago'
	String monthsAgo({required Object n}) => '${n} mo ago';
}

// Path: common.language
class Translations$common$language$en {
	Translations$common$language$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'English'
	String get en => 'English';

	/// en: 'French'
	String get fr => 'French';

	/// en: 'Spanish'
	String get es => 'Spanish';

	/// en: 'German'
	String get de => 'German';

	/// en: 'Italian'
	String get it => 'Italian';
}

// Path: contact.header
class Translations$contact$header$en {
	Translations$contact$header$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Contact & feedback'
	String get title => 'Contact & feedback';

	/// en: 'A bug, an idea, a question? Write to us, we read everything.'
	String get subtitle => 'A bug, an idea, a question? Write to us, we read everything.';
}

// Path: contact.sections
class Translations$contact$sections$en {
	Translations$contact$sections$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Request type'
	String get type => 'Request type';

	/// en: 'Your info'
	String get yourInfo => 'Your info';

	/// en: 'Message'
	String get message => 'Message';
}

// Path: contact.fields
class Translations$contact$fields$en {
	Translations$contact$fields$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Your first name'
	String get nameHint => 'Your first name';

	/// en: 'Name required'
	String get nameRequired => 'Name required';

	/// en: 'Your email address'
	String get emailHint => 'Your email address';

	/// en: 'Invalid email'
	String get emailInvalid => 'Invalid email';

	/// en: 'Message too short (10 characters min)'
	String get messageTooShort => 'Message too short (10 characters min)';
}

// Path: contact.categories
class Translations$contact$categories$en {
	Translations$contact$categories$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$contact$categories$bug$en bug = Translations$contact$categories$bug$en.internal(_root);
	late final Translations$contact$categories$feature$en feature = Translations$contact$categories$feature$en.internal(_root);
	late final Translations$contact$categories$general$en general = Translations$contact$categories$general$en.internal(_root);
	late final Translations$contact$categories$other$en other = Translations$contact$categories$other$en.internal(_root);
}

// Path: contact.success
class Translations$contact$success$en {
	Translations$contact$success$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Message sent'
	String get title => 'Message sent';

	/// en: 'Back to settings'
	String get back => 'Back to settings';
}

// Path: dashboard.greeting
class Translations$dashboard$greeting$en {
	Translations$dashboard$greeting$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Good morning'
	String get morning => 'Good morning';

	/// en: 'Good afternoon'
	String get afternoon => 'Good afternoon';

	/// en: 'Good evening'
	String get evening => 'Good evening';
}

// Path: dashboard.sections
class Translations$dashboard$sections$en {
	Translations$dashboard$sections$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Templates'
	String get templates => 'Templates';

	/// en: 'Latest sessions'
	String get recentSessions => 'Latest sessions';
}

// Path: dashboard.templates
class Translations$dashboard$templates$en {
	Translations$dashboard$templates$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'No templates yet'
	String get empty => 'No templates yet';

	/// en: 'New'
	String get newLabel => 'New';
}

// Path: dashboard.hero
class Translations$dashboard$hero$en {
	Translations$dashboard$hero$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'READY TO TRAIN?'
	String get eyebrow => 'READY TO TRAIN?';

	/// en: 'Start session'
	String get start => 'Start session';

	/// en: 'Create your first template'
	String get emptyTitle => 'Create your first template';

	/// en: 'Set up your exercises and off you go.'
	String get emptyMessage => 'Set up your exercises and off you go.';

	/// en: 'Create a template'
	String get create => 'Create a template';
}

// Path: dashboard.recent
class Translations$dashboard$recent$en {
	Translations$dashboard$recent$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Start your first session!'
	String get emptyTitle => 'Start your first session!';

	/// en: 'Pick a template and off you go.'
	String get emptyMessage => 'Pick a template and off you go.';

	/// en: 'tonnage'
	String get tonnage => 'tonnage';
}

// Path: dashboard.inProgress
class Translations$dashboard$inProgress$en {
	Translations$dashboard$inProgress$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'SESSION IN PROGRESS'
	String get label => 'SESSION IN PROGRESS';

	/// en: 'Started {{when}}'
	String startedAt({required Object when}) => 'Started ${when}';

	/// en: 'Resume'
	String get resume => 'Resume';

	/// en: 'Discard'
	String get discard => 'Discard';

	/// en: 'Discard session?'
	String get discardTitle => 'Discard session?';

	/// en: 'All current entries will be lost.'
	String get discardMessage => 'All current entries will be lost.';

	/// en: 'Failed — try again.'
	String get discardError => 'Failed — try again.';
}

// Path: dashboard.stats
class Translations$dashboard$stats$en {
	Translations$dashboard$stats$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Sessions'
	String get sessions => 'Sessions';

	/// en: 'Volume'
	String get volume => 'Volume';

	/// en: 'Streak'
	String get streak => 'Streak';

	/// en: 'this wk'
	String get thisWeek => 'this wk';

	/// en: '(one) {week} (other) {weeks}'
	String weekCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'week',
		other: 'weeks',
	);
}

// Path: errors.auth
class Translations$errors$auth$en {
	Translations$errors$auth$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Incorrect email or password.'
	String get invalidCredentials => 'Incorrect email or password.';

	/// en: 'Confirm your email before signing in.'
	String get emailNotConfirmed => 'Confirm your email before signing in.';

	/// en: 'An account already exists with this email.'
	String get userAlreadyExists => 'An account already exists with this email.';

	/// en: 'Session expired. Please sign in again.'
	String get sessionExpired => 'Session expired. Please sign in again.';

	/// en: 'You must be signed in.'
	String get notSignedIn => 'You must be signed in.';
}

// Path: history.groups
class Translations$history$groups$en {
	Translations$history$groups$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'This week'
	String get thisWeek => 'This week';

	/// en: 'Last week'
	String get lastWeek => 'Last week';

	/// en: '(one) {{{n}} week ago} (other) {{{n}} weeks ago}'
	String weeksAgo({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} week ago',
		other: '${n} weeks ago',
	);
}

// Path: history.panel
class Translations$history$panel$en {
	Translations$history$panel$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Sessions'
	String get sessions => 'Sessions';

	/// en: 'Volume'
	String get volume => 'Volume';

	/// en: 'Time'
	String get time => 'Time';
}

// Path: history.detail
class Translations$history$detail$en {
	Translations$history$detail$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Session'
	String get title => 'Session';

	/// en: 'EEEE, MMMM d 'at' HH:mm'
	String get dateFormat => 'EEEE, MMMM d \'at\' HH:mm';

	/// en: 'Duration'
	String get duration => 'Duration';

	/// en: 'Tonnage'
	String get tonnage => 'Tonnage';

	/// en: 'Sets'
	String get sets => 'Sets';

	/// en: 'Notes'
	String get notes => 'Notes';

	/// en: 'Per-exercise breakdown'
	String get perExercise => 'Per-exercise breakdown';

	/// en: '(one) {{{n}} set} (other) {{{n}} sets}'
	String setsCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} set',
		other: '${n} sets',
	);

	/// en: 'Bodyweight'
	String get bodyweight => 'Bodyweight';

	/// en: 'Set'
	String get colSet => 'Set';

	/// en: 'Reps'
	String get colReps => 'Reps';

	/// en: 'Load'
	String get colLoad => 'Load';

	/// en: 'Held'
	String get colHeld => 'Held';

	/// en: 'Exercise total'
	String get totalExercise => 'Exercise total';

	/// en: 'Total held'
	String get totalHeld => 'Total held';

	late final Translations$history$detail$edit$en edit = Translations$history$detail$edit$en.internal(_root);
}

// Path: muscleGroups.sections
class Translations$muscleGroups$sections$en {
	Translations$muscleGroups$sections$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Chest & Back'
	String get chestBack => 'Chest & Back';

	/// en: 'Shoulders & Arms'
	String get shouldersArms => 'Shoulders & Arms';

	/// en: 'Legs & Glutes'
	String get legsGlutes => 'Legs & Glutes';

	/// en: 'Abs'
	String get abs => 'Abs';

	/// en: 'Other'
	String get other => 'Other';
}

// Path: profile.editSheet
class Translations$profile$editSheet$en {
	Translations$profile$editSheet$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Edit profile'
	String get title => 'Edit profile';
}

// Path: profile.sections
class Translations$profile$sections$en {
	Translations$profile$sections$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Favorite muscle group'
	String get favoriteMuscleGroup => 'Favorite muscle group';

	/// en: 'Badges'
	String get badges => 'Badges';
}

// Path: profile.stats
class Translations$profile$stats$en {
	Translations$profile$stats$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Sessions'
	String get sessions => 'Sessions';

	/// en: 'Tonnage'
	String get tonnage => 'Tonnage';

	/// en: 'Sets'
	String get sets => 'Sets';
}

// Path: profile.badges
class Translations$profile$badges$en {
	Translations$profile$badges$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Start your first workout to unlock badges!'
	String get empty => 'Start your first workout to unlock badges!';

	/// en: 'First workout'
	String get firstSession => 'First workout';

	/// en: '10 workouts'
	String get tenSessions => '10 workouts';

	/// en: '10 tonnes'
	String get tenTonnes => '10 tonnes';

	/// en: 'Planner'
	String get planner => 'Planner';
}

// Path: profile.avatar
class Translations$profile$avatar$en {
	Translations$profile$avatar$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Profile photo'
	String get sheetTitle => 'Profile photo';

	/// en: 'Take a photo'
	String get takePhoto => 'Take a photo';

	/// en: 'Photo gallery'
	String get gallery => 'Photo gallery';

	/// en: 'Remove photo'
	String get remove => 'Remove photo';

	/// en: 'Couldn't open the photo.'
	String get openError => 'Couldn\'t open the photo.';

	/// en: 'Photo updated!'
	String get updated => 'Photo updated!';

	/// en: 'Couldn't save the photo.'
	String get saveError => 'Couldn\'t save the photo.';

	/// en: 'Photo removed.'
	String get removed => 'Photo removed.';

	/// en: 'Couldn't remove the photo.'
	String get removeError => 'Couldn\'t remove the photo.';
}

// Path: profile.editForm
class Translations$profile$editForm$en {
	Translations$profile$editForm$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Profile updated.'
	String get saved => 'Profile updated.';

	/// en: 'Pick a date'
	String get pickDate => 'Pick a date';

	late final Translations$profile$editForm$sections$en sections = Translations$profile$editForm$sections$en.internal(_root);
	late final Translations$profile$editForm$fields$en fields = Translations$profile$editForm$fields$en.internal(_root);
	late final Translations$profile$editForm$validation$en validation = Translations$profile$editForm$validation$en.internal(_root);
}

// Path: session.error
class Translations$session$error$en {
	Translations$session$error$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Couldn't start the session.'
	String get startFailed => 'Couldn\'t start the session.';

	/// en: 'Save failed.'
	String get saveFailed => 'Save failed.';
}

// Path: session.live
class Translations$session$live$en {
	Translations$session$live$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Exercise {{current}} / {{total}}'
	String exercisePosition({required Object current, required Object total}) => 'Exercise ${current} / ${total}';

	/// en: 'Superset {{current}} / {{total}}'
	String supersetPosition({required Object current, required Object total}) => 'Superset ${current} / ${total}';

	/// en: '{{completed}}/{{total}} sets · {{time}}'
	String headerSubtitle({required Object completed, required Object total, required Object time}) => '${completed}/${total} sets · ${time}';

	/// en: 'Total tonnage'
	String get totalTonnage => 'Total tonnage';

	/// en: 'Next exercise'
	String get nextExercise => 'Next exercise';

	/// en: 'Next block'
	String get nextBlock => 'Next block';

	/// en: 'Finish session'
	String get finishSession => 'Finish session';
}

// Path: session.confirm
class Translations$session$confirm$en {
	Translations$session$confirm$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Discard session?'
	String get quitTitle => 'Discard session?';

	/// en: 'All progress will be lost.'
	String get quitMessage => 'All progress will be lost.';

	/// en: 'Discard'
	String get quitConfirm => 'Discard';

	/// en: 'A session is already in progress'
	String get inProgressTitle => 'A session is already in progress';

	/// en: '“{{name}}” was started {{date}}. Starting a new one will permanently delete its progress.'
	String inProgressMessage({required Object name, required Object date}) => '“${name}” was started ${date}. Starting a new one will permanently delete its progress.';

	/// en: 'Overwrite and start'
	String get overwriteAndStart => 'Overwrite and start';

	/// en: 'Delete “{{name}}”?'
	String deleteExerciseTitle({required Object name}) => 'Delete “${name}”?';

	/// en: '(one) {This exercise already has {{n}} completed set. It will be lost.} (other) {This exercise already has {{n}} completed sets. They will be lost.}'
	String deleteExerciseMessage({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'This exercise already has ${n} completed set. It will be lost.',
		other: 'This exercise already has ${n} completed sets. They will be lost.',
	);
}

// Path: session.add
class Translations$session$add$en {
	Translations$session$add$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Add an exercise'
	String get title => 'Add an exercise';

	/// en: 'Added to this session only, without changing the template.'
	String get subtitle => 'Added to this session only, without changing the template.';

	/// en: 'Add'
	String get addLabel => 'Add';

	/// en: 'Add to session'
	String get addToSession => 'Add to session';

	/// en: 'Reps'
	String get reps => 'Reps';

	/// en: 'Time'
	String get time => 'Time';
}

// Path: session.swap
class Translations$session$swap$en {
	Translations$session$swap$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Edit exercise'
	String get title => 'Edit exercise';

	/// en: 'Currently: {{name}}'
	String currently({required Object name}) => 'Currently: ${name}';

	/// en: 'These changes apply to this session only.'
	String get sessionOnly => 'These changes apply to this session only.';

	/// en: 'Use'
	String get useLabel => 'Use';

	/// en: 'Adopt the format'
	String get adoptFormat => 'Adopt the format';

	/// en: '{{summary}} · from “{{name}}”'
	String adoptFormatSummary({required Object summary, required Object name}) => '${summary} · from “${name}”';

	/// en: 'Apply for this session'
	String get apply => 'Apply for this session';
}

// Path: session.variants
class Translations$session$variants$en {
	Translations$session$variants$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Choose a variant'
	String get title => 'Choose a variant';

	/// en: 'A set is already completed — finish the exercise or use “Swap” to adjust on the fly.'
	String get lockedMessage => 'A set is already completed — finish the exercise or use “Swap” to adjust on the fly.';

	/// en: 'Pick a variant for this slot. It will replace the current exercise.'
	String get pickMessage => 'Pick a variant for this slot. It will replace the current exercise.';

	/// en: 'No variant defined for this exercise.'
	String get empty => 'No variant defined for this exercise.';

	/// en: 'MAIN'
	String get main => 'MAIN';

	/// en: 'Variant {{n}}'
	String variantN({required Object n}) => 'Variant ${n}';

	/// en: '{{n}}s rest'
	String restSeconds({required Object n}) => '${n}s rest';

	/// en: ' · tempo {{tempo}}'
	String tempoPart({required Object tempo}) => ' · tempo ${tempo}';
}

// Path: session.finish
class Translations$session$finish$en {
	Translations$session$finish$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Finish session?'
	String get title => 'Finish session?';

	/// en: '{{completed}}/{{total}} sets · '
	String summaryReps({required Object completed, required Object total}) => '${completed}/${total} sets · ';

	/// en: ' of tonnage'
	String get summaryTonnageSuffix => ' of tonnage';

	/// en: 'Notes about the session (optional)…'
	String get notesHint => 'Notes about the session (optional)…';

	/// en: 'Finish'
	String get confirm => 'Finish';

	/// en: '(one) {{{n}} UNVALIDATED SET} (other) {{{n}} UNVALIDATED SETS}'
	String unvalidatedSets({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} UNVALIDATED SET',
		other: '${n} UNVALIDATED SETS',
	);

	/// en: 'You can go back and complete your sets, or finish anyway — only checked sets will be saved.'
	String get incompleteHint => 'You can go back and complete your sets, or finish anyway — only checked sets will be saved.';
}

// Path: session.timer
class Translations$session$timer$en {
	Translations$session$timer$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'GET READY'
	String get preparation => 'GET READY';

	/// en: 'IN PROGRESS'
	String get running => 'IN PROGRESS';

	/// en: 'DONE'
	String get done => 'DONE';

	/// en: 'GO'
	String get go => 'GO';

	/// en: 'Stop'
	String get stop => 'Stop';
}

// Path: session.rest
class Translations$session$rest$en {
	Translations$session$rest$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'REST'
	String get title => 'REST';

	/// en: 'SEC'
	String get sec => 'SEC';

	/// en: 'Skip'
	String get skip => 'Skip';

	/// en: 'Minimize'
	String get minimize => 'Minimize';
}

// Path: session.set
class Translations$session$set$en {
	Translations$session$set$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Add a set'
	String get addSet => 'Add a set';

	/// en: 'Set {{n}}'
	String setLabel({required Object n}) => 'Set ${n}';

	/// en: 'Reps'
	String get reps => 'Reps';

	/// en: 'Load'
	String get load => 'Load';

	/// en: 'Duration'
	String get duration => 'Duration';

	/// en: 'Held'
	String get held => 'Held';

	/// en: 'TONNAGE'
	String get tonnage => 'TONNAGE';

	/// en: 'target {{n}} reps'
	String targetReps({required Object n}) => 'target ${n} reps';

	/// en: 'target {{value}}'
	String targetDuration({required Object value}) => 'target ${value}';

	/// en: 'Complete without timer'
	String get validateWithoutTimer => 'Complete without timer';

	/// en: 'Top'
	String get cmpUp => 'Top';
}

// Path: session.exercise
class Translations$session$exercise$en {
	Translations$session$exercise$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Timed'
	String get timed => 'Timed';

	/// en: 'Tempo {{tempo}}'
	String tempoChip({required Object tempo}) => 'Tempo ${tempo}';

	/// en: '{{n}}s rest'
	String restChip({required Object n}) => '${n}s rest';

	/// en: 'Modified · this session only'
	String get modified => 'Modified · this session only';

	/// en: 'Modified · this session only (was: {{name}})'
	String modifiedWas({required Object name}) => 'Modified · this session only (was: ${name})';

	/// en: '✓ Done'
	String get completedBadge => '✓ Done';

	/// en: 'Total held: {{value}}'
	String totalHeld({required Object value}) => 'Total held: ${value}';

	/// en: 'Exercise volume: {{value}} kg'
	String exerciseVolume({required Object value}) => 'Exercise volume: ${value} kg';

	/// en: 'Last time'
	String get lastTimeLabel => 'Last time';

	/// en: 'was aiming for {{n}} reps'
	String targetWasReps({required Object n}) => 'was aiming for ${n} reps';

	/// en: 'was aiming for {{n}}s'
	String targetWasSeconds({required Object n}) => 'was aiming for ${n}s';

	/// en: '+{{n}}'
	String morePerfs({required Object n}) => '+${n}';
}

// Path: session.overview
class Translations$session$overview$en {
	Translations$session$overview$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Exercises'
	String get title => 'Exercises';

	/// en: 'CURRENT'
	String get current => 'CURRENT';

	/// en: '{{completed}}/{{total}} sets completed'
	String setsValidated({required Object completed, required Object total}) => '${completed}/${total} sets completed';
}

// Path: session.superset
class Translations$session$superset$en {
	Translations$session$superset$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'SUPERSET · {{n}} EXERCISES'
	String badge({required Object n}) => 'SUPERSET · ${n} EXERCISES';

	/// en: 'Add a set to {{letter}} · {{name}}'
	String addSetTo({required Object letter, required Object name}) => 'Add a set to ${letter} · ${name}';
}

// Path: session.duration
class Translations$session$duration$en {
	Translations$session$duration$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Duration per set'
	String get title => 'Duration per set';

	/// en: '45 or 1m30'
	String get hint => '45 or 1m30';

	/// en: 'Confirm — {{value}}'
	String confirm({required Object value}) => 'Confirm — ${value}';
}

// Path: session.weight
class Translations$session$weight$en {
	Translations$session$weight$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Bodyweight'
	String get bodyweight => 'Bodyweight';

	/// en: 'Confirm — Bodyweight'
	String get confirmBodyweight => 'Confirm — Bodyweight';

	/// en: 'Confirm — {{value}} kg'
	String confirmKg({required Object value}) => 'Confirm — ${value} kg';
}

// Path: session.search
class Translations$session$search$en {
	Translations$session$search$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Search for an exercise…'
	String get hint => 'Search for an exercise…';

	/// en: 'Loading exercises…'
	String get loading => 'Loading exercises…';

	/// en: 'No exercise matches.'
	String get noMatch => 'No exercise matches.';

	/// en: 'Repster exercise'
	String get certifiedBadge => 'Repster exercise';
}

// Path: session.history
class Translations$session$history$en {
	Translations$session$history$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'History · {{name}}'
	String title({required Object name}) => 'History · ${name}';

	/// en: 'No history yet for this exercise.'
	String get empty => 'No history yet for this exercise.';

	/// en: 'Loading history…'
	String get loading => 'Loading history…';

	/// en: 'Set {{n}}'
	String setLabel({required Object n}) => 'Set ${n}';

	/// en: 'MMM d, yyyy'
	String get dateFormat => 'MMM d, yyyy';
}

// Path: session.fields
class Translations$session$fields$en {
	Translations$session$fields$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Exercise name'
	String get exerciseName => 'Exercise name';

	/// en: 'Type'
	String get type => 'Type';

	/// en: 'Sets'
	String get sets => 'Sets';

	/// en: 'Duration (sec)'
	String get durationSec => 'Duration (sec)';

	/// en: 'Target reps'
	String get targetReps => 'Target reps';

	/// en: 'Rest (sec)'
	String get restShort => 'Rest (sec)';

	/// en: 'Rest (sec)'
	String get rest => 'Rest (sec)';

	/// en: 'Tempo'
	String get tempo => 'Tempo';

	/// en: 'Notes (optional)'
	String get notesOptional => 'Notes (optional)';

	/// en: 'Technique tips…'
	String get notesHint => 'Technique tips…';
}

// Path: session.toast
class Translations$session$toast$en {
	Translations$session$toast$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '{{name}} added to the session'
	String exerciseAdded({required Object name}) => '${name} added to the session';

	/// en: 'Complete at least one set before finishing.'
	String get validateOneSet => 'Complete at least one set before finishing.';

	/// en: 'Session saved! 🎉'
	String get sessionSaved => 'Session saved! 🎉';

	/// en: 'Finish the current set or use “Swap”.'
	String get finishOrSwap => 'Finish the current set or use “Swap”.';
}

// Path: session.notif
class Translations$session$notif$en {
	Translations$session$notif$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Rest countdown'
	String get countdownChannel => 'Rest countdown';

	/// en: 'Rest finished'
	String get doneChannel => 'Rest finished';

	/// en: 'Rest's over'
	String get doneTitle => 'Rest\'s over';
}

// Path: settings.sections
class Translations$settings$sections$en {
	Translations$settings$sections$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Profile'
	String get profile => 'Profile';

	/// en: 'My data'
	String get data => 'My data';

	/// en: 'Preferences'
	String get preferences => 'Preferences';

	/// en: 'Account'
	String get account => 'Account';
}

// Path: settings.rows
class Translations$settings$rows$en {
	Translations$settings$rows$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'My templates'
	String get templates => 'My templates';

	/// en: 'Session history'
	String get history => 'Session history';

	/// en: 'Statistics'
	String get stats => 'Statistics';

	/// en: 'Notifications'
	String get notifications => 'Notifications';

	/// en: 'Privacy'
	String get privacy => 'Privacy';

	/// en: 'Contact & Feedback'
	String get contact => 'Contact & Feedback';

	/// en: 'Language'
	String get language => 'Language';

	/// en: 'Change my password'
	String get changePassword => 'Change my password';
}

// Path: settings.logout
class Translations$settings$logout$en {
	Translations$settings$logout$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Sign out'
	String get action => 'Sign out';

	/// en: 'Sign-out failed.'
	String get error => 'Sign-out failed.';
}

// Path: settings.language
class Translations$settings$language$en {
	Translations$settings$language$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Language'
	String get title => 'Language';

	/// en: 'Choose the app language'
	String get subtitle => 'Choose the app language';

	/// en: 'System default'
	String get system => 'System default';
}

// Path: stats.subtitle
class Translations$stats$subtitle$en {
	Translations$stats$subtitle$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'No sessions in this period'
	String get empty => 'No sessions in this period';
}

// Path: stats.empty
class Translations$stats$empty$en {
	Translations$stats$empty$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'No data yet'
	String get title => 'No data yet';

	/// en: 'Complete a few sessions to see your curves and progress.'
	String get message => 'Complete a few sessions to see your curves and progress.';
}

// Path: stats.range
class Translations$stats$range$en {
	Translations$stats$range$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$stats$range$last4Weeks$en last4Weeks = Translations$stats$range$last4Weeks$en.internal(_root);
	late final Translations$stats$range$last3Months$en last3Months = Translations$stats$range$last3Months$en.internal(_root);
	late final Translations$stats$range$all$en all = Translations$stats$range$all$en.internal(_root);
}

// Path: stats.kpi
class Translations$stats$kpi$en {
	Translations$stats$kpi$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Sessions'
	String get sessions => 'Sessions';

	/// en: 'Volume'
	String get volume => 'Volume';

	/// en: 'Sets'
	String get sets => 'Sets';

	/// en: 'Avg. duration'
	String get avgDuration => 'Avg. duration';
}

// Path: stats.consistency
class Translations$stats$consistency$en {
	Translations$stats$consistency$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Consistency'
	String get title => 'Consistency';

	/// en: 'active days'
	String get trainingDays => 'active days';

	/// en: 'sessions / wk'
	String get perWeek => 'sessions / wk';

	/// en: 'best streak'
	String get bestStreak => 'best streak';

	/// en: 'no streak'
	String get noStreak => 'no streak';

	/// en: 'less'
	String get less => 'less';

	/// en: 'more'
	String get more => 'more';
}

// Path: stats.weeklyVolume
class Translations$stats$weeklyVolume$en {
	Translations$stats$weeklyVolume$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Weekly volume'
	String get title => 'Weekly volume';

	/// en: 'Not enough sessions in this period yet.'
	String get empty => 'Not enough sessions in this period yet.';
}

// Path: stats.exercise
class Translations$stats$exercise$en {
	Translations$stats$exercise$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Progress by exercise'
	String get title => 'Progress by exercise';

	/// en: 'Log at least 2 sessions with the same loaded exercise to see your strength curve.'
	String get empty => 'Log at least 2 sessions with the same loaded exercise to see your strength curve.';

	/// en: 'Choose an exercise'
	String get pickerTitle => 'Choose an exercise';

	/// en: 'No exercise'
	String get noExercise => 'No exercise';

	/// en: 'Search…'
	String get searchHint => 'Search…';

	/// en: 'max estimated 1RM'
	String get oneRmMax => 'max estimated 1RM';

	/// en: 'best load'
	String get bestLoad => 'best load';

	/// en: 'record'
	String get record => 'record';
}

// Path: stats.muscleBalance
class Translations$stats$muscleBalance$en {
	Translations$stats$muscleBalance$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Muscle balance'
	String get title => 'Muscle balance';

	/// en: '— not trained for {{days}} d {{emoji}}'
	String neglected({required Object days, required Object emoji}) => '— not trained for ${days} d ${emoji}';

	late final Translations$stats$muscleBalance$since$en since = Translations$stats$muscleBalance$since$en.internal(_root);
}

// Path: stats.records
class Translations$stats$records$en {
	Translations$stats$records$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Records'
	String get title => 'Records';

	/// en: 'Best session'
	String get bestSession => 'Best session';

	/// en: 'Heaviest lift'
	String get heaviestLift => 'Heaviest lift';

	/// en: 'Estimated 1RM'
	String get bestOneRm => 'Estimated 1RM';

	/// en: 'Longest streak'
	String get bestStreak => 'Longest streak';

	/// en: 'consecutive weeks'
	String get consecutiveWeeks => 'consecutive weeks';
}

// Path: templates.list
class Translations$templates$list$en {
	Translations$templates$list$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Program'
	String get title => 'Program';

	/// en: '(one) {{{n}} active session} (other) {{{n}} active sessions}'
	String subtitleActive({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} active session',
		other: '${n} active sessions',
	);

	/// en: '(one) {{{n}} / {{total}} active} (other) {{{n}} / {{total}} active}'
	String subtitleManage({required num n, required Object total}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} / ${total} active',
		other: '${n} / ${total} active',
	);

	/// en: 'Manage'
	String get manage => 'Manage';

	/// en: 'New'
	String get newAction => 'New';

	/// en: 'No sessions'
	String get emptyTitle => 'No sessions';

	/// en: 'Create your first session to build your program.'
	String get emptyMessage => 'Create your first session to build your program.';

	/// en: 'Create a session'
	String get emptyAction => 'Create a session';

	/// en: 'No sessions in the program'
	String get emptyActiveTitle => 'No sessions in the program';

	/// en: 'Activate sessions to add them to your program.'
	String get emptyActiveMessage => 'Activate sessions to add them to your program.';

	/// en: 'Manage sessions'
	String get emptyActiveAction => 'Manage sessions';

	/// en: 'No results'
	String get noResult => 'No results';

	/// en: 'Search a session…'
	String get searchHint => 'Search a session…';

	/// en: 'Drag to reorder · tap the circle to hide/show a session'
	String get manageHint => 'Drag to reorder · tap the circle to hide/show a session';

	/// en: 'Changes saved ✓'
	String get savedChanges => 'Changes saved ✓';

	/// en: 'Reordering failed.'
	String get reorderError => 'Reordering failed.';

	/// en: 'Action failed.'
	String get toggleError => 'Action failed.';

	/// en: 'Session copied!'
	String get duplicated => 'Session copied!';

	/// en: 'Duplication failed.'
	String get duplicateError => 'Duplication failed.';

	/// en: 'Session deleted.'
	String get deleted => 'Session deleted.';

	/// en: 'Deletion failed.'
	String get deleteError => 'Deletion failed.';

	/// en: '(copy)'
	String get copySuffix => '(copy)';
}

// Path: templates.card
class Translations$templates$card$en {
	Translations$templates$card$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '(one) {{{n}} exercise} (other) {{{n}} exercises}'
	String exerciseCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} exercise',
		other: '${n} exercises',
	);

	/// en: 'Details'
	String get details => 'Details';

	/// en: 'Copy'
	String get copy => 'Copy';

	/// en: 'Delete'
	String get deleteShort => 'Delete';

	/// en: 'Activate'
	String get activate => 'Activate';

	/// en: 'Deactivate'
	String get deactivate => 'Deactivate';
}

// Path: templates.detail
class Translations$templates$detail$en {
	Translations$templates$detail$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Template'
	String get title => 'Template';

	/// en: 'No exercises in this template.'
	String get noExercises => 'No exercises in this template.';

	/// en: 'Superset'
	String get superset => 'Superset';

	/// en: '(one) {{{n}} set} (other) {{{n}} sets}'
	String setsCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} set',
		other: '${n} sets',
	);

	/// en: '{{n}} s'
	String seconds({required Object n}) => '${n} s';

	/// en: 'Tempo {{value}}'
	String tempo({required Object value}) => 'Tempo ${value}';

	/// en: 'Rest {{n}}s'
	String rest({required Object n}) => 'Rest ${n}s';

	/// en: '(one) {+{{n}} variant} (other) {+{{n}} variants}'
	String variantsMore({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '+${n} variant',
		other: '+${n} variants',
	);

	/// en: 'Start session'
	String get start => 'Start session';
}

// Path: templates.editor
class Translations$templates$editor$en {
	Translations$templates$editor$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'New session'
	String get newTitle => 'New session';

	/// en: 'Edit session'
	String get editTitle => 'Edit session';

	/// en: 'EXERCISES ({{count}})'
	String exercisesHeader({required Object count}) => 'EXERCISES (${count})';

	/// en: 'Add an exercise'
	String get addExercise => 'Add an exercise';

	/// en: 'Save session'
	String get save => 'Save session';

	/// en: 'Enter a name and at least one named exercise.'
	String get validationError => 'Enter a name and at least one named exercise.';
}

// Path: templates.fields
class Translations$templates$fields$en {
	Translations$templates$fields$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Session name'
	String get name => 'Session name';

	/// en: 'e.g. Chest / Triceps / Shoulders'
	String get nameHint => 'e.g. Chest / Triceps / Shoulders';

	/// en: 'Description (optional)'
	String get description => 'Description (optional)';

	/// en: 'Describe your session…'
	String get descriptionHint => 'Describe your session…';

	/// en: 'Muscle groups'
	String get muscleGroups => 'Muscle groups';

	/// en: '(one) {{{n}} selected} (other) {{{n}} selected}'
	String selectedCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} selected',
		other: '${n} selected',
	);

	/// en: 'Exercise name'
	String get exerciseName => 'Exercise name';

	/// en: 'e.g. Bench press'
	String get exerciseNameHint => 'e.g. Bench press';

	/// en: 'Type'
	String get type => 'Type';

	/// en: 'Sets'
	String get sets => 'Sets';

	/// en: 'Duration (s)'
	String get duration => 'Duration (s)';

	/// en: 'Target reps'
	String get targetReps => 'Target reps';

	/// en: 'Rest (s)'
	String get rest => 'Rest (s)';

	/// en: 'Tempo'
	String get tempo => 'Tempo';

	/// en: '3-1-X-0'
	String get tempoHint => '3-1-X-0';

	/// en: 'Notes (optional)'
	String get notes => 'Notes (optional)';

	/// en: 'Technical tips…'
	String get notesHint => 'Technical tips…';
}

// Path: templates.slot
class Translations$templates$slot$en {
	Translations$templates$slot$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'New exercise'
	String get newExercise => 'New exercise';

	/// en: 'Variant {{n}}'
	String variantN({required Object n}) => 'Variant ${n}';

	/// en: 'PRIMARY'
	String get primary => 'PRIMARY';

	/// en: 'Variant'
	String get variant => 'Variant';

	/// en: 'Add a variant'
	String get addVariant => 'Add a variant';

	/// en: 'Chained in a superset with the next exercise'
	String get supersetNote => 'Chained in a superset with the next exercise';

	/// en: 'SUPERSET'
	String get supersetLabel => 'SUPERSET';

	/// en: 'Reps'
	String get reps => 'Reps';

	/// en: 'Time'
	String get time => 'Time';
}

// Path: auth.onboarding.goalDescriptions
class Translations$auth$onboarding$goalDescriptions$en {
	Translations$auth$onboarding$goalDescriptions$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Build muscle'
	String get hypertrophy => 'Build muscle';

	/// en: 'Lift heavier'
	String get strength => 'Lift heavier';

	/// en: 'Cardio & resistance'
	String get endurance => 'Cardio & resistance';

	/// en: 'Burn calories'
	String get weightLoss => 'Burn calories';

	/// en: 'Stay in shape'
	String get maintenance => 'Stay in shape';
}

// Path: contact.categories.bug
class Translations$contact$categories$bug$en {
	Translations$contact$categories$bug$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Bug'
	String get label => 'Bug';

	/// en: 'E.g. after my set, the rest timer doesn't start…'
	String get placeholder => 'E.g. after my set, the rest timer doesn\'t start…';

	/// en: 'Give the steps to reproduce, what you expected, and your phone model — it helps us fix it fast.'
	String get guidance => 'Give the steps to reproduce, what you expected, and your phone model — it helps us fix it fast.';

	/// en: 'Got it — we're heading over to take a close look at this bug.'
	String get successLine => 'Got it — we\'re heading over to take a close look at this bug.';
}

// Path: contact.categories.feature
class Translations$contact$categories$feature$en {
	Translations$contact$categories$feature$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Idea'
	String get label => 'Idea';

	/// en: 'E.g. being able to duplicate an existing template…'
	String get placeholder => 'E.g. being able to duplicate an existing template…';

	/// en: 'Above all, describe the need behind the idea: what would it let you do?'
	String get guidance => 'Above all, describe the need behind the idea: what would it let you do?';

	/// en: 'Great idea, thanks! We're adding it to our thinking.'
	String get successLine => 'Great idea, thanks! We\'re adding it to our thinking.';
}

// Path: contact.categories.general
class Translations$contact$categories$general$en {
	Translations$contact$categories$general$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Message'
	String get label => 'Message';

	/// en: 'Your question, your opinion or your feedback…'
	String get placeholder => 'Your question, your opinion or your feedback…';

	/// en: 'A question, a remark, some encouragement: we read every message.'
	String get guidance => 'A question, a remark, some encouragement: we read every message.';

	/// en: 'Thanks for your message. We take the time to read every piece of feedback.'
	String get successLine => 'Thanks for your message. We take the time to read every piece of feedback.';
}

// Path: contact.categories.other
class Translations$contact$categories$other$en {
	Translations$contact$categories$other$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Other'
	String get label => 'Other';

	/// en: 'Tell us everything…'
	String get placeholder => 'Tell us everything…';

	/// en: 'Give us as much context as possible so we can help you as best we can.'
	String get guidance => 'Give us as much context as possible so we can help you as best we can.';

	/// en: 'Thanks for your message. We'll get back to you if needed.'
	String get successLine => 'Thanks for your message. We\'ll get back to you if needed.';
}

// Path: history.detail.edit
class Translations$history$detail$edit$en {
	Translations$history$detail$edit$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Edit'
	String get open => 'Edit';

	/// en: 'Edit session'
	String get title => 'Edit session';

	/// en: 'Title'
	String get name => 'Title';

	/// en: 'Session name'
	String get namePlaceholder => 'Session name';

	/// en: 'Date'
	String get date => 'Date';

	/// en: 'Time'
	String get time => 'Time';

	/// en: 'Duration'
	String get durationLabel => 'Duration';

	/// en: 'h'
	String get hours => 'h';

	/// en: 'min'
	String get minutes => 'min';

	/// en: 'How did it go?'
	String get notesPlaceholder => 'How did it go?';

	/// en: 'Save'
	String get save => 'Save';

	/// en: 'Session updated.'
	String get saved => 'Session updated.';

	/// en: 'Update failed.'
	String get error => 'Update failed.';

	/// en: 'A title is required.'
	String get nameRequired => 'A title is required.';

	/// en: 'MMMM d, y'
	String get dateFormat => 'MMMM d, y';
}

// Path: profile.editForm.sections
class Translations$profile$editForm$sections$en {
	Translations$profile$editForm$sections$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Identity'
	String get identity => 'Identity';

	/// en: 'Physique'
	String get physique => 'Physique';

	/// en: 'Goal'
	String get goal => 'Goal';
}

// Path: profile.editForm.fields
class Translations$profile$editForm$fields$en {
	Translations$profile$editForm$fields$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Name / Nickname'
	String get name => 'Name / Nickname';

	/// en: 'Bio'
	String get bio => 'Bio';

	/// en: 'Date of birth'
	String get birthdate => 'Date of birth';

	/// en: 'Weight (kg)'
	String get weight => 'Weight (kg)';

	/// en: 'Height (cm)'
	String get height => 'Height (cm)';
}

// Path: profile.editForm.validation
class Translations$profile$editForm$validation$en {
	Translations$profile$editForm$validation$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'At least 2 characters'
	String get nameMin => 'At least 2 characters';

	/// en: '60 characters max'
	String get nameMax => '60 characters max';

	/// en: 'Invalid number'
	String get invalidNumber => 'Invalid number';

	/// en: 'Between 80 and 260 cm'
	String get heightRange => 'Between 80 and 260 cm';

	/// en: 'Between 30 and 350 kg'
	String get weightRange => 'Between 30 and 350 kg';
}

// Path: stats.range.last4Weeks
class Translations$stats$range$last4Weeks$en {
	Translations$stats$range$last4Weeks$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '4 weeks'
	String get label => '4 weeks';

	/// en: '4 wk'
	String get short => '4 wk';
}

// Path: stats.range.last3Months
class Translations$stats$range$last3Months$en {
	Translations$stats$range$last3Months$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '3 months'
	String get label => '3 months';

	/// en: '3 mo'
	String get short => '3 mo';
}

// Path: stats.range.all
class Translations$stats$range$all$en {
	Translations$stats$range$all$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'All'
	String get label => 'All';

	/// en: 'All'
	String get short => 'All';
}

// Path: stats.muscleBalance.since
class Translations$stats$muscleBalance$since$en {
	Translations$stats$muscleBalance$since$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '–'
	String get none => '–';

	/// en: 'today'
	String get today => 'today';

	/// en: 'yesterday'
	String get yesterday => 'yesterday';

	/// en: '{{n}}d'
	String daysShort({required Object n}) => '${n}d';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'auth.fields.email' => 'Email address',
			'auth.fields.password' => 'Password',
			'auth.backToLogin' => 'Back to sign in',
			'auth.login.welcomeTitle' => 'Good to see you again',
			'auth.login.welcomeSubtitle' => 'Sign in to continue.',
			'auth.login.forgotPassword' => 'Forgot password?',
			'auth.login.submit' => 'Sign in',
			'auth.login.submitLoading' => 'Signing in…',
			'auth.login.noAccount' => 'No account yet?',
			'auth.login.createAccount' => 'Create an account',
			'auth.signup.title' => 'Create an account',
			'auth.signup.subtitle' => 'Join thousands of athletes.',
			'auth.signup.passwordHint' => 'Password (8 char. min.)',
			'auth.signup.submit' => 'Create my account',
			'auth.signup.submitLoading' => 'Creating…',
			'auth.signup.terms' => 'By creating an account, you accept our terms of use.',
			'auth.onboarding.step1Title' => 'What\'s your\nname?',
			'auth.onboarding.step1Subtitle' => 'To personalize your experience.',
			'auth.onboarding.nameHint' => 'Your first name',
			'auth.onboarding.continueLabel' => 'Continue',
			'auth.onboarding.step2Title' => 'What\'s your\ngoal?',
			'auth.onboarding.step2Subtitle' => 'We\'ll adapt your sessions accordingly.',
			'auth.onboarding.step3Title' => 'A few details',
			'auth.onboarding.optional' => 'Optional',
			'auth.onboarding.step3Subtitle' => 'For more accurate recommendations.',
			'auth.onboarding.weightHint' => 'Weight (kg)',
			'auth.onboarding.heightHint' => 'Height (cm)',
			'auth.onboarding.birthdate' => 'Date of birth',
			'auth.onboarding.submit' => 'Let\'s go!',
			'auth.onboarding.submitLoading' => 'Saving…',
			'auth.onboarding.skip' => 'Skip this step',
			'auth.onboarding.goalDescriptions.hypertrophy' => 'Build muscle',
			'auth.onboarding.goalDescriptions.strength' => 'Lift heavier',
			'auth.onboarding.goalDescriptions.endurance' => 'Cardio & resistance',
			'auth.onboarding.goalDescriptions.weightLoss' => 'Burn calories',
			'auth.onboarding.goalDescriptions.maintenance' => 'Stay in shape',
			'auth.onboarding.nameRequired' => 'Your first name is required.',
			'auth.onboarding.nameTooLong' => 'First name too long.',
			'auth.onboarding.goalRequired' => 'Choose a goal.',
			'auth.onboarding.weightInvalid' => 'Invalid weight',
			'auth.onboarding.heightInvalid' => 'Invalid height',
			'auth.verifyEmail.title' => 'Verify your email',
			'auth.verifyEmail.subtitle' => 'We sent a 6-digit code',
			'auth.verifyEmail.submitLoading' => 'Verifying…',
			'auth.verifyEmail.submitComplete' => 'Verify the code',
			'auth.verifyEmail.submitIncomplete' => 'Enter the code you received',
			'auth.verifyEmail.noCode' => 'Didn\'t receive the code?',
			'auth.verifyEmail.resent' => 'Code resent!',
			'auth.verifyEmail.resendCooldown' => ({required Object n}) => 'Resend in ${n}s',
			'auth.verifyEmail.resending' => 'Sending…',
			'auth.verifyEmail.resend' => 'Resend the code',
			'auth.verifyEmail.emailMissing' => 'Missing email. Go back to sign up.',
			'auth.forgotPassword.title' => 'Forgot password',
			'auth.forgotPassword.subtitle' => 'We\'ll send you a reset link',
			'auth.forgotPassword.submit' => 'Send the link',
			'auth.forgotPassword.submitLoading' => 'Sending…',
			'auth.forgotPassword.successMessage' => 'A reset link has been sent to your email address. Check your inbox.',
			'auth.updatePassword.title' => 'New password',
			'auth.updatePassword.subtitle' => 'Choose a secure password',
			'auth.updatePassword.newHint' => 'New password',
			'auth.updatePassword.confirmHint' => 'Confirm the password',
			'auth.updatePassword.submit' => 'Save the password',
			'auth.updatePassword.submitLoading' => 'Saving…',
			'auth.changePassword.title' => 'Change password',
			'auth.changePassword.subtitle' => 'For your security, confirm your current password before choosing a new one.',
			'auth.changePassword.currentHint' => 'Current password',
			'auth.changePassword.newHint' => 'New password',
			'auth.changePassword.confirmHint' => 'Confirm the new password',
			'auth.changePassword.submit' => 'Update the password',
			'auth.changePassword.submitLoading' => 'Updating…',
			'auth.changePassword.successToast' => 'Password updated',
			'auth.changePassword.currentRequired' => 'Current password required',
			'auth.changePassword.mustDiffer' => 'The new password must differ from the current one',
			'auth.changePassword.currentIncorrect' => 'Current password incorrect',
			'auth.validators.emailRequired' => 'Email required',
			'auth.validators.emailInvalid' => 'Invalid email',
			'auth.validators.passwordRequired' => 'Password required',
			'auth.validators.passwordMin' => 'Minimum 8 characters',
			'auth.validators.passwordMismatch' => 'Passwords do not match',
			'common.appName' => 'Repster',
			'common.actions.cancel' => 'Cancel',
			'common.actions.confirm' => 'Confirm',
			'common.actions.save' => 'Save',
			'common.actions.retry' => 'Retry',
			'common.actions.delete' => 'Delete',
			'common.actions.close' => 'Close',
			'common.actions.edit' => 'Edit',
			'common.actions.done' => 'Done',
			'common.actions.next' => 'Next',
			'common.actions.back' => 'Back',
			'common.all' => 'All',
			'common.unnamed' => '(unnamed)',
			'common.units.reps' => 'reps',
			'common.date.justNow' => 'just now',
			'common.date.minutesAgo' => ({required Object n}) => '${n} min ago',
			'common.date.hoursAgo' => ({required Object n}) => '${n} h ago',
			'common.date.yesterday' => 'yesterday',
			'common.date.daysAgo' => ({required Object n}) => '${n} d ago',
			'common.date.today' => 'today',
			'common.date.weeksAgo' => ({required Object n}) => '${n} w ago',
			'common.date.monthsAgo' => ({required Object n}) => '${n} mo ago',
			'common.language.en' => 'English',
			'common.language.fr' => 'French',
			'common.language.es' => 'Spanish',
			'common.language.de' => 'German',
			'common.language.it' => 'Italian',
			'contact.header.title' => 'Contact & feedback',
			'contact.header.subtitle' => 'A bug, an idea, a question? Write to us, we read everything.',
			'contact.sections.type' => 'Request type',
			'contact.sections.yourInfo' => 'Your info',
			'contact.sections.message' => 'Message',
			'contact.fields.nameHint' => 'Your first name',
			'contact.fields.nameRequired' => 'Name required',
			'contact.fields.emailHint' => 'Your email address',
			'contact.fields.emailInvalid' => 'Invalid email',
			'contact.fields.messageTooShort' => 'Message too short (10 characters min)',
			'contact.counter' => ({required Object current, required Object max}) => '${current} / ${max}',
			'contact.submit' => 'Send',
			'contact.categories.bug.label' => 'Bug',
			'contact.categories.bug.placeholder' => 'E.g. after my set, the rest timer doesn\'t start…',
			'contact.categories.bug.guidance' => 'Give the steps to reproduce, what you expected, and your phone model — it helps us fix it fast.',
			'contact.categories.bug.successLine' => 'Got it — we\'re heading over to take a close look at this bug.',
			'contact.categories.feature.label' => 'Idea',
			'contact.categories.feature.placeholder' => 'E.g. being able to duplicate an existing template…',
			'contact.categories.feature.guidance' => 'Above all, describe the need behind the idea: what would it let you do?',
			'contact.categories.feature.successLine' => 'Great idea, thanks! We\'re adding it to our thinking.',
			'contact.categories.general.label' => 'Message',
			'contact.categories.general.placeholder' => 'Your question, your opinion or your feedback…',
			'contact.categories.general.guidance' => 'A question, a remark, some encouragement: we read every message.',
			'contact.categories.general.successLine' => 'Thanks for your message. We take the time to read every piece of feedback.',
			'contact.categories.other.label' => 'Other',
			'contact.categories.other.placeholder' => 'Tell us everything…',
			'contact.categories.other.guidance' => 'Give us as much context as possible so we can help you as best we can.',
			'contact.categories.other.successLine' => 'Thanks for your message. We\'ll get back to you if needed.',
			'contact.success.title' => 'Message sent',
			'contact.success.back' => 'Back to settings',
			'dashboard.greeting.morning' => 'Good morning',
			'dashboard.greeting.afternoon' => 'Good afternoon',
			'dashboard.greeting.evening' => 'Good evening',
			'dashboard.defaultName' => 'Athlete',
			'dashboard.seeAll' => 'See all',
			'dashboard.sections.templates' => 'Templates',
			'dashboard.sections.recentSessions' => 'Latest sessions',
			'dashboard.templates.empty' => 'No templates yet',
			'dashboard.templates.newLabel' => 'New',
			'dashboard.exerciseCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} exercise', other: '${n} exercises', ), 
			'dashboard.hero.eyebrow' => 'READY TO TRAIN?',
			'dashboard.hero.start' => 'Start session',
			'dashboard.hero.emptyTitle' => 'Create your first template',
			'dashboard.hero.emptyMessage' => 'Set up your exercises and off you go.',
			'dashboard.hero.create' => 'Create a template',
			'dashboard.recent.emptyTitle' => 'Start your first session!',
			'dashboard.recent.emptyMessage' => 'Pick a template and off you go.',
			'dashboard.recent.tonnage' => 'tonnage',
			'dashboard.inProgress.label' => 'SESSION IN PROGRESS',
			'dashboard.inProgress.startedAt' => ({required Object when}) => 'Started ${when}',
			'dashboard.inProgress.resume' => 'Resume',
			'dashboard.inProgress.discard' => 'Discard',
			'dashboard.inProgress.discardTitle' => 'Discard session?',
			'dashboard.inProgress.discardMessage' => 'All current entries will be lost.',
			'dashboard.inProgress.discardError' => 'Failed — try again.',
			'dashboard.stats.sessions' => 'Sessions',
			'dashboard.stats.volume' => 'Volume',
			'dashboard.stats.streak' => 'Streak',
			'dashboard.stats.thisWeek' => 'this wk',
			'dashboard.stats.weekCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: 'week', other: 'weeks', ), 
			'dashboard.streakBadge' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} week streak', other: '${n} weeks streak', ), 
			'errors.network' => 'No network connection. Check your connection.',
			'errors.notFound' => 'Item not found.',
			'errors.generic' => 'Something went wrong. Try again.',
			'errors.invalidCode' => 'Invalid or expired code.',
			'errors.passwordSameAsOld' => 'The new password must be different from the old one.',
			'errors.auth.invalidCredentials' => 'Incorrect email or password.',
			'errors.auth.emailNotConfirmed' => 'Confirm your email before signing in.',
			'errors.auth.userAlreadyExists' => 'An account already exists with this email.',
			'errors.auth.sessionExpired' => 'Session expired. Please sign in again.',
			'errors.auth.notSignedIn' => 'You must be signed in.',
			'goals.strength' => 'Strength',
			'goals.hypertrophy' => 'Hypertrophy',
			'goals.endurance' => 'Endurance',
			'goals.weightLoss' => 'Weight loss',
			'goals.maintenance' => 'Maintenance',
			'history.title' => 'History',
			'history.emptySubtitle' => 'No sessions',
			'history.emptyTitle' => 'No sessions yet',
			'history.emptyMessage' => 'Start your first session from the home screen — it will show up here.',
			'history.sessionCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} session', other: '${n} sessions', ), 
			'history.deleteError' => 'Delete failed.',
			'history.noResult' => 'No sessions for this group',
			'history.groups.thisWeek' => 'This week',
			'history.groups.lastWeek' => 'Last week',
			'history.groups.weeksAgo' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} week ago', other: '${n} weeks ago', ), 
			'history.panel.sessions' => 'Sessions',
			'history.panel.volume' => 'Volume',
			'history.panel.time' => 'Time',
			'history.detail.title' => 'Session',
			'history.detail.dateFormat' => 'EEEE, MMMM d \'at\' HH:mm',
			'history.detail.duration' => 'Duration',
			'history.detail.tonnage' => 'Tonnage',
			'history.detail.sets' => 'Sets',
			'history.detail.notes' => 'Notes',
			'history.detail.perExercise' => 'Per-exercise breakdown',
			'history.detail.setsCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} set', other: '${n} sets', ), 
			'history.detail.bodyweight' => 'Bodyweight',
			'history.detail.colSet' => 'Set',
			'history.detail.colReps' => 'Reps',
			'history.detail.colLoad' => 'Load',
			'history.detail.colHeld' => 'Held',
			'history.detail.totalExercise' => 'Exercise total',
			'history.detail.totalHeld' => 'Total held',
			'history.detail.edit.open' => 'Edit',
			'history.detail.edit.title' => 'Edit session',
			'history.detail.edit.name' => 'Title',
			'history.detail.edit.namePlaceholder' => 'Session name',
			'history.detail.edit.date' => 'Date',
			'history.detail.edit.time' => 'Time',
			'history.detail.edit.durationLabel' => 'Duration',
			'history.detail.edit.hours' => 'h',
			'history.detail.edit.minutes' => 'min',
			'history.detail.edit.notesPlaceholder' => 'How did it go?',
			'history.detail.edit.save' => 'Save',
			'history.detail.edit.saved' => 'Session updated.',
			'history.detail.edit.error' => 'Update failed.',
			'history.detail.edit.nameRequired' => 'A title is required.',
			'history.detail.edit.dateFormat' => 'MMMM d, y',
			'legal.onlyInEnglish' => 'This document is available in English only.',
			'muscleGroups.chest' => 'Chest',
			'muscleGroups.back' => 'Back',
			'muscleGroups.shoulders' => 'Shoulders',
			'muscleGroups.biceps' => 'Biceps',
			'muscleGroups.triceps' => 'Triceps',
			'muscleGroups.forearms' => 'Forearms',
			'muscleGroups.quads' => 'Quads',
			'muscleGroups.hamstrings' => 'Hamstrings',
			'muscleGroups.glutes' => 'Glutes',
			'muscleGroups.calves' => 'Calves',
			'muscleGroups.abs' => 'Abs',
			'muscleGroups.custom' => 'Other',
			'muscleGroups.sections.chestBack' => 'Chest & Back',
			'muscleGroups.sections.shouldersArms' => 'Shoulders & Arms',
			'muscleGroups.sections.legsGlutes' => 'Legs & Glutes',
			'muscleGroups.sections.abs' => 'Abs',
			'muscleGroups.sections.other' => 'Other',
			'nav.home' => 'Home',
			'nav.program' => 'Program',
			'nav.history' => 'History',
			'nav.stats' => 'Stats',
			'nav.settings' => 'Settings',
			'profile.notConnected' => 'Not signed in.',
			'profile.navTitle' => 'PROFILE',
			'profile.defaultName' => 'Athlete',
			'profile.since' => ({required Object month}) => 'Since ${month}',
			'profile.editSheet.title' => 'Edit profile',
			'profile.sections.favoriteMuscleGroup' => 'Favorite muscle group',
			'profile.sections.badges' => 'Badges',
			'profile.stats.sessions' => 'Sessions',
			'profile.stats.tonnage' => 'Tonnage',
			'profile.stats.sets' => 'Sets',
			'profile.sessionCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} session', other: '${n} sessions', ), 
			'profile.badges.empty' => 'Start your first workout to unlock badges!',
			'profile.badges.firstSession' => 'First workout',
			'profile.badges.tenSessions' => '10 workouts',
			'profile.badges.tenTonnes' => '10 tonnes',
			'profile.badges.planner' => 'Planner',
			'profile.avatar.sheetTitle' => 'Profile photo',
			'profile.avatar.takePhoto' => 'Take a photo',
			'profile.avatar.gallery' => 'Photo gallery',
			'profile.avatar.remove' => 'Remove photo',
			'profile.avatar.openError' => 'Couldn\'t open the photo.',
			'profile.avatar.updated' => 'Photo updated!',
			'profile.avatar.saveError' => 'Couldn\'t save the photo.',
			'profile.avatar.removed' => 'Photo removed.',
			'profile.avatar.removeError' => 'Couldn\'t remove the photo.',
			'profile.editForm.saved' => 'Profile updated.',
			'profile.editForm.pickDate' => 'Pick a date',
			'profile.editForm.sections.identity' => 'Identity',
			'profile.editForm.sections.physique' => 'Physique',
			'profile.editForm.sections.goal' => 'Goal',
			'profile.editForm.fields.name' => 'Name / Nickname',
			'profile.editForm.fields.bio' => 'Bio',
			'profile.editForm.fields.birthdate' => 'Date of birth',
			'profile.editForm.fields.weight' => 'Weight (kg)',
			'profile.editForm.fields.height' => 'Height (cm)',
			'profile.editForm.validation.nameMin' => 'At least 2 characters',
			'profile.editForm.validation.nameMax' => '60 characters max',
			'profile.editForm.validation.invalidNumber' => 'Invalid number',
			'profile.editForm.validation.heightRange' => 'Between 80 and 260 cm',
			'profile.editForm.validation.weightRange' => 'Between 30 and 350 kg',
			'session.bw' => 'BW',
			'session.continueLabel' => 'Continue',
			'session.error.startFailed' => 'Couldn\'t start the session.',
			'session.error.saveFailed' => 'Save failed.',
			'session.live.exercisePosition' => ({required Object current, required Object total}) => 'Exercise ${current} / ${total}',
			'session.live.supersetPosition' => ({required Object current, required Object total}) => 'Superset ${current} / ${total}',
			'session.live.headerSubtitle' => ({required Object completed, required Object total, required Object time}) => '${completed}/${total} sets · ${time}',
			'session.live.totalTonnage' => 'Total tonnage',
			'session.live.nextExercise' => 'Next exercise',
			'session.live.nextBlock' => 'Next block',
			'session.live.finishSession' => 'Finish session',
			'session.confirm.quitTitle' => 'Discard session?',
			'session.confirm.quitMessage' => 'All progress will be lost.',
			'session.confirm.quitConfirm' => 'Discard',
			'session.confirm.inProgressTitle' => 'A session is already in progress',
			'session.confirm.inProgressMessage' => ({required Object name, required Object date}) => '“${name}” was started ${date}. Starting a new one will permanently delete its progress.',
			'session.confirm.overwriteAndStart' => 'Overwrite and start',
			'session.confirm.deleteExerciseTitle' => ({required Object name}) => 'Delete “${name}”?',
			'session.confirm.deleteExerciseMessage' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: 'This exercise already has ${n} completed set. It will be lost.', other: 'This exercise already has ${n} completed sets. They will be lost.', ), 
			'session.add.title' => 'Add an exercise',
			'session.add.subtitle' => 'Added to this session only, without changing the template.',
			'session.add.addLabel' => 'Add',
			'session.add.addToSession' => 'Add to session',
			'session.add.reps' => 'Reps',
			'session.add.time' => 'Time',
			'session.swap.title' => 'Edit exercise',
			'session.swap.currently' => ({required Object name}) => 'Currently: ${name}',
			'session.swap.sessionOnly' => 'These changes apply to this session only.',
			'session.swap.useLabel' => 'Use',
			'session.swap.adoptFormat' => 'Adopt the format',
			'session.swap.adoptFormatSummary' => ({required Object summary, required Object name}) => '${summary} · from “${name}”',
			'session.swap.apply' => 'Apply for this session',
			'session.variants.title' => 'Choose a variant',
			'session.variants.lockedMessage' => 'A set is already completed — finish the exercise or use “Swap” to adjust on the fly.',
			'session.variants.pickMessage' => 'Pick a variant for this slot. It will replace the current exercise.',
			'session.variants.empty' => 'No variant defined for this exercise.',
			'session.variants.main' => 'MAIN',
			'session.variants.variantN' => ({required Object n}) => 'Variant ${n}',
			'session.variants.restSeconds' => ({required Object n}) => '${n}s rest',
			'session.variants.tempoPart' => ({required Object tempo}) => ' · tempo ${tempo}',
			'session.finish.title' => 'Finish session?',
			'session.finish.summaryReps' => ({required Object completed, required Object total}) => '${completed}/${total} sets · ',
			'session.finish.summaryTonnageSuffix' => ' of tonnage',
			'session.finish.notesHint' => 'Notes about the session (optional)…',
			'session.finish.confirm' => 'Finish',
			'session.finish.unvalidatedSets' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} UNVALIDATED SET', other: '${n} UNVALIDATED SETS', ), 
			'session.finish.incompleteHint' => 'You can go back and complete your sets, or finish anyway — only checked sets will be saved.',
			'session.timer.preparation' => 'GET READY',
			'session.timer.running' => 'IN PROGRESS',
			'session.timer.done' => 'DONE',
			'session.timer.go' => 'GO',
			'session.timer.stop' => 'Stop',
			'session.rest.title' => 'REST',
			'session.rest.sec' => 'SEC',
			'session.rest.skip' => 'Skip',
			'session.rest.minimize' => 'Minimize',
			'session.set.addSet' => 'Add a set',
			'session.set.setLabel' => ({required Object n}) => 'Set ${n}',
			'session.set.reps' => 'Reps',
			'session.set.load' => 'Load',
			'session.set.duration' => 'Duration',
			'session.set.held' => 'Held',
			'session.set.tonnage' => 'TONNAGE',
			'session.set.targetReps' => ({required Object n}) => 'target ${n} reps',
			'session.set.targetDuration' => ({required Object value}) => 'target ${value}',
			'session.set.validateWithoutTimer' => 'Complete without timer',
			'session.set.cmpUp' => 'Top',
			'session.exercise.timed' => 'Timed',
			'session.exercise.tempoChip' => ({required Object tempo}) => 'Tempo ${tempo}',
			'session.exercise.restChip' => ({required Object n}) => '${n}s rest',
			'session.exercise.modified' => 'Modified · this session only',
			'session.exercise.modifiedWas' => ({required Object name}) => 'Modified · this session only (was: ${name})',
			'session.exercise.completedBadge' => '✓ Done',
			'session.exercise.totalHeld' => ({required Object value}) => 'Total held: ${value}',
			'session.exercise.exerciseVolume' => ({required Object value}) => 'Exercise volume: ${value} kg',
			'session.exercise.lastTimeLabel' => 'Last time',
			'session.exercise.targetWasReps' => ({required Object n}) => 'was aiming for ${n} reps',
			'session.exercise.targetWasSeconds' => ({required Object n}) => 'was aiming for ${n}s',
			'session.exercise.morePerfs' => ({required Object n}) => '+${n}',
			'session.overview.title' => 'Exercises',
			'session.overview.current' => 'CURRENT',
			'session.overview.setsValidated' => ({required Object completed, required Object total}) => '${completed}/${total} sets completed',
			'session.superset.badge' => ({required Object n}) => 'SUPERSET · ${n} EXERCISES',
			'session.superset.addSetTo' => ({required Object letter, required Object name}) => 'Add a set to ${letter} · ${name}',
			'session.duration.title' => 'Duration per set',
			'session.duration.hint' => '45 or 1m30',
			'session.duration.confirm' => ({required Object value}) => 'Confirm — ${value}',
			'session.weight.bodyweight' => 'Bodyweight',
			'session.weight.confirmBodyweight' => 'Confirm — Bodyweight',
			'session.weight.confirmKg' => ({required Object value}) => 'Confirm — ${value} kg',
			'session.search.hint' => 'Search for an exercise…',
			'session.search.loading' => 'Loading exercises…',
			'session.search.noMatch' => 'No exercise matches.',
			'session.search.certifiedBadge' => 'Repster exercise',
			'session.history.title' => ({required Object name}) => 'History · ${name}',
			'session.history.empty' => 'No history yet for this exercise.',
			'session.history.loading' => 'Loading history…',
			'session.history.setLabel' => ({required Object n}) => 'Set ${n}',
			'session.history.dateFormat' => 'MMM d, yyyy',
			'session.fields.exerciseName' => 'Exercise name',
			'session.fields.type' => 'Type',
			'session.fields.sets' => 'Sets',
			'session.fields.durationSec' => 'Duration (sec)',
			'session.fields.targetReps' => 'Target reps',
			'session.fields.restShort' => 'Rest (sec)',
			'session.fields.rest' => 'Rest (sec)',
			'session.fields.tempo' => 'Tempo',
			'session.fields.notesOptional' => 'Notes (optional)',
			'session.fields.notesHint' => 'Technique tips…',
			'session.toast.exerciseAdded' => ({required Object name}) => '${name} added to the session',
			'session.toast.validateOneSet' => 'Complete at least one set before finishing.',
			'session.toast.sessionSaved' => 'Session saved! 🎉',
			'session.toast.finishOrSwap' => 'Finish the current set or use “Swap”.',
			'session.notif.countdownChannel' => 'Rest countdown',
			'session.notif.doneChannel' => 'Rest finished',
			'session.notif.doneTitle' => 'Rest\'s over',
			'settings.title' => 'Settings',
			'settings.sections.profile' => 'Profile',
			'settings.sections.data' => 'My data',
			'settings.sections.preferences' => 'Preferences',
			'settings.sections.account' => 'Account',
			'settings.defaultName' => 'Athlete',
			'settings.editProfile' => 'EDIT',
			'settings.rows.templates' => 'My templates',
			'settings.rows.history' => 'Session history',
			'settings.rows.stats' => 'Statistics',
			'settings.rows.notifications' => 'Notifications',
			'settings.rows.privacy' => 'Privacy',
			'settings.rows.contact' => 'Contact & Feedback',
			'settings.rows.language' => 'Language',
			'settings.rows.changePassword' => 'Change my password',
			'settings.soon' => 'Soon',
			'settings.soonToast' => 'Coming soon',
			'settings.logout.action' => 'Sign out',
			'settings.logout.error' => 'Sign-out failed.',
			'settings.version' => 'Repster v1.0 · Train, progress, repeat.',
			'settings.language.title' => 'Language',
			'settings.language.subtitle' => 'Choose the app language',
			'settings.language.system' => 'System default',
			'stats.title' => 'Stats',
			'stats.sessionsCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} session', other: '${n} sessions', ), 
			'stats.weeksShort' => ({required Object n}) => '${n} wk',
			'stats.subtitle.empty' => 'No sessions in this period',
			'stats.empty.title' => 'No data yet',
			'stats.empty.message' => 'Complete a few sessions to see your curves and progress.',
			'stats.range.last4Weeks.label' => '4 weeks',
			'stats.range.last4Weeks.short' => '4 wk',
			'stats.range.last3Months.label' => '3 months',
			'stats.range.last3Months.short' => '3 mo',
			'stats.range.all.label' => 'All',
			'stats.range.all.short' => 'All',
			'stats.kpi.sessions' => 'Sessions',
			'stats.kpi.volume' => 'Volume',
			'stats.kpi.sets' => 'Sets',
			'stats.kpi.avgDuration' => 'Avg. duration',
			'stats.consistency.title' => 'Consistency',
			'stats.consistency.trainingDays' => 'active days',
			'stats.consistency.perWeek' => 'sessions / wk',
			'stats.consistency.bestStreak' => 'best streak',
			'stats.consistency.noStreak' => 'no streak',
			'stats.consistency.less' => 'less',
			'stats.consistency.more' => 'more',
			'stats.weeklyVolume.title' => 'Weekly volume',
			'stats.weeklyVolume.empty' => 'Not enough sessions in this period yet.',
			'stats.exercise.title' => 'Progress by exercise',
			'stats.exercise.empty' => 'Log at least 2 sessions with the same loaded exercise to see your strength curve.',
			'stats.exercise.pickerTitle' => 'Choose an exercise',
			'stats.exercise.noExercise' => 'No exercise',
			'stats.exercise.searchHint' => 'Search…',
			'stats.exercise.oneRmMax' => 'max estimated 1RM',
			'stats.exercise.bestLoad' => 'best load',
			'stats.exercise.record' => 'record',
			'stats.muscleBalance.title' => 'Muscle balance',
			'stats.muscleBalance.neglected' => ({required Object days, required Object emoji}) => '— not trained for ${days} d ${emoji}',
			'stats.muscleBalance.since.none' => '–',
			'stats.muscleBalance.since.today' => 'today',
			'stats.muscleBalance.since.yesterday' => 'yesterday',
			'stats.muscleBalance.since.daysShort' => ({required Object n}) => '${n}d',
			'stats.records.title' => 'Records',
			'stats.records.bestSession' => 'Best session',
			'stats.records.heaviestLift' => 'Heaviest lift',
			'stats.records.bestOneRm' => 'Estimated 1RM',
			'stats.records.bestStreak' => 'Longest streak',
			'stats.records.consecutiveWeeks' => 'consecutive weeks',
			'templates.list.title' => 'Program',
			'templates.list.subtitleActive' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} active session', other: '${n} active sessions', ), 
			'templates.list.subtitleManage' => ({required num n, required Object total}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} / ${total} active', other: '${n} / ${total} active', ), 
			'templates.list.manage' => 'Manage',
			'templates.list.newAction' => 'New',
			'templates.list.emptyTitle' => 'No sessions',
			'templates.list.emptyMessage' => 'Create your first session to build your program.',
			'templates.list.emptyAction' => 'Create a session',
			'templates.list.emptyActiveTitle' => 'No sessions in the program',
			'templates.list.emptyActiveMessage' => 'Activate sessions to add them to your program.',
			'templates.list.emptyActiveAction' => 'Manage sessions',
			'templates.list.noResult' => 'No results',
			'templates.list.searchHint' => 'Search a session…',
			'templates.list.manageHint' => 'Drag to reorder · tap the circle to hide/show a session',
			'templates.list.savedChanges' => 'Changes saved ✓',
			'templates.list.reorderError' => 'Reordering failed.',
			'templates.list.toggleError' => 'Action failed.',
			'templates.list.duplicated' => 'Session copied!',
			'templates.list.duplicateError' => 'Duplication failed.',
			'templates.list.deleted' => 'Session deleted.',
			'templates.list.deleteError' => 'Deletion failed.',
			'templates.list.copySuffix' => '(copy)',
			'templates.card.exerciseCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} exercise', other: '${n} exercises', ), 
			'templates.card.details' => 'Details',
			'templates.card.copy' => 'Copy',
			'templates.card.deleteShort' => 'Delete',
			'templates.card.activate' => 'Activate',
			'templates.card.deactivate' => 'Deactivate',
			'templates.detail.title' => 'Template',
			'templates.detail.noExercises' => 'No exercises in this template.',
			'templates.detail.superset' => 'Superset',
			'templates.detail.setsCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} set', other: '${n} sets', ), 
			'templates.detail.seconds' => ({required Object n}) => '${n} s',
			'templates.detail.tempo' => ({required Object value}) => 'Tempo ${value}',
			'templates.detail.rest' => ({required Object n}) => 'Rest ${n}s',
			'templates.detail.variantsMore' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '+${n} variant', other: '+${n} variants', ), 
			'templates.detail.start' => 'Start session',
			'templates.editor.newTitle' => 'New session',
			'templates.editor.editTitle' => 'Edit session',
			'templates.editor.exercisesHeader' => ({required Object count}) => 'EXERCISES (${count})',
			_ => null,
		} ?? switch (path) {
			'templates.editor.addExercise' => 'Add an exercise',
			'templates.editor.save' => 'Save session',
			'templates.editor.validationError' => 'Enter a name and at least one named exercise.',
			'templates.fields.name' => 'Session name',
			'templates.fields.nameHint' => 'e.g. Chest / Triceps / Shoulders',
			'templates.fields.description' => 'Description (optional)',
			'templates.fields.descriptionHint' => 'Describe your session…',
			'templates.fields.muscleGroups' => 'Muscle groups',
			'templates.fields.selectedCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} selected', other: '${n} selected', ), 
			'templates.fields.exerciseName' => 'Exercise name',
			'templates.fields.exerciseNameHint' => 'e.g. Bench press',
			'templates.fields.type' => 'Type',
			'templates.fields.sets' => 'Sets',
			'templates.fields.duration' => 'Duration (s)',
			'templates.fields.targetReps' => 'Target reps',
			'templates.fields.rest' => 'Rest (s)',
			'templates.fields.tempo' => 'Tempo',
			'templates.fields.tempoHint' => '3-1-X-0',
			'templates.fields.notes' => 'Notes (optional)',
			'templates.fields.notesHint' => 'Technical tips…',
			'templates.slot.newExercise' => 'New exercise',
			'templates.slot.variantN' => ({required Object n}) => 'Variant ${n}',
			'templates.slot.primary' => 'PRIMARY',
			'templates.slot.variant' => 'Variant',
			'templates.slot.addVariant' => 'Add a variant',
			'templates.slot.supersetNote' => 'Chained in a superset with the next exercise',
			'templates.slot.supersetLabel' => 'SUPERSET',
			'templates.slot.reps' => 'Reps',
			'templates.slot.time' => 'Time',
			'tempo.helper' => 'Eccentric — pause — concentric — pause (in s)',
			'tempo.formatError' => 'Expected format: 3-1-X-0',
			_ => null,
		};
	}
}
