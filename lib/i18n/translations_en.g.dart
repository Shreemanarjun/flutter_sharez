///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

part of 'translations.g.dart';

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
  /// [AppLocaleUtils.buildWithOverrides] is recommended for overriding.
  Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
      : $meta = TranslationMetadata(
          locale: AppLocale.en,
          overrides: overrides ?? {},
          cardinalResolver: cardinalResolver,
          ordinalResolver: ordinalResolver,
        ) {
    $meta.setFlatMapFunction(_flatMapFunction);
  }

  /// Metadata for the translations of <en>.
  @override
  final TranslationMetadata<AppLocale, Translations> $meta;

  /// Access flat map
  dynamic operator [](String key) => $meta.getTranslation(key);

  late final Translations _root = this; // ignore: unused_field

  // Translations
  String get locale_en => TranslationOverrides.string(_root.$meta, 'locale_en', {}) ?? 'English';
  String get locale_es => TranslationOverrides.string(_root.$meta, 'locale_es', {}) ?? 'Español';
  String get locale_or => TranslationOverrides.string(_root.$meta, 'locale_or', {}) ?? 'Odia';
  String found_devices({required num n}) =>
      TranslationOverrides.plural(_root.$meta, 'found_devices', {'n': n}) ??
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        n,
        zero: 'No devices found',
        one: 'Found {count} device',
        many: 'Found {count} devices',
        other: 'Found {count} devices',
      );
  String receive_share_files({required num n}) =>
      TranslationOverrides.plural(_root.$meta, 'receive_share_files', {'n': n}) ??
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        n,
        zero: 'Currently sharing no file',
        one: 'Currently sharing {count} file',
        many: 'Currently sharing {count} files',
        other: 'Currently sharing {count} files',
      );
  String share_files({required num n}) =>
      TranslationOverrides.plural(_root.$meta, 'share_files', {'n': n}) ??
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        n,
        zero: 'You are currently sharing no file',
        one: 'You are currently sharing {count} file',
        many: 'You are currently sharing {count} files',
        other: 'You are currently sharing {count} files',
      );
  String get action_downloads => TranslationOverrides.string(_root.$meta, 'action_downloads', {}) ?? 'Downloads';
  String get action_settings => TranslationOverrides.string(_root.$meta, 'action_settings', {}) ?? 'App Settings';
  String get add_files => TranslationOverrides.string(_root.$meta, 'add_files', {}) ?? 'Add files';
  String get add_more_files => TranslationOverrides.string(_root.$meta, 'add_more_files', {}) ?? 'Add more files';
  String get address_copied_msg => TranslationOverrides.string(_root.$meta, 'address_copied_msg', {}) ?? 'Address Copied to Clipboard';
  String get app_title => TranslationOverrides.string(_root.$meta, 'app_title', {}) ?? 'Flutter Sharez';
  String get cancel => TranslationOverrides.string(_root.$meta, 'cancel', {}) ?? 'Cancel';
  String get change_language => TranslationOverrides.string(_root.$meta, 'change_language', {}) ?? 'Change Language';
  String get connect => TranslationOverrides.string(_root.$meta, 'connect', {}) ?? 'Connect';
  String get copy_address_tooltip => TranslationOverrides.string(_root.$meta, 'copy_address_tooltip', {}) ?? 'Copy Address';
  String get copy_ip_message => TranslationOverrides.string(_root.$meta, 'copy_ip_message', {}) ?? 'IP Copied to Clipboard';
  String get copy_ip_tooltip => TranslationOverrides.string(_root.$meta, 'copy_ip_tooltip', {}) ?? 'Copy IP';
  String get counter_app_bar_title => TranslationOverrides.string(_root.$meta, 'counter_app_bar_title', {}) ?? 'Counter';
  String get developed_by => TranslationOverrides.string(_root.$meta, 'developed_by', {}) ?? 'Developed By Shreeman Arjun \nMade with 💙 Riverpod ';
  String get dialog_action_no => TranslationOverrides.string(_root.$meta, 'dialog_action_no', {}) ?? 'No';
  String get dialog_action_yes => TranslationOverrides.string(_root.$meta, 'dialog_action_yes', {}) ?? 'Yes';
  String get downloads => TranslationOverrides.string(_root.$meta, 'downloads', {}) ?? 'Downloads';
  String get enter_ip => TranslationOverrides.string(_root.$meta, 'enter_ip', {}) ?? 'Enter IP';
  String get enter_port => TranslationOverrides.string(_root.$meta, 'enter_port', {}) ?? 'Enter Port';
  String get ip_lablel => TranslationOverrides.string(_root.$meta, 'ip_lablel', {}) ?? 'IP';
  String get manually_add => TranslationOverrides.string(_root.$meta, 'manually_add', {}) ?? 'Manually Add';
  String get no_devicesin_network => TranslationOverrides.string(_root.$meta, 'no_devicesin_network', {}) ?? 'No devices in the network!';
  String get no_file_selected => TranslationOverrides.string(_root.$meta, 'no_file_selected', {}) ?? 'No files selected';
  String get no_files_selected_yet => TranslationOverrides.string(_root.$meta, 'no_files_selected_yet', {}) ?? 'No files selected yet';
  String get ok => TranslationOverrides.string(_root.$meta, 'ok', {}) ?? 'OK';
  String get os_copy_message => TranslationOverrides.string(_root.$meta, 'os_copy_message', {}) ?? 'OS name Copied to Clipboard';
  String get os_lable => TranslationOverrides.string(_root.$meta, 'os_lable', {}) ?? 'OS Name';
  String get os_tooltip => TranslationOverrides.string(_root.$meta, 'os_tooltip', {}) ?? 'Copy OS Name';
  String get os_version_label => TranslationOverrides.string(_root.$meta, 'os_version_label', {}) ?? 'OS Version';
  String get os_version_msg => TranslationOverrides.string(_root.$meta, 'os_version_msg', {}) ?? 'OS version Copied to Clipboard';
  String get os_versiontooltip => TranslationOverrides.string(_root.$meta, 'os_versiontooltip', {}) ?? 'Copy OS Version';
  String get port_label => TranslationOverrides.string(_root.$meta, 'port_label', {}) ?? 'Port';
  String get port_message => TranslationOverrides.string(_root.$meta, 'port_message', {}) ?? 'Port Copied to Clipboard';
  String get port_tolltip => TranslationOverrides.string(_root.$meta, 'port_tolltip', {}) ?? 'Copy Port';
  String get qr_scan => TranslationOverrides.string(_root.$meta, 'qr_scan', {}) ?? 'QR Scan';
  String get qrscannot_supported =>
      TranslationOverrides.string(_root.$meta, 'qrscannot_supported', {}) ?? 'QR Scanner not supported in desktop.Please connect manually.';
  String get receive_lbl => TranslationOverrides.string(_root.$meta, 'receive_lbl', {}) ?? 'Receive';
  String get report => TranslationOverrides.string(_root.$meta, 'report', {}) ?? 'Report';
  String get report_a_bug => TranslationOverrides.string(_root.$meta, 'report_a_bug', {}) ?? 'Report a Bug';
  String get report_description =>
      TranslationOverrides.string(_root.$meta, 'report_description', {}) ??
      'If you find bugs/issues or suggestions, please file a report to github issues.';
  String get rescan => TranslationOverrides.string(_root.$meta, 'rescan', {}) ?? 'Rescan';
  String get scanning_network => TranslationOverrides.string(_root.$meta, 'scanning_network', {}) ?? 'Scanning all device in your network';
  String get send_lbl => TranslationOverrides.string(_root.$meta, 'send_lbl', {}) ?? 'Send';
  String get send_state_server_stopped => TranslationOverrides.string(_root.$meta, 'send_state_server_stopped', {}) ?? 'Server stopped';
  String get setting_up_server => TranslationOverrides.string(_root.$meta, 'setting_up_server', {}) ?? 'Setting up server to share your files';
  String get settings_page => TranslationOverrides.string(_root.$meta, 'settings_page', {}) ?? 'Settings';
  String get share_info_message =>
      TranslationOverrides.string(_root.$meta, 'share_info_message', {}) ?? 'You can access the server by following infomation ';
  String get share_on_web => TranslationOverrides.string(_root.$meta, 'share_on_web', {}) ?? 'Share on Web';
  String get share_web_msg =>
      TranslationOverrides.string(_root.$meta, 'share_web_msg', {}) ?? 'Please visit the below link in a browser to acess all you shared files';
  String get show_files => TranslationOverrides.string(_root.$meta, 'show_files', {}) ?? 'Show files';
  String get stop_sharing => TranslationOverrides.string(_root.$meta, 'stop_sharing', {}) ?? 'Stop Sharing';
  String get stop_sharing_title => TranslationOverrides.string(_root.$meta, 'stop_sharing_title', {}) ?? 'Are you sure to stop sharing?';
  String get switch_theme => TranslationOverrides.string(_root.$meta, 'switch_theme', {}) ?? 'Switch Theme';
  String get wifi_warning => TranslationOverrides.string(_root.$meta, 'wifi_warning', {}) ?? 'Please make sure you have connected to same wifi.';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on Translations {
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
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
              n,
              zero: 'No devices found',
              one: 'Found {count} device',
              many: 'Found {count} devices',
              other: 'Found {count} devices',
            );
      case 'receive_share_files':
        return ({required num n}) =>
            TranslationOverrides.plural(_root.$meta, 'receive_share_files', {'n': n}) ??
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
              n,
              zero: 'Currently sharing no file',
              one: 'Currently sharing {count} file',
              many: 'Currently sharing {count} files',
              other: 'Currently sharing {count} files',
            );
      case 'share_files':
        return ({required num n}) =>
            TranslationOverrides.plural(_root.$meta, 'share_files', {'n': n}) ??
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
              n,
              zero: 'You are currently sharing no file',
              one: 'You are currently sharing {count} file',
              many: 'You are currently sharing {count} files',
              other: 'You are currently sharing {count} files',
            );
      case 'action_downloads':
        return TranslationOverrides.string(_root.$meta, 'action_downloads', {}) ?? 'Downloads';
      case 'action_settings':
        return TranslationOverrides.string(_root.$meta, 'action_settings', {}) ?? 'App Settings';
      case 'add_files':
        return TranslationOverrides.string(_root.$meta, 'add_files', {}) ?? 'Add files';
      case 'add_more_files':
        return TranslationOverrides.string(_root.$meta, 'add_more_files', {}) ?? 'Add more files';
      case 'address_copied_msg':
        return TranslationOverrides.string(_root.$meta, 'address_copied_msg', {}) ?? 'Address Copied to Clipboard';
      case 'app_title':
        return TranslationOverrides.string(_root.$meta, 'app_title', {}) ?? 'Flutter Sharez';
      case 'cancel':
        return TranslationOverrides.string(_root.$meta, 'cancel', {}) ?? 'Cancel';
      case 'change_language':
        return TranslationOverrides.string(_root.$meta, 'change_language', {}) ?? 'Change Language';
      case 'connect':
        return TranslationOverrides.string(_root.$meta, 'connect', {}) ?? 'Connect';
      case 'copy_address_tooltip':
        return TranslationOverrides.string(_root.$meta, 'copy_address_tooltip', {}) ?? 'Copy Address';
      case 'copy_ip_message':
        return TranslationOverrides.string(_root.$meta, 'copy_ip_message', {}) ?? 'IP Copied to Clipboard';
      case 'copy_ip_tooltip':
        return TranslationOverrides.string(_root.$meta, 'copy_ip_tooltip', {}) ?? 'Copy IP';
      case 'counter_app_bar_title':
        return TranslationOverrides.string(_root.$meta, 'counter_app_bar_title', {}) ?? 'Counter';
      case 'developed_by':
        return TranslationOverrides.string(_root.$meta, 'developed_by', {}) ?? 'Developed By Shreeman Arjun \nMade with 💙 Riverpod ';
      case 'dialog_action_no':
        return TranslationOverrides.string(_root.$meta, 'dialog_action_no', {}) ?? 'No';
      case 'dialog_action_yes':
        return TranslationOverrides.string(_root.$meta, 'dialog_action_yes', {}) ?? 'Yes';
      case 'downloads':
        return TranslationOverrides.string(_root.$meta, 'downloads', {}) ?? 'Downloads';
      case 'enter_ip':
        return TranslationOverrides.string(_root.$meta, 'enter_ip', {}) ?? 'Enter IP';
      case 'enter_port':
        return TranslationOverrides.string(_root.$meta, 'enter_port', {}) ?? 'Enter Port';
      case 'ip_lablel':
        return TranslationOverrides.string(_root.$meta, 'ip_lablel', {}) ?? 'IP';
      case 'manually_add':
        return TranslationOverrides.string(_root.$meta, 'manually_add', {}) ?? 'Manually Add';
      case 'no_devicesin_network':
        return TranslationOverrides.string(_root.$meta, 'no_devicesin_network', {}) ?? 'No devices in the network!';
      case 'no_file_selected':
        return TranslationOverrides.string(_root.$meta, 'no_file_selected', {}) ?? 'No files selected';
      case 'no_files_selected_yet':
        return TranslationOverrides.string(_root.$meta, 'no_files_selected_yet', {}) ?? 'No files selected yet';
      case 'ok':
        return TranslationOverrides.string(_root.$meta, 'ok', {}) ?? 'OK';
      case 'os_copy_message':
        return TranslationOverrides.string(_root.$meta, 'os_copy_message', {}) ?? 'OS name Copied to Clipboard';
      case 'os_lable':
        return TranslationOverrides.string(_root.$meta, 'os_lable', {}) ?? 'OS Name';
      case 'os_tooltip':
        return TranslationOverrides.string(_root.$meta, 'os_tooltip', {}) ?? 'Copy OS Name';
      case 'os_version_label':
        return TranslationOverrides.string(_root.$meta, 'os_version_label', {}) ?? 'OS Version';
      case 'os_version_msg':
        return TranslationOverrides.string(_root.$meta, 'os_version_msg', {}) ?? 'OS version Copied to Clipboard';
      case 'os_versiontooltip':
        return TranslationOverrides.string(_root.$meta, 'os_versiontooltip', {}) ?? 'Copy OS Version';
      case 'port_label':
        return TranslationOverrides.string(_root.$meta, 'port_label', {}) ?? 'Port';
      case 'port_message':
        return TranslationOverrides.string(_root.$meta, 'port_message', {}) ?? 'Port Copied to Clipboard';
      case 'port_tolltip':
        return TranslationOverrides.string(_root.$meta, 'port_tolltip', {}) ?? 'Copy Port';
      case 'qr_scan':
        return TranslationOverrides.string(_root.$meta, 'qr_scan', {}) ?? 'QR Scan';
      case 'qrscannot_supported':
        return TranslationOverrides.string(_root.$meta, 'qrscannot_supported', {}) ?? 'QR Scanner not supported in desktop.Please connect manually.';
      case 'receive_lbl':
        return TranslationOverrides.string(_root.$meta, 'receive_lbl', {}) ?? 'Receive';
      case 'report':
        return TranslationOverrides.string(_root.$meta, 'report', {}) ?? 'Report';
      case 'report_a_bug':
        return TranslationOverrides.string(_root.$meta, 'report_a_bug', {}) ?? 'Report a Bug';
      case 'report_description':
        return TranslationOverrides.string(_root.$meta, 'report_description', {}) ??
            'If you find bugs/issues or suggestions, please file a report to github issues.';
      case 'rescan':
        return TranslationOverrides.string(_root.$meta, 'rescan', {}) ?? 'Rescan';
      case 'scanning_network':
        return TranslationOverrides.string(_root.$meta, 'scanning_network', {}) ?? 'Scanning all device in your network';
      case 'send_lbl':
        return TranslationOverrides.string(_root.$meta, 'send_lbl', {}) ?? 'Send';
      case 'send_state_server_stopped':
        return TranslationOverrides.string(_root.$meta, 'send_state_server_stopped', {}) ?? 'Server stopped';
      case 'setting_up_server':
        return TranslationOverrides.string(_root.$meta, 'setting_up_server', {}) ?? 'Setting up server to share your files';
      case 'settings_page':
        return TranslationOverrides.string(_root.$meta, 'settings_page', {}) ?? 'Settings';
      case 'share_info_message':
        return TranslationOverrides.string(_root.$meta, 'share_info_message', {}) ?? 'You can access the server by following infomation ';
      case 'share_on_web':
        return TranslationOverrides.string(_root.$meta, 'share_on_web', {}) ?? 'Share on Web';
      case 'share_web_msg':
        return TranslationOverrides.string(_root.$meta, 'share_web_msg', {}) ??
            'Please visit the below link in a browser to acess all you shared files';
      case 'show_files':
        return TranslationOverrides.string(_root.$meta, 'show_files', {}) ?? 'Show files';
      case 'stop_sharing':
        return TranslationOverrides.string(_root.$meta, 'stop_sharing', {}) ?? 'Stop Sharing';
      case 'stop_sharing_title':
        return TranslationOverrides.string(_root.$meta, 'stop_sharing_title', {}) ?? 'Are you sure to stop sharing?';
      case 'switch_theme':
        return TranslationOverrides.string(_root.$meta, 'switch_theme', {}) ?? 'Switch Theme';
      case 'wifi_warning':
        return TranslationOverrides.string(_root.$meta, 'wifi_warning', {}) ?? 'Please make sure you have connected to same wifi.';
      default:
        return null;
    }
  }
}
