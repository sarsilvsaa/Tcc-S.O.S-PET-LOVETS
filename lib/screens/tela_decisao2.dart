import 'package:flutter/material.dart';
import 'package:teste/screens/tela_cadastro.dart';
import 'package:teste/screens/tela_cadastrocuidador1.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyDecisao(),
    );
  }
}

class MyDecisao extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF8CCCC),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xffF8CCCC),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'DESEJA SE CADASTRAR COMO?',
              style: TextStyle(
                fontFamily: 'Pangolin',
                //backgroundColor: Color(0xffE89999),
                fontSize: 25,
                color: Color(0xffA45309),
              ),
            ),
            SizedBox(height: 60),
            ElevatedButton(
              child: Text(
                'Usuário',
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'Pangolin',
                  color: Color(0xffA45309),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffffffff),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: Size(300, 50),
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              child: Text(
                'Cuidador(a)',
                style: TextStyle(
                  fontFamily: 'Pangolin',
                  fontSize: 30,
                  color: Color(0xffA45309),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RegistroCuidadorPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffffffff),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: Size(300, 50),
              ),
            ),
            SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}
