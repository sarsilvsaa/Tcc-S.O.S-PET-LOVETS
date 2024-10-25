import 'dart:async';
import 'dart:typed_data';
import 'package:teste/screens/termosecondicoes.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teste/screens/resources/auth.dart';
import 'package:teste/screens/tela_inicial.dart';
import 'package:teste/widgtes/email_verification_page.dart';
import 'package:flutter/services.dart';
import 'package:teste/screens/input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:teste/widgtes/until.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() {
    // TODO: implement createState
    return _SignupScreenState();
  }
}

final FirebaseAuth _auth = FirebaseAuth.instance;

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _idadeController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _passwordConfirmationController =
      TextEditingController();

  Uint8List? _image;
  bool _isLoading = false;

  bool _agreeWithTermsAndConditions = false;
  bool _isEmailVerified = true;
  Timer? _timer;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _nameController.dispose();
    _cidadeController.dispose();
    _idadeController.dispose();
    _telefoneController.dispose();
    _passwordConfirmationController.dispose();
  }

  void checkEmailVerified() async {
    await _auth.currentUser?.reload();

    setState(() {
      _isEmailVerified = _auth.currentUser!.emailVerified;
    });

    if (_isEmailVerified) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Seu email foi verificado!")));

      _timer?.cancel();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
      );
    }
  }

  Future<void> selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  Future<void> signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUserWithEmailAndPassword(
      email: _emailController.text,
      cidade: _cidadeController.text,
      password: _passwordController.text,
      name: _nameController.text,
      idade: _idadeController.text,
      bio: _bioController.text,
      file: _image!,
    );

    await _auth.currentUser?.sendEmailVerification();

    Navigator.pushReplacementNamed(
      context,
      '/email_verification',
    );

    setState(() {
      _isLoading = false;
    });
    if (res != 'success') {
      showSnackBar(res, context);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => EmailVerificationScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF8CCCC),
      appBar: AppBar(
        backgroundColor: Color(0xffF8CCCC),
        elevation: 0,
        title: Text(
          'Cadastro - Usuário',
          style: TextStyle(
            color: Color(0xffA45309),
          ),
        ),
      ),
      body: _isEmailVerified ? _buildRegistrationForm() : _buildWaitingScreen(),
    );
  }

  Widget _buildWaitingScreen() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  Widget _buildRegistrationForm() {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color(0xffF8CCCC),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      'Meus Dados',
                      style: TextStyle(
                        color: Colors.black,
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
                CustomInputField(
                  keyboardType: TextInputType.visiblePassword,
                  hintText: "Nome",
                  controller: _nameController,
                  validator: (String? name) {
                    if (name == null || name.isEmpty) {
                      return "O nome não pode estar vazio.";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                CustomInputField(
                  keyboardType: TextInputType.phone,
                  hintText: "Telefone",
                  controller: _telefoneController,
                  inputFormatters: [
                    MaskedTextInputFormatter(mask: '(##) #####-####'),
                  ],
                  validator: (String? telefone) {
                    if (telefone == null || telefone.isEmpty) {
                      return "O número de telefone não pode estar vazio.";
                    }

                    String cleanedPhoneNumber =
                        telefone.replaceAll(RegExp(r'[^0-9]'), '');

                    if (cleanedPhoneNumber.length < 10) {
                      return "O número de telefone deve ter pelo menos 10 dígitos.";
                    }

                    return null;
                  },
                ),
                SizedBox(height: 10),
                CustomInputField(
                  keyboardType: TextInputType.streetAddress,
                  hintText: "Cidade",
                  controller: _cidadeController,
                  validator: (String? cidade) {
                    if (cidade == null || cidade.isEmpty) {
                      return "Insira sua cidade.";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      'E-mail e Senha',
                      style: TextStyle(
                        color: Colors.black,
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
                CustomInputField(
                  keyboardType: TextInputType.emailAddress,
                  hintText: "Email",
                  controller: _emailController,
                  validator: (String? email) {
                    if (email == null) {
                      return null;
                    }
                    bool emailValid = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                    ).hasMatch(email);
                    return emailValid ? null : "O email não é válido.";
                  },
                ),
                SizedBox(height: 10),
                CustomInputField(
                  keyboardType: TextInputType.visiblePassword,
                  hintText: "Senha",
                  obscureText: true,
                  controller: _passwordController,
                  validator: (String? password) {
                    if (password == null) {
                      return null;
                    }
                    if (password.length < 6) {
                      return "Senha muito curta.";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                CustomInputField(
                  keyboardType: TextInputType.visiblePassword,
                  hintText: "Confirmação da senha",
                  obscureText: true,
                  controller: _passwordConfirmationController,
                  validator: (String? password) {
                    if (password == null) {
                      return null;
                    }
                    if (password != _passwordController.text) {
                      return "Senha não compatível.";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      'CRIAÇÃO DE PERFIL',
                      style: TextStyle(
                        color: Colors.black,
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
                const SizedBox(height: 30),
                Stack(
                  children: [
                    _image != null
                        ? CircleAvatar(
                            radius: 64,
                            backgroundImage: MemoryImage(_image!),
                          )
                        : CircleAvatar(
                            radius: 64,
                            backgroundImage: NetworkImage(
                                'https://t3.ftcdn.net/jpg/00/64/67/80/360_F_64678017_zUpiZFjj04cnLri7oADnyMH0XBYyQghG.jpg'),
                          ),
                    Positioned(
                        bottom: -10,
                        left: 80,
                        child: IconButton(
                          onPressed: selectImage,
                          icon: Icon(Icons.add_a_photo),
                        ))
                  ],
                ),
                SizedBox(height: 20),
                CustomInputField(
                  keyboardType: TextInputType.text,
                  hintText: "Idade",
                  controller: _idadeController,
                  validator: (String? bio) {
                    if (bio == null || bio.isEmpty) {
                      return "Insira sua idade";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                CustomInputField(
                  keyboardType: TextInputType.text,
                  hintText: "Biografia",
                  controller: _bioController,
                  validator: (String? bio) {
                    if (bio == null || bio.isEmpty) {
                      return "Fale sobre você...";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                CustomCheckbox(
                  label: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          "Para a criação da conta, você concorda com\n os termos:",
                          style: TextStyle(
                            color: Color(0xFFa8a8a7),
                          ),
                        ),
                      ),
                      TextButton(
                        child: Text('Termos & Condições'),
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TermosPage()),
                            (route) => false,
                          );
                        },
                      ),
                    ],
                  ),
                  value: _agreeWithTermsAndConditions,
                  onChanged: (checked) => setState(
                    () => _agreeWithTermsAndConditions = checked ?? false,
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  child: Text("Registrar"),
                  onPressed: !_agreeWithTermsAndConditions ? null : signUpUser,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffF06292),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: Size(200, 50),
                  ),
                ),
                const SizedBox(height: 64),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
