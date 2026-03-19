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
class TranslationsEs with BaseTranslations<AppLocale, Translations> implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsEs({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.es,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <es>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsEs _root = this; // ignore: unused_field

	@override 
	TranslationsEs $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsEs(meta: meta ?? this.$meta);

	// Translations
	@override String get locale_en => 'English';
	@override String get locale_es => 'Español';
	@override String get locale_or => 'Odia';
	@override String foundDevices({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		zero: 'No devices found',
		one: 'Found ${n} device',
		many: 'Found ${n} devices',
		other: 'Found ${n} devices',
	);
	@override String receiveShareFiles({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		zero: 'Currently sharing no file',
		one: 'Currently sharing ${n} file',
		many: 'Currently sharing ${n} files',
		other: 'Currently sharing ${n} files',
	);
	@override String shareFiles({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		zero: 'You are currently sharing no file',
		one: 'You are currently sharing ${n} file',
		many: 'You are currently sharing ${n} files',
		other: 'You are currently sharing ${n} files',
	);
	@override String get actionDownloads => 'Descargas';
	@override String get actionSettings => 'Ajustes de Aplicacion';
	@override String get addFiles => 'Agregar archivos';
	@override String get addMoreFiles => 'Agrega mas archivos';
	@override String get addressCopiedMsg => 'Dirección copiada al portapapeles';
	@override String get appTitle => 'Flutter Sharez';
	@override String get cancel => 'Cancelar';
	@override String get changeLanguage => 'Cambiar idioma';
	@override String get connect => 'Conectar';
	@override String get copyAddressTooltip => 'Dirección de copia';
	@override String get copyIpMessage => 'IP copiado al portapapeles';
	@override String get copyIpTooltip => 'Copiar IP';
	@override String get counterAppBarTitle => 'Contador';
	@override String get developedBy => 'Desarrollado por Shreeman Arjun \nHecho con 💙 Riverpod.';
	@override String get dialogActionNo => 'no';
	@override String get dialogActionYes => 'Sí';
	@override String get downloads => 'Descargas';
	@override String get enterIp => 'Ingrese IP';
	@override String get enterPort => 'Ingresar puerto';
	@override String get ipLablel => 'ip';
	@override String get manuallyAdd => 'Agregar manualmente';
	@override String get noDevicesinNetwork => '¡No hay ningún dispositivo en la red!';
	@override String get noFileSelected => 'No hay archivos seleccionados';
	@override String get noFilesSelectedYet => 'No hay archivos seleccionados todavía';
	@override String get ok => 'Bueno';
	@override String get osCopyMessage => 'Nombre del sistema operativo copiado al portapapeles';
	@override String get osLable => 'Nombre del sistema operativo';
	@override String get osTooltip => 'Copiar el nombre del sistema operativo';
	@override String get osVersionLabel => 'Versión del sistema operativo';
	@override String get osVersionMsg => 'Versión del sistema operativo copiado al portapapeles';
	@override String get osVersiontooltip => 'Copiar versión del sistema operativo';
	@override String get portLabel => 'Puerto';
	@override String get portMessage => 'Puerto copiado al portapapeles';
	@override String get portTolltip => 'Puerto de copia';
	@override String get qrScan => 'Escaneo QR';
	@override String get qrscannotSupported => 'El escáner QR no es compatible con el escritorio. Conéctese manualmente.';
	@override String get receiveLbl => 'Recibir';
	@override String get report => 'Reporte';
	@override String get reportABug => 'Reportar un error';
	@override String get reportDescription => 'Si encuentra algún error/problema/sugerencia, presente un informe a github issues.';
	@override String get rescan => 'Volver a escanear';
	@override String get scanningNetwork => 'Escaneando todos los dispositivos en su red';
	@override String get sendLbl => 'Enviar';
	@override String get sendStateServerStopped => 'Servidor se detuvo';
	@override String get settingUpServer => 'Configuración del servidor para compartir sus archivos';
	@override String get settingsPage => 'Configuración';
	@override String get shareInfoMessage => 'Puede acceder al servidor siguiendo la información';
	@override String get shareOnWeb => 'Compartir en la web';
	@override String get shareWebMsg => 'Visite el siguiente enlace en un navegador para acceder a todos los archivos que compartió';
	@override String get showFiles => 'Mostrar archivos';
	@override String get stopSharing => 'Deja de compartir';
	@override String get stopSharingTitle => '¿Estás seguro de dejar de compartir?';
	@override String get switchTheme => 'Cambiar tema';
	@override String get wifiWarning => 'Asegúrese de haber conectado al mismo wifi.';
}

/// The flat map containing all translations for locale <es>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsEs {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'locale_en' => 'English',
			'locale_es' => 'Español',
			'locale_or' => 'Odia',
			'foundDevices' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, zero: 'No devices found', one: 'Found ${n} device', many: 'Found ${n} devices', other: 'Found ${n} devices', ), 
			'receiveShareFiles' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, zero: 'Currently sharing no file', one: 'Currently sharing ${n} file', many: 'Currently sharing ${n} files', other: 'Currently sharing ${n} files', ), 
			'shareFiles' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, zero: 'You are currently sharing no file', one: 'You are currently sharing ${n} file', many: 'You are currently sharing ${n} files', other: 'You are currently sharing ${n} files', ), 
			'actionDownloads' => 'Descargas',
			'actionSettings' => 'Ajustes de Aplicacion',
			'addFiles' => 'Agregar archivos',
			'addMoreFiles' => 'Agrega mas archivos',
			'addressCopiedMsg' => 'Dirección copiada al portapapeles',
			'appTitle' => 'Flutter Sharez',
			'cancel' => 'Cancelar',
			'changeLanguage' => 'Cambiar idioma',
			'connect' => 'Conectar',
			'copyAddressTooltip' => 'Dirección de copia',
			'copyIpMessage' => 'IP copiado al portapapeles',
			'copyIpTooltip' => 'Copiar IP',
			'counterAppBarTitle' => 'Contador',
			'developedBy' => 'Desarrollado por Shreeman Arjun \nHecho con 💙 Riverpod.',
			'dialogActionNo' => 'no',
			'dialogActionYes' => 'Sí',
			'downloads' => 'Descargas',
			'enterIp' => 'Ingrese IP',
			'enterPort' => 'Ingresar puerto',
			'ipLablel' => 'ip',
			'manuallyAdd' => 'Agregar manualmente',
			'noDevicesinNetwork' => '¡No hay ningún dispositivo en la red!',
			'noFileSelected' => 'No hay archivos seleccionados',
			'noFilesSelectedYet' => 'No hay archivos seleccionados todavía',
			'ok' => 'Bueno',
			'osCopyMessage' => 'Nombre del sistema operativo copiado al portapapeles',
			'osLable' => 'Nombre del sistema operativo',
			'osTooltip' => 'Copiar el nombre del sistema operativo',
			'osVersionLabel' => 'Versión del sistema operativo',
			'osVersionMsg' => 'Versión del sistema operativo copiado al portapapeles',
			'osVersiontooltip' => 'Copiar versión del sistema operativo',
			'portLabel' => 'Puerto',
			'portMessage' => 'Puerto copiado al portapapeles',
			'portTolltip' => 'Puerto de copia',
			'qrScan' => 'Escaneo QR',
			'qrscannotSupported' => 'El escáner QR no es compatible con el escritorio. Conéctese manualmente.',
			'receiveLbl' => 'Recibir',
			'report' => 'Reporte',
			'reportABug' => 'Reportar un error',
			'reportDescription' => 'Si encuentra algún error/problema/sugerencia, presente un informe a github issues.',
			'rescan' => 'Volver a escanear',
			'scanningNetwork' => 'Escaneando todos los dispositivos en su red',
			'sendLbl' => 'Enviar',
			'sendStateServerStopped' => 'Servidor se detuvo',
			'settingUpServer' => 'Configuración del servidor para compartir sus archivos',
			'settingsPage' => 'Configuración',
			'shareInfoMessage' => 'Puede acceder al servidor siguiendo la información',
			'shareOnWeb' => 'Compartir en la web',
			'shareWebMsg' => 'Visite el siguiente enlace en un navegador para acceder a todos los archivos que compartió',
			'showFiles' => 'Mostrar archivos',
			'stopSharing' => 'Deja de compartir',
			'stopSharingTitle' => '¿Estás seguro de dejar de compartir?',
			'switchTheme' => 'Cambiar tema',
			'wifiWarning' => 'Asegúrese de haber conectado al mismo wifi.',
			_ => null,
		};
	}
}
