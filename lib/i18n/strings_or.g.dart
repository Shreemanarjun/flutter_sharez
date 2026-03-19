///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsOr with BaseTranslations<AppLocale, Translations> implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsOr({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
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

	@override 
	TranslationsOr $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsOr(meta: meta ?? this.$meta);

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

/// The flat map containing all translations for locale <or>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsOr {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'locale_en' => 'English',
			'locale_es' => 'Español',
			'locale_or' => 'Odia',
			'foundDevices' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('or'))(n, zero: 'No devices found', one: 'Found ${n} device', many: 'Found ${n} devices', other: 'Found ${n} devices', ), 
			'receiveShareFiles' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('or'))(n, zero: 'Currently sharing no file', one: 'Currently sharing ${n} file', many: 'Currently sharing ${n} files', other: 'Currently sharing ${n} files', ), 
			'shareFiles' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('or'))(n, zero: 'You are currently sharing no file', one: 'You are currently sharing ${n} file', many: 'You are currently sharing ${n} files', other: 'You are currently sharing ${n} files', ), 
			'actionDownloads' => 'ଡାଉନଲୋଡ୍',
			'actionSettings' => 'ଆପ୍ ସେଟିଂସମୂହ',
			'addFiles' => 'ଫାଇଲ୍ ଯୋଡନ୍ତୁ',
			'addMoreFiles' => 'ଅଧିକ ଫାଇଲ୍ ଯୋଡନ୍ତୁ',
			'addressCopiedMsg' => 'କ୍ଲିପବୋର୍ଡରେ ଠିକଣା କପି ହୋଇଛି',
			'appTitle' => 'Flutter Sharez',
			'cancel' => 'ବାତିଲ୍ କରନ୍ତୁ',
			'changeLanguage' => 'ଭାଷା ପରିବର୍ତ୍ତନ କରନ୍ତୁ',
			'connect' => 'ସଂଯୋଗ କରନ୍ତୁ ',
			'copyAddressTooltip' => 'ଠିକଣା କପି କରନ୍ତୁ',
			'copyIpMessage' => 'IP କ୍ଲିପବୋର୍ଡରେ କପି ହୋଇଛି',
			'copyIpTooltip' => 'IP କପି କରନ୍ତୁ',
			'counterAppBarTitle' => 'Counter',
			'developedBy' => 'ଶ୍ରୀମାନ ଅର୍ଜୁନ ଙ୍କ ଦ୍ୱାରା ବିକଶିତ \n 💙 ରିଭରପୋଡ୍ ସହିତ ତିଆରି |',
			'dialogActionNo' => 'ନା',
			'dialogActionYes' => 'ହଁ',
			'downloads' => 'ଡାଉନଲୋଡ୍',
			'enterIp' => 'IP ପ୍ରବେଶ କରନ୍ତୁ ',
			'enterPort' => 'ପୋର୍ଟ ପ୍ରବେଶ କରନ୍ତୁ ',
			'ipLablel' => 'IP',
			'manuallyAdd' => 'ମାନୁଆଲ୍ ଯୋଗ କରନ୍ତୁ',
			'noDevicesinNetwork' => 'ନେଟୱାର୍କରେ ଡିଭାଇସ୍ କିଛି ନାହିଁ!',
			'noFileSelected' => 'କିଛି ଫାଇଲ୍ ଚୟନ ହୋଇନାହିଁ',
			'noFilesSelectedYet' => 'ଏପର୍ଯ୍ୟନ୍ତ କିଛି ଫାଇଲ୍ ଚୟନ ହୋଇନାହିଁ',
			'ok' => 'ଠିକ ଅଛି',
			'osCopyMessage' => 'OS ନାମ କ୍ଲିପବୋର୍ଡରେ କପି ହୋଇଛି',
			'osLable' => 'OS ନାମ',
			'osTooltip' => 'OS ନାମ କପି କରନ୍ତୁ',
			'osVersionLabel' => 'OS ସଂସ୍କରଣ',
			'osVersionMsg' => 'OS ସଂସ୍କରଣ କ୍ଲିପବୋର୍ଡରେ କପି ହୋଇଛି',
			'osVersiontooltip' => 'OS ସଂସ୍କରଣ କପି କରନ୍ତୁ',
			'portLabel' => 'ପୋର୍ଟ',
			'portMessage' => 'କ୍ଲିପବୋର୍ଡକୁ ପୋର୍ଟ କପି କରାଯାଇଛି',
			'portTolltip' => 'ପୋର୍ଟ କପି କରନ୍ତୁ',
			'qrScan' => 'QR ସ୍କାନ୍ କରନ୍ତୁ',
			'qrscannotSupported' => 'ଡେସ୍କଟପରେ QR ସ୍କାନର୍ ସମର୍ଥିତ ନୁହେଁ | ଦୟାକରି ମାନୁଆଲ ସଂଯୋଗ କରନ୍ତୁ |',
			'receiveLbl' => 'ଗ୍ରହଣ',
			'report' => 'ରିପୋର୍ଟ କରନ୍ତୁ',
			'reportABug' => 'ଏକ ତ୍ରୁଟି ଖବର କରନ୍ତୁ',
			'reportDescription' => 'ଯଦି ଆପଣ ବଗ୍ / ଇସୁ କିମ୍ବା ପରାମର୍ଶ ଖୋଜନ୍ତି, ଦୟାକରି github ଇସୁ ପାଇଁ ଏକ ରିପୋର୍ଟ ଫାଇଲ୍ କରନ୍ତୁ',
			'rescan' => 'ପୁନର୍ବାର ସ୍କାନ୍ କରନ୍ତୁ',
			'scanningNetwork' => 'ଆପଣଙ୍କର ନେଟୱର୍କରେ ଥିବା ସମସ୍ତ ଉପକରଣକୁ ସ୍କାନ କରୁଛି ',
			'sendLbl' => 'ପ୍ରେରଣ',
			'sendStateServerStopped' => 'ସର୍ଭର ବନ୍ଦ ହୋଇଗଲା',
			'settingUpServer' => 'ଆପଣଙ୍କର ଫାଇଲଗୁଡିକ ଅଂଶୀଦାର କରିବାକୁ ସର୍ଭର ସେଟ୍ ଅପ୍ କରନ୍ତୁ',
			'settingsPage' => 'ସେଟିଙ୍ଗ୍',
			'shareInfoMessage' => 'ଆପଣ ନିମ୍ନଲିଖିତ ସୂଚନା ଦ୍ୱାରା ସର୍ଭରକୁ ପ୍ରବେଶ କରିପାରିବେ ',
			'shareOnWeb' => 'ୱେବରେ ସେୟାର କରନ୍ତୁ ',
			'shareWebMsg' => 'ଆପଣ ସମସ୍ତ ଅଂଶୀଦାର ଫାଇଲଗୁଡିକୁ ଆକସେସ୍ କରିବାକୁ ଦୟାକରି ଏକ ବ୍ରାଉଜରରେ ନିମ୍ନ ଲିଙ୍କ୍ ପରିଦର୍ଶନ କରନ୍ତୁ',
			'showFiles' => 'ଫାଇଲଗୁଡିକ ଦେଖାନ୍ତୁ',
			'stopSharing' => 'ସେୟାର କରିବା ବନ୍ଦ କରନ୍ତୁ',
			'stopSharingTitle' => 'ଆପଣ ଅଂଶୀଦାର ବନ୍ଦ କରିବାକୁ ନିଶ୍ଚିତ କି?',
			'switchTheme' => 'ଥିମ୍ ପରିବର୍ତ୍ତନ କରନ୍ତୁ ',
			'wifiWarning' => 'ଦୟାକରି ନିଶ୍ଚିତ କରନ୍ତୁ ଯେ ଆପଣ ସମାନ ୱାଇଫାଇ ସହିତ ସଂଯୁକ୍ତ ଅଛନ୍ତି |',
			_ => null,
		};
	}
}
