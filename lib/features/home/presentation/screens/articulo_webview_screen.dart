import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticuloWebviewScreen extends StatefulWidget {
  final String titulo;
  final String url;

  const ArticuloWebviewScreen({
    super.key,
    required this.titulo,
    required this.url,
  });

  @override
  State<ArticuloWebviewScreen> createState() => _ArticuloWebviewScreenState();
}

class _ArticuloWebviewScreenState extends State<ArticuloWebviewScreen> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.titulo),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}