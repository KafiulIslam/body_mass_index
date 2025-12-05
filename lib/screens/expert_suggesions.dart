import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../common/custom_appbar.dart';
import '../common/custom_orientation_builder.dart';

class ExpertSuggestion extends StatefulWidget {
  final String consultantUrl;
  const ExpertSuggestion({Key? key, required this.consultantUrl}) : super(key: key);

  @override
  State<ExpertSuggestion> createState() => _ExpertSuggestionState();
}

class _ExpertSuggestionState extends State<ExpertSuggestion> {
  late final WebViewController _controller;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    
    // Initialize WebViewController for webview_flutter 4.x
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Progress tracking if needed in the future
          },
          onPageStarted: (String url) {
            setState(() {
              isLoading = true;
            });
            // Uncomment if you want to run JavaScript to hide header/footer
            // _controller.runJavaScript(
            //     "document.getElementsByTagName('header')[0].style.display='none'");
            // _controller.runJavaScript(
            //     "document.getElementsByTagName('footer')[0].style.display='none'");
            // _controller.runJavaScriptReturningResult(
            //     ("javascript:(function() { " +
            //         "var head = document.getElementsByTagName('header')[0];" +
            //         "head.parentNode.removeChild(head);" +
            //         "var footer = document.getElementsByTagName('footer')[0];" +
            //         "footer.parentNode.removeChild(footer);" +
            //         "})()")
            // ).then((value) =>
            //     debugPrint('header is deleting'))
            //     .catchError((onError) => debugPrint('$onError'));
          },
          onPageFinished: (String url) {
            setState(() {
              isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('WebView error: ${error.description}');
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.consultantUrl));
  }

  @override
  Widget build(BuildContext context) {
    return CustomOrientationBuilder(
      portrait: Scaffold(
        appBar: const CustomAppBar(title: 'Consultancy'),
        body: Stack(
          children: [
            WebViewWidget(controller: _controller),
            if (isLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
      landscape: Scaffold(
        appBar: const CustomAppBar(title: 'Consultancy'),
        body: Stack(
          children: [
            WebViewWidget(controller: _controller),
            if (isLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
