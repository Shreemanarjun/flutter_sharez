import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter_sharez/i18n/translations.g.dart';
import 'package:flutter_sharez/translation_pod.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage(
  deferredLoading: true,
)
class DownloadsPage extends ConsumerWidget {
  const DownloadsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = ref.watch(translationsPod);
    return Scaffold(
      appBar: AppBar(
        title: t.downloads.text.make(),
      ),
      body: ListView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.all(8),
        children: [
          ListTile(
            title: "Change".text.make(),
            onTap: () async {
              Translations t2 = await AppLocaleUtils.buildWithOverridesFromMap(
                locale: AppLocaleUtils.parse("or"),
                isFlatMap: false,
                map: {
                  t.action_downloads: "action download",
                  t.downloads: 'updated transladsdtdsad',
                },
              );
              ref.read(translationsPod.notifier).update(
                    (state) => t2,
                  );
            },
          )
        ],
      ),
    );
  }
}
