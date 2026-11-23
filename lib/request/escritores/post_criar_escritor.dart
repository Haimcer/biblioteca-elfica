import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:provider/provider.dart';

import '../../controllers/user_ids.dart';
import '../../globals/globals_vars.dart';
import '../../globals/globlas_alert.dart';

class PostCriarEscritorRequest {
  final BuildContext context;
  PostCriarEscritorRequest(this.context);

  Future<Map<String, dynamic>?> criarEscritor({
    required String nomeCompleto,
    required DateTime dataNascimento,
    required String cpf,
    String? telefone,
    String? enderecoLinha1,
    String? enderecoLinha2,
    String? cidade,
    String? estado,
    String? cep,
    String? pais,
    String? contaBancaria,
    String? stripeAccountId,
    Uint8List? foto, // agora o tipo correto!
    String? fotoFileName, // necessário para mandar o nome do arquivo
    bool isAnonimo = false,
    String? novoToken,
  }) async {
    final userIds = Provider.of<UserIds>(context, listen: false);
    final uri = Uri.parse('${GlobalsVars().urlAPI}/escritores');

    try {
      if (foto != null && fotoFileName != null) {
        /// Se tiver foto → Multipart
        final request = http.MultipartRequest('POST', uri);

        request.headers.addAll({
          'Authorization': 'Bearer ${userIds.tokenAPI}',
        });

        request.fields.addAll({
          'nome_completo': nomeCompleto,
          'data_nascimento': dataNascimento.toIso8601String().split('T').first,
          'cpf': cpf,
          if (telefone != null) 'telefone': telefone,
          if (enderecoLinha1 != null) 'endereco_linha1': enderecoLinha1,
          if (enderecoLinha2 != null) 'endereco_linha2': enderecoLinha2,
          if (cidade != null) 'cidade': cidade,
          if (estado != null) 'estado': estado,
          if (cep != null) 'cep': cep,
          if (pais != null) 'pais': pais,
          if (contaBancaria != null) 'conta_bancaria': contaBancaria,
          if (stripeAccountId != null) 'stripe_account_id': stripeAccountId,
          'is_anonimo': isAnonimo.toString(),
        });

        final mime = lookupMimeType(fotoFileName) ?? 'image/jpeg';
        request.files.add(http.MultipartFile.fromBytes(
          'foto',
          foto,
          filename: fotoFileName,
          contentType: MediaType.parse(mime),
        ));

        final response = await request.send();
        final resultBody = await response.stream.bytesToString();

        if (response.statusCode >= 200 && response.statusCode < 300) {
          return json.decode(resultBody);
        } else if (response.statusCode == 403 && novoToken == null) {
          final novoTokenAux = await userIds.setRenovaToken();
          userIds.setTokenAPI(novoTokenAux);
          return await criarEscritor(
            nomeCompleto: nomeCompleto,
            dataNascimento: dataNascimento,
            cpf: cpf,
            telefone: telefone,
            enderecoLinha1: enderecoLinha1,
            enderecoLinha2: enderecoLinha2,
            cidade: cidade,
            estado: estado,
            cep: cep,
            pais: pais,
            contaBancaria: contaBancaria,
            stripeAccountId: stripeAccountId,
            foto: foto,
            fotoFileName: fotoFileName,
            isAnonimo: isAnonimo,
            novoToken: novoTokenAux,
          );
        } else {
          GlobalsAlert(context).alertWarning(
            context,
            text: "$resultBody\nErro ao criar perfil de escritor.",
          );
        }
      } else {
        /// Se NÃO tiver foto → JSON normal
        final body = <String, dynamic>{
          'nome_completo': nomeCompleto,
          'data_nascimento': dataNascimento.toIso8601String().split('T').first,
          'cpf': cpf,
          'telefone': telefone,
          'endereco_linha1': enderecoLinha1,
          'endereco_linha2': enderecoLinha2,
          'cidade': cidade,
          'estado': estado,
          'cep': cep,
          'pais': pais,
          'conta_bancaria': contaBancaria,
          'stripe_account_id': stripeAccountId,
          'is_anonimo': isAnonimo,
        }..removeWhere((_, v) => v == null);

        final res = await http.post(
          uri,
          headers: {
            'Authorization': 'Bearer ${userIds.tokenAPI}',
            'Content-Type': 'application/json',
          },
          body: jsonEncode(body),
        );

        if (res.statusCode >= 200 && res.statusCode < 300) {
          return jsonDecode(res.body) as Map<String, dynamic>;
        }

        if (res.statusCode == 403 && novoToken == null) {
          final refreshed = await userIds.setRenovaToken();
          if (refreshed != null) {
            userIds.setTokenAPI(refreshed);
            return criarEscritor(
              nomeCompleto: nomeCompleto,
              dataNascimento: dataNascimento,
              cpf: cpf,
              telefone: telefone,
              enderecoLinha1: enderecoLinha1,
              enderecoLinha2: enderecoLinha2,
              cidade: cidade,
              estado: estado,
              cep: cep,
              pais: pais,
              contaBancaria: contaBancaria,
              stripeAccountId: stripeAccountId,
              foto: foto,
              fotoFileName: fotoFileName,
              isAnonimo: isAnonimo,
              novoToken: refreshed,
            );
          }
        }

        GlobalsAlert(context).alertWarning(
          context,
          text: '${res.body}\nErro ao criar perfil de escritor.',
        );
      }
    } catch (e) {
      GlobalsAlert(context).alertWarning(
        context,
        text: 'Erro inesperado: $e',
      );
    }
    return null;
  }
}
