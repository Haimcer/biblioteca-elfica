import 'package:flutter/material.dart';
import 'package:leitor_ebooks/globals/globals_functions.dart';
import 'package:leitor_ebooks/globals/globlas_alert.dart';
import 'package:leitor_ebooks/modals/escritor_model.dart';
import 'package:leitor_ebooks/pages/configuracoes/registrar_escritor/store/registrar_escritor_store.dart';

class CadastroEscritorFunctions {
  BuildContext context;
  CadastroEscritorFunctions(this.context);

  EscritorModel? escritorModelEsc;

  final nomeCompletoController = TextEditingController();
  final bioDescricaoController = TextEditingController();

  Future escritorFunctionsPrincipal(EscritorModel? escritorModelEscAux,
      ResgistrarEscritorStore resgistrarEscritorStore) async {
    escritorModelEsc = escritorModelEscAux;
    if (escritorModelEsc != null) {
      await iniciaControllersUpdate(resgistrarEscritorStore);
    }
  }

  Future iniciaControllersUpdate(
      ResgistrarEscritorStore resgistrarEscritorStore) async {
    nomeCompletoController.text = escritorModelEsc?.nomeCompleto ?? '';
    bioDescricaoController.text = escritorModelEsc?.nomeCompleto ?? '';
    resgistrarEscritorStore.setFoto(escritorModelEsc?.foto);
    resgistrarEscritorStore.setIsAnonimo(escritorModelEsc?.isAnonimo);
  }

  Future cadastraFornecedor(BuildContext contextAux,
      ResgistrarEscritorStore resgistrarEscritorStore) async {
    if (await GlobalsFunctions().verificaConexao()) {
      GlobalsAlert(context).alertInternet(contextAux);
      return;
    }

    if (nomeCompletoController.text.isEmpty) {
      GlobalsAlert(context)
          .alertWarning(contextAux, text: "Ops! Nome é um campo obrigatório");
      return;
    }

    if (bioDescricaoController.text.isEmpty) {
      GlobalsAlert(context)
          .alertWarning(contextAux, text: "Ops! Bio é um campo obrigatório");
      return;
    }
  }

  void limpaControllers() {
    nomeCompletoController.clear();
    bioDescricaoController.clear();
  }
}
