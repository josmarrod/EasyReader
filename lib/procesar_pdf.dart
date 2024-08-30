import 'dart:io';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:path_provider/path_provider.dart';

Future<String> procesarPdf(String rutaPdfOriginal) async {
  // Lee el archivo PDF original
  final PdfDocument document = PdfDocument(inputBytes: File(rutaPdfOriginal).readAsBytesSync());

  // Recorre las páginas del PDF
  for (int i = 0; i < document.pages.count; i++) {
    final PdfPage page = document.pages[i];
    final PdfTextExtractor extractor = PdfTextExtractor(page);
    final String text = extractor.extractText();

    // Procesa el texto para resaltar las primeras letras
    final List<String> lines = text.split('\n');
    final PdfGraphics graphics = page.graphics;
    final PdfFont font = PdfStandardFont(PdfFontFamily.helvetica, 12);
    final PdfBrush normalBrush = PdfSolidBrush(PdfColor(0, 0, 0));
    final PdfBrush boldBrush = PdfSolidBrush(PdfColor(255, 0, 0));  // Cambié el color a rojo para mejor visibilidad
    double y = 0;

    for (String line in lines) {
      final List<String> words = line.split(' ');
      double x = 0;

      for (String word in words) {
        PdfTextElement textElement;
        if (word.length > 4) {
          textElement = PdfTextElement(
            text: word.substring(0, 3),
            font: PdfStandardFont(PdfFontFamily.helvetica, 12, style: PdfFontStyle.bold),
            brush: boldBrush,
          );
          textElement.draw(graphics: graphics, bounds: Rect.fromLTWH(x, y, 0, 0));
          x += textElement.size.width;

          textElement = PdfTextElement(
            text: word.substring(3) + ' ',
            font: font,
            brush: normalBrush,
          );
        } else if (word.length == 4) {
          textElement = PdfTextElement(
            text: word.substring(0, 2),
            font: PdfStandardFont(PdfFontFamily.helvetica, 12, style: PdfFontStyle.bold),
            brush: boldBrush,
          );
          textElement.draw(graphics: graphics, bounds: Rect.fromLTWH(x, y, 0, 0));
          x += textElement.size.width;

          textElement = PdfTextElement(
            text: word.substring(2) + ' ',
            font: font,
            brush: normalBrush,
          );
        } else if (word.isNotEmpty) {
          textElement = PdfTextElement(
            text: word[0],
            font: PdfStandardFont(PdfFontFamily.helvetica, 12, style: PdfFontStyle.bold),
            brush: boldBrush,
          );
          textElement.draw(graphics: graphics, bounds: Rect.fromLTWH(x, y, 0, 0));
          x += textElement.size.width;

          textElement = PdfTextElement(
            text: word.substring(1) + ' ',
            font: font,
            brush: normalBrush,
          );
        } else {
          textElement = PdfTextElement(
            text: word + ' ',
            font: font,
            brush: normalBrush,
          );
        }
        textElement.draw(graphics: graphics, bounds: Rect.fromLTWH(x, y, 0, 0));
        x += textElement.size.width;
      }
      y += 15;
    }
  }

  final Directory outputDir = await getTemporaryDirectory();
  final String outputPdfPath = '${outputDir.path}/mi_pdf_modificado.pdf';
  final File outputFile = File(outputPdfPath);
  await outputFile.writeAsBytes(await document.save());

  document.dispose();
  return outputPdfPath;
}
