import 'package:flutter/material.dart';

import '../controller/login_controller.dart';

class TelaConfiguracoes extends StatefulWidget {
  const TelaConfiguracoes({super.key});

  @override
  State<TelaConfiguracoes> createState() => _TelaConfiguracoesState();
}

class _TelaConfiguracoesState extends State<TelaConfiguracoes> {
  //Future<String>? _nome;
  //Future<String>? _email;
  @override
  void initState() {
    super.initState();
    //_nome = LoginController().usuarioLogado();
    //_email = LoginController().emailUsuario();
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
        child: Column(
          children: [
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
                    //futures

                    FutureBuilder<String>(
                      future: LoginController().usuarioLogado(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else {
                          return Text(snapshot.data.toString());
                        }
                      },
                    ),
                    /*
                    FutureBuilder<String>(
                      future: _email,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else {
                          return Text(snapshot.data.toString());
                        }
                      },
                    ),*/
                  ],
                )
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
                  //_alterarNome(),
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
          ],
        ),
      ),
    );
  }
}
