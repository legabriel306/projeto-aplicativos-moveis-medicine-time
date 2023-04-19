// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import '../model/remedio.dart';
import 'package:helloworld/view/tela_cadastro_remedio.dart';

//STATEFUL stf+TAB
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
    lista.add(Remedio('', '10 ML', '10:00'));
    lista.add(Remedio('Buscopan', '1X', '08:00'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Remédios')),
      body: Column(
        children: [
          /*Expanded(
            flex: 1,
            child: adicionar(),
          ),*/
          Expanded(
            flex: 2,
            child: listar(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          receber(context);
        },
      ),
      //BARRA DE STATUS
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

  //
  // LISTAR REMEDIOS
  //
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
              leading: Icon(Icons.medication_outlined),
              title: Text(lista[index].nome),
              subtitle:
                  Text(lista[index].dose + '  ' + lista[index].horaInicio),
              trailing: IconButton(
                icon: Icon(Icons.delete_outline),
                onPressed: () {
                  //REMOVER
                  setState(() {
                    lista.removeAt(index);
                  });
                  mensagem('Remedio removido com sucesso.');
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

  //
  // EXIBIR MENSAGEM
  //
  mensagem(msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: 2),
      content: Text(msg),
    ));
  }
}
