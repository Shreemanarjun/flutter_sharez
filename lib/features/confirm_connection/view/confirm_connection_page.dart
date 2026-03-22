import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sharez/data/model/receiver_model.dart';
import 'package:flutter_sharez/shared/widget/os_logo.dart';

@RoutePage(
  deferredLoading: true,
)
class ConfirmConnectionDialogPage extends StatelessWidget {
  const ConfirmConnectionDialogPage({
    super.key,
    required this.receiverModel,
    required this.onCofirmation,
    this.isConfirmingReceiver = true,
  });

  final ReceiverModel receiverModel;
  final bool isConfirmingReceiver;

  final void Function(bool) onCofirmation;
  @override
  Widget build(BuildContext context) {
    final label = isConfirmingReceiver ? "Receiver" : "Sender";
    return Padding(
        padding: const EdgeInsets.all(40.0),
        child: AlertDialog(
          title: Center(
            child: Text(
              'Confirm $label',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyMedium,
                      children: [
                        TextSpan(text: "$label Name: "),
                        TextSpan(
                          text: receiverModel.host,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                OSLogo(os: receiverModel.os),
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyMedium,
                      children: [
                        TextSpan(text: "$label IP: "),
                        TextSpan(
                          text: receiverModel.ip,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyMedium,
                      children: [
                        TextSpan(text: "$label Port: "),
                        TextSpan(
                          text: receiverModel.port.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyMedium,
                      children: [
                        TextSpan(text: "$label OS: "),
                        TextSpan(
                          text: receiverModel.os,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyMedium,
                      children: [
                        TextSpan(text: "$label Version: \n"),
                        TextSpan(
                          text: receiverModel.version,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    "want to connect with you",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                onCofirmation(true);
              },
              child: const Text(
                "Accept",
                style: TextStyle(color: Colors.green),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                onCofirmation(false);
              },
              child: const Text(
                "Reject",
                style: TextStyle(color: Colors.red),
              ),
            )
          ],
        ),
    );
  }
}
