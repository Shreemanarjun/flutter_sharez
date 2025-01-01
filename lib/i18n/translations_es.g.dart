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
class TranslationsEs extends Translations {
  /// You can call this constructor and build your own translation instance of this locale.
  /// Constructing via the enum [AppLocale.build] is preferred.
  /// [AppLocaleUtils.buildWithOverrides] is recommended for overriding.
  TranslationsEs({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
      : $meta = TranslationMetadata(
          locale: AppLocale.es,
          overrides: overrides ?? {},
          cardinalResolver: cardinalResolver,
          ordinalResolver: ordinalResolver,
        ),
        super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
    super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
    $meta.setFlatMapFunction(_flatMapFunction);
  }

  /// Metadata for the translations of <es>.
  @override
  final TranslationMetadata<AppLocale, Translations> $meta;

  /// Access flat map
  @override
  dynamic operator [](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

  late final TranslationsEs _root = this; // ignore: unused_field

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
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
        n,
        zero: 'No devices found',
        one: 'Found {count} device',
        many: 'Found {count} devices',
        other: 'Found {count} devices',
      );
  @override
  String receive_share_files({required num n}) =>
      TranslationOverrides.plural(_root.$meta, 'receive_share_files', {'n': n}) ??
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
        n,
        zero: 'Currently sharing no file',
        one: 'Currently sharing {count} file',
        many: 'Currently sharing {count} files',
        other: 'Currently sharing {count} files',
      );
  @override
  String share_files({required num n}) =>
      TranslationOverrides.plural(_root.$meta, 'share_files', {'n': n}) ??
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
        n,
        zero: 'You are currently sharing no file',
        one: 'You are currently sharing {count} file',
        many: 'You are currently sharing {count} files',
        other: 'You are currently sharing {count} files',
      );
  @override
  String get action_downloads => TranslationOverrides.string(_root.$meta, 'action_downloads', {}) ?? 'Descargas';
  @override
  String get action_settings => TranslationOverrides.string(_root.$meta, 'action_settings', {}) ?? 'Ajustes de Aplicacion';
  @override
  String get add_files => TranslationOverrides.string(_root.$meta, 'add_files', {}) ?? 'Agregar archivos';
  @override
  String get add_more_files => TranslationOverrides.string(_root.$meta, 'add_more_files', {}) ?? 'Agrega mas archivos';
  @override
  String get address_copied_msg => TranslationOverrides.string(_root.$meta, 'address_copied_msg', {}) ?? 'Dirección copiada al portapapeles';
  @override
  String get app_title => TranslationOverrides.string(_root.$meta, 'app_title', {}) ?? 'Flutter Sharez';
  @override
  String get cancel => TranslationOverrides.string(_root.$meta, 'cancel', {}) ?? 'Cancelar';
  @override
  String get change_language => TranslationOverrides.string(_root.$meta, 'change_language', {}) ?? 'Cambiar idioma';
  @override
  String get connect => TranslationOverrides.string(_root.$meta, 'connect', {}) ?? 'Conectar';
  @override
  String get copy_address_tooltip => TranslationOverrides.string(_root.$meta, 'copy_address_tooltip', {}) ?? 'Dirección de copia';
  @override
  String get copy_ip_message => TranslationOverrides.string(_root.$meta, 'copy_ip_message', {}) ?? 'IP copiado al portapapeles';
  @override
  String get copy_ip_tooltip => TranslationOverrides.string(_root.$meta, 'copy_ip_tooltip', {}) ?? 'Copiar IP';
  @override
  String get counter_app_bar_title => TranslationOverrides.string(_root.$meta, 'counter_app_bar_title', {}) ?? 'Contador';
  @override
  String get developed_by =>
      TranslationOverrides.string(_root.$meta, 'developed_by', {}) ?? 'Desarrollado por Shreeman Arjun \nHecho con 💙 Riverpod.';
  @override
  String get dialog_action_no => TranslationOverrides.string(_root.$meta, 'dialog_action_no', {}) ?? 'no';
  @override
  String get dialog_action_yes => TranslationOverrides.string(_root.$meta, 'dialog_action_yes', {}) ?? 'Sí';
  @override
  String get downloads => TranslationOverrides.string(_root.$meta, 'downloads', {}) ?? 'Descargas';
  @override
  String get enter_ip => TranslationOverrides.string(_root.$meta, 'enter_ip', {}) ?? 'Ingrese IP';
  @override
  String get enter_port => TranslationOverrides.string(_root.$meta, 'enter_port', {}) ?? 'Ingresar puerto';
  @override
  String get ip_lablel => TranslationOverrides.string(_root.$meta, 'ip_lablel', {}) ?? 'ip';
  @override
  String get manually_add => TranslationOverrides.string(_root.$meta, 'manually_add', {}) ?? 'Agregar manualmente';
  @override
  String get no_devicesin_network => TranslationOverrides.string(_root.$meta, 'no_devicesin_network', {}) ?? '¡No hay ningún dispositivo en la red!';
  @override
  String get no_file_selected => TranslationOverrides.string(_root.$meta, 'no_file_selected', {}) ?? 'No hay archivos seleccionados';
  @override
  String get no_files_selected_yet =>
      TranslationOverrides.string(_root.$meta, 'no_files_selected_yet', {}) ?? 'No hay archivos seleccionados todavía';
  @override
  String get ok => TranslationOverrides.string(_root.$meta, 'ok', {}) ?? 'Bueno';
  @override
  String get os_copy_message =>
      TranslationOverrides.string(_root.$meta, 'os_copy_message', {}) ?? 'Nombre del sistema operativo copiado al portapapeles';
  @override
  String get os_lable => TranslationOverrides.string(_root.$meta, 'os_lable', {}) ?? 'Nombre del sistema operativo';
  @override
  String get os_tooltip => TranslationOverrides.string(_root.$meta, 'os_tooltip', {}) ?? 'Copiar el nombre del sistema operativo';
  @override
  String get os_version_label => TranslationOverrides.string(_root.$meta, 'os_version_label', {}) ?? 'Versión del sistema operativo';
  @override
  String get os_version_msg =>
      TranslationOverrides.string(_root.$meta, 'os_version_msg', {}) ?? 'Versión del sistema operativo copiado al portapapeles';
  @override
  String get os_versiontooltip => TranslationOverrides.string(_root.$meta, 'os_versiontooltip', {}) ?? 'Copiar versión del sistema operativo';
  @override
  String get port_label => TranslationOverrides.string(_root.$meta, 'port_label', {}) ?? 'Puerto';
  @override
  String get port_message => TranslationOverrides.string(_root.$meta, 'port_message', {}) ?? 'Puerto copiado al portapapeles';
  @override
  String get port_tolltip => TranslationOverrides.string(_root.$meta, 'port_tolltip', {}) ?? 'Puerto de copia';
  @override
  String get qr_scan => TranslationOverrides.string(_root.$meta, 'qr_scan', {}) ?? 'Escaneo QR';
  @override
  String get qrscannot_supported =>
      TranslationOverrides.string(_root.$meta, 'qrscannot_supported', {}) ??
      'El escáner QR no es compatible con el escritorio. Conéctese manualmente.';
  @override
  String get receive_lbl => TranslationOverrides.string(_root.$meta, 'receive_lbl', {}) ?? 'Recibir';
  @override
  String get report => TranslationOverrides.string(_root.$meta, 'report', {}) ?? 'Reporte';
  @override
  String get report_a_bug => TranslationOverrides.string(_root.$meta, 'report_a_bug', {}) ?? 'Reportar un error';
  @override
  String get report_description =>
      TranslationOverrides.string(_root.$meta, 'report_description', {}) ??
      'Si encuentra algún error/problema/sugerencia, presente un informe a github issues.';
  @override
  String get rescan => TranslationOverrides.string(_root.$meta, 'rescan', {}) ?? 'Volver a escanear';
  @override
  String get scanning_network => TranslationOverrides.string(_root.$meta, 'scanning_network', {}) ?? 'Escaneando todos los dispositivos en su red';
  @override
  String get send_lbl => TranslationOverrides.string(_root.$meta, 'send_lbl', {}) ?? 'Enviar';
  @override
  String get send_state_server_stopped => TranslationOverrides.string(_root.$meta, 'send_state_server_stopped', {}) ?? 'Servidor se detuvo';
  @override
  String get setting_up_server =>
      TranslationOverrides.string(_root.$meta, 'setting_up_server', {}) ?? 'Configuración del servidor para compartir sus archivos';
  @override
  String get settings_page => TranslationOverrides.string(_root.$meta, 'settings_page', {}) ?? 'Configuración';
  @override
  String get share_info_message =>
      TranslationOverrides.string(_root.$meta, 'share_info_message', {}) ?? 'Puede acceder al servidor siguiendo la información';
  @override
  String get share_on_web => TranslationOverrides.string(_root.$meta, 'share_on_web', {}) ?? 'Compartir en la web';
  @override
  String get share_web_msg =>
      TranslationOverrides.string(_root.$meta, 'share_web_msg', {}) ??
      'Visite el siguiente enlace en un navegador para acceder a todos los archivos que compartió';
  @override
  String get show_files => TranslationOverrides.string(_root.$meta, 'show_files', {}) ?? 'Mostrar archivos';
  @override
  String get stop_sharing => TranslationOverrides.string(_root.$meta, 'stop_sharing', {}) ?? 'Deja de compartir';
  @override
  String get stop_sharing_title => TranslationOverrides.string(_root.$meta, 'stop_sharing_title', {}) ?? '¿Estás seguro de dejar de compartir?';
  @override
  String get switch_theme => TranslationOverrides.string(_root.$meta, 'switch_theme', {}) ?? 'Cambiar tema';
  @override
  String get wifi_warning => TranslationOverrides.string(_root.$meta, 'wifi_warning', {}) ?? 'Asegúrese de haber conectado al mismo wifi.';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsEs {
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
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
              n,
              zero: 'No devices found',
              one: 'Found {count} device',
              many: 'Found {count} devices',
              other: 'Found {count} devices',
            );
      case 'receive_share_files':
        return ({required num n}) =>
            TranslationOverrides.plural(_root.$meta, 'receive_share_files', {'n': n}) ??
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
              n,
              zero: 'Currently sharing no file',
              one: 'Currently sharing {count} file',
              many: 'Currently sharing {count} files',
              other: 'Currently sharing {count} files',
            );
      case 'share_files':
        return ({required num n}) =>
            TranslationOverrides.plural(_root.$meta, 'share_files', {'n': n}) ??
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
              n,
              zero: 'You are currently sharing no file',
              one: 'You are currently sharing {count} file',
              many: 'You are currently sharing {count} files',
              other: 'You are currently sharing {count} files',
            );
      case 'action_downloads':
        return TranslationOverrides.string(_root.$meta, 'action_downloads', {}) ?? 'Descargas';
      case 'action_settings':
        return TranslationOverrides.string(_root.$meta, 'action_settings', {}) ?? 'Ajustes de Aplicacion';
      case 'add_files':
        return TranslationOverrides.string(_root.$meta, 'add_files', {}) ?? 'Agregar archivos';
      case 'add_more_files':
        return TranslationOverrides.string(_root.$meta, 'add_more_files', {}) ?? 'Agrega mas archivos';
      case 'address_copied_msg':
        return TranslationOverrides.string(_root.$meta, 'address_copied_msg', {}) ?? 'Dirección copiada al portapapeles';
      case 'app_title':
        return TranslationOverrides.string(_root.$meta, 'app_title', {}) ?? 'Flutter Sharez';
      case 'cancel':
        return TranslationOverrides.string(_root.$meta, 'cancel', {}) ?? 'Cancelar';
      case 'change_language':
        return TranslationOverrides.string(_root.$meta, 'change_language', {}) ?? 'Cambiar idioma';
      case 'connect':
        return TranslationOverrides.string(_root.$meta, 'connect', {}) ?? 'Conectar';
      case 'copy_address_tooltip':
        return TranslationOverrides.string(_root.$meta, 'copy_address_tooltip', {}) ?? 'Dirección de copia';
      case 'copy_ip_message':
        return TranslationOverrides.string(_root.$meta, 'copy_ip_message', {}) ?? 'IP copiado al portapapeles';
      case 'copy_ip_tooltip':
        return TranslationOverrides.string(_root.$meta, 'copy_ip_tooltip', {}) ?? 'Copiar IP';
      case 'counter_app_bar_title':
        return TranslationOverrides.string(_root.$meta, 'counter_app_bar_title', {}) ?? 'Contador';
      case 'developed_by':
        return TranslationOverrides.string(_root.$meta, 'developed_by', {}) ?? 'Desarrollado por Shreeman Arjun \nHecho con 💙 Riverpod.';
      case 'dialog_action_no':
        return TranslationOverrides.string(_root.$meta, 'dialog_action_no', {}) ?? 'no';
      case 'dialog_action_yes':
        return TranslationOverrides.string(_root.$meta, 'dialog_action_yes', {}) ?? 'Sí';
      case 'downloads':
        return TranslationOverrides.string(_root.$meta, 'downloads', {}) ?? 'Descargas';
      case 'enter_ip':
        return TranslationOverrides.string(_root.$meta, 'enter_ip', {}) ?? 'Ingrese IP';
      case 'enter_port':
        return TranslationOverrides.string(_root.$meta, 'enter_port', {}) ?? 'Ingresar puerto';
      case 'ip_lablel':
        return TranslationOverrides.string(_root.$meta, 'ip_lablel', {}) ?? 'ip';
      case 'manually_add':
        return TranslationOverrides.string(_root.$meta, 'manually_add', {}) ?? 'Agregar manualmente';
      case 'no_devicesin_network':
        return TranslationOverrides.string(_root.$meta, 'no_devicesin_network', {}) ?? '¡No hay ningún dispositivo en la red!';
      case 'no_file_selected':
        return TranslationOverrides.string(_root.$meta, 'no_file_selected', {}) ?? 'No hay archivos seleccionados';
      case 'no_files_selected_yet':
        return TranslationOverrides.string(_root.$meta, 'no_files_selected_yet', {}) ?? 'No hay archivos seleccionados todavía';
      case 'ok':
        return TranslationOverrides.string(_root.$meta, 'ok', {}) ?? 'Bueno';
      case 'os_copy_message':
        return TranslationOverrides.string(_root.$meta, 'os_copy_message', {}) ?? 'Nombre del sistema operativo copiado al portapapeles';
      case 'os_lable':
        return TranslationOverrides.string(_root.$meta, 'os_lable', {}) ?? 'Nombre del sistema operativo';
      case 'os_tooltip':
        return TranslationOverrides.string(_root.$meta, 'os_tooltip', {}) ?? 'Copiar el nombre del sistema operativo';
      case 'os_version_label':
        return TranslationOverrides.string(_root.$meta, 'os_version_label', {}) ?? 'Versión del sistema operativo';
      case 'os_version_msg':
        return TranslationOverrides.string(_root.$meta, 'os_version_msg', {}) ?? 'Versión del sistema operativo copiado al portapapeles';
      case 'os_versiontooltip':
        return TranslationOverrides.string(_root.$meta, 'os_versiontooltip', {}) ?? 'Copiar versión del sistema operativo';
      case 'port_label':
        return TranslationOverrides.string(_root.$meta, 'port_label', {}) ?? 'Puerto';
      case 'port_message':
        return TranslationOverrides.string(_root.$meta, 'port_message', {}) ?? 'Puerto copiado al portapapeles';
      case 'port_tolltip':
        return TranslationOverrides.string(_root.$meta, 'port_tolltip', {}) ?? 'Puerto de copia';
      case 'qr_scan':
        return TranslationOverrides.string(_root.$meta, 'qr_scan', {}) ?? 'Escaneo QR';
      case 'qrscannot_supported':
        return TranslationOverrides.string(_root.$meta, 'qrscannot_supported', {}) ??
            'El escáner QR no es compatible con el escritorio. Conéctese manualmente.';
      case 'receive_lbl':
        return TranslationOverrides.string(_root.$meta, 'receive_lbl', {}) ?? 'Recibir';
      case 'report':
        return TranslationOverrides.string(_root.$meta, 'report', {}) ?? 'Reporte';
      case 'report_a_bug':
        return TranslationOverrides.string(_root.$meta, 'report_a_bug', {}) ?? 'Reportar un error';
      case 'report_description':
        return TranslationOverrides.string(_root.$meta, 'report_description', {}) ??
            'Si encuentra algún error/problema/sugerencia, presente un informe a github issues.';
      case 'rescan':
        return TranslationOverrides.string(_root.$meta, 'rescan', {}) ?? 'Volver a escanear';
      case 'scanning_network':
        return TranslationOverrides.string(_root.$meta, 'scanning_network', {}) ?? 'Escaneando todos los dispositivos en su red';
      case 'send_lbl':
        return TranslationOverrides.string(_root.$meta, 'send_lbl', {}) ?? 'Enviar';
      case 'send_state_server_stopped':
        return TranslationOverrides.string(_root.$meta, 'send_state_server_stopped', {}) ?? 'Servidor se detuvo';
      case 'setting_up_server':
        return TranslationOverrides.string(_root.$meta, 'setting_up_server', {}) ?? 'Configuración del servidor para compartir sus archivos';
      case 'settings_page':
        return TranslationOverrides.string(_root.$meta, 'settings_page', {}) ?? 'Configuración';
      case 'share_info_message':
        return TranslationOverrides.string(_root.$meta, 'share_info_message', {}) ?? 'Puede acceder al servidor siguiendo la información';
      case 'share_on_web':
        return TranslationOverrides.string(_root.$meta, 'share_on_web', {}) ?? 'Compartir en la web';
      case 'share_web_msg':
        return TranslationOverrides.string(_root.$meta, 'share_web_msg', {}) ??
            'Visite el siguiente enlace en un navegador para acceder a todos los archivos que compartió';
      case 'show_files':
        return TranslationOverrides.string(_root.$meta, 'show_files', {}) ?? 'Mostrar archivos';
      case 'stop_sharing':
        return TranslationOverrides.string(_root.$meta, 'stop_sharing', {}) ?? 'Deja de compartir';
      case 'stop_sharing_title':
        return TranslationOverrides.string(_root.$meta, 'stop_sharing_title', {}) ?? '¿Estás seguro de dejar de compartir?';
      case 'switch_theme':
        return TranslationOverrides.string(_root.$meta, 'switch_theme', {}) ?? 'Cambiar tema';
      case 'wifi_warning':
        return TranslationOverrides.string(_root.$meta, 'wifi_warning', {}) ?? 'Asegúrese de haber conectado al mismo wifi.';
      default:
        return null;
    }
  }
}
