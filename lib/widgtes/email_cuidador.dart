import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:teste/telas_cuidadores/tela_inicialcuidador.dart';

class EmailVerificationCuidadorScreen extends StatefulWidget {
  const EmailVerificationCuidadorScreen({Key? key}) : super(key: key);

  @override
  State<EmailVerificationCuidadorScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState
    extends State<EmailVerificationCuidadorScreen> {
  bool isEmailVerified = false;
  Timer? timer;
  bool isResendButtonEnabled = true;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser?.sendEmailVerification();
    FirebaseAuth.instance.currentUser?.reload();

    timer =
        Timer.periodic(const Duration(seconds: 3), (_) => checkEmailVerified());
  }

  checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser?.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
      isResendButtonEnabled = !isEmailVerified;
    });

    if (isEmailVerified) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Seu e-mail foi verificado!"),
        backgroundColor: Colors.green,
      ));
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomePagePetSitter()),
      );
      timer?.cancel();
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 220, 177, 177),
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/blobs.png',
                fit: BoxFit.fill,
              ),
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 100),
                  const SizedBox(height: 40),
                  const Center(
                    child: Text(
                      'Cheque o seu email!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 25,
                          color: Color(0xffA45309),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Pangolin'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Center(
                      child: FutureBuilder(
                        future: Future.delayed(Duration(seconds: 2)),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator(); // Adicione um indicador de carregamento se estiver aguardando.
                          } else if (snapshot.hasError) {
                            return Text(
                                'Erro ao carregar dados.'); // Adicione uma mensagem de erro se ocorrer um erro.
                          } else {
                            final email =
                                FirebaseAuth.instance.currentUser?.email ??
                                    'N/A';
                            return Text(
                              'Nós mandamos um e-mail em $email',
                              style: TextStyle(
                                color: Color(0xffA45309),
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Pangolin',
                              ),
                              textAlign: TextAlign.center,
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 60),
                  isEmailVerified
                      ? const Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 50,
                        )
                      : const Center(child: CircularProgressIndicator()),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.0),
                    child: Center(
                      child: Text(
                        'Verificando o e-mail...',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xffA45309),
                            fontFamily: 'Pangolin'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 57),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isEmailVerified
                            ? Color.fromARGB(255, 230, 138, 217)
                            : Color.fromARGB(
                                255, 230, 114, 153), // Cor de fundo
                        disabledBackgroundColor: Colors.white, // Cor do texto
                      ),
                      child: Text(
                        isEmailVerified
                            ? 'E-mail Verificado'
                            : 'Reenviar E-mail',
                        style: TextStyle(fontSize: 16), // Estilo do texto
                      ),
                      onPressed: isResendButtonEnabled
                          ? () {
                              try {
                                FirebaseAuth.instance.currentUser
                                    ?.sendEmailVerification();
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content:
                                      Text("E-mail de verificação reenviado!"),
                                  backgroundColor: Colors.pink,
                                ));
                              } catch (e) {
                                debugPrint('$e');
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                      "Erro ao reenviar e-mail de verificação."),
                                  backgroundColor: Colors.red,
                                ));
                              }
                            }
                          : null,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
