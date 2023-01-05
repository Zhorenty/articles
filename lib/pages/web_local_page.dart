import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class WebViewLocalPage extends StatefulWidget {
  const WebViewLocalPage({super.key});

  @override
  State<WebViewLocalPage> createState() => _WebViewLocalPageState();
}

class _WebViewLocalPageState extends State<WebViewLocalPage> {
  late WebViewPlusController _webController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('WebView Local'),
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: WebViewPlus(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: 'assets/index.html',
          onWebViewCreated: ((controller) {
            _webController = controller;
            // loadLocalHTML();
          }),
          javascriptChannels: {
            JavascriptChannel(
                name: 'MyJSChannel',
                onMessageReceived: (message) async {
                  log('JavaScript: ${message.message}');
                  await showDialog(
                      context: context,
                      builder: ((context) {
                        return AlertDialog(
                          content: Text(message.message),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  _webController.webViewController
                                      .evaluateJavascript('sendOK()');
                                  Navigator.pop(context);
                                },
                                child: Text('базар'))
                          ],
                        );
                      }));
                }),
          }),
    );
  }

  void loadLocalHTML() async {
    final html = await rootBundle.loadString('assets/index.html');
    final url = Uri.dataFromString(
      html,
      mimeType: 'text/html',
      encoding: Encoding.getByName('utf-8'),
    ).toString();

    _webController.loadUrl(url);
  }

  // final html = '''<!DOCTYPE html>
  // <html>
  // <body>

  // <h1>This is heading 1</h1>
  // <h2>This is heading 2</h2>
  // <h3>This is heading 3</h3>
  // <h4>This is heading 4</h4>
  // <h5>This is heading 5</h5>
  // <h6>This is heading 6</h6>

  // </body>
  // </html>''';
}
