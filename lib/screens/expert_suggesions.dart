import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../common/custom_appbar.dart';
import '../common/custom_orientation_builder.dart';
import '../constant/color.dart';
import '../constant/pixel_ratio.dart';

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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final heightRatio = MediaQuery.of(context).size.height;
    final widthRatio = MediaQuery.of(context).size.width;

    return CustomOrientationBuilder(
        portrait: SafeArea(
          child: Scaffold(
            appBar: const CustomAppBar(title: 'Consultancy',),
            body: isLoading == true ? const Center(child: CircularProgressIndicator()) :
            WebView(
                    javascriptMode: JavascriptMode.unrestricted,
                      initialUrl: widget.consultantUrl,
                    onWebViewCreated: (controller) {
                      _webViewController = controller;
                      _controller.complete(controller);
                    },
              onProgress: (int progress) {},
              onPageStarted: (String url) {
                _webViewController.runJavascript(
                    "document.getElementsByTagName('header')[0].style.display='none'");
                _webViewController.runJavascript(
                    "document.getElementsByTagName('footer')[0].style.display='none'");
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
        ),
        landscape: SafeArea(
          child: Scaffold(
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
                _webViewController
                    .runJavascriptReturningResult(
                  // "javascript:(function() { var head = document.getElementsByTagName('header')[0];head.parentNode.removeChild(head);var footer = document.getElementsByTagName('footer')[0];footer.parentNode.removeChild(footer);})()"
                    "document.getElementsByTagName('header')[0].style.display='none'"
                ).then((value) =>
                    debugPrint('header is deleting'))
                    .catchError((onError) => debugPrint('$onError'));
                print('Page started loading');
              },
              onPageFinished: (String url) {
                print('Page finished loading: $url');
              },
            ),
          ),
        ));
  }
}
