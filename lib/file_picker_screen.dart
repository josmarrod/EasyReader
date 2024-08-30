import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'procesar_pdf.dart';
import 'visor_pdf_widget.dart';

class FilePickerScreen extends StatefulWidget {
  @override
  _FilePickerScreenState createState() => _FilePickerScreenState();
}

class _FilePickerScreenState extends State<FilePickerScreen> {
  bool _isProcessing = false;

  Future<void> _pickFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null) {
        setState(() {
          _isProcessing = true;
        });

        final filePath = result.files.single.path!;
        final processedFilePath = await procesarPdf(filePath);

        setState(() {
          _isProcessing = false;
        });

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VisorPDFWidget(rutaPdf: processedFilePath),
          ),
        );
      } else {
        print("Selección de archivo cancelada");
      }
    } catch (e) {
      print('Error al seleccionar archivo: $e');
      setState(() {
        _isProcessing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Importar PDF'),
      ),
      body: Center(
        child: _isProcessing
            ? CircularProgressIndicator()
            : ElevatedButton(
                onPressed: _pickFile,
                child: Text('Seleccionar PDF'),
              ),
      ),
    );
  }
}
