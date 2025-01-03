///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations implements BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
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

	// Translations
	String get locale_en => 'English';
	String get locale_es => 'Español';
	String get locale_or => 'Odia';
	String foundDevices({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		zero: 'No devices found',
		one: 'Found ${n} device',
		many: 'Found ${n} devices',
		other: 'Found ${n} devices',
	);
	String receiveShareFiles({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		zero: 'Currently sharing no file',
		one: 'Currently sharing ${n} file',
		many: 'Currently sharing ${n} files',
		other: 'Currently sharing ${n} files',
	);
	String shareFiles({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		zero: 'You are currently sharing no file',
		one: 'You are currently sharing ${n} file',
		many: 'You are currently sharing ${n} files',
		other: 'You are currently sharing ${n} files',
	);
	String get actionDownloads => 'Downloads';
	String get actionSettings => 'App Settings';
	String get addFiles => 'Add files';
	String get addMoreFiles => 'Add more files';
	String get addressCopiedMsg => 'Address Copied to Clipboard';
	String get appTitle => 'Flutter Sharez';
	String get cancel => 'Cancel';
	String get changeLanguage => 'Change Language';
	String get connect => 'Connect';
	String get copyAddressTooltip => 'Copy Address';
	String get copyIpMessage => 'IP Copied to Clipboard';
	String get copyIpTooltip => 'Copy IP';
	String get counterAppBarTitle => 'Counter';
	String get developedBy => 'Developed By Shreeman Arjun \nMade with 💙 Riverpod ';
	String get dialogActionNo => 'No';
	String get dialogActionYes => 'Yes';
	String get downloads => 'Downloads';
	String get enterIp => 'Enter IP';
	String get enterPort => 'Enter Port';
	String get ipLablel => 'IP';
	String get manuallyAdd => 'Manually Add';
	String get noDevicesinNetwork => 'No devices in the network!';
	String get noFileSelected => 'No files selected';
	String get noFilesSelectedYet => 'No files selected yet';
	String get ok => 'OK';
	String get osCopyMessage => 'OS name Copied to Clipboard';
	String get osLable => 'OS Name';
	String get osTooltip => 'Copy OS Name';
	String get osVersionLabel => 'OS Version';
	String get osVersionMsg => 'OS version Copied to Clipboard';
	String get osVersiontooltip => 'Copy OS Version';
	String get portLabel => 'Port';
	String get portMessage => 'Port Copied to Clipboard';
	String get portTolltip => 'Copy Port';
	String get qrScan => 'QR Scan';
	String get qrscannotSupported => 'QR Scanner not supported in desktop.Please connect manually.';
	String get receiveLbl => 'Receive';
	String get report => 'Report';
	String get reportABug => 'Report a Bug';
	String get reportDescription => 'If you find bugs/issues or suggestions, please file a report to github issues.';
	String get rescan => 'Rescan';
	String get scanningNetwork => 'Scanning all device in your network';
	String get sendLbl => 'Send';
	String get sendStateServerStopped => 'Server stopped';
	String get settingUpServer => 'Setting up server to share your files';
	String get settingsPage => 'Settings';
	String get shareInfoMessage => 'You can access the server by following infomation ';
	String get shareOnWeb => 'Share on Web';
	String get shareWebMsg => 'Please visit the below link in a browser to acess all you shared files';
	String get showFiles => 'Show files';
	String get stopSharing => 'Stop Sharing';
	String get stopSharingTitle => 'Are you sure to stop sharing?';
	String get switchTheme => 'Switch Theme';
	String get wifiWarning => 'Please make sure you have connected to same wifi.';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on Translations {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'locale_en': return 'English';
			case 'locale_es': return 'Español';
			case 'locale_or': return 'Odia';
			case 'foundDevices': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				zero: 'No devices found',
				one: 'Found ${n} device',
				many: 'Found ${n} devices',
				other: 'Found ${n} devices',
			);
			case 'receiveShareFiles': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				zero: 'Currently sharing no file',
				one: 'Currently sharing ${n} file',
				many: 'Currently sharing ${n} files',
				other: 'Currently sharing ${n} files',
			);
			case 'shareFiles': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				zero: 'You are currently sharing no file',
				one: 'You are currently sharing ${n} file',
				many: 'You are currently sharing ${n} files',
				other: 'You are currently sharing ${n} files',
			);
			case 'actionDownloads': return 'Downloads';
			case 'actionSettings': return 'App Settings';
			case 'addFiles': return 'Add files';
			case 'addMoreFiles': return 'Add more files';
			case 'addressCopiedMsg': return 'Address Copied to Clipboard';
			case 'appTitle': return 'Flutter Sharez';
			case 'cancel': return 'Cancel';
			case 'changeLanguage': return 'Change Language';
			case 'connect': return 'Connect';
			case 'copyAddressTooltip': return 'Copy Address';
			case 'copyIpMessage': return 'IP Copied to Clipboard';
			case 'copyIpTooltip': return 'Copy IP';
			case 'counterAppBarTitle': return 'Counter';
			case 'developedBy': return 'Developed By Shreeman Arjun \nMade with 💙 Riverpod ';
			case 'dialogActionNo': return 'No';
			case 'dialogActionYes': return 'Yes';
			case 'downloads': return 'Downloads';
			case 'enterIp': return 'Enter IP';
			case 'enterPort': return 'Enter Port';
			case 'ipLablel': return 'IP';
			case 'manuallyAdd': return 'Manually Add';
			case 'noDevicesinNetwork': return 'No devices in the network!';
			case 'noFileSelected': return 'No files selected';
			case 'noFilesSelectedYet': return 'No files selected yet';
			case 'ok': return 'OK';
			case 'osCopyMessage': return 'OS name Copied to Clipboard';
			case 'osLable': return 'OS Name';
			case 'osTooltip': return 'Copy OS Name';
			case 'osVersionLabel': return 'OS Version';
			case 'osVersionMsg': return 'OS version Copied to Clipboard';
			case 'osVersiontooltip': return 'Copy OS Version';
			case 'portLabel': return 'Port';
			case 'portMessage': return 'Port Copied to Clipboard';
			case 'portTolltip': return 'Copy Port';
			case 'qrScan': return 'QR Scan';
			case 'qrscannotSupported': return 'QR Scanner not supported in desktop.Please connect manually.';
			case 'receiveLbl': return 'Receive';
			case 'report': return 'Report';
			case 'reportABug': return 'Report a Bug';
			case 'reportDescription': return 'If you find bugs/issues or suggestions, please file a report to github issues.';
			case 'rescan': return 'Rescan';
			case 'scanningNetwork': return 'Scanning all device in your network';
			case 'sendLbl': return 'Send';
			case 'sendStateServerStopped': return 'Server stopped';
			case 'settingUpServer': return 'Setting up server to share your files';
			case 'settingsPage': return 'Settings';
			case 'shareInfoMessage': return 'You can access the server by following infomation ';
			case 'shareOnWeb': return 'Share on Web';
			case 'shareWebMsg': return 'Please visit the below link in a browser to acess all you shared files';
			case 'showFiles': return 'Show files';
			case 'stopSharing': return 'Stop Sharing';
			case 'stopSharingTitle': return 'Are you sure to stop sharing?';
			case 'switchTheme': return 'Switch Theme';
			case 'wifiWarning': return 'Please make sure you have connected to same wifi.';
			default: return null;
		}
	}
}

