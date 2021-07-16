import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {
  final String url;
  final String name;

  WebViewScreen(this.url,this.name);

  @override
  Widget build(BuildContext context) {
    var index = name.indexOf('.');
    var title = name.substring(0,index);
    return Scaffold(
      appBar: AppBar(
        title: Text('$title'),
      ),
      body: WebView(
        initialUrl: url,
      ),
    );
  }
}
