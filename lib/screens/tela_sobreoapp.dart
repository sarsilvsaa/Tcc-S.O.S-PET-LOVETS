// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';

class SobreoappPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      appBar: AppBar(
        elevation: 0,
        title: Text('Informações sobre'),
        backgroundColor: Color(0xffebaeae),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'SOBRE O APLICATIVO:',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: Color(0xff000000),
                    fontSize: 20,
                    fontFamily: 'WorkSans',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Divider(
              color: Color(0xffA45309),
              thickness: 4,
            ),
            SizedBox(height: 10),
            Container(
              width: 500,
              height: 500,
              decoration: BoxDecoration(
                color: Color(0xffF8CCCC),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xffffffff),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(30),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    'Somos alunos da ETEC Polivalente de Americana extensão - FATEC, desenvolvemos o aplicativo pois nós somos donos de pets que se preocupam com o bem estar dos nossos animais de estimação, \n criando este aplicativo que facilite na busca de um cuidador que saiba aplicar medicações orais ou injetáveis.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xff000000),
                      fontFamily: 'WorkSans',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: SobreoappPage()));
}
