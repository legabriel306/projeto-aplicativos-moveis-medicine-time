import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TelaSobre extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4FB286),
        title: Text(
          'Sobre',
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
      body: Column(children: [
        SizedBox(
          height: 20,
        ),
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: AssetImage(
              'lib/images/foto-perfil.jpg',
            )),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "Leandro Gabriel",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Desenvolvedor",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        Container(
          padding: EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
            bottom: 70,
          ),
          child: Text(
            "Medicine Time é um aplicativo para o auxílio na organização e no gerenciamento de remédios para pessoas idosas.",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Meu Github",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ]),
        SizedBox(
          height: 20,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                icon: Image.asset(
                  'lib/images/github-icon.png',
                ),
                iconSize: 50,
                onPressed: () async {
                  final Uri _url = Uri.parse('https://github.com/legabriel306');
                  if (await canLaunchUrl(_url)) {
                    await launchUrl(_url);
                  } else {
                    throw 'Could not launch $_url';
                  }
                }),
          ],
        ),
      ]),
    );
  }
}