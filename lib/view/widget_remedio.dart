//ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:medicine_time/model/remedio.dart';
import 'package:medicine_time/view/widget_mensagem.dart';

class WidgetRemedio extends StatelessWidget {
  final Remedio r;

  const WidgetRemedio(this.r, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.asset("lib/images/drogas.png"),
        title: Text(r.nome),
        subtitle: Text(r.dose + '  ' + r.horaInicio),
        trailing: IconButton(
          icon: Icon(Icons.delete_outline),
          onPressed: () {
            setState(() {
              lista.removeAt(index);
            });
            WidgetMensagem().simples(context, 'Remedio removido com sucesso.');
          },
        ),
        //Selecionar um ITEM da lista
        onTap: () {
          setState(() {
            //Armazenar a posição da lista
            this.index = index;
            txtNome.text = lista[index].nome;
            txtDose.text = lista[index].dose;
            txtHoraInicio.text = lista[index].horaInicio;
          });
        },
        //Alterar a cor do ITEM selecionado
        tileColor:
            (this.index == index) ? Colors.amberAccent.shade100 : Colors.white,
        onLongPress: () {
          setState(() {
            this.index = -1;
            //txtNome.clear();
            //txtDose.clear();
            //txtHoraInicio.clear();
          });
        },
      ),
    );
  }
}

/**
 * FIREBASE STORAGE
https://pub.dev/packages/firebase_storage

IMAGE PICKER
https://pub.dev/packages/image_picker
 * 
 * 1) Configurar a Variável de Ambiente para sua CONTA no PATH

	C:\flutter\sdk\bin

2) EXECUTAR os seguintes comandos no POWERSHELL

  Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser       
	flutter config --android-sdk c:\flutter\android
	flutter config --no-enable-windows-desktop
	flutter config --no-enable-linux-desktop
	flutter config --no-enable-macos-desktop	

3) INSTALAR VsCODE (https://code.visualstudio.com/)

  Adicionar as extensões: FLUTTER e VSCODE-ICONS
  

4) FIREBASE CLI + FLUTTERFIRE CLI
  
  npm get prefix
  npm install -g firebase-tools
  firebase login
  dart pub global activate flutterfire_cli
    
    
cloud_firestore: ^4.5.3
firebase_auth: ^4.4.2
firebase_core: ^2.10.0 */