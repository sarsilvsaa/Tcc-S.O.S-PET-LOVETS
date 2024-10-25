import 'package:flutter/material.dart';
import 'package:teste/screens/tela_decisao1.dart';
import 'package:teste/telas_cuidadores/tela_inicialcuidador.dart';
import 'package:teste/screens/tela_inicial.dart';
import 'package:teste/screens/scrollablecolumn.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: IntroductionUserPage(),
    );
  }
}

class IntroductionUserPage extends StatelessWidget {
  String textoComQuebrasDeLinha =
      "Primeira linha\nSegunda linha\nTerceira linha";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffFFD3D2), // Cor de fundo da página

        body: Center(
          child: Padding(
            padding: EdgeInsets.all(20), // Adjust the value as needed

            child: ScrollableColumn(
              children: [
                SizedBox(height: 10),
                Text(
                  "Bem-vindo(a)\n ao\n S.O.S PET LOVERS!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    color: Color(0xffA45309),
                    fontFamily: 'Worksans',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Image.asset(
                  'assets/images/gifcachorro.gif',
                  width: 280,
                  height: 230,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Color(0xffF5ACAB),
                  ), // Removi a cor de fundo do container para usar o fundo da página
                  child: Text(
                    "Com S.O.S Pet Lovers,\n mostramos amor e cuidado aos \n animais, um pet de cada vez. Junte-se a nós nesta jornada de \n compaixão e proteção aos\n nossos aumigos e miaumigos!\n🐾💖",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xffA45309), // Cor do texto
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyHomePage(),
                      ), // Substitua MyDecisao1 pelo nome correto da sua tela
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffF06292), // Cor de fundo do botão
                    onPrimary: Colors.white, // Cor do texto do botão
                    padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10), // Espaçamento interno do botão
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Borda do botão
                    ),
                  ),
                  child: Text("Obrigado(a)"),
                ),
              ],
            ),
          ),
        ));
  }
}

class IntroductionCaregiverPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffFFD3D2), // Cor de fundo da página

        body: Center(
          child: Padding(
            padding: EdgeInsets.all(20), // Adjust the value as needed

            child: ScrollableColumn(
              children: [
                SizedBox(height: 10),
                Text(
                  "Bem-vindo(a)\n ao\n S.O.S PET LOVERS!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    color: Color(0xffA45309),
                    fontFamily: 'Worksans',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Image.asset(
                  'assets/images/gifcachorro.gif',
                  width: 280,
                  height: 230,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Color(0xffF5ACAB),
                  ), // Removi a cor de fundo do container para usar o fundo da página
                  child: Text(
                    "Com S.O.S Pet Lovers,\n mostramos amor e cuidado aos \n animais, um pet de cada vez. Junte-se a nós nesta jornada de \n compaixão e proteção aos\n nossos aumigos e miaumigos!\n🐾💖",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xffA45309), // Cor do texto
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              HomePagePetSitter()), // Substitua MyDecisao1 pelo nome correto da sua tela
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffF06292), // Cor de fundo do botão
                    onPrimary: Colors.white, // Cor do texto do botão
                    padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10), // Espaçamento interno do botão
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Borda do botão
                    ),
                  ),
                  child: Text("Obrigado(a)"),
                ),
              ],
            ),
          ),
        ));
  }
}
