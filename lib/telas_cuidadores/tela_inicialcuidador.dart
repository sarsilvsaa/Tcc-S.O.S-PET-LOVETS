import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:teste/telas_cuidadores/bloconotas.dart';
import 'dart:async';
import 'package:teste/screens/tela_meupet.dart';
import 'package:teste/screens/tela_adocao.dart';
import 'package:teste/screens/tela_clinicas.dart';
import 'package:teste/screens/tela_sobreoapp.dart';
import 'package:teste/telas_cuidadores/tela_ajustescuidador.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:teste/telas_cuidadores/tela_perfil_cuidador.dart';

class HomePagePetSitter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppTheme>(builder: (context, appTheme, child) {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        return Container(
          child: Text("User não encontrado!"),
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
                  color: Color(0xffffb6b2),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.person,
                    color: Color(0xffffffff),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileCuidadorScreen(
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
                  ('Seja bem vindo(a) /n ${user.email}'),
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Pangolin',
                    fontSize: 25,
                  ),
                ),
              ),
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
                iconColor: appTheme.modoNoturno
                    ? Color(0xffffffff)
                    : Color(0xff000000),
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomePagePetSitter()),
                    (route) => false,
                  );
                },
              ),
              Divider(
                thickness: 1,
                indent: 15,
                endIndent: 15,
                color: appTheme.modoNoturno
                    ? Color(0xffffffff)
                    : Color(0xff000000),
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
                iconColor: appTheme.modoNoturno
                    ? Color(0xffffffff)
                    : Color(0xff000000),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyPerfilPetPage()),
                  );
                },
              ),
              Divider(
                thickness: 1,
                indent: 15,
                endIndent: 15,
                color: appTheme.modoNoturno
                    ? Color(0xffffffff)
                    : Color(0xff000000),
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
                iconColor: appTheme.modoNoturno
                    ? Color(0xffffffff)
                    : Color(0xff000000),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AdocaoPage()),
                  );
                },
              ),
              Divider(
                thickness: 1,
                indent: 15,
                endIndent: 15,
                color: appTheme.modoNoturno
                    ? Color(0xffffffff)
                    : Color(0xff000000),
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
                iconColor: appTheme.modoNoturno
                    ? Color(0xffffffff)
                    : Color(0xff000000),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MapPage()),
                  );
                },
              ),
              Divider(
                thickness: 1,
                indent: 15,
                endIndent: 15,
                color: appTheme.modoNoturno
                    ? Color(0xffffffff)
                    : Color(0xff000000),
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
                iconColor: appTheme.modoNoturno
                    ? Color(0xffffffff)
                    : Color(0xff000000),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MySettingsCuidadorPage()),
                  );
                },
              ),
              Divider(
                thickness: 1,
                indent: 15,
                endIndent: 15,
                color: appTheme.modoNoturno
                    ? Color(0xffffffff)
                    : Color(0xff000000),
              ),
              ListTile(
                leading: Icon(Icons.chat),
                title: Text(
                  'Chat',
                  style: TextStyle(
                    color: appTheme.modoNoturno
                        ? Color(0xffffffff)
                        : Color(0xff000000),
                  ),
                ),
                iconColor: appTheme.modoNoturno
                    ? Color(0xffffffff)
                    : Color(0xff000000),
                onTap: () {
                  //Navigator.push(
                  //context,
                  //  MaterialPageRoute(builder: (context) => ChatScreen()),
                  //);
                },
              ),
              Divider(
                thickness: 1,
                indent: 15,
                endIndent: 15,
                color: appTheme.modoNoturno
                    ? Color(0xffffffff)
                    : Color(0xff000000),
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
                iconColor: appTheme.modoNoturno
                    ? Color(0xffffffff)
                    : Color(0xff000000),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SobreoappPage()),
                  );
                },
              ),
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: 300.0,
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
                              MaterialPageRoute(
                                builder: (context) => SecondPage(),
                              ),
                            );
                          } else if (index == 1) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ThirdPage(),
                              ),
                            );
                          } else if (index == 2) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FourthPage(),
                              ),
                            );
                          } else if (index == 3) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FiftenPage(),
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
                              'assets/images/carroselcui/banner${index + 1}.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Card(
                      color: appTheme.modoNoturno
                          ? Color(0xff754343)
                          : Color(0xffF8CCCC),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NotepadApp()),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(
                                Icons.calendar_today,
                                size: 48,
                                color: appTheme.modoNoturno
                                    ? Color(0xffffffff)
                                    : Color(0xff000000),
                              ),
                              Text(
                                'Datas Agendadas',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: appTheme.modoNoturno
                                      ? Color(0xffffffff)
                                      : Color(0xff000000),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF8CCCC),
      appBar: AppBar(
        title: Text('DICAS DE CUIDADOS'),
        backgroundColor: Color(0xffebaeae),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Divider(
              color: Color(0xffA45309),
              thickness: 4,
            ),
            SizedBox(height: 10),
            Container(
              width: 300,
              height: 300,
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
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/animaisss.png', // Caminho para a sua imagem na pasta assets
                      width: 200, // Largura da imagem
                      height: 150, // Altura da imagem
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class ThirdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IMPORTANCIA DO APEGO'),
      ),
      body: Center(
        child: Text('Conteúdo da terceira página'),
      ),
    );
  }
}

class FourthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ARTIGO: SEMELHAÇAS...'),
      ),
      body: Center(
        child: Text('Conteúdo da quarta página'),
      ),
    );
  }
}

class FiftenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CUIDADO!'),
      ),
      body: Center(
        child: Text('Conteúdo da quinta página'),
      ),
    );
  }
}
