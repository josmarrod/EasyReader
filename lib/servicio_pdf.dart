import 'dart:io';
import 'package:path_provider/path_provider.dart';  // Asegúrate de importar path_provider
import 'package:pdf/widgets.dart' as pw;

Future<String> crearPDFResaltado(String rutaPdfOriginal) async {
  final documento = pw.Document();
  documento.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Center(
          child: pw.Text("Hola Mundo!"),
        );
      },
    ),
  );

  final directory = await getApplicationDocumentsDirectory(); // Obtener una ruta válida para guardar el archivo
  final outputPdfPath = '${directory.path}/mi_pdf_modificado.pdf';
  final archivo = File(outputPdfPath);
  await archivo.writeAsBytes(await documento.save());
  return archivo.path;
}
