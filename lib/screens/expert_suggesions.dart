import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../common/custom_appbar.dart';
import '../common/custom_orientation_builder.dart';

class ExpertSuggestion extends StatefulWidget {
  final String consultantUrl;
  const ExpertSuggestion({Key? key,required this.consultantUrl}) : super(key: key);

  @override
  State<ExpertSuggestion> createState() => _ExpertSuggestionState();
}

class _ExpertSuggestionState extends State<ExpertSuggestion> {

  final Completer<WebViewController> _controller =
  Completer<WebViewController>();
  late WebViewController _webViewController;
  late bool isLoading = false;
  late int _progress = 0;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return CustomOrientationBuilder(
        portrait: Scaffold(
          appBar: const CustomAppBar(title: 'Consultancy',),
          body: WebView(
                  javascriptMode: JavascriptMode.unrestricted,
                    initialUrl: widget.consultantUrl,
                  onWebViewCreated: (controller) {
                    _webViewController = controller;
                    _controller.complete(controller);
                  },
            onProgress: (int progress) {},
            onPageStarted: (String url) {
              // _webViewController.runJavascript(
              //     "document.getElementsByTagName('header')[0].style.display='none'");
              // _webViewController.runJavascript(
              //     "document.getElementsByTagName('footer')[0].style.display='none'");
              // _webViewController
              //     .runJavascriptReturningResult(
              //     ("javascript:(function() { " +
              //         "var head = document.getElementsByTagName('header')[0];" +
              //         "head.parentNode.removeChild(head);" +
              //         "var footer = document.getElementsByTagName('footer')[0];" +
              //         "footer.parentNode.removeChild(footer);" +
              //         "})()")
              //      // "document.getElementsByTagName('header')[0].style.display='none'"
              // ).then((value) =>
              //     debugPrint('header is deleting'))
              //     .catchError((onError) => debugPrint('$onError'));
              },
            onPageFinished: (String url) {},
                ),
        ),
        landscape: Scaffold(
          appBar: const CustomAppBar(title: 'Consultancy',),
          body: isLoading == true ? const Center(child: CircularProgressIndicator()) : WebView(
            javascriptMode: JavascriptMode.unrestricted,
            initialUrl: widget.consultantUrl,
            onWebViewCreated: (controller) {
              _webViewController = controller;
              _controller.complete(controller);
            },
            onProgress: (int progress) {

            },
            onPageStarted: (String url) {
              // _webViewController
              //     .runJavascriptReturningResult(
              //      "document.getElementsByTagName('header')[0].style.display='none'"
              // ).then((value) =>
              //     debugPrint('header is deleting'))
              //     .catchError((onError) => debugPrint('$onError'));

            },
            onPageFinished: (String url) {},
          ),
        ));
  }
}
