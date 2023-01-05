import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

enum MenuOptions {
  clearCache,
  clearCoockie,
}

class WebViewPage extends StatefulWidget {
  const WebViewPage({super.key});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late WebViewController _webController;
  double varProgress = 0;
  bool isLinear = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await _webController.canGoBack()) {
          _webController.goBack();
        } else {
          log('нет записи в истории');
        }

        // stay app
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('WebView'),
          actions: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () async {
                if (await _webController.canGoBack()) {
                  _webController.goBack();
                } else {
                  log('нет записи в истории');
                }
                return;
              },
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: () async {
                if (await _webController.canGoForward()) {
                  _webController.goForward();
                } else {
                  log('нет записи в истории');
                }
                return;
              },
            ),
            IconButton(
              icon: const Icon(Icons.replay),
              onPressed: () => _webController.reload(),
            ),
            PopupMenuButton(
                onSelected: ((value) {
                  switch (value) {
                    case MenuOptions.clearCache:
                      _onClearCache(context, _webController);
                      break;

                    case MenuOptions.clearCoockie:
                      _onClearCookies(context);
                      break;
                  }
                }),
                itemBuilder: ((context) => <PopupMenuItem<MenuOptions>>[
                      const PopupMenuItem(
                          value: MenuOptions.clearCache,
                          child: Text('Очистить кеш')),
                      const PopupMenuItem(
                          value: MenuOptions.clearCoockie,
                          child: Text('Очистить печенья'))
                    ])),
          ],
        ),
        body: Column(
          children: [
            isLinear
                ? LinearProgressIndicator(
                    value: varProgress,
                    color: Colors.red,
                    backgroundColor: Colors.white,
                  )
                : Container(),
            Expanded(
              child: WebView(
                javascriptMode: JavascriptMode.unrestricted, //работа интерфейса
                initialUrl: 'https://facebook.com',
                onWebViewCreated: (controller) => _webController = controller,
                onProgress: (progress) {
                  setState(() {
                    varProgress = progress / 100;
                  });
                },
                onPageStarted: (url) {
                  if (url.contains('https://flutter.dev')) {
                    Future.delayed(const Duration(microseconds: 100), (() {
                      _webController.evaluateJavascript(
                        "document.getElementsByTagName('footer')[0].style.display='none'",
                      );
                    }));
                  }
                  isLinear = true;
                  log('новая страница $url');
                },
                onPageFinished: (url) {
                  isLinear = false;
                  log('страница загружена');
                },
                navigationDelegate: (navigation) {
                  if (navigation.url.startsWith('https://m.youtube.com')) {
                    log('навигация заблокирована к $navigation');
                    return NavigationDecision.prevent; //блок к доступу сайта
                  }
                  log('навигация разрешена к $navigation');
                  return NavigationDecision.navigate;
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.next_plan, size: 32),
          onPressed: () async {
            // _webController.evaluateJavascript(
            //   "document.getElementsByTagName('footer')[0].style.display='none'",
            // );
            // _webController.loadUrl('https://www.youtube.com');
          },
        ),
      ),
    );
  }

  void _onClearCookies(BuildContext context) async {
    final bool hadCookies = await CookieManager().clearCookies();
    String message = 'Cookies deleted';
    if (!hadCookies) {
      message = 'кукесы уже очищены';
    }
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _onClearCache(BuildContext context, WebViewController controller) async {
    await _webController.clearCache();
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Кэш очищен')));
  }
}
