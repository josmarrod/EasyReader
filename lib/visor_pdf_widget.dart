import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class VisorPDFWidget extends StatelessWidget {
  final String rutaPdf;

  VisorPDFWidget({required this.rutaPdf});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Documento PDF')),
      body: PDFView(
        filePath: rutaPdf,
        autoSpacing: false,
        enableSwipe: true,
        swipeHorizontal: false,
        pageFling: true,
        pageSnap: true,
        onError: (error) {
          print("Error al cargar el PDF: $error");
        },
        onRender: (_pages) {
          print("PDF Renderizado con $_pages páginas");
        },
      ),
    );
  }
}
