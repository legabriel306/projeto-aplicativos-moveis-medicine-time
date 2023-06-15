// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:medicine_time/view/tela_configuracoes_view1.dart';
import 'package:medicine_time/view/tela_splash_view.dart';
import './view/tela_login_view.dart';
import 'package:medicine_time/view/tela_menu_view.dart';
import 'package:medicine_time/view/tela_cadastro_remedio_view.dart';
import 'package:medicine_time/view/tela_resetar_senha_view.dart';
import 'package:medicine_time/view/tela_cadastro_view.dart';
import 'package:medicine_time/view/tela_sobre_view.dart';

import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((result) {
    runApp(
      DevicePreview(
        enabled: false,
        builder: (context) => MaterialApp(
          title: 'Medicine Time',
          debugShowCheckedModeBanner: false,
          initialRoute: 'SplashView',
          routes: {
            'SplashView': (context) => SplashView(),
            'TelaLogin': (context) => TelaLogin(),
            'TelaResetarSenha': (context) => TelaResetarSenha(),
            'TelaCadastro': (context) => TelaCadastro(),
            'TelaMenu': (context) => TelaMenu(),
            'TelaCadastroRemedio': (context) => TelaCadastroRemedio(),
            'TelaSobre': (context) => TelaSobre(),
            'TelaConfiguracoes': (context) => TelaConfiguracoes(),
          },
          theme: ThemeData(
            primarySwatch: Colors.green,
          ),
        ),
      ),
    );
  });
}
