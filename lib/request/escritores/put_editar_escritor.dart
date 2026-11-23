import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../controllers/user_ids.dart';
import '../../globals/globals_vars.dart';
import '../../globals/globlas_alert.dart';

class PutEditarEscritorRequest {
  final BuildContext context;
  PutEditarEscritorRequest(this.context);

  /// Atualiza **apenas** os campos enviados (edição parcial).
  ///
  /// O back‑end descobre o escritor pelo token, por isso não exige `id`.
  Future<Map<String, dynamic>?> editarEscritor({
    // ───── campos possíveis ─────
    String? nomeCompleto,
    DateTime? dataNascimento,
    String? cpf,
    String? telefone,
    String? enderecoLinha1,
    String? enderecoLinha2,
    String? cidade,
    String? estado,
    String? cep,
    String? pais,
    String? contaBancaria,
    String? stripeAccountId,
    String? foto,
    bool? isAnonimo,
    String? novoToken, // uso interno para renovar token
  }) async {
    final userIds = Provider.of<UserIds>(context, listen: false);

    // monta payload apenas com campos não‑nulos
    final body = <String, dynamic>{
      'nome_completo': nomeCompleto,
      'data_nascimento': dataNascimento?.toIso8601String().split('T').first,
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
      'foto': foto,
      'is_anonimo': isAnonimo,
    }..removeWhere((_, v) => v == null);

    if (body.isEmpty) {
      GlobalsAlert(context).alertWarning(
        context,
        text: 'Nenhum campo para atualizar.',
      );
      return null;
    }

    try {
      final res = await http.put(
        Uri.parse('${GlobalsVars().urlAPI}/escritores'),
        headers: {
          'Authorization': 'Bearer ${userIds.tokenAPI}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      if (res.statusCode >= 200 && res.statusCode < 300) {
        return jsonDecode(res.body) as Map<String, dynamic>;
      }

      // token expirado → renova uma vez
      if (res.statusCode == 403 && novoToken == null) {
        final refreshed = await userIds.setRenovaToken();
        if (refreshed != null) {
          userIds.setTokenAPI(refreshed);
          return editarEscritor(
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
            isAnonimo: isAnonimo,
            novoToken: refreshed,
          );
        }
      }

      GlobalsAlert(context).alertWarning(
        context,
        text: '${res.body}\nErro ao atualizar escritor.',
      );
    } catch (e) {
      GlobalsAlert(context).alertWarning(
        context,
        text: 'Erro inesperado: $e',
      );
    }
    return null;
  }
}
