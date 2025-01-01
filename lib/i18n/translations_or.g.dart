///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'package:slang/overrides.dart';
import 'translations.g.dart';

// Path: <root>
class TranslationsOr extends Translations {
  /// You can call this constructor and build your own translation instance of this locale.
  /// Constructing via the enum [AppLocale.build] is preferred.
  /// [AppLocaleUtils.buildWithOverrides] is recommended for overriding.
  TranslationsOr({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
      : $meta = TranslationMetadata(
          locale: AppLocale.or,
          overrides: overrides ?? {},
          cardinalResolver: cardinalResolver,
          ordinalResolver: ordinalResolver,
        ),
        super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
    super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
    $meta.setFlatMapFunction(_flatMapFunction);
  }

  /// Metadata for the translations of <or>.
  @override
  final TranslationMetadata<AppLocale, Translations> $meta;

  /// Access flat map
  @override
  dynamic operator [](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

  late final TranslationsOr _root = this; // ignore: unused_field

  // Translations
  @override
  String get locale_en => TranslationOverrides.string(_root.$meta, 'locale_en', {}) ?? 'English';
  @override
  String get locale_es => TranslationOverrides.string(_root.$meta, 'locale_es', {}) ?? 'Español';
  @override
  String get locale_or => TranslationOverrides.string(_root.$meta, 'locale_or', {}) ?? 'Odia';
  @override
  String found_devices({required num n}) =>
      TranslationOverrides.plural(_root.$meta, 'found_devices', {'n': n}) ??
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('or'))(
        n,
        zero: 'No devices found',
        one: 'Found {count} device',
        many: 'Found {count} devices',
        other: 'Found {count} devices',
      );
  @override
  String receive_share_files({required num n}) =>
      TranslationOverrides.plural(_root.$meta, 'receive_share_files', {'n': n}) ??
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('or'))(
        n,
        zero: 'Currently sharing no file',
        one: 'Currently sharing {count} file',
        many: 'Currently sharing {count} files',
        other: 'Currently sharing {count} files',
      );
  @override
  String share_files({required num n}) =>
      TranslationOverrides.plural(_root.$meta, 'share_files', {'n': n}) ??
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('or'))(
        n,
        zero: 'You are currently sharing no file',
        one: 'You are currently sharing {count} file',
        many: 'You are currently sharing {count} files',
        other: 'You are currently sharing {count} files',
      );
  @override
  String get action_downloads => TranslationOverrides.string(_root.$meta, 'action_downloads', {}) ?? 'ଡାଉନଲୋଡ୍';
  @override
  String get action_settings => TranslationOverrides.string(_root.$meta, 'action_settings', {}) ?? 'ଆପ୍ ସେଟିଂସମୂହ';
  @override
  String get add_files => TranslationOverrides.string(_root.$meta, 'add_files', {}) ?? 'ଫାଇଲ୍ ଯୋଡନ୍ତୁ';
  @override
  String get add_more_files => TranslationOverrides.string(_root.$meta, 'add_more_files', {}) ?? 'ଅଧିକ ଫାଇଲ୍ ଯୋଡନ୍ତୁ';
  @override
  String get address_copied_msg => TranslationOverrides.string(_root.$meta, 'address_copied_msg', {}) ?? 'କ୍ଲିପବୋର୍ଡରେ ଠିକଣା କପି ହୋଇଛି';
  @override
  String get app_title => TranslationOverrides.string(_root.$meta, 'app_title', {}) ?? 'Flutter Sharez';
  @override
  String get cancel => TranslationOverrides.string(_root.$meta, 'cancel', {}) ?? 'ବାତିଲ୍ କରନ୍ତୁ';
  @override
  String get change_language => TranslationOverrides.string(_root.$meta, 'change_language', {}) ?? 'ଭାଷା ପରିବର୍ତ୍ତନ କରନ୍ତୁ';
  @override
  String get connect => TranslationOverrides.string(_root.$meta, 'connect', {}) ?? 'ସଂଯୋଗ କରନ୍ତୁ ';
  @override
  String get copy_address_tooltip => TranslationOverrides.string(_root.$meta, 'copy_address_tooltip', {}) ?? 'ଠିକଣା କପି କରନ୍ତୁ';
  @override
  String get copy_ip_message => TranslationOverrides.string(_root.$meta, 'copy_ip_message', {}) ?? 'IP କ୍ଲିପବୋର୍ଡରେ କପି ହୋଇଛି';
  @override
  String get copy_ip_tooltip => TranslationOverrides.string(_root.$meta, 'copy_ip_tooltip', {}) ?? 'IP କପି କରନ୍ତୁ';
  @override
  String get counter_app_bar_title => TranslationOverrides.string(_root.$meta, 'counter_app_bar_title', {}) ?? 'Counter';
  @override
  String get developed_by =>
      TranslationOverrides.string(_root.$meta, 'developed_by', {}) ?? 'ଶ୍ରୀମାନ ଅର୍ଜୁନ ଙ୍କ ଦ୍ୱାରା ବିକଶିତ \n 💙 ରିଭରପୋଡ୍ ସହିତ ତିଆରି |';
  @override
  String get dialog_action_no => TranslationOverrides.string(_root.$meta, 'dialog_action_no', {}) ?? 'ନା';
  @override
  String get dialog_action_yes => TranslationOverrides.string(_root.$meta, 'dialog_action_yes', {}) ?? 'ହଁ';
  @override
  String get downloads => TranslationOverrides.string(_root.$meta, 'downloads', {}) ?? 'ଡାଉନଲୋଡ୍';
  @override
  String get enter_ip => TranslationOverrides.string(_root.$meta, 'enter_ip', {}) ?? 'IP ପ୍ରବେଶ କରନ୍ତୁ ';
  @override
  String get enter_port => TranslationOverrides.string(_root.$meta, 'enter_port', {}) ?? 'ପୋର୍ଟ ପ୍ରବେଶ କରନ୍ତୁ ';
  @override
  String get ip_lablel => TranslationOverrides.string(_root.$meta, 'ip_lablel', {}) ?? 'IP';
  @override
  String get manually_add => TranslationOverrides.string(_root.$meta, 'manually_add', {}) ?? 'ମାନୁଆଲ୍ ଯୋଗ କରନ୍ତୁ';
  @override
  String get no_devicesin_network => TranslationOverrides.string(_root.$meta, 'no_devicesin_network', {}) ?? 'ନେଟୱାର୍କରେ ଡିଭାଇସ୍ କିଛି ନାହିଁ!';
  @override
  String get no_file_selected => TranslationOverrides.string(_root.$meta, 'no_file_selected', {}) ?? 'କିଛି ଫାଇଲ୍ ଚୟନ ହୋଇନାହିଁ';
  @override
  String get no_files_selected_yet => TranslationOverrides.string(_root.$meta, 'no_files_selected_yet', {}) ?? 'ଏପର୍ଯ୍ୟନ୍ତ କିଛି ଫାଇଲ୍ ଚୟନ ହୋଇନାହିଁ';
  @override
  String get ok => TranslationOverrides.string(_root.$meta, 'ok', {}) ?? 'ଠିକ ଅଛି';
  @override
  String get os_copy_message => TranslationOverrides.string(_root.$meta, 'os_copy_message', {}) ?? 'OS ନାମ କ୍ଲିପବୋର୍ଡରେ କପି ହୋଇଛି';
  @override
  String get os_lable => TranslationOverrides.string(_root.$meta, 'os_lable', {}) ?? 'OS ନାମ';
  @override
  String get os_tooltip => TranslationOverrides.string(_root.$meta, 'os_tooltip', {}) ?? 'OS ନାମ କପି କରନ୍ତୁ';
  @override
  String get os_version_label => TranslationOverrides.string(_root.$meta, 'os_version_label', {}) ?? 'OS ସଂସ୍କରଣ';
  @override
  String get os_version_msg => TranslationOverrides.string(_root.$meta, 'os_version_msg', {}) ?? 'OS ସଂସ୍କରଣ କ୍ଲିପବୋର୍ଡରେ କପି ହୋଇଛି';
  @override
  String get os_versiontooltip => TranslationOverrides.string(_root.$meta, 'os_versiontooltip', {}) ?? 'OS ସଂସ୍କରଣ କପି କରନ୍ତୁ';
  @override
  String get port_label => TranslationOverrides.string(_root.$meta, 'port_label', {}) ?? 'ପୋର୍ଟ';
  @override
  String get port_message => TranslationOverrides.string(_root.$meta, 'port_message', {}) ?? 'କ୍ଲିପବୋର୍ଡକୁ ପୋର୍ଟ କପି କରାଯାଇଛି';
  @override
  String get port_tolltip => TranslationOverrides.string(_root.$meta, 'port_tolltip', {}) ?? 'ପୋର୍ଟ କପି କରନ୍ତୁ';
  @override
  String get qr_scan => TranslationOverrides.string(_root.$meta, 'qr_scan', {}) ?? 'QR ସ୍କାନ୍ କରନ୍ତୁ';
  @override
  String get qrscannot_supported =>
      TranslationOverrides.string(_root.$meta, 'qrscannot_supported', {}) ?? 'ଡେସ୍କଟପରେ QR ସ୍କାନର୍ ସମର୍ଥିତ ନୁହେଁ | ଦୟାକରି ମାନୁଆଲ ସଂଯୋଗ କରନ୍ତୁ |';
  @override
  String get receive_lbl => TranslationOverrides.string(_root.$meta, 'receive_lbl', {}) ?? 'ଗ୍ରହଣ';
  @override
  String get report => TranslationOverrides.string(_root.$meta, 'report', {}) ?? 'ରିପୋର୍ଟ କରନ୍ତୁ';
  @override
  String get report_a_bug => TranslationOverrides.string(_root.$meta, 'report_a_bug', {}) ?? 'ଏକ ତ୍ରୁଟି ଖବର କରନ୍ତୁ';
  @override
  String get report_description =>
      TranslationOverrides.string(_root.$meta, 'report_description', {}) ??
      'ଯଦି ଆପଣ ବଗ୍ / ଇସୁ କିମ୍ବା ପରାମର୍ଶ ଖୋଜନ୍ତି, ଦୟାକରି github ଇସୁ ପାଇଁ ଏକ ରିପୋର୍ଟ ଫାଇଲ୍ କରନ୍ତୁ';
  @override
  String get rescan => TranslationOverrides.string(_root.$meta, 'rescan', {}) ?? 'ପୁନର୍ବାର ସ୍କାନ୍ କରନ୍ତୁ';
  @override
  String get scanning_network =>
      TranslationOverrides.string(_root.$meta, 'scanning_network', {}) ?? 'ଆପଣଙ୍କର ନେଟୱର୍କରେ ଥିବା ସମସ୍ତ ଉପକରଣକୁ ସ୍କାନ କରୁଛି ';
  @override
  String get send_lbl => TranslationOverrides.string(_root.$meta, 'send_lbl', {}) ?? 'ପ୍ରେରଣ';
  @override
  String get send_state_server_stopped => TranslationOverrides.string(_root.$meta, 'send_state_server_stopped', {}) ?? 'ସର୍ଭର ବନ୍ଦ ହୋଇଗଲା';
  @override
  String get setting_up_server =>
      TranslationOverrides.string(_root.$meta, 'setting_up_server', {}) ?? 'ଆପଣଙ୍କର ଫାଇଲଗୁଡିକ ଅଂଶୀଦାର କରିବାକୁ ସର୍ଭର ସେଟ୍ ଅପ୍ କରନ୍ତୁ';
  @override
  String get settings_page => TranslationOverrides.string(_root.$meta, 'settings_page', {}) ?? 'ସେଟିଙ୍ଗ୍';
  @override
  String get share_info_message =>
      TranslationOverrides.string(_root.$meta, 'share_info_message', {}) ?? 'ଆପଣ ନିମ୍ନଲିଖିତ ସୂଚନା ଦ୍ୱାରା ସର୍ଭରକୁ ପ୍ରବେଶ କରିପାରିବେ ';
  @override
  String get share_on_web => TranslationOverrides.string(_root.$meta, 'share_on_web', {}) ?? 'ୱେବରେ ସେୟାର କରନ୍ତୁ ';
  @override
  String get share_web_msg =>
      TranslationOverrides.string(_root.$meta, 'share_web_msg', {}) ??
      'ଆପଣ ସମସ୍ତ ଅଂଶୀଦାର ଫାଇଲଗୁଡିକୁ ଆକସେସ୍ କରିବାକୁ ଦୟାକରି ଏକ ବ୍ରାଉଜରରେ ନିମ୍ନ ଲିଙ୍କ୍ ପରିଦର୍ଶନ କରନ୍ତୁ';
  @override
  String get show_files => TranslationOverrides.string(_root.$meta, 'show_files', {}) ?? 'ଫାଇଲଗୁଡିକ ଦେଖାନ୍ତୁ';
  @override
  String get stop_sharing => TranslationOverrides.string(_root.$meta, 'stop_sharing', {}) ?? 'ସେୟାର କରିବା ବନ୍ଦ କରନ୍ତୁ';
  @override
  String get stop_sharing_title => TranslationOverrides.string(_root.$meta, 'stop_sharing_title', {}) ?? 'ଆପଣ ଅଂଶୀଦାର ବନ୍ଦ କରିବାକୁ ନିଶ୍ଚିତ କି?';
  @override
  String get switch_theme => TranslationOverrides.string(_root.$meta, 'switch_theme', {}) ?? 'ଥିମ୍ ପରିବର୍ତ୍ତନ କରନ୍ତୁ ';
  @override
  String get wifi_warning =>
      TranslationOverrides.string(_root.$meta, 'wifi_warning', {}) ?? 'ଦୟାକରି ନିଶ୍ଚିତ କରନ୍ତୁ ଯେ ଆପଣ ସମାନ ୱାଇଫାଇ ସହିତ ସଂଯୁକ୍ତ ଅଛନ୍ତି |';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsOr {
  dynamic _flatMapFunction(String path) {
    switch (path) {
      case 'locale_en':
        return TranslationOverrides.string(_root.$meta, 'locale_en', {}) ?? 'English';
      case 'locale_es':
        return TranslationOverrides.string(_root.$meta, 'locale_es', {}) ?? 'Español';
      case 'locale_or':
        return TranslationOverrides.string(_root.$meta, 'locale_or', {}) ?? 'Odia';
      case 'found_devices':
        return ({required num n}) =>
            TranslationOverrides.plural(_root.$meta, 'found_devices', {'n': n}) ??
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('or'))(
              n,
              zero: 'No devices found',
              one: 'Found {count} device',
              many: 'Found {count} devices',
              other: 'Found {count} devices',
            );
      case 'receive_share_files':
        return ({required num n}) =>
            TranslationOverrides.plural(_root.$meta, 'receive_share_files', {'n': n}) ??
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('or'))(
              n,
              zero: 'Currently sharing no file',
              one: 'Currently sharing {count} file',
              many: 'Currently sharing {count} files',
              other: 'Currently sharing {count} files',
            );
      case 'share_files':
        return ({required num n}) =>
            TranslationOverrides.plural(_root.$meta, 'share_files', {'n': n}) ??
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('or'))(
              n,
              zero: 'You are currently sharing no file',
              one: 'You are currently sharing {count} file',
              many: 'You are currently sharing {count} files',
              other: 'You are currently sharing {count} files',
            );
      case 'action_downloads':
        return TranslationOverrides.string(_root.$meta, 'action_downloads', {}) ?? 'ଡାଉନଲୋଡ୍';
      case 'action_settings':
        return TranslationOverrides.string(_root.$meta, 'action_settings', {}) ?? 'ଆପ୍ ସେଟିଂସମୂହ';
      case 'add_files':
        return TranslationOverrides.string(_root.$meta, 'add_files', {}) ?? 'ଫାଇଲ୍ ଯୋଡନ୍ତୁ';
      case 'add_more_files':
        return TranslationOverrides.string(_root.$meta, 'add_more_files', {}) ?? 'ଅଧିକ ଫାଇଲ୍ ଯୋଡନ୍ତୁ';
      case 'address_copied_msg':
        return TranslationOverrides.string(_root.$meta, 'address_copied_msg', {}) ?? 'କ୍ଲିପବୋର୍ଡରେ ଠିକଣା କପି ହୋଇଛି';
      case 'app_title':
        return TranslationOverrides.string(_root.$meta, 'app_title', {}) ?? 'Flutter Sharez';
      case 'cancel':
        return TranslationOverrides.string(_root.$meta, 'cancel', {}) ?? 'ବାତିଲ୍ କରନ୍ତୁ';
      case 'change_language':
        return TranslationOverrides.string(_root.$meta, 'change_language', {}) ?? 'ଭାଷା ପରିବର୍ତ୍ତନ କରନ୍ତୁ';
      case 'connect':
        return TranslationOverrides.string(_root.$meta, 'connect', {}) ?? 'ସଂଯୋଗ କରନ୍ତୁ ';
      case 'copy_address_tooltip':
        return TranslationOverrides.string(_root.$meta, 'copy_address_tooltip', {}) ?? 'ଠିକଣା କପି କରନ୍ତୁ';
      case 'copy_ip_message':
        return TranslationOverrides.string(_root.$meta, 'copy_ip_message', {}) ?? 'IP କ୍ଲିପବୋର୍ଡରେ କପି ହୋଇଛି';
      case 'copy_ip_tooltip':
        return TranslationOverrides.string(_root.$meta, 'copy_ip_tooltip', {}) ?? 'IP କପି କରନ୍ତୁ';
      case 'counter_app_bar_title':
        return TranslationOverrides.string(_root.$meta, 'counter_app_bar_title', {}) ?? 'Counter';
      case 'developed_by':
        return TranslationOverrides.string(_root.$meta, 'developed_by', {}) ?? 'ଶ୍ରୀମାନ ଅର୍ଜୁନ ଙ୍କ ଦ୍ୱାରା ବିକଶିତ \n 💙 ରିଭରପୋଡ୍ ସହିତ ତିଆରି |';
      case 'dialog_action_no':
        return TranslationOverrides.string(_root.$meta, 'dialog_action_no', {}) ?? 'ନା';
      case 'dialog_action_yes':
        return TranslationOverrides.string(_root.$meta, 'dialog_action_yes', {}) ?? 'ହଁ';
      case 'downloads':
        return TranslationOverrides.string(_root.$meta, 'downloads', {}) ?? 'ଡାଉନଲୋଡ୍';
      case 'enter_ip':
        return TranslationOverrides.string(_root.$meta, 'enter_ip', {}) ?? 'IP ପ୍ରବେଶ କରନ୍ତୁ ';
      case 'enter_port':
        return TranslationOverrides.string(_root.$meta, 'enter_port', {}) ?? 'ପୋର୍ଟ ପ୍ରବେଶ କରନ୍ତୁ ';
      case 'ip_lablel':
        return TranslationOverrides.string(_root.$meta, 'ip_lablel', {}) ?? 'IP';
      case 'manually_add':
        return TranslationOverrides.string(_root.$meta, 'manually_add', {}) ?? 'ମାନୁଆଲ୍ ଯୋଗ କରନ୍ତୁ';
      case 'no_devicesin_network':
        return TranslationOverrides.string(_root.$meta, 'no_devicesin_network', {}) ?? 'ନେଟୱାର୍କରେ ଡିଭାଇସ୍ କିଛି ନାହିଁ!';
      case 'no_file_selected':
        return TranslationOverrides.string(_root.$meta, 'no_file_selected', {}) ?? 'କିଛି ଫାଇଲ୍ ଚୟନ ହୋଇନାହିଁ';
      case 'no_files_selected_yet':
        return TranslationOverrides.string(_root.$meta, 'no_files_selected_yet', {}) ?? 'ଏପର୍ଯ୍ୟନ୍ତ କିଛି ଫାଇଲ୍ ଚୟନ ହୋଇନାହିଁ';
      case 'ok':
        return TranslationOverrides.string(_root.$meta, 'ok', {}) ?? 'ଠିକ ଅଛି';
      case 'os_copy_message':
        return TranslationOverrides.string(_root.$meta, 'os_copy_message', {}) ?? 'OS ନାମ କ୍ଲିପବୋର୍ଡରେ କପି ହୋଇଛି';
      case 'os_lable':
        return TranslationOverrides.string(_root.$meta, 'os_lable', {}) ?? 'OS ନାମ';
      case 'os_tooltip':
        return TranslationOverrides.string(_root.$meta, 'os_tooltip', {}) ?? 'OS ନାମ କପି କରନ୍ତୁ';
      case 'os_version_label':
        return TranslationOverrides.string(_root.$meta, 'os_version_label', {}) ?? 'OS ସଂସ୍କରଣ';
      case 'os_version_msg':
        return TranslationOverrides.string(_root.$meta, 'os_version_msg', {}) ?? 'OS ସଂସ୍କରଣ କ୍ଲିପବୋର୍ଡରେ କପି ହୋଇଛି';
      case 'os_versiontooltip':
        return TranslationOverrides.string(_root.$meta, 'os_versiontooltip', {}) ?? 'OS ସଂସ୍କରଣ କପି କରନ୍ତୁ';
      case 'port_label':
        return TranslationOverrides.string(_root.$meta, 'port_label', {}) ?? 'ପୋର୍ଟ';
      case 'port_message':
        return TranslationOverrides.string(_root.$meta, 'port_message', {}) ?? 'କ୍ଲିପବୋର୍ଡକୁ ପୋର୍ଟ କପି କରାଯାଇଛି';
      case 'port_tolltip':
        return TranslationOverrides.string(_root.$meta, 'port_tolltip', {}) ?? 'ପୋର୍ଟ କପି କରନ୍ତୁ';
      case 'qr_scan':
        return TranslationOverrides.string(_root.$meta, 'qr_scan', {}) ?? 'QR ସ୍କାନ୍ କରନ୍ତୁ';
      case 'qrscannot_supported':
        return TranslationOverrides.string(_root.$meta, 'qrscannot_supported', {}) ??
            'ଡେସ୍କଟପରେ QR ସ୍କାନର୍ ସମର୍ଥିତ ନୁହେଁ | ଦୟାକରି ମାନୁଆଲ ସଂଯୋଗ କରନ୍ତୁ |';
      case 'receive_lbl':
        return TranslationOverrides.string(_root.$meta, 'receive_lbl', {}) ?? 'ଗ୍ରହଣ';
      case 'report':
        return TranslationOverrides.string(_root.$meta, 'report', {}) ?? 'ରିପୋର୍ଟ କରନ୍ତୁ';
      case 'report_a_bug':
        return TranslationOverrides.string(_root.$meta, 'report_a_bug', {}) ?? 'ଏକ ତ୍ରୁଟି ଖବର କରନ୍ତୁ';
      case 'report_description':
        return TranslationOverrides.string(_root.$meta, 'report_description', {}) ??
            'ଯଦି ଆପଣ ବଗ୍ / ଇସୁ କିମ୍ବା ପରାମର୍ଶ ଖୋଜନ୍ତି, ଦୟାକରି github ଇସୁ ପାଇଁ ଏକ ରିପୋର୍ଟ ଫାଇଲ୍ କରନ୍ତୁ';
      case 'rescan':
        return TranslationOverrides.string(_root.$meta, 'rescan', {}) ?? 'ପୁନର୍ବାର ସ୍କାନ୍ କରନ୍ତୁ';
      case 'scanning_network':
        return TranslationOverrides.string(_root.$meta, 'scanning_network', {}) ?? 'ଆପଣଙ୍କର ନେଟୱର୍କରେ ଥିବା ସମସ୍ତ ଉପକରଣକୁ ସ୍କାନ କରୁଛି ';
      case 'send_lbl':
        return TranslationOverrides.string(_root.$meta, 'send_lbl', {}) ?? 'ପ୍ରେରଣ';
      case 'send_state_server_stopped':
        return TranslationOverrides.string(_root.$meta, 'send_state_server_stopped', {}) ?? 'ସର୍ଭର ବନ୍ଦ ହୋଇଗଲା';
      case 'setting_up_server':
        return TranslationOverrides.string(_root.$meta, 'setting_up_server', {}) ?? 'ଆପଣଙ୍କର ଫାଇଲଗୁଡିକ ଅଂଶୀଦାର କରିବାକୁ ସର୍ଭର ସେଟ୍ ଅପ୍ କରନ୍ତୁ';
      case 'settings_page':
        return TranslationOverrides.string(_root.$meta, 'settings_page', {}) ?? 'ସେଟିଙ୍ଗ୍';
      case 'share_info_message':
        return TranslationOverrides.string(_root.$meta, 'share_info_message', {}) ?? 'ଆପଣ ନିମ୍ନଲିଖିତ ସୂଚନା ଦ୍ୱାରା ସର୍ଭରକୁ ପ୍ରବେଶ କରିପାରିବେ ';
      case 'share_on_web':
        return TranslationOverrides.string(_root.$meta, 'share_on_web', {}) ?? 'ୱେବରେ ସେୟାର କରନ୍ତୁ ';
      case 'share_web_msg':
        return TranslationOverrides.string(_root.$meta, 'share_web_msg', {}) ??
            'ଆପଣ ସମସ୍ତ ଅଂଶୀଦାର ଫାଇଲଗୁଡିକୁ ଆକସେସ୍ କରିବାକୁ ଦୟାକରି ଏକ ବ୍ରାଉଜରରେ ନିମ୍ନ ଲିଙ୍କ୍ ପରିଦର୍ଶନ କରନ୍ତୁ';
      case 'show_files':
        return TranslationOverrides.string(_root.$meta, 'show_files', {}) ?? 'ଫାଇଲଗୁଡିକ ଦେଖାନ୍ତୁ';
      case 'stop_sharing':
        return TranslationOverrides.string(_root.$meta, 'stop_sharing', {}) ?? 'ସେୟାର କରିବା ବନ୍ଦ କରନ୍ତୁ';
      case 'stop_sharing_title':
        return TranslationOverrides.string(_root.$meta, 'stop_sharing_title', {}) ?? 'ଆପଣ ଅଂଶୀଦାର ବନ୍ଦ କରିବାକୁ ନିଶ୍ଚିତ କି?';
      case 'switch_theme':
        return TranslationOverrides.string(_root.$meta, 'switch_theme', {}) ?? 'ଥିମ୍ ପରିବର୍ତ୍ତନ କରନ୍ତୁ ';
      case 'wifi_warning':
        return TranslationOverrides.string(_root.$meta, 'wifi_warning', {}) ?? 'ଦୟାକରି ନିଶ୍ଚିତ କରନ୍ତୁ ଯେ ଆପଣ ସମାନ ୱାଇଫାଇ ସହିତ ସଂଯୁକ୍ତ ଅଛନ୍ତି |';
      default:
        return null;
    }
  }
}
