import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teste/screens/tela_decisao2.dart';
import 'package:teste/screens/tela_login.dart';

class MyDecisao1 extends StatefulWidget {
  MyDecisao1({Key? key}) : super(key: key);

  @override
  _MyDecisao1State createState() => _MyDecisao1State();
}

class _MyDecisao1State extends State<MyDecisao1> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
      backgroundColor: Color(0xffF8CCCC),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xffF8CCCC),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Center(
                child: Container(
                    height: 547,
                    alignment: Alignment.bottomCenter,
                    child: _buildBannerCard(),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/images/patas.png'), // Substitua pelo caminho da sua imagem PNG
                        fit: BoxFit.cover,
                      ),
                    )),
              ),
              Center(child: _buildImageBanner()),
            ],
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildBannerCard() {
    return Container(
      height: 300,
      width: 300,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        elevation: 10,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Seja bem-vindo(a)',
              style: TextStyle(
                fontFamily: 'WorkSans',
                fontSize: 30,
                color: Color(0xffA45309),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              child: Text(
                'ENTRAR',
                style: TextStyle(
                  fontFamily: 'WorkSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Color(0xffA45309),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffFFFAFC),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                minimumSize: Size(200, 60),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text(
                'CADASTRAR',
                style: TextStyle(
                  fontFamily: 'WorkSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Color(0xffA45309),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          MyDecisao()), // Corrigido para MyDecisao2
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffFFFAFC),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                minimumSize: Size(150, 60),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildImageBanner() {
    return Container(
      height: 380,
      child: Image(
        image: AssetImage('assets/images/cachorro-semfundo.png'),
      ),
    );
  }
}
