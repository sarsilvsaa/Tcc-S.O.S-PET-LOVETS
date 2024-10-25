import 'package:flutter/material.dart';

import 'package:teste/screens/tela_inicial.dart';

class MyPetRegistroPage extends StatefulWidget {
  @override
  _MyPetRegistroState createState() => _MyPetRegistroState();
}

class _MyPetRegistroState extends State<MyPetRegistroPage> {
  String nomePet = '';
  String sobretPet = '';
  String especiePet = '';
  String racaPet = '';
  String idadePet = '';
  String pesoPet = '';
  String microchipPet = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF8CCCC),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xffF8CCCC),
        title: Text('Cadastre seu pet'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              width: 300,
              height: 300,
              child: Placeholder(), // Add your image upload widget here
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'FALE UM POUCO SOBRE SEU PET...',
                labelStyle: TextStyle(
                  color: Color(0xff000000),
                ),
                alignLabelWithHint: true,
                filled: true,
                fillColor: Color(0xffffffff),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              minLines: 5,
              maxLines: 10,
              onChanged: (value) {
                setState(() {
                  sobretPet = value;
                });
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'ESPÉCIE',
                labelStyle: TextStyle(
                  color: Color(0xff000000),
                ),
                filled: true,
                fillColor: Color(0xffffffff),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  especiePet = value;
                });
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'RAÇA',
                labelStyle: TextStyle(
                  color: Color(0xff000000),
                ),
                filled: true,
                fillColor: Color(0xffffffff),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  racaPet = value;
                });
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'IDADE',
                labelStyle: TextStyle(
                  color: Color(0xff000000),
                ),
                filled: true,
                fillColor: Color(0xffffffff),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  idadePet = value;
                });
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'PESO',
                labelStyle: TextStyle(
                  color: Color(0xff000000),
                ),
                filled: true,
                fillColor: Color(0xffffffff),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  pesoPet = value;
                });
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'MICROCHIP',
                labelStyle: TextStyle(
                  color: Color(0xff000000),
                ),
                filled: true,
                fillColor: Color(0xffffffff),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  microchipPet = value;
                });
              },
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Seu pet é vacinado contra raiva?',
                  style: TextStyle(
                    fontFamily: 'WorkSans',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color(0xff000000),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'Sim',
                    style: TextStyle(
                      color: Color(0xff6F6363),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffffffff),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'Não',
                    style: TextStyle(
                      color: Color(0xff6F6363),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffEBAEAE),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                );
              },
              child: Text('CADASTRAR'),
              style: ElevatedButton.styleFrom(
                primary: Color(0xffF06292),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: Size(150, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
