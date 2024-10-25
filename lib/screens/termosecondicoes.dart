import 'package:flutter/material.dart';
import 'package:teste/screens/tela_cadastro.dart';
import 'package:teste/screens/tela_cadastrocuidador1.dart';

void main() {
  runApp(MaterialApp(home: TermosPage()));
}

class TermosCuidadorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      appBar: AppBar(
        elevation: 0,
        title: Text('Termos e condições'),
        backgroundColor: Color(0xffebaeae),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => RegistroCuidadorPage()),
              (route) => false,
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'NOSSOS TERMOS E CONDIÇÕES:',
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
              width: 2000,
              height: 2000,
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
                    '''
Bem-vindo ao aplicativo S.O.S PET LOVERS! \n Antes de usar nosso aplicativo, por favor, leia atentamente estes Termos de Uso, pois eles regem o uso dos nossos serviços. Ao utilizar o aplicativo, você concorda com os seguintes termos:

1. Uso Aceitável:\n
Você concorda em usar o aplicativo de maneira responsável e de acordo com todas as leis e regulamentos aplicáveis. Não é permitido enviar conteúdo ofensivo, ilegal, difamatório ou prejudicial para outros usuários.

2. Registro e Conta:\n 
Você é responsável por manter a confidencialidade de sua conta e senha. Todas as atividades realizadas através da sua conta são de sua responsabilidade.

3. Privacidade:\n
Respeitamos sua privacidade. Ao usar o aplicativo, você concorda com nossa Política de Privacidade, que descreve como coletamos, usamos e protegemos suas informações pessoais.

4. Conteúdo Gerado pelos Usuários:\n
Ao compartilhar fotos, comentários ou outras informações no aplicativo, você concede a nós o direito de usar, modificar e distribuir esse conteúdo para fins relacionados ao aplicativo.

5. Propriedade Intelectual:\n
O conteúdo do aplicativo, incluindo logotipos, textos, imagens e funcionalidades, é protegido por direitos autorais e outras leis de propriedade intelectual. Você concorda em não copiar, reproduzir ou distribuir esse conteúdo sem permissão.

6. Limitação de Responsabilidade:\n
O uso do aplicativo é por sua conta e risco. Não nos responsabilizamos por qualquer dano direto, indireto, incidental, especial ou consequencial resultante do uso ou incapacidade de usar o aplicativo.

7. Modificações nos Termos:\n
Reservamos o direito de modificar estes Termos de Uso a qualquer momento. Você será notificado sobre quaisquer alterações significativas. O uso contínuo do aplicativo após as alterações constitui sua aceitação dos novos termos.

8. Encerramento da Conta:\n
Reservamos o direito de encerrar ou suspender sua conta a qualquer momento, por violações destes termos ou por qualquer motivo a nosso critério.

Agradecemos por escolher o aplicativo S.O.S PET LOVERS para conectar-se com outros amantes de animais. Esperamos que aproveite sua experiência em nossa plataforma! Se tiver alguma dúvida ou preocupação, entre em contato conosco em suporte.sospetlovers@gmail.com.\n

Ao clicar em "Aceitar" ou usar o aplicativo, você concorda com estes Termos de Uso.
''',
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

class TermosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      appBar: AppBar(
        elevation: 0,
        title: Text('Termos e condições'),
        backgroundColor: Color(0xffebaeae),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => SignupScreen()),
              (route) => false,
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'NOSSOS TERMOS E CONDIÇÕES:',
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
              width: 2000,
              height: 2000,
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
                    '''
Bem-vindo ao aplicativo S.O.S PET LOVERS! \n Antes de usar nosso aplicativo, por favor, leia atentamente estes Termos de Uso, pois eles regem o uso dos nossos serviços. Ao utilizar o aplicativo, você concorda com os seguintes termos:

1. Uso Aceitável:\n
Você concorda em usar o aplicativo de maneira responsável e de acordo com todas as leis e regulamentos aplicáveis. Não é permitido enviar conteúdo ofensivo, ilegal, difamatório ou prejudicial para outros usuários.

2. Registro e Conta:\n 
Você é responsável por manter a confidencialidade de sua conta e senha. Todas as atividades realizadas através da sua conta são de sua responsabilidade.

3. Privacidade:\n
Respeitamos sua privacidade. Ao usar o aplicativo, você concorda com nossa Política de Privacidade, que descreve como coletamos, usamos e protegemos suas informações pessoais.

4. Conteúdo Gerado pelos Usuários:\n
Ao compartilhar fotos, comentários ou outras informações no aplicativo, você concede a nós o direito de usar, modificar e distribuir esse conteúdo para fins relacionados ao aplicativo.

5. Propriedade Intelectual:\n
O conteúdo do aplicativo, incluindo logotipos, textos, imagens e funcionalidades, é protegido por direitos autorais e outras leis de propriedade intelectual. Você concorda em não copiar, reproduzir ou distribuir esse conteúdo sem permissão.

6. Limitação de Responsabilidade:\n
O uso do aplicativo é por sua conta e risco. Não nos responsabilizamos por qualquer dano direto, indireto, incidental, especial ou consequencial resultante do uso ou incapacidade de usar o aplicativo.

7. Modificações nos Termos:\n
Reservamos o direito de modificar estes Termos de Uso a qualquer momento. Você será notificado sobre quaisquer alterações significativas. O uso contínuo do aplicativo após as alterações constitui sua aceitação dos novos termos.

8. Encerramento da Conta:\n
Reservamos o direito de encerrar ou suspender sua conta a qualquer momento, por violações destes termos ou por qualquer motivo a nosso critério.

Agradecemos por escolher o aplicativo S.O.S PET LOVERS para conectar-se com outros amantes de animais. Esperamos que aproveite sua experiência em nossa plataforma! Se tiver alguma dúvida ou preocupação, entre em contato conosco em suporte.sospetlovers@gmail.com.\n

Ao clicar em "Aceitar" ou usar o aplicativo, você concorda com estes Termos de Uso.
''',
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
