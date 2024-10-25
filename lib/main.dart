import 'package:flutter/material.dart';
import 'package:teste/screens/tela_decisao1.dart';
import 'package:teste/screens/tela_entrada.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:teste/screens/tela_inicial.dart';
import 'package:teste/screens/tela_login.dart';
import 'package:provider/provider.dart';
import 'package:teste/telas_cuidadores/tela_inicialcuidador.dart';
import 'package:teste/widgtes/email_verification_page.dart';
import 'package:teste/widgtes/email_cuidador.dart';
import 'package:teste/screens/tela_ajustes.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:teste/widgtes/password.dart';
import 'package:teste/screens/tela_introducao.dart';

FirebaseAnalytics? analytics;

FirebaseAnalyticsObserver? observer;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    FirebaseApp app = await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyDa8KfGnWIx4s6AIkcMw33GmwOO43RdKfs",
        appId: '1:293076145285:web:13f87dcaf5c0c28b3545ec',
        messagingSenderId: '293076145285',
        projectId: 'bdtcc-e0559',
        storageBucket: "bdtcc-e0559.appspot.com",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AppTheme>(create: (context) => AppTheme()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'S.O.S PET LOVERS',
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => LoginPage(),
        '/home': (context) => MyHomePage(),
        '/home_caregiver': (context) => HomePagePetSitter(),
        '/introducao': (context) => IntroductionUserPage(),
        '/forgotpassword': (context) => ForgotPasswordScreen(),
        '/email_verification': (context) => EmailVerificationScreen(),
        '/email_verification_caregiver': (context) =>
            EmailVerificationCuidadorScreen(),
        '/decisao': (context) => MyDecisao1()
      },
    );
  }
}
