//import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
//import 'package:medicine_time/view/widget_mensagem.dart';

import '../controller/login_controller.dart';

class TelaConfiguracoes extends StatefulWidget {
  const TelaConfiguracoes({super.key});

  @override
  State<TelaConfiguracoes> createState() => _TelaConfiguracoesState();
}

class _TelaConfiguracoesState extends State<TelaConfiguracoes> {
  TextEditingController nomeController = TextEditingController();

  Future<void> _alterarNome() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Editar Nome'),
          content: TextField(
            controller: nomeController,
            decoration: const InputDecoration(labelText: 'Nome'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancelar',
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  LoginController()
                      .atualizarNomeUsuario(context, nomeController.text);
                });
                // Agora o nome do usuário será atualizado no banco de dados
              },
              child: const Text(
                'Salvar',
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4FB286),
        title: Text(
          'Configurações',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => {
            Navigator.pop(context),
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 70,
                height: 70,
                margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xfff4f4f4),
                ),
                child: Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.grey,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FutureBuilder<String>(
                    future: LoginController().usuarioLogado(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        //if (snapshot.hasData) {
                        return Text(
                          snapshot.data.toString(),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 30,
                          ),
                        );

                        //} else {
                        //return Text('Nome');
                        //}
                      }
                      return Text('2');
                    },
                  ),
                  // FutureBuilder<String>(
                  //   future: LoginController().emailLogado(),
                  //   builder: (context, snapshot) {
                  //     if (snapshot.connectionState == ConnectionState.done) {
                  //       if (snapshot.hasData) {
                  //         return Text(
                  //           snapshot.data.toString(),
                  //           textAlign: TextAlign.left,
                  //           style: TextStyle(
                  //             fontWeight: FontWeight.w100,
                  //             fontSize: 20,
                  //           ),
                  //         );
                  //       } else {
                  //         return Text('teste@gmail.com');
                  //       }
                  //     }
                  //     return Text('');
                  //   },
                  // ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            alignment: Alignment.centerLeft,
            height: 40,
            child: TextButton(
              style: ButtonStyle(
                alignment: Alignment.centerLeft,
              ),
              child: Text(
                "Alterar Nome",
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              onPressed: () => {
                _alterarNome(),
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.centerLeft,
            height: 40,
            child: TextButton(
              child: Text(
                "Sobre o aplicativo",
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              onPressed: () => {
                Navigator.pushNamed(context, 'TelaSobre'),
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.centerLeft,
            height: 40,
            child: TextButton(
              style: ButtonStyle(
                alignment: Alignment.centerLeft,
              ),
              child: Text(
                "Logout",
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                ),
              ),
              onPressed: () => {
                LoginController().logout(),
                Navigator.pushReplacementNamed(context, 'TelaLogin'),
              },
            ),
          ),
        ]),
      ),
    );
  }
}
