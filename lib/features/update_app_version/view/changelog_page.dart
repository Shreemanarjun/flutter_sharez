import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/bootstrap.dart';
import 'package:flutter_sharez/data/model/update_model.dart';
import 'package:flutter_sharez/features/update_app_version/controller/get_changelog_pod.dart';
import 'package:flutter_sharez/shared/riverpod_ext/asynvalue_easy_when.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage(
  deferredLoading: true,
)
class ChangelogPage extends StatefulWidget {
  final UpdateModel? updateModel;
  const ChangelogPage({super.key, required this.updateModel});

  @override
  State<ChangelogPage> createState() => _ChangelogPageState();
}

class _ChangelogPageState extends State<ChangelogPage> {
  void downloadApp(final assetURl) async {
    final uri = Uri.parse(assetURl);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $uri');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Consumer(
        builder: (context, ref, child) {
          final changelogs = ref.watch(getChangeLogPod);
          return changelogs.easyWhen(
            data: (data) => <Widget>[
              if (widget.updateModel != null)
                "A new update available \n🎉 ${widget.updateModel?.name}"
                    .text
                    .bold
                    .xl2
                    .amber500
                    .center
                    .make()
                    .p12()
              else
                "No updates available for now !"
                    .text
                    .bold
                    .xl2
                    .center
                    .amber500
                    .make()
                    .p12(),
              if (widget.updateModel != null)
                <Widget>[
                  FilledButton(
                    onPressed: () {
                      talker.debug(widget.updateModel);
                      downloadApp(widget.updateModel?.html_url.toString());
                    },
                    child: "Download".text.make(),
                  ),
                  FilledButton(
                    onPressed: () {
                      context.back();
                    },
                    child: "Cancel".text.make(),
                  ),
                ]
                    .hStack(
                      alignment: MainAxisAlignment.spaceAround,
                    )
                    .p16()
              else
                FilledButton(
                  onPressed: () {
                    context.back();
                  },
                  child: "Cancel".text.make(),
                ),
              "Changelogs".text.bold.xl3.make(),
              Markdown(
                data: data,
                physics: const ClampingScrollPhysics(),
              ).expand(),
            ]
                .vStack(
                  axisSize: MainAxisSize.min,
                )
                .p12(),
            onRetry: () {
              ref.invalidate(getChangeLogPod);
            },
          );
        },
      ),
    );
  }
}
