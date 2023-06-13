//ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:medicine_time/controller/remedio_controller.dart';
//import 'package:medicine_time/model/remedio.dart';
import 'package:medicine_time/view/widget_mensagem.dart';

import '../controller/login_controller.dart';
import '../model/remedio.dart';

class WidgetRemedio extends StatefulWidget {
  final String nome;
  final String dose;
  final String horaInicio;
  final String id;

  const WidgetRemedio(this.nome, this.dose, this.horaInicio, this.id,
      {super.key});

  @override
  State<WidgetRemedio> createState() => _WidgetRemedioState();
}

class _WidgetRemedioState extends State<WidgetRemedio> {
  //final Remedio r;
  var selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.asset("lib/images/drogas.png"),
        title: Text(
          widget.nome,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(widget.dose + '  ' + widget.horaInicio),
        trailing: IconButton(
          icon: Icon(Icons.delete_outline),
          onPressed: () {
            RemedioController().excluir(context, widget.id);
            WidgetMensagem().simples(context, 'Remedio removido com sucesso.');
          },
        ),
        //Selecionar um ITEM da lista
        onTap: () {
          setState(() {
            //Armazenar a posição da lista
            //id = widg
            //txtNome.text = lista[index].nome;
            //txtDose.text = lista[index].dose;
            //txtHoraInicio.text = lista[index].horaInicio;
            alterarRemedio(context, docId: widget.id);
          });
        },
        //Alterar a cor do ITEM selecionadoid
        tileColor: (this.selectedIndex == widget.id)
            ? Colors.amberAccent.shade100
            : Colors.white,
        onLongPress: () {
          setState(() {
            if (this.selectedIndex != widget.id) {
              this.selectedIndex = widget.id;
            } else {
              this.selectedIndex = 0;
            }
          });
        },
      ),
    );
  }

  void alterarRemedio(context, {docId}) {
    var txtNome = TextEditingController();
    var txtDose = TextEditingController();
    var txtHoraInicio = TextEditingController();

    txtNome.text = widget.nome;
    txtDose.text = widget.dose;
    txtHoraInicio.text = widget.horaInicio;

    showDialog(
        context: context,
        builder: (BuildContext context) {
          // retorna um objeto do tipo Dialog
          return AlertDialog(
            title: Text("Adicionar Tarefa"),
            content: SizedBox(
              height: 250,
              width: 300,
              child: Column(
                children: [
                  TextField(
                    controller: txtNome,
                    decoration: InputDecoration(
                      labelText: 'Nome',
                      prefixIcon: Icon(Icons.description),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    controller: txtDose,
                    maxLines: 1,
                    decoration: InputDecoration(
                      labelText: 'Dose',
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  TextField(
                    controller: txtHoraInicio,
                    maxLines: 1,
                    decoration: InputDecoration(
                      labelText: 'Intervalo de tempo',
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            actionsPadding: EdgeInsets.fromLTRB(20, 0, 20, 10),
            actions: [
              TextButton(
                child: Text("fechar"),
                onPressed: () {
                  txtNome.clear();
                  txtDose.clear();
                  txtHoraInicio.clear();
                  Navigator.of(context).pop();
                },
              ),
              ElevatedButton(
                child: Text("salvar"),
                onPressed: () {
                  var r = Remedio(
                    LoginController().idUsuario(),
                    txtNome.text,
                    txtDose.text,
                    txtHoraInicio.text,
                  );
                  txtNome.clear();
                  txtDose.clear();
                  txtHoraInicio.clear();

                  RemedioController().atualizar(context, docId, r);
                },
              ),
            ],
          );
        });
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