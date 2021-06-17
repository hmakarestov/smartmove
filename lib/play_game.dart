import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PlayGame extends StatelessWidget {
  final String url;

  PlayGame({@required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: WebView(
      initialUrl: this.url,
      javascriptMode: JavascriptMode.unrestricted,
    ));
  }
}
