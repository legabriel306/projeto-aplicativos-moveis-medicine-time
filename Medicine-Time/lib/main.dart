import 'package:helloworld/view/tela_login.dart';
import 'package:helloworld/view/tela_menu.dart';
import 'package:helloworld/view/tela_cadastro_remedio.dart';
import 'package:helloworld/view/tela_resetar_senha.dart';
import 'package:helloworld/view/tela_cadastro.dart';
import 'package:helloworld/view/tela_sobre.dart';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Application name
      title: 'Medicine Time',
      debugShowCheckedModeBanner: false,
      initialRoute: 'TelaLogin',
      routes: {
        'TelaLogin': (context) => TelaLogin(),
        'TelaResetarSenha': (context) => TelaResetarSenha(),
        'TelaCadastro': (context) => TelaCadastro(),
        'TelaMenu': (context) => TelaMenu(),
        'TelaCadastroRemedio': (context) => TelaCadastroRemedio(),
        'TelaSobre': (context) => TelaSobre(),
      },
      // Application theme data, you can set the colors for the application as
      // you want
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      // A widget which will be started on application startup
    );
  }
}
