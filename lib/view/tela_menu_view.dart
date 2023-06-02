// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medicine_time/controller/login_controller.dart';
import 'package:medicine_time/controller/remedio_controller.dart';
import 'package:medicine_time/view/widget_mensagem.dart';
import 'package:medicine_time/view/widget_remedio.dart';

import '../model/remedio.dart';
import './tela_cadastro_remedio_view.dart';

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
                        Navigator.pushReplacementNamed(context, 'TelaLogin');
                      },
                      icon: Icon(Icons.exit_to_app, size: 14),
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
        Text('Total de Remédios: ${lista.length}'),
      ],
    );
  }

  receber(BuildContext context) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const TelaCadastroRemedio(),
        ));
    setState(() {
      lista.add(result);
    });
  }

  listar() {
    return Container(
      padding: EdgeInsets.all(20),
      color: Colors.blueGrey.shade50,
      child: ListView.builder(
        //Definir a quantidade de elementos
        itemCount: lista.length,
        //Definir a aparência dos elementos
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Image.asset("lib/images/drogas.png"),
              title: Text(lista[index].nome),
              subtitle:
                  Text(lista[index].dose + '  ' + lista[index].horaInicio),
              trailing: IconButton(
                icon: Icon(Icons.delete_outline),
                onPressed: () {
                  //REMOVER
                  setState(() {
                    //RemedioController().excluir(context, id);
                    lista.removeAt(index);
                  });
                  WidgetMensagem()
                      .simples(context, 'Remedio removido com sucesso.');
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
              tileColor: (this.index == index)
                  ? Colors.amberAccent.shade100
                  : Colors.white,
              onLongPress: () {
                setState(() {
                  this.index = -1;
                  txtNome.clear();
                  txtDose.clear();
                  txtHoraInicio.clear();
                });
              },
            ),
          );
        },
      ),
    );
  }
}
