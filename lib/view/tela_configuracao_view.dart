//import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import '../controller/login_controller.dart';

class TelaConfiguracoes extends StatefulWidget {
  const TelaConfiguracoes({super.key});

  @override
  State<TelaConfiguracoes> createState() => _TelaConfiguracoesState();
}

class _TelaConfiguracoesState extends State<TelaConfiguracoes> {
  //final nome = LoginController().usuarioLogado();

  //final nome = LoginController().usuarioLogado();
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
                margin: EdgeInsets.only(
                  left: 0.0,
                  top: 0.0,
                  right: 20.0,
                  bottom: 0.0,
                ),
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage(
                    'lib/images/foto-perfil.jpg',
                  )),
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
                          //snapshot.data.toString(),
                          "Teste",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 30,
                          ),
                        );

                        //} else {
                        //return Text('1');
                        //}
                      }
                      return Text('2');
                    },
                  ),
                  FutureBuilder<String>(
                    future: LoginController().emailLogado(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          return Text(
                            snapshot.data.toString(),
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 20,
                            ),
                          );
                        } else {
                          return Text('teste@gmail.com');
                        }
                      }
                      return Text('');
                    },
                  ),
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
