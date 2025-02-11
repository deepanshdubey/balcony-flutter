
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

@RoutePage()
class WebViewPage extends StatelessWidget {
  final String url;
  final String? title;

  const WebViewPage({Key? key, required this.url,  this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller =  WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},

        ),
      )
      ..loadRequest(Uri.parse(url));


    return Scaffold(
      appBar: AppBar(
        title:  Text( title ?? "Web View"),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
