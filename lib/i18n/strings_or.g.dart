///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsOr implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsOr({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.or,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <or>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsOr _root = this; // ignore: unused_field

	// Translations
	@override String get locale_en => 'English';
	@override String get locale_es => 'Español';
	@override String get locale_or => 'Odia';
	@override String foundDevices({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('or'))(n,
		zero: 'No devices found',
		one: 'Found ${n} device',
		many: 'Found ${n} devices',
		other: 'Found ${n} devices',
	);
	@override String receiveShareFiles({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('or'))(n,
		zero: 'Currently sharing no file',
		one: 'Currently sharing ${n} file',
		many: 'Currently sharing ${n} files',
		other: 'Currently sharing ${n} files',
	);
	@override String shareFiles({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('or'))(n,
		zero: 'You are currently sharing no file',
		one: 'You are currently sharing ${n} file',
		many: 'You are currently sharing ${n} files',
		other: 'You are currently sharing ${n} files',
	);
	@override String get actionDownloads => 'ଡାଉନଲୋଡ୍';
	@override String get actionSettings => 'ଆପ୍ ସେଟିଂସମୂହ';
	@override String get addFiles => 'ଫାଇଲ୍ ଯୋଡନ୍ତୁ';
	@override String get addMoreFiles => 'ଅଧିକ ଫାଇଲ୍ ଯୋଡନ୍ତୁ';
	@override String get addressCopiedMsg => 'କ୍ଲିପବୋର୍ଡରେ ଠିକଣା କପି ହୋଇଛି';
	@override String get appTitle => 'Flutter Sharez';
	@override String get cancel => 'ବାତିଲ୍ କରନ୍ତୁ';
	@override String get changeLanguage => 'ଭାଷା ପରିବର୍ତ୍ତନ କରନ୍ତୁ';
	@override String get connect => 'ସଂଯୋଗ କରନ୍ତୁ ';
	@override String get copyAddressTooltip => 'ଠିକଣା କପି କରନ୍ତୁ';
	@override String get copyIpMessage => 'IP କ୍ଲିପବୋର୍ଡରେ କପି ହୋଇଛି';
	@override String get copyIpTooltip => 'IP କପି କରନ୍ତୁ';
	@override String get counterAppBarTitle => 'Counter';
	@override String get developedBy => 'ଶ୍ରୀମାନ ଅର୍ଜୁନ ଙ୍କ ଦ୍ୱାରା ବିକଶିତ \n 💙 ରିଭରପୋଡ୍ ସହିତ ତିଆରି |';
	@override String get dialogActionNo => 'ନା';
	@override String get dialogActionYes => 'ହଁ';
	@override String get downloads => 'ଡାଉନଲୋଡ୍';
	@override String get enterIp => 'IP ପ୍ରବେଶ କରନ୍ତୁ ';
	@override String get enterPort => 'ପୋର୍ଟ ପ୍ରବେଶ କରନ୍ତୁ ';
	@override String get ipLablel => 'IP';
	@override String get manuallyAdd => 'ମାନୁଆଲ୍ ଯୋଗ କରନ୍ତୁ';
	@override String get noDevicesinNetwork => 'ନେଟୱାର୍କରେ ଡିଭାଇସ୍ କିଛି ନାହିଁ!';
	@override String get noFileSelected => 'କିଛି ଫାଇଲ୍ ଚୟନ ହୋଇନାହିଁ';
	@override String get noFilesSelectedYet => 'ଏପର୍ଯ୍ୟନ୍ତ କିଛି ଫାଇଲ୍ ଚୟନ ହୋଇନାହିଁ';
	@override String get ok => 'ଠିକ ଅଛି';
	@override String get osCopyMessage => 'OS ନାମ କ୍ଲିପବୋର୍ଡରେ କପି ହୋଇଛି';
	@override String get osLable => 'OS ନାମ';
	@override String get osTooltip => 'OS ନାମ କପି କରନ୍ତୁ';
	@override String get osVersionLabel => 'OS ସଂସ୍କରଣ';
	@override String get osVersionMsg => 'OS ସଂସ୍କରଣ କ୍ଲିପବୋର୍ଡରେ କପି ହୋଇଛି';
	@override String get osVersiontooltip => 'OS ସଂସ୍କରଣ କପି କରନ୍ତୁ';
	@override String get portLabel => 'ପୋର୍ଟ';
	@override String get portMessage => 'କ୍ଲିପବୋର୍ଡକୁ ପୋର୍ଟ କପି କରାଯାଇଛି';
	@override String get portTolltip => 'ପୋର୍ଟ କପି କରନ୍ତୁ';
	@override String get qrScan => 'QR ସ୍କାନ୍ କରନ୍ତୁ';
	@override String get qrscannotSupported => 'ଡେସ୍କଟପରେ QR ସ୍କାନର୍ ସମର୍ଥିତ ନୁହେଁ | ଦୟାକରି ମାନୁଆଲ ସଂଯୋଗ କରନ୍ତୁ |';
	@override String get receiveLbl => 'ଗ୍ରହଣ';
	@override String get report => 'ରିପୋର୍ଟ କରନ୍ତୁ';
	@override String get reportABug => 'ଏକ ତ୍ରୁଟି ଖବର କରନ୍ତୁ';
	@override String get reportDescription => 'ଯଦି ଆପଣ ବଗ୍ / ଇସୁ କିମ୍ବା ପରାମର୍ଶ ଖୋଜନ୍ତି, ଦୟାକରି github ଇସୁ ପାଇଁ ଏକ ରିପୋର୍ଟ ଫାଇଲ୍ କରନ୍ତୁ';
	@override String get rescan => 'ପୁନର୍ବାର ସ୍କାନ୍ କରନ୍ତୁ';
	@override String get scanningNetwork => 'ଆପଣଙ୍କର ନେଟୱର୍କରେ ଥିବା ସମସ୍ତ ଉପକରଣକୁ ସ୍କାନ କରୁଛି ';
	@override String get sendLbl => 'ପ୍ରେରଣ';
	@override String get sendStateServerStopped => 'ସର୍ଭର ବନ୍ଦ ହୋଇଗଲା';
	@override String get settingUpServer => 'ଆପଣଙ୍କର ଫାଇଲଗୁଡିକ ଅଂଶୀଦାର କରିବାକୁ ସର୍ଭର ସେଟ୍ ଅପ୍ କରନ୍ତୁ';
	@override String get settingsPage => 'ସେଟିଙ୍ଗ୍';
	@override String get shareInfoMessage => 'ଆପଣ ନିମ୍ନଲିଖିତ ସୂଚନା ଦ୍ୱାରା ସର୍ଭରକୁ ପ୍ରବେଶ କରିପାରିବେ ';
	@override String get shareOnWeb => 'ୱେବରେ ସେୟାର କରନ୍ତୁ ';
	@override String get shareWebMsg => 'ଆପଣ ସମସ୍ତ ଅଂଶୀଦାର ଫାଇଲଗୁଡିକୁ ଆକସେସ୍ କରିବାକୁ ଦୟାକରି ଏକ ବ୍ରାଉଜରରେ ନିମ୍ନ ଲିଙ୍କ୍ ପରିଦର୍ଶନ କରନ୍ତୁ';
	@override String get showFiles => 'ଫାଇଲଗୁଡିକ ଦେଖାନ୍ତୁ';
	@override String get stopSharing => 'ସେୟାର କରିବା ବନ୍ଦ କରନ୍ତୁ';
	@override String get stopSharingTitle => 'ଆପଣ ଅଂଶୀଦାର ବନ୍ଦ କରିବାକୁ ନିଶ୍ଚିତ କି?';
	@override String get switchTheme => 'ଥିମ୍ ପରିବର୍ତ୍ତନ କରନ୍ତୁ ';
	@override String get wifiWarning => 'ଦୟାକରି ନିଶ୍ଚିତ କରନ୍ତୁ ଯେ ଆପଣ ସମାନ ୱାଇଫାଇ ସହିତ ସଂଯୁକ୍ତ ଅଛନ୍ତି |';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsOr {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'locale_en': return 'English';
			case 'locale_es': return 'Español';
			case 'locale_or': return 'Odia';
			case 'foundDevices': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('or'))(n,
				zero: 'No devices found',
				one: 'Found ${n} device',
				many: 'Found ${n} devices',
				other: 'Found ${n} devices',
			);
			case 'receiveShareFiles': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('or'))(n,
				zero: 'Currently sharing no file',
				one: 'Currently sharing ${n} file',
				many: 'Currently sharing ${n} files',
				other: 'Currently sharing ${n} files',
			);
			case 'shareFiles': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('or'))(n,
				zero: 'You are currently sharing no file',
				one: 'You are currently sharing ${n} file',
				many: 'You are currently sharing ${n} files',
				other: 'You are currently sharing ${n} files',
			);
			case 'actionDownloads': return 'ଡାଉନଲୋଡ୍';
			case 'actionSettings': return 'ଆପ୍ ସେଟିଂସମୂହ';
			case 'addFiles': return 'ଫାଇଲ୍ ଯୋଡନ୍ତୁ';
			case 'addMoreFiles': return 'ଅଧିକ ଫାଇଲ୍ ଯୋଡନ୍ତୁ';
			case 'addressCopiedMsg': return 'କ୍ଲିପବୋର୍ଡରେ ଠିକଣା କପି ହୋଇଛି';
			case 'appTitle': return 'Flutter Sharez';
			case 'cancel': return 'ବାତିଲ୍ କରନ୍ତୁ';
			case 'changeLanguage': return 'ଭାଷା ପରିବର୍ତ୍ତନ କରନ୍ତୁ';
			case 'connect': return 'ସଂଯୋଗ କରନ୍ତୁ ';
			case 'copyAddressTooltip': return 'ଠିକଣା କପି କରନ୍ତୁ';
			case 'copyIpMessage': return 'IP କ୍ଲିପବୋର୍ଡରେ କପି ହୋଇଛି';
			case 'copyIpTooltip': return 'IP କପି କରନ୍ତୁ';
			case 'counterAppBarTitle': return 'Counter';
			case 'developedBy': return 'ଶ୍ରୀମାନ ଅର୍ଜୁନ ଙ୍କ ଦ୍ୱାରା ବିକଶିତ \n 💙 ରିଭରପୋଡ୍ ସହିତ ତିଆରି |';
			case 'dialogActionNo': return 'ନା';
			case 'dialogActionYes': return 'ହଁ';
			case 'downloads': return 'ଡାଉନଲୋଡ୍';
			case 'enterIp': return 'IP ପ୍ରବେଶ କରନ୍ତୁ ';
			case 'enterPort': return 'ପୋର୍ଟ ପ୍ରବେଶ କରନ୍ତୁ ';
			case 'ipLablel': return 'IP';
			case 'manuallyAdd': return 'ମାନୁଆଲ୍ ଯୋଗ କରନ୍ତୁ';
			case 'noDevicesinNetwork': return 'ନେଟୱାର୍କରେ ଡିଭାଇସ୍ କିଛି ନାହିଁ!';
			case 'noFileSelected': return 'କିଛି ଫାଇଲ୍ ଚୟନ ହୋଇନାହିଁ';
			case 'noFilesSelectedYet': return 'ଏପର୍ଯ୍ୟନ୍ତ କିଛି ଫାଇଲ୍ ଚୟନ ହୋଇନାହିଁ';
			case 'ok': return 'ଠିକ ଅଛି';
			case 'osCopyMessage': return 'OS ନାମ କ୍ଲିପବୋର୍ଡରେ କପି ହୋଇଛି';
			case 'osLable': return 'OS ନାମ';
			case 'osTooltip': return 'OS ନାମ କପି କରନ୍ତୁ';
			case 'osVersionLabel': return 'OS ସଂସ୍କରଣ';
			case 'osVersionMsg': return 'OS ସଂସ୍କରଣ କ୍ଲିପବୋର୍ଡରେ କପି ହୋଇଛି';
			case 'osVersiontooltip': return 'OS ସଂସ୍କରଣ କପି କରନ୍ତୁ';
			case 'portLabel': return 'ପୋର୍ଟ';
			case 'portMessage': return 'କ୍ଲିପବୋର୍ଡକୁ ପୋର୍ଟ କପି କରାଯାଇଛି';
			case 'portTolltip': return 'ପୋର୍ଟ କପି କରନ୍ତୁ';
			case 'qrScan': return 'QR ସ୍କାନ୍ କରନ୍ତୁ';
			case 'qrscannotSupported': return 'ଡେସ୍କଟପରେ QR ସ୍କାନର୍ ସମର୍ଥିତ ନୁହେଁ | ଦୟାକରି ମାନୁଆଲ ସଂଯୋଗ କରନ୍ତୁ |';
			case 'receiveLbl': return 'ଗ୍ରହଣ';
			case 'report': return 'ରିପୋର୍ଟ କରନ୍ତୁ';
			case 'reportABug': return 'ଏକ ତ୍ରୁଟି ଖବର କରନ୍ତୁ';
			case 'reportDescription': return 'ଯଦି ଆପଣ ବଗ୍ / ଇସୁ କିମ୍ବା ପରାମର୍ଶ ଖୋଜନ୍ତି, ଦୟାକରି github ଇସୁ ପାଇଁ ଏକ ରିପୋର୍ଟ ଫାଇଲ୍ କରନ୍ତୁ';
			case 'rescan': return 'ପୁନର୍ବାର ସ୍କାନ୍ କରନ୍ତୁ';
			case 'scanningNetwork': return 'ଆପଣଙ୍କର ନେଟୱର୍କରେ ଥିବା ସମସ୍ତ ଉପକରଣକୁ ସ୍କାନ କରୁଛି ';
			case 'sendLbl': return 'ପ୍ରେରଣ';
			case 'sendStateServerStopped': return 'ସର୍ଭର ବନ୍ଦ ହୋଇଗଲା';
			case 'settingUpServer': return 'ଆପଣଙ୍କର ଫାଇଲଗୁଡିକ ଅଂଶୀଦାର କରିବାକୁ ସର୍ଭର ସେଟ୍ ଅପ୍ କରନ୍ତୁ';
			case 'settingsPage': return 'ସେଟିଙ୍ଗ୍';
			case 'shareInfoMessage': return 'ଆପଣ ନିମ୍ନଲିଖିତ ସୂଚନା ଦ୍ୱାରା ସର୍ଭରକୁ ପ୍ରବେଶ କରିପାରିବେ ';
			case 'shareOnWeb': return 'ୱେବରେ ସେୟାର କରନ୍ତୁ ';
			case 'shareWebMsg': return 'ଆପଣ ସମସ୍ତ ଅଂଶୀଦାର ଫାଇଲଗୁଡିକୁ ଆକସେସ୍ କରିବାକୁ ଦୟାକରି ଏକ ବ୍ରାଉଜରରେ ନିମ୍ନ ଲିଙ୍କ୍ ପରିଦର୍ଶନ କରନ୍ତୁ';
			case 'showFiles': return 'ଫାଇଲଗୁଡିକ ଦେଖାନ୍ତୁ';
			case 'stopSharing': return 'ସେୟାର କରିବା ବନ୍ଦ କରନ୍ତୁ';
			case 'stopSharingTitle': return 'ଆପଣ ଅଂଶୀଦାର ବନ୍ଦ କରିବାକୁ ନିଶ୍ଚିତ କି?';
			case 'switchTheme': return 'ଥିମ୍ ପରିବର୍ତ୍ତନ କରନ୍ତୁ ';
			case 'wifiWarning': return 'ଦୟାକରି ନିଶ୍ଚିତ କରନ୍ତୁ ଯେ ଆପଣ ସମାନ ୱାଇଫାଇ ସହିତ ସଂଯୁକ୍ତ ଅଛନ୍ତି |';
			default: return null;
		}
	}
}

