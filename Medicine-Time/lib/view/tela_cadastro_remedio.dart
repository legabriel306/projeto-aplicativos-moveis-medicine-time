// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import '../model/remedio.dart';

//STATEFUL stf+TAB
class TelaCadastroRemedio extends StatefulWidget {
  const TelaCadastroRemedio({super.key});

  @override
  State<TelaCadastroRemedio> createState() => _TelaCadastroRemedioState();
}

class _TelaCadastroRemedioState extends State<TelaCadastroRemedio> {
  //Atributos
  var txtNome = TextEditingController();
  var txtDose = TextEditingController();
  var txtHoraInicio = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Remédios')),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(20),
              color: Colors.blueGrey.shade50,
              child: Column(
                children: [
                  //CAMPO DE TEXTO
                  TextField(
                    controller: txtNome,
                    decoration: InputDecoration(
                      labelText: 'Nome',
                      labelStyle: TextStyle(fontSize: 18),
                      prefixIcon: Icon(Icons.medication),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  //CAMPO DE TEXTO
                  TextField(
                    controller: txtDose,
                    decoration: InputDecoration(
                      labelText: 'Dose',
                      labelStyle: TextStyle(fontSize: 18),
                      prefixIcon: Icon(Icons.do_disturb),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  //CAMPO DE TEXTO
                  TextField(
                    controller: txtHoraInicio,
                    decoration: InputDecoration(
                      labelText: 'Intervalo de tempo',
                      labelStyle: TextStyle(fontSize: 18),
                      prefixIcon: Icon(Icons.watch_later_outlined),
                      border: OutlineInputBorder(),
                    ),
                  ),

                  SizedBox(height: 15),
                  //BOTÃO> ElevatedButton; OutlinedButton; TextButton
                  ElevatedButton(
                    //Evento
                    onPressed: () {
                      if (txtNome.text.isNotEmpty && txtNome.text.isNotEmpty) {
                        mensagem('Remedio adicionado com sucesso!');
                        /*
                        txtNome.clear();
                        txtDose.clear();
                        txtHoraInicio.clear();
                        */
                        Navigator.pop(
                          context,
                          Remedio(
                              txtNome.text, txtDose.text, txtHoraInicio.text),
                        );
                      } else {
                        mensagem(
                          'Os campos nome, dose e horario de inicio precisam ser preenchidos.',
                        );
                      }
                    },
                    //Conteúdo
                    child: Text('salvar'),
                  ),
                ],
              ),
            ),
          ),
        ],
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
