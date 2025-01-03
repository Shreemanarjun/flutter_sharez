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
class TranslationsEs implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsEs({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
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

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsEs {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'locale_en': return 'English';
			case 'locale_es': return 'Español';
			case 'locale_or': return 'Odia';
			case 'foundDevices': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				zero: 'No devices found',
				one: 'Found ${n} device',
				many: 'Found ${n} devices',
				other: 'Found ${n} devices',
			);
			case 'receiveShareFiles': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				zero: 'Currently sharing no file',
				one: 'Currently sharing ${n} file',
				many: 'Currently sharing ${n} files',
				other: 'Currently sharing ${n} files',
			);
			case 'shareFiles': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
				zero: 'You are currently sharing no file',
				one: 'You are currently sharing ${n} file',
				many: 'You are currently sharing ${n} files',
				other: 'You are currently sharing ${n} files',
			);
			case 'actionDownloads': return 'Descargas';
			case 'actionSettings': return 'Ajustes de Aplicacion';
			case 'addFiles': return 'Agregar archivos';
			case 'addMoreFiles': return 'Agrega mas archivos';
			case 'addressCopiedMsg': return 'Dirección copiada al portapapeles';
			case 'appTitle': return 'Flutter Sharez';
			case 'cancel': return 'Cancelar';
			case 'changeLanguage': return 'Cambiar idioma';
			case 'connect': return 'Conectar';
			case 'copyAddressTooltip': return 'Dirección de copia';
			case 'copyIpMessage': return 'IP copiado al portapapeles';
			case 'copyIpTooltip': return 'Copiar IP';
			case 'counterAppBarTitle': return 'Contador';
			case 'developedBy': return 'Desarrollado por Shreeman Arjun \nHecho con 💙 Riverpod.';
			case 'dialogActionNo': return 'no';
			case 'dialogActionYes': return 'Sí';
			case 'downloads': return 'Descargas';
			case 'enterIp': return 'Ingrese IP';
			case 'enterPort': return 'Ingresar puerto';
			case 'ipLablel': return 'ip';
			case 'manuallyAdd': return 'Agregar manualmente';
			case 'noDevicesinNetwork': return '¡No hay ningún dispositivo en la red!';
			case 'noFileSelected': return 'No hay archivos seleccionados';
			case 'noFilesSelectedYet': return 'No hay archivos seleccionados todavía';
			case 'ok': return 'Bueno';
			case 'osCopyMessage': return 'Nombre del sistema operativo copiado al portapapeles';
			case 'osLable': return 'Nombre del sistema operativo';
			case 'osTooltip': return 'Copiar el nombre del sistema operativo';
			case 'osVersionLabel': return 'Versión del sistema operativo';
			case 'osVersionMsg': return 'Versión del sistema operativo copiado al portapapeles';
			case 'osVersiontooltip': return 'Copiar versión del sistema operativo';
			case 'portLabel': return 'Puerto';
			case 'portMessage': return 'Puerto copiado al portapapeles';
			case 'portTolltip': return 'Puerto de copia';
			case 'qrScan': return 'Escaneo QR';
			case 'qrscannotSupported': return 'El escáner QR no es compatible con el escritorio. Conéctese manualmente.';
			case 'receiveLbl': return 'Recibir';
			case 'report': return 'Reporte';
			case 'reportABug': return 'Reportar un error';
			case 'reportDescription': return 'Si encuentra algún error/problema/sugerencia, presente un informe a github issues.';
			case 'rescan': return 'Volver a escanear';
			case 'scanningNetwork': return 'Escaneando todos los dispositivos en su red';
			case 'sendLbl': return 'Enviar';
			case 'sendStateServerStopped': return 'Servidor se detuvo';
			case 'settingUpServer': return 'Configuración del servidor para compartir sus archivos';
			case 'settingsPage': return 'Configuración';
			case 'shareInfoMessage': return 'Puede acceder al servidor siguiendo la información';
			case 'shareOnWeb': return 'Compartir en la web';
			case 'shareWebMsg': return 'Visite el siguiente enlace en un navegador para acceder a todos los archivos que compartió';
			case 'showFiles': return 'Mostrar archivos';
			case 'stopSharing': return 'Deja de compartir';
			case 'stopSharingTitle': return '¿Estás seguro de dejar de compartir?';
			case 'switchTheme': return 'Cambiar tema';
			case 'wifiWarning': return 'Asegúrese de haber conectado al mismo wifi.';
			default: return null;
		}
	}
}

