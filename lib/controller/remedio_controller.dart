import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/remedio.dart';
import './login_controller.dart';
import '../view/widget_mensagem.dart';

class RemedioController {
  void adicionar(context, Remedio r) {
    FirebaseFirestore.instance
        .collection('remedios')
        .add(r.toJson())
        .then((value) =>
            WidgetMensagem().sucesso(context, 'Remedio adicionada com sucesso'))
        .catchError(
            (e) => WidgetMensagem().erro(context, 'ERRO: ${e.code.toString()}'))
        .whenComplete(() => Navigator.of(context).pop());
  }

  void atualizar(context, id, Remedio r) {
    FirebaseFirestore.instance
        .collection('remedios')
        .doc(id)
        .update(r.toJson())
        .then((value) =>
            WidgetMensagem().sucesso(context, 'Remedio atualizada com sucesso'))
        .catchError(
            (e) => WidgetMensagem().erro(context, 'ERRO: ${e.code.toString()}'))
        .whenComplete(() => Navigator.of(context).pop());
  }

  void excluir(context, id) {
    FirebaseFirestore.instance
        .collection('remedios')
        .doc(id)
        .delete()
        .then((value) =>
            WidgetMensagem().sucesso(context, 'Remedio excluída com sucesso'))
        .catchError((e) =>
            WidgetMensagem().erro(context, 'ERRO: ${e.code.toString()}'));
  }

  listar() {
    return FirebaseFirestore.instance
        .collection('remedios')
        .where('uid', isEqualTo: LoginController().idUsuario());
  }
}
