import 'package:flutter/material.dart';
import 'file_picker_screen.dart';  // Asegúrate de crear este archivo y de importarlo aquí

class PantallaInicio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/logo.png'), // Añade tu logo en la carpeta de assets
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FilePickerScreen()),
              ),
              child: Text('Importar Archivo'),
            ),
          ],
        ),
      ),
    );
  }
}
