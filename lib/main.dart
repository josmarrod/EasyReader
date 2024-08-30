import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'pantalla_inicio.dart';  // Asegúrate de que la ruta es correcta
import 'file_picker_screen.dart';
void main() {
  runApp(EasyReaderApp());
}

class EasyReaderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EasyReader',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _requestStoragePermission();
  }

  Future<void> _requestStoragePermission() async {
    if (!await Permission.storage.isGranted) {
      final status = await Permission.storage.request();
      if (status.isGranted) {
        // Permisos concedidos
      } else {
        // Permisos denegados
        _showPermissionDeniedDialog();
      }
    }
  }

  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Permiso Denegado"),
          content: Text("Se necesitan permisos de almacenamiento para seleccionar archivos."),
          actions: <Widget>[
            TextButton(
              child: Text("Abrir Configuración"),
              onPressed: () {
                openAppSettings();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

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
