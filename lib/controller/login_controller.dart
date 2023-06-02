import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../view/widget_mensagem.dart';

class LoginController {
  criarConta(context, nome, email, senha) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: senha,
    )
        .then((resultado) {
      
      FirebaseFirestore.instance.collection('usuarios').add({
        'uid': resultado.user!.uid,
        'nome': nome,
      });

      WidgetMensagem().sucesso(context, 'Usuário criado com sucesso.');
      Navigator.pop(context);
    }).catchError((e) {
      switch (e.code) {
        case 'email-already-in-use':
          WidgetMensagem().erro(context, 'O email já foi cadastrado.');
          break;
        case 'invalid-email':
          WidgetMensagem().erro(context, 'O formato do email é inválido.');
          break;
        default:
          WidgetMensagem().erro(context, 'ERRO: ${e.code.toString()}');
      }
    });
  }

  login(context, email, senha) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: senha)
        .then((resultado) {
        Navigator.pushReplacementNamed(context, 'TelaMenu');
    }).catchError((e) {
      switch (e.code) {
        case 'invalid-email':
          break;
        case 'user-not-found':
          WidgetMensagem().erro(context, 'Usuário não encontrado.');
          break;
        case 'wrong-password':
          WidgetMensagem().erro(context, 'Senha incorreta.');
          break;
        default:
        WidgetMensagem().erro(context, 'ERRO: ${e.code.toString()}');
      }
    });
  }

  esqueceuSenha(context, String email) {
    if (email.isNotEmpty) {
      FirebaseAuth.instance.sendPasswordResetEmail(
        email: email,
      );
      WidgetMensagem().sucesso(context, 'Email enviado com sucesso.');
    } else {
      WidgetMensagem().erro(context, 'Informe o email para recuperar a conta.');
    }
    Navigator.pop(context);
  }

  logout() {
    FirebaseAuth.instance.signOut();
  }

  idUsuario() {
    return FirebaseAuth.instance.currentUser!.uid;
  }

  Future<String> usuarioLogado() async {
    var usuario = '';
    await FirebaseFirestore.instance
        .collection('usuarios')
        .where('uid', isEqualTo: idUsuario())
        .get()
        .then(
      (resultado) {
        usuario = resultado.docs[0].data()['nome'] ?? '';
      },
    );
    return usuario;
  }
}
