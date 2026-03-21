// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart' hide AppLocaleUtils;
import 'package:flutter_sharez/core/theme/shad_theme.dart';
import 'package:flutter_sharez/core/router/auto_route_observer.dart';
import 'package:flutter_sharez/core/router/router_pod.dart';
import 'package:flutter_sharez/core/theme/app_theme.dart';
import 'package:flutter_sharez/core/theme/app_theme_pod.dart';
import 'package:flutter_sharez/i18n/strings.g.dart';

import 'package:flutter_sharez/app/wrapper/app_wrapper.dart';
import 'package:flutter_sharez/shared/helper/global_helper.dart';
import 'package:flutter_sharez/shared/widget/responsive_wrapper.dart';
import 'package:flutter_sharez/translation_pod.dart';

import 'package:responsive_framework/responsive_framework.dart';

/// Global wrapper that integrates Responsive Framework scaling with Shadcn UI breakpoint detection
class GlobalShadResponsiveWrapper extends StatelessWidget {
  final Widget child;

  const GlobalShadResponsiveWrapper({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveBreakpoints.builder(
      child: ShadResponsiveProxyWrapper(child: child),
      breakpoints: [
        const Breakpoint(
            start: 0, end: 639, name: MOBILE), // TN + SM range (0-639px)
        const Breakpoint(
            start: 640, end: 1023, name: TABLET), // MD + LG range (640-1023px)
        const Breakpoint(
            start: 1024,
            end: 1535,
            name: DESKTOP), // XL + XXL range (1024-1535px)
        const Breakpoint(start: 1536, end: double.infinity, name: '4K'),
      ],
    );
  }
}

/// Proxy wrapper that ensures ShadResponsiveBuilder gets proper breakpoint context
class ShadResponsiveProxyWrapper extends StatelessWidget {
  final Widget child;

  const ShadResponsiveProxyWrapper({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ResponsiveBreakPointWrapper(
          firstFrameWidget: Container(color: Colors.white),
          child: child,
        );
      },
    );
  }
}

///This class holds Material App or Router with routing, theming and locale setup.
class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> with GlobalHelper {
  @override
  Widget build(BuildContext context) {
    final approuter = ref.watch(autorouterProvider);
    final themeMode = ref.watch(themeModePod);
    final accent = ref.watch(themeAccentPod);

    return ShadApp.router(
      debugShowCheckedModeBanner: false,
      title: 'flutter_sharez App',
      themeMode: themeMode,
      materialThemeBuilder: (context, theme) {
        return theme.brightness == Brightness.light
            ? Themes.theme(accent.scheme)
            : Themes.darkTheme(accent.scheme);
      },
      theme: AppShadTheme.light(),
      darkTheme: AppShadTheme.dark(),
      routerConfig: approuter.config(
        navRestorationScopeId: "app",
        placeholder: (context) => const SizedBox.shrink(),
        navigatorObservers: () => [RouterObserver()],
        includePrefixMatches: true,
        rebuildStackOnDeepLink: true,
      ),
      locale: ref.watch(translationsPod).$meta.locale.flutterLocale,
      supportedLocales: AppLocaleUtils.supportedLocales,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      builder: (context, child) => AppWrapper(
        currentTheme: themeMode,
        child: child ?? const SizedBox.shrink(),
      ),
    );
  }
}
