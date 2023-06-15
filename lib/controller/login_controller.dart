import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../view/widget_mensagem.dart';

class LoginController {
  criarConta(context, name, email, password) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((result) async {
      FirebaseFirestore.instance
          .collection('usuarios')
          .doc(result.user!.uid)
          .set(
        {
          'uid': result.user!.uid,
          'email': email,
          'nome': name,
        },
      ).then((value) {
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

  emailUsuario() {
    return FirebaseAuth.instance.currentUser!.email;
  }

  Future<String> emailLogado() async {
    var email = '';
    await FirebaseFirestore.instance
        .collection('usuarios')
        .where('uid', isEqualTo: idUsuario())
        .get()
        .then(
      (resultado) {
        email = resultado.docs[0].data()['email'] ?? '';
      },
    );
    return email;
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

  Future<String> atualizarNomeUsuario(context, novoNome) async {
    var userId = await idUsuario();

    FirebaseFirestore.instance
        .collection('usuarios')
        .doc(userId)
        .set({'nome': novoNome}, SetOptions(merge: true)).then((result) {
      WidgetMensagem()
          .sucesso(context, 'Nome do usuário atualizado com sucesso.');
      Navigator.of(context).pop();
    }).catchError((e) {
      WidgetMensagem().erro(context, 'Erro na atualização: ${e.toString()}');
    });

    return novoNome;
  }
}
