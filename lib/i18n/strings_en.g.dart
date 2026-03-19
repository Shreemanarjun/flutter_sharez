///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'strings.g.dart';

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

	/// en: 'English'
	String get locale_en => 'English';

	/// en: 'Español'
	String get locale_es => 'Español';

	/// en: 'Odia'
	String get locale_or => 'Odia';

	/// en: '(zero) {No devices found} (one) {Found $n device} (many) {Found $n devices} (other) {Found $n devices}'
	String foundDevices({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		zero: 'No devices found',
		one: 'Found ${n} device',
		many: 'Found ${n} devices',
		other: 'Found ${n} devices',
	);

	/// en: '(zero) {Currently sharing no file} (one) {Currently sharing $n file} (many) {Currently sharing $n files} (other) {Currently sharing $n files}'
	String receiveShareFiles({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		zero: 'Currently sharing no file',
		one: 'Currently sharing ${n} file',
		many: 'Currently sharing ${n} files',
		other: 'Currently sharing ${n} files',
	);

	/// en: '(zero) {You are currently sharing no file} (one) {You are currently sharing $n file} (many) {You are currently sharing $n files} (other) {You are currently sharing $n files}'
	String shareFiles({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		zero: 'You are currently sharing no file',
		one: 'You are currently sharing ${n} file',
		many: 'You are currently sharing ${n} files',
		other: 'You are currently sharing ${n} files',
	);

	/// en: 'Downloads'
	String get actionDownloads => 'Downloads';

	/// en: 'App Settings'
	String get actionSettings => 'App Settings';

	/// en: 'Add files'
	String get addFiles => 'Add files';

	/// en: 'Add more files'
	String get addMoreFiles => 'Add more files';

	/// en: 'Address Copied to Clipboard'
	String get addressCopiedMsg => 'Address Copied to Clipboard';

	/// en: 'Flutter Sharez'
	String get appTitle => 'Flutter Sharez';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Change Language'
	String get changeLanguage => 'Change Language';

	/// en: 'Connect'
	String get connect => 'Connect';

	/// en: 'Copy Address'
	String get copyAddressTooltip => 'Copy Address';

	/// en: 'IP Copied to Clipboard'
	String get copyIpMessage => 'IP Copied to Clipboard';

	/// en: 'Copy IP'
	String get copyIpTooltip => 'Copy IP';

	/// en: 'Counter'
	String get counterAppBarTitle => 'Counter';

	/// en: 'Developed By Shreeman Arjun Made with 💙 Riverpod '
	String get developedBy => 'Developed By Shreeman Arjun \nMade with 💙 Riverpod ';

	/// en: 'No'
	String get dialogActionNo => 'No';

	/// en: 'Yes'
	String get dialogActionYes => 'Yes';

	/// en: 'Downloads'
	String get downloads => 'Downloads';

	/// en: 'Enter IP'
	String get enterIp => 'Enter IP';

	/// en: 'Enter Port'
	String get enterPort => 'Enter Port';

	/// en: 'IP'
	String get ipLablel => 'IP';

	/// en: 'Manually Add'
	String get manuallyAdd => 'Manually Add';

	/// en: 'No devices in the network!'
	String get noDevicesinNetwork => 'No devices in the network!';

	/// en: 'No files selected'
	String get noFileSelected => 'No files selected';

	/// en: 'No files selected yet'
	String get noFilesSelectedYet => 'No files selected yet';

	/// en: 'OK'
	String get ok => 'OK';

	/// en: 'OS name Copied to Clipboard'
	String get osCopyMessage => 'OS name Copied to Clipboard';

	/// en: 'OS Name'
	String get osLable => 'OS Name';

	/// en: 'Copy OS Name'
	String get osTooltip => 'Copy OS Name';

	/// en: 'OS Version'
	String get osVersionLabel => 'OS Version';

	/// en: 'OS version Copied to Clipboard'
	String get osVersionMsg => 'OS version Copied to Clipboard';

	/// en: 'Copy OS Version'
	String get osVersiontooltip => 'Copy OS Version';

	/// en: 'Port'
	String get portLabel => 'Port';

	/// en: 'Port Copied to Clipboard'
	String get portMessage => 'Port Copied to Clipboard';

	/// en: 'Copy Port'
	String get portTolltip => 'Copy Port';

	/// en: 'QR Scan'
	String get qrScan => 'QR Scan';

	/// en: 'QR Scanner not supported in desktop.Please connect manually.'
	String get qrscannotSupported => 'QR Scanner not supported in desktop.Please connect manually.';

	/// en: 'Receive'
	String get receiveLbl => 'Receive';

	/// en: 'Report'
	String get report => 'Report';

	/// en: 'Report a Bug'
	String get reportABug => 'Report a Bug';

	/// en: 'If you find bugs/issues or suggestions, please file a report to github issues.'
	String get reportDescription => 'If you find bugs/issues or suggestions, please file a report to github issues.';

	/// en: 'Rescan'
	String get rescan => 'Rescan';

	/// en: 'Scanning all device in your network'
	String get scanningNetwork => 'Scanning all device in your network';

	/// en: 'Send'
	String get sendLbl => 'Send';

	/// en: 'Server stopped'
	String get sendStateServerStopped => 'Server stopped';

	/// en: 'Setting up server to share your files'
	String get settingUpServer => 'Setting up server to share your files';

	/// en: 'Settings'
	String get settingsPage => 'Settings';

	/// en: 'You can access the server by following infomation '
	String get shareInfoMessage => 'You can access the server by following infomation ';

	/// en: 'Share on Web'
	String get shareOnWeb => 'Share on Web';

	/// en: 'Please visit the below link in a browser to acess all you shared files'
	String get shareWebMsg => 'Please visit the below link in a browser to acess all you shared files';

	/// en: 'Show files'
	String get showFiles => 'Show files';

	/// en: 'Stop Sharing'
	String get stopSharing => 'Stop Sharing';

	/// en: 'Are you sure to stop sharing?'
	String get stopSharingTitle => 'Are you sure to stop sharing?';

	/// en: 'Switch Theme'
	String get switchTheme => 'Switch Theme';

	/// en: 'Please make sure you have connected to same wifi.'
	String get wifiWarning => 'Please make sure you have connected to same wifi.';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'locale_en' => 'English',
			'locale_es' => 'Español',
			'locale_or' => 'Odia',
			'foundDevices' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, zero: 'No devices found', one: 'Found ${n} device', many: 'Found ${n} devices', other: 'Found ${n} devices', ), 
			'receiveShareFiles' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, zero: 'Currently sharing no file', one: 'Currently sharing ${n} file', many: 'Currently sharing ${n} files', other: 'Currently sharing ${n} files', ), 
			'shareFiles' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, zero: 'You are currently sharing no file', one: 'You are currently sharing ${n} file', many: 'You are currently sharing ${n} files', other: 'You are currently sharing ${n} files', ), 
			'actionDownloads' => 'Downloads',
			'actionSettings' => 'App Settings',
			'addFiles' => 'Add files',
			'addMoreFiles' => 'Add more files',
			'addressCopiedMsg' => 'Address Copied to Clipboard',
			'appTitle' => 'Flutter Sharez',
			'cancel' => 'Cancel',
			'changeLanguage' => 'Change Language',
			'connect' => 'Connect',
			'copyAddressTooltip' => 'Copy Address',
			'copyIpMessage' => 'IP Copied to Clipboard',
			'copyIpTooltip' => 'Copy IP',
			'counterAppBarTitle' => 'Counter',
			'developedBy' => 'Developed By Shreeman Arjun \nMade with 💙 Riverpod ',
			'dialogActionNo' => 'No',
			'dialogActionYes' => 'Yes',
			'downloads' => 'Downloads',
			'enterIp' => 'Enter IP',
			'enterPort' => 'Enter Port',
			'ipLablel' => 'IP',
			'manuallyAdd' => 'Manually Add',
			'noDevicesinNetwork' => 'No devices in the network!',
			'noFileSelected' => 'No files selected',
			'noFilesSelectedYet' => 'No files selected yet',
			'ok' => 'OK',
			'osCopyMessage' => 'OS name Copied to Clipboard',
			'osLable' => 'OS Name',
			'osTooltip' => 'Copy OS Name',
			'osVersionLabel' => 'OS Version',
			'osVersionMsg' => 'OS version Copied to Clipboard',
			'osVersiontooltip' => 'Copy OS Version',
			'portLabel' => 'Port',
			'portMessage' => 'Port Copied to Clipboard',
			'portTolltip' => 'Copy Port',
			'qrScan' => 'QR Scan',
			'qrscannotSupported' => 'QR Scanner not supported in desktop.Please connect manually.',
			'receiveLbl' => 'Receive',
			'report' => 'Report',
			'reportABug' => 'Report a Bug',
			'reportDescription' => 'If you find bugs/issues or suggestions, please file a report to github issues.',
			'rescan' => 'Rescan',
			'scanningNetwork' => 'Scanning all device in your network',
			'sendLbl' => 'Send',
			'sendStateServerStopped' => 'Server stopped',
			'settingUpServer' => 'Setting up server to share your files',
			'settingsPage' => 'Settings',
			'shareInfoMessage' => 'You can access the server by following infomation ',
			'shareOnWeb' => 'Share on Web',
			'shareWebMsg' => 'Please visit the below link in a browser to acess all you shared files',
			'showFiles' => 'Show files',
			'stopSharing' => 'Stop Sharing',
			'stopSharingTitle' => 'Are you sure to stop sharing?',
			'switchTheme' => 'Switch Theme',
			'wifiWarning' => 'Please make sure you have connected to same wifi.',
			_ => null,
		};
	}
}
