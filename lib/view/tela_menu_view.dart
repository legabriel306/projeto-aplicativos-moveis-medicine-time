// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medicine_time/controller/login_controller.dart';
import 'package:medicine_time/controller/remedio_controller.dart';
import 'package:medicine_time/view/widget_remedio.dart';

import '../model/remedio.dart';

class TelaMenu extends StatefulWidget {
  const TelaMenu({super.key});

  @override
  State<TelaMenu> createState() => _TelaMenuState();
}

class _TelaMenuState extends State<TelaMenu> {
  //Atributos
  List<Remedio> lista = [];
  var index;
  var txtNome = TextEditingController();
  var txtDose = TextEditingController();
  var txtHoraInicio = TextEditingController();
  var contador = 0;

  @override
  void initState() {
    index = -1;
    //lista.add(Remedio('Omeprazol', '10 ML', '10:00'));
    //lista.add(Remedio('Buscopan', '1X', '08:00'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(child: Text('Remedios')),
            FutureBuilder<String>(
              future: LoginController().usuarioLogado(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextButton.icon(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        textStyle: TextStyle(fontSize: 12),
                      ),
                      onPressed: () {
                        LoginController().logout();
                        Navigator.pushNamed(context, 'TelaConfiguracoes');
                      },
                      icon: Icon(Icons.engineering, size: 14),
                      label: Text(snapshot.data.toString()),
                    ),
                  );
                }
                return Text('');
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: RemedioController().listar().snapshots(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Center(
                  child: Text('Não foi possível conectar.'),
                );
              case ConnectionState.waiting:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              default:
                final dados = snapshot.requireData;
                if (dados.size > 0) {
                  return ListView.builder(
                    itemCount: dados.size,
                    itemBuilder: (context, index) {
                      String id = dados.docs[index].id;
                      dynamic item = dados.docs[index].data();
                      contador++;
                      return WidgetRemedio(
                          item['nome'], item['dose'], item['horaInicio'], id);
                    },
                  );
                } else {
                  return Center(
                    child: Text('Nenhuma tarefa encontrada.'),
                  );
                }
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, 'TelaCadastroRemedio');
        },
      ),
      persistentFooterButtons: [
        Text('Total de Remédios: ${contador}'),
      ],
    );
  }

  void alterarRemedio(context, {docId}) {
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
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelText: 'Dose',
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(),
                  ),
                ),
                TextField(
                  controller: txtHoraInicio,
                  maxLines: 5,
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
                if (docId == null) {
                  //
                  // ADICIONAR TAREFA
                  //
                  RemedioController().adicionar(context, r);
                } else {
                  //
                  // ATUALIZAR TAREFA
                  //
                  RemedioController().atualizar(context, docId, r);
                }
              },
            ),
          ],
        );
      },
    );
  }
}
