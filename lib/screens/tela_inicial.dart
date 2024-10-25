import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/gmail/v1.dart';
import 'package:teste/screens/scrollablecolumn.dart';
import 'package:teste/screens/tela_ajustes.dart';
import 'package:teste/screens/tela_perfil.dart';
import 'package:teste/screens/tela_cuidadores.dart';
import 'package:teste/screens/tela_meupet.dart';
import 'package:teste/screens/tela_adocao.dart';
import 'package:teste/screens/tela_clinicas.dart';
import 'package:teste/screens/tela_sobreoapp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class CustomPageRouteBuilder extends PageRouteBuilder {
  final Widget page;

  CustomPageRouteBuilder({required this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return page;
          },
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            const begin = Offset(1.0, 0.0);

            const end = Offset.zero;

            const curve = Curves.easeInOut;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            var offsetAnimation = animation.drive(tween);

            var fadeAnimation =
                animation.drive(Tween<double>(begin: 0.0, end: 1.0));

            return FadeTransition(
              opacity: fadeAnimation,
              child: SlideTransition(
                position: offsetAnimation,
                child: child,
              ),
            );
          },
        );
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late User _user;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser!;
  }

  void checkPetStatus() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String userId = user.uid;

      DocumentSnapshot profileSnapshot =
          await FirebaseFirestore.instance.collection('pets').doc(userId).get();

      if (profileSnapshot.exists) {
        Navigator.pushReplacement(
          context,
          CustomPageRouteBuilder(
            page: PetProfileScreen(
              petId: userId,
              name: profileSnapshot['name'],
              bio: profileSnapshot['bio'],
              idade: profileSnapshot['idade'],
              raca: profileSnapshot['raca'],
              especie: profileSnapshot['especie'],
              peso: profileSnapshot['peso'],
              sexo: profileSnapshot['sexo'],
              castrado: profileSnapshot['castrado'],
              profileImagePet: profileSnapshot['profileImagePet'],
              hasDeficiencia: profileSnapshot['hasDeficiencia'],
              hasMicrochip: profileSnapshot['hasMicrochip'],
              microchip: profileSnapshot['microchip'],
              deficiencia: profileSnapshot['deficiencia'],
            ),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          CustomPageRouteBuilder(
            page: MyPerfilPetPage(),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return Container(
        child: Text("Entrada"),
      );
    }
    AppTheme appTheme = Provider.of<AppTheme>(context);

    return Scaffold(
      backgroundColor:
          appTheme.modoNoturno ? Color(0xff353333) : Color(0xffffffff),
      appBar: AppBar(
        backgroundColor:
            appTheme.modoNoturno ? Color(0xffB94F4F) : Color(0xffF8CCCC),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: appTheme.modoNoturno
                    ? Color(0xff754343)
                    : Color(0xffffb6b2),
              ),
              child: IconButton(
                icon: Icon(
                  Icons.person,
                  color: Color(0xffffffff),
                ),
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileScreen(
                          uid: FirebaseAuth.instance.currentUser!.uid),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        elevation: 0,
        backgroundColor:
            appTheme.modoNoturno ? Color(0xffB94F4F) : Color(0xffffffff),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: appTheme.modoNoturno
                    ? Color(0xffB94F4F)
                    : Color(0xffEBAEAE),
              ),
              child: Text(
                "Seja bem vindo(a)! ${_user.email} ",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Pangolin',
                  fontSize: 25,
                ),
              ),
            ), //
            ListTile(
              title: Text(
                'Início',
                style: TextStyle(
                  color: appTheme.modoNoturno
                      ? Color(0xffffffff)
                      : Color(0xff000000),
                ),
              ),
              leading: Icon(Icons.home),
              iconColor:
                  appTheme.modoNoturno ? Color(0xffffffff) : Color(0xff000000),
              onTap: () {
                Navigator.push(
                  context,
                  CustomPageRouteBuilder(
                    page: MyHomePage(),
                  ),
                );
              },
            ),
            Divider(
              thickness: 1,
              indent: 15,
              endIndent: 15,
              color:
                  appTheme.modoNoturno ? Color(0xffffffff) : Color(0xff000000),
            ),

            ListTile(
              leading: Icon(Icons.pets),
              title: Text(
                'Meu Pet',
                style: TextStyle(
                  color: appTheme.modoNoturno
                      ? Color(0xffffffff)
                      : Color(0xff000000),
                ),
              ),
              iconColor:
                  appTheme.modoNoturno ? Color(0xffffffff) : Color(0xff000000),
              onTap: () {
                checkPetStatus();
              },
            ),
            Divider(
              thickness: 1,
              indent: 15,
              endIndent: 15,
              color: Color(0xff000000),
            ),
            ListTile(
              leading: Icon(Icons.badge),
              title: Text(
                'Cuidadores',
                style: TextStyle(
                  color: appTheme.modoNoturno
                      ? Color(0xffffffff)
                      : Color(0xff000000),
                ),
              ),
              iconColor:
                  appTheme.modoNoturno ? Color(0xffffffff) : Color(0xff000000),
              onTap: () {
                Navigator.push(
                  context,
                  CustomPageRouteBuilder(
                    page: CuidadoresScreen(),
                  ),
                );
              },
            ),

            Divider(
              thickness: 1,
              indent: 15,
              endIndent: 15,
              color: Color(0xff000000),
            ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text(
                'Adoção',
                style: TextStyle(
                  color: appTheme.modoNoturno
                      ? Color(0xffffffff)
                      : Color(0xff000000),
                ),
              ),
              iconColor:
                  appTheme.modoNoturno ? Color(0xffffffff) : Color(0xff000000),
              onTap: () {
                Navigator.push(
                  context,
                  CustomPageRouteBuilder(
                    page: AdocaoPage(),
                  ),
                );
              },
            ),
            Divider(
              thickness: 1,
              indent: 15,
              endIndent: 15,
              color: Color(0xff000000),
            ),
            ListTile(
              leading: Icon(Icons.local_hospital_outlined),
              title: Text(
                'Clínicas',
                style: TextStyle(
                  color: appTheme.modoNoturno
                      ? Color(0xffffffff)
                      : Color(0xff000000),
                ),
              ),
              iconColor:
                  appTheme.modoNoturno ? Color(0xffffffff) : Color(0xff000000),
              onTap: () {
                Navigator.push(
                  context,
                  CustomPageRouteBuilder(
                    page: MapPage(),
                  ),
                );
              },
            ),
            Divider(
              thickness: 1,
              indent: 15,
              endIndent: 15,
              color: Color(0xff000000),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text(
                'Ajustes',
                style: TextStyle(
                  color: appTheme.modoNoturno
                      ? Color(0xffffffff)
                      : Color(0xff000000),
                ),
              ),
              iconColor:
                  appTheme.modoNoturno ? Color(0xffffffff) : Color(0xff000000),
              onTap: () {
                Navigator.push(
                  context,
                  CustomPageRouteBuilder(
                    page: MySettingsPage(),
                  ),
                );
              },
            ),
            Divider(
              thickness: 1,
              indent: 15,
              endIndent: 15,
              color: Color(0xff000000),
            ),
            ListTile(
              leading: Icon(Icons.android_outlined),
              title: Text(
                'Sobre o aplicativo',
                style: TextStyle(
                  color: appTheme.modoNoturno
                      ? Color(0xffffffff)
                      : Color(0xff000000),
                ),
              ),
              iconColor:
                  appTheme.modoNoturno ? Color(0xffffffff) : Color(0xff000000),
              onTap: () {
                Navigator.push(
                  context,
                  CustomPageRouteBuilder(
                    page: SobreoappPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding:
            EdgeInsets.only(top: 20.0), // Ajuste o valor conforme necessário

        child: Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 310.0,
                enableInfiniteScroll: true,
                autoPlay: false,
                autoPlayCurve: Curves.fastOutSlowIn,
                pauseAutoPlayOnTouch: true,
                enlargeCenterPage: true,
              ),
              items: [0, 1, 2, 3].map((index) {
                return Builder(
                  builder: (BuildContext context) {
                    return GestureDetector(
                      onTap: () {
                        if (index == 0) {
                          Navigator.push(
                            context,
                            CustomPageRouteBuilder(
                              page: SecondPage(),
                            ),
                          );
                        } else if (index == 1) {
                          Navigator.push(
                            context,
                            CustomPageRouteBuilder(
                              page: ThirdPage(),
                            ),
                          );
                        } else if (index == 2) {
                          Navigator.push(
                            context,
                            CustomPageRouteBuilder(
                              page: FourthPage(),
                            ),
                          );
                        } else if (index == 3) {
                          Navigator.push(
                            context,
                            CustomPageRouteBuilder(
                              page: FiftenPage(),
                            ),
                          );
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 6.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Colors.grey,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.asset(
                            'assets/images/carrosel/banner${index + 1}.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 40),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  CustomPageRouteBuilder(
                    page: AdocaoPage(),
                  ),
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 250,
                child: Image.asset(
                  'assets/images/carrosel/banneradocao.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppTheme appTheme = Provider.of<AppTheme>(context);
    return Scaffold(
      backgroundColor:
          appTheme.modoNoturno ? Color(0xff353333) : Color(0xffffffff),
      appBar: AppBar(
        title: Text('Dicas de Cuidados'),
        backgroundColor:
            appTheme.modoNoturno ? Color(0xffB94F4F) : Color(0xffF8CCCC),
      ),
      body: ListView(
        children: [
          SizedBox(height: 15),
          Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color:
                  appTheme.modoNoturno ? Color(0xffB94F4F) : Color(0xffF8CCCC),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              children: [
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'assets/banner/cuidados.png',
                      fit: BoxFit.cover,
                      height: 200,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "Ter um animal de estimação é uma jornada incrível, repleta de amor e alegria. Para garantir que seu companheiro peludo viva a vida mais feliz e saudável possível, aqui estão 10 dicas carinhosas para você seguir:",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: appTheme.modoNoturno
                            ? Color(0xffFFFFFF)
                            : Color(0xff000000),
                        fontSize: 15,
                        fontFamily: 'WorkSans',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Refeições Deliciosas e Nutritivas:\nMime seu amiguinho com uma dieta balanceada, adaptada à sua idade e necessidades específicas.\n\nExercício é Purrrfeito:\nMantenha seu pet ativo com brincadeiras diárias. Exercícios não são só para humanos!\n\nCheck-ups Veterinários:\nFaça visitas regulares ao veterinário para garantir que seu peludo esteja sempre com a saúde em dia.\n\nPêlos Lindos e Bem-Cuidados:\nEscove e cuide do pelo do seu bichinho para deixá-lo sempre impecável.\n\nDentes Saudáveis, Sorriso Feliz:\nNão esqueça da higiene bucal! Escovar os dentes ou dar brinquedos dentários fazem maravilhas.\n\nAmbiente Seguro e Aconchegante:\nCrie um lar seguro, livre de perigos, e com um cantinho confortável para seu pet descansar.\n\nIdentificação com Estilo:\nDeixe seu amigo fashion com uma coleira de identificação. Microchipar também é uma opção bacana!\n\nSocialização Divertida:\nIncentive a socialização desde pequeno. Amigos peludos e humanos são sempre bem-vindos.\n\nBrincadeiras que Cativam:\nProporcione briquedos interessantes para manter o corpo e a mente do seu pet em forma.\n\nTreino com Amor:\nEnsine truques e comportamentos positivos. Paciência e amor sempre rendem os melhores resultados.",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: appTheme.modoNoturno
                            ? Color(0xffFFFFFF)
                            : Color(0xff000000),
                        fontSize: 15,
                        fontFamily: 'WorkSans',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Lembre-se, cada animalzinho é único. Observe, adapte e, acima de tudo, compartilhe amor e carinho. Seu pet vai agradecer com ronronados, latidos ou qualquer que seja sua forma especial de demonstrar felicidade. 💖🐾",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: appTheme.modoNoturno
                            ? Color(0xffFFFFFF)
                            : Color(0xff000000),
                        fontSize: 15,
                        fontFamily: 'WorkSans',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ThirdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppTheme appTheme = Provider.of<AppTheme>(context);
    return Scaffold(
      backgroundColor:
          appTheme.modoNoturno ? Color(0xff353333) : Color(0xffffffff),
      appBar: AppBar(
        title: Text('Importância do apego!'),
        backgroundColor:
            appTheme.modoNoturno ? Color(0xffB94F4F) : Color(0xffF8CCCC),
      ),
      body: ListView(
        children: [
          SizedBox(height: 15),
          Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color:
                  appTheme.modoNoturno ? Color(0xffB94F4F) : Color(0xffF8CCCC),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              children: [
                SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/banner/amor.png',
                    fit: BoxFit.cover,
                    height: 200,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "Oi pessoal, tudo bem? Hoje, queria compartilhar algo muito especial com vocês - cuidados dedicados aos nossos cãezinhos que têm necessidades diferentes. Ter um pet com deficiências pode ser uma jornada única, cheia de desafios, mas também repleta de amor e gratificação. Aqui estão alguns cuidados específicos que podem fazer toda a diferença na vida desses amiguinhos peludos.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: appTheme.modoNoturno
                            ? Color(0xffFFFFFF)
                            : Color(0xff000000),
                        fontSize: 15,
                        fontFamily: 'WorkSans',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "1. Uma Casa Adaptada:\nVamos começar tornando nosso lar mais acolhedor para eles. Rampas suaves e tapetes antiderrapantes ajudam a criar um ambiente seguro e acessível para cães com mobilidade reduzida. \n\n2. Treinamento Personalizado:\nAssim como cada um de nós, nossos amigos de quatro patas tem suas próprias necessidades. Um treinamento adaptado, com comandos específicos e muita paciência, pode ser a chave para uma convivência harmoniosa. \n\n3. Passeios Planejados:\nAo sair para passear, considere as necessidades do seu cãozinho. Arnês especial, carrinho de transporte ou uma faixa de suporte podem ser aliados valiosos para garantir passeios confortáveis e seguros. \n\n4. Saúde em Foco:\nConsultas regulares ao veterinário são essenciais. Eles nos orientarão sobre dieta, medicação e outros cuidados específicos para garantir que nossos pets estejam sempre saudáveis e felizes.\n\n5. Estimulação Mental:\nPara cães com deficiências visuais ou auditivas, a estimulação mental é fundamental. Brinquedos sensoriais e atividades interativas ajudam a manter suas mentes ativas e felizes. \n\n6. Socialização Positiva:\nAssim como qualquer outro cão, nossos amigos especiais precisam de interação social. Introduza-os gradualmente a novos ambientes, pessoas e outros animais, proporcionando experiências positivas. \n\n7. Alimentação Adequada:\nA alimentação certa é crucial. Converse com o veterinário para garantir que a dieta do seu pet atenda às suas necessidades individuais, considerando fatores como peso e condições de saúde.\n\n8. Ambiente Seguro:\nNo quintal ou jardim, certifique-se de que o ambiente seja seguro. Remova objetos perigosos, evite plantas tóxicas e crie áreas sombreadas para protegê-los do sol.\n\n9. Amor Incondicional:\nAcima de tudo, ofereça amor incondicional. Com apoio e carinho, nossos cães com necessidades diferentes podem levar vidas cheias de alegria.",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: appTheme.modoNoturno
                            ? Color(0xffFFFFFF)
                            : Color(0xff000000),
                        fontSize: 15,
                        fontFamily: 'WorkSans',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Lembre-se, cada cão é único, e os cuidados específicos podem variar. Converse com o veterinário para desenvolver um plano personalizado para o seu pet. Ao dedicar tempo e esforço aos cuidados específicos, estaremos proporcionando uma vida cheia de amor e alegria para esses amigos especiais. Eles podem ter necessidades diferentes, mas uma coisa é certa - o amor deles por nós é tão único quanto eles são. 🐾💕",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: appTheme.modoNoturno
                            ? Color(0xffFFFFFF)
                            : Color(0xff000000),
                        fontSize: 15,
                        fontFamily: 'WorkSans',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FourthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppTheme appTheme = Provider.of<AppTheme>(context);
    return Scaffold(
      backgroundColor:
          appTheme.modoNoturno ? Color(0xff353333) : Color(0xffffffff),
      appBar: AppBar(
        title: Text('Semelhanças Entre Cães e Gatos'),
        backgroundColor:
            appTheme.modoNoturno ? Color(0xffB94F4F) : Color(0xffF8CCCC),
      ),
      body: ScrollableColumn(
        children: [
          SizedBox(height: 15),
          Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color:
                  appTheme.modoNoturno ? Color(0xffB94F4F) : Color(0xffF8CCCC),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              children: [
                SizedBox(height: 20),
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(20), // Define a borda arredondada
                  child: Image.asset(
                    'assets/banner/caoegato.png',
                    fit: BoxFit.cover,
                    height: 200,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "🐾Semelhanças Entre Cães e Gatos🐾\n\nCães e gatos, embora diferentes, compartilham várias características encantadoras que conquistam nossos corações:\n\n1. Amor pelo Cochilo: Ambos são mestres no quesito soneca, encontrando os lugares mais confortáveis para tirar aquele soninho gostoso.\n\n2. Expressões Fofas: Cães e gatos têm um jeito único de nos olhar, derretendo nossos corações com expressões adoráveis que nos fazem sorrir.\n3\n. Exploradores Domésticos: Adoram passear pela casa com uma elegância peculiar, mostrando que cada cantinho é parte do seu reino.\n\n4. Teatro nas Emoções: Quando querem atenção, não hesitam em fazer um drama encantador, seja para ganhar um carinho extra ou conquistar um petisco.\n\n5. Personalidade Distinta: Assim como nós, cada um tem sua personalidade única. Alguns são extrovertidos e brincalhões, enquanto outros são mais reservados e observadores. Em resumo, cães e gatos têm jeitos especiais de nos encantar.\n\nSuas semelhanças e diferenças tornam nossa convivência com eles uma experiência única e cheia de amor.\n🐶❤️🐱",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: appTheme.modoNoturno
                            ? Color(0xffFFFFFF)
                            : Color(0xff000000),
                        fontSize: 15,
                        fontFamily: 'WorkSans',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FiftenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppTheme appTheme = Provider.of<AppTheme>(context);
    return Scaffold(
      backgroundColor:
          appTheme.modoNoturno ? Color(0xff353333) : Color(0xffffffff),
      appBar: AppBar(
        title: Text('CUIDADO!'),
        backgroundColor:
            appTheme.modoNoturno ? Color(0xffB94F4F) : Color(0xffF8CCCC),
      ),
      body: ScrollableColumn(
        children: [
          SizedBox(height: 15),
          Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color:
                  appTheme.modoNoturno ? Color(0xffB94F4F) : Color(0xffF8CCCC),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              children: [
                SizedBox(height: 20),
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(20), // Define a borda arredondada
                  child: Image.asset(
                    'assets/banner/cuidado.jpg',
                    fit: BoxFit.cover,
                    height: 200,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "Prezados usuários do aplicativo S.O.S PET LOVERS,\n\nÀ medida que incorporamos a tecnologia em nossas vidas para facilitar o cuidado e a gestão de informações sobre nossos queridos animais de estimação, é crucial manter uma abordagem cautelosa em relação à segurança de nossas informações pessoais. Abaixo, apresentamos orientações fundamentais para garantir a confidencialidade e integridade de seus dados ao utilizar aplicativos dedicados a animais:\n\nCredenciais de Acesso Fortes: Opte por senhas robustas e exclusivas para sua conta no aplicativo. Evite utilizar informações facilmente acessíveis, como datas de nascimento ou nomes comuns, e considere o uso de autenticação de dois fatores, se disponível.\n\nPermissões de Aplicativos: Revise e compreenda as permissões solicitadas pelo aplicativo. Conceda apenas as permissões estritamente necessárias para a funcionalidade desejada, limitando assim o acesso a informações sensíveis.\n\nAtualizações e Patches: Mantenha o aplicativo sempre atualizado, instalando as atualizações e patches de segurança fornecidos pelos desenvolvedores. Essas atualizações frequentes frequentemente abordam vulnerabilidades de segurança.\n\nComunicação Segura: Se o aplicativo oferecer funcionalidades de comunicação, esteja atento às informações compartilhadas. Evite divulgar detalhes pessoais desnecessários e esteja ciente da audiência para a qual suas mensagens são destinadas.\n\nTransparência de Dados: Certifique-se de compreender como o aplicativo trata e armazena seus dados. Leia as políticas de privacidade e termos de serviço para garantir que suas informações estejam protegidas conforme suas expectativas.\n\nConsciência de Phishing: Mantenha-se vigilante contra tentativas de phishing. Não clique em links suspeitos e evite fornecer informações confidenciais fora do ambiente seguro do aplicativo.\n\nAo adotar essas práticas, você fortalece a segurança de suas informações pessoais e contribui para a construção de uma comunidade digital centrada no cuidado responsável de animais. A segurança é fundamental para uma experiência positiva e confiável em aplicativos dedicados ao bem-estar animal.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: appTheme.modoNoturno
                            ? Color(0xffFFFFFF)
                            : Color(0xff000000),
                        fontSize: 15,
                        fontFamily: 'WorkSans',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
