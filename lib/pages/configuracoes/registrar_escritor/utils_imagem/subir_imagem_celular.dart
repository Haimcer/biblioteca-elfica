import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

Future<void> selecionarImagemCelular(
  Function(Uint8List novaImagem, String nomeImagem) onSelecionado,
) async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    final bytes = await pickedFile.readAsBytes();
    onSelecionado(bytes, pickedFile.name);
  }
}
