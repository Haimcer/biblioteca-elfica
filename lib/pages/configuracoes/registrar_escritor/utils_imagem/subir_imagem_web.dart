  import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:html' as html; // só será usado no web

Future<void> selecionarImagemWeb(
  Function(Uint8List novaImagem, String nomeImagem) onSelecionado,
) async {
  if (kIsWeb) {
    final uploadInput = html.FileUploadInputElement();
    uploadInput.accept = 'image/*';
    uploadInput.click();

    uploadInput.onChange.listen((event) {
      final file = uploadInput.files?.first;
      if (file != null) {
        final reader = html.FileReader();
        reader.readAsArrayBuffer(file);
        reader.onLoadEnd.listen((event) {
          final data = reader.result as Uint8List;
          onSelecionado(data, file.name);
        });
      }
    });
  } 
}