import 'package:flutter/material.dart';

import '../controller/login_controller.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  var txtEmail = TextEditingController();
  var txtSenha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.white,
          child: ListView(
            padding: EdgeInsets.only(
              left: 40,
              right: 40,
            ),
            children: <Widget>[
              SizedBox(
                height: 60,
              ),
              SizedBox(
                width: 128,
                height: 128,
                child: Icon(
                  Icons.medication,
                  color: Colors.black,
                  size: 100,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                autofocus: true,
                controller: txtEmail,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "E-mail",
                  labelStyle: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                ),
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: txtSenha,
                autofocus: false,
                keyboardType: TextInputType.text,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Senha",
                  labelStyle: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                ),
                style: TextStyle(fontSize: 20),
              ),
              Container(
                height: 40,
                alignment: Alignment.centerRight,
                child: TextButton(
                  child: Text(
                    "Recuperar Senha",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, 'TelaResetarSenha');
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 60,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.3, 1],
                    colors: [
                      Color(0xFF4FB286),
                      Color(0xFF3C896D),
                    ],
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                child: SizedBox.expand(
                  child: TextButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Entrar",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    onPressed: () => {
                      LoginController().login(
                        context,
                        txtEmail.text,
                        txtSenha.text,
                      )
                    },
                  ),
                ),
              ),
              Container(
                height: 40,
                child: TextButton(
                  child: Text(
                    "Cadastre-se",
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () => {
                    Navigator.pushNamed(context, 'TelaCadastro'),
                  },
                ),
              ),
              Container(
                height: 40,
                child: TextButton(
                  child: Text(
                    "Sobre o aplicativo",
                    textAlign: TextAlign.right,
                  ),
                  onPressed: () => {
                    Navigator.pushNamed(context, 'TelaSobre'),
                  },
                ),
              ),
            ],
          )),
    );
  }
}
