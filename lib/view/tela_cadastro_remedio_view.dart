import 'package:flutter/material.dart';
import 'package:medicine_time/controller/login_controller.dart';
import 'package:medicine_time/controller/remedio_controller.dart';
import 'package:medicine_time/view/widget_mensagem.dart';
import '../model/remedio.dart';

class TelaCadastroRemedio extends StatefulWidget {
  const TelaCadastroRemedio({super.key});

  @override
  State<TelaCadastroRemedio> createState() => _TelaCadastroRemedioState();
}

class _TelaCadastroRemedioState extends State<TelaCadastroRemedio> {
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
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.grey,
                    ),
                    child: Icon(
                      Icons.add_a_photo_sharp,
                      size: 100,
                      color: Colors.black38,
                    ),
                  ),
                  SizedBox(height: 10),
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
                  ElevatedButton(
                    onPressed: () {
                      if (txtNome.text.isNotEmpty && txtNome.text.isNotEmpty) {
                        var r = Remedio(
                          LoginController().idUsuario(),
                          txtNome.text,
                          txtDose.text,
                          txtHoraInicio.text,
                        );

                        RemedioController().adicionar(context, r);
                      } else {
                        WidgetMensagem().erro(
                          context,
                          'Os campos nome, dose e horario de inicio precisam ser preenchidos.',
                        );
                      }
                    },
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
}
