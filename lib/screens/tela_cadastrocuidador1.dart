import 'dart:async';
import 'dart:typed_data';
import 'package:teste/screens/termosecondicoes.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teste/screens/tela_decisao1.dart';
import 'package:teste/screens/resources/auth1.dart';
import 'package:teste/telas_cuidadores/tela_inicialcuidador.dart';
import 'package:teste/widgtes/email_cuidador.dart';
import 'package:teste/widgtes/until.dart';
import 'package:flutter/services.dart';
import 'package:teste/screens/input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:teste/screens/tela_ajustes.dart';

class RegistroCuidadorPage extends StatefulWidget {
  const RegistroCuidadorPage({Key? key}) : super(key: key);

  @override
  _RegistroCuidadorPageState createState() {
    // TODO: implement createState
    return _RegistroCuidadorPageState();
  }
}

final FirebaseAuth _auth = FirebaseAuth.instance;

class _RegistroCuidadorPageState extends State<RegistroCuidadorPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _passwordConfirmationController =
      TextEditingController();
  final TextEditingController _expVetController = TextEditingController();
  final TextEditingController _expInjController = TextEditingController();
  final TextEditingController _expOraController = TextEditingController();
  final TextEditingController _porteController = TextEditingController();
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _distController = TextEditingController();
  final TextEditingController _disponibilidadeController =
      TextEditingController();
  final TextEditingController _redesocialController = TextEditingController();

  Uint8List? _image;
  double _valor = 0.0;
  bool _isLoading = false;

  String _selectedUnit = 'Metros';
  List<String> _unitOptions = ['Metros', 'Quilômetros'];

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
    _telefoneController.dispose();
    _passwordConfirmationController.dispose();
    _expOraController.dispose();
    _expInjController.dispose();
    _expVetController.dispose();
    _distController.dispose();
    _porteController.dispose();
    _disponibilidadeController.dispose();
    _redesocialController.dispose();
    _controller.dispose();
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
        MaterialPageRoute(builder: (context) => HomePagePetSitter()),
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
    String res = await AuthMethods1().signUpUserWithEmailAndPassword1(
      email: _emailController.text,
      cidade: _cidadeController.text,
      password: _passwordController.text,
      name: _nameController.text,
      bio: _bioController.text,
      expInj: _expInjController.text,
      expOra: _expOraController.text,
      expVet: _expVetController.text,
      dist: _distController.text,
      controller: _controller.text,
      porte: _porteController.text,
      telefone: _telefoneController.text,
      redesocial: _redesocialController.text,
      disponilibidade: _disponibilidadeController.text,
      file: _image!,
    );

    await _auth.currentUser?.sendEmailVerification();

    try {
      await _auth.currentUser?.sendEmailVerification();
    } catch (e) {
      print('Erro ao enviar verificação por e-mail: $e');
    }

    Navigator.pushReplacementNamed(
      context,
      '/email_verification_caregiver',
    );

    setState(() {
      _isLoading = false;
    });
    if (res != 'Sucesso!') {
      showSnackBar(res, context);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => MyDecisao1()),
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
          'Cadastro - Cuidador',
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
    AppTheme appTheme = Provider.of<AppTheme>(context);
    // TODO: implement build
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
              SizedBox(height: 10),
              Text(
                'CRIAÇÃO DO PERFIL:',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'WorkSans',
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
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
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'SERVIÇOS E PREÇOS',
                    style: TextStyle(
                      color: Color(0xffA45309),
                      fontSize: 20,
                      fontFamily: 'Pangolin',
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
              Row(
                children: [
                  Text(
                    'Qual será o valor de seus serviços?',
                    style: TextStyle(
                      color: Color(0xff000000),
                      fontSize: 15,
                      fontFamily: 'WorkSans',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                onChanged: (text) {
                  setState(() {
                    // Pega o valor da caixa de texto e limita a 100
                    _valor = double.tryParse(text) ?? 0.0;
                    _valor = _valor.clamp(0.0, 100.0);
                    // Atualiza o texto na caixa de texto para refletir o valor limitado
                    _controller.text = _valor.toString();
                    _controller.selection = TextSelection.fromPosition(
                      TextPosition(offset: _controller.text.length),
                    );
                  });
                },
                decoration: InputDecoration(
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                  hintText: "Insira o valor de seus serviços",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    // Define as bordas arredondadas
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(children: [
                Text(
                  'Possuí experiência com medicações orais?',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: appTheme.modoNoturno ? Colors.white : Colors.black,
                    fontSize: 15,
                    fontFamily: 'WorkSans',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]),
              SizedBox(height: 10),
              CustomInputField(
                keyboardType: TextInputType.text,
                hintText: "Sim ou Não",
                controller: _expOraController,
              ),
              Row(children: [
                Text(
                  'Possuí experiência com medicações injetáveis?',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: appTheme.modoNoturno ? Colors.white : Colors.black,
                    fontSize: 15,
                    fontFamily: 'WorkSans',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]),
              SizedBox(height: 10),
              CustomInputField(
                keyboardType: TextInputType.text,
                hintText: "Sim ou Não",
                controller: _expInjController,
              ),
              SizedBox(height: 10),
              Row(children: [
                Text(
                  'Possuí experiência veterinária?',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: appTheme.modoNoturno ? Colors.white : Colors.black,
                    fontSize: 15,
                    fontFamily: 'WorkSans',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]),
              SizedBox(height: 10),
              CustomInputField(
                keyboardType: TextInputType.text,
                hintText: "Sim ou Não",
                controller: _expVetController,
              ),
              SizedBox(height: 10),
              Divider(
                color: Color(0xffA45309),
                thickness: 4,
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    'PORTE',
                    style: TextStyle(
                      color: Color(0xffA45309),
                      fontSize: 20,
                      fontFamily: 'Pangolin',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Até qual porte você atende?',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'WorkSans',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    'Pequeno(5-10Kg), Médio(11-25Kg) e Grande(26-44Kg)',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'WorkSans',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              CustomInputField(
                keyboardType: TextInputType.text,
                hintText: "Ex. Pequeno",
                controller: _porteController,
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Disponibilize os dias em que você esteja\n livre geralmente para trabalhar!',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'WorkSans',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              CustomInputField(
                keyboardType: TextInputType.visiblePassword,
                hintText: "Disponibilidade dos dias da semana",
                controller: _disponibilidadeController,
                validator: (String? name) {
                  if (name == null || name.isEmpty) {
                    return "Deve ter dias selecionados.";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Distância Máxima',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'WorkSans',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Até qual distância você pode atender?',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'WorkSans',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: DropdownButton<String>(
                      value: _selectedUnit,
                      items: _unitOptions.map((String unit) {
                        return DropdownMenuItem<String>(
                          value: unit,
                          child: Text(unit),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          _selectedUnit = value!;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                      width:
                          30.0), // Adiciona um espaço entre o DropdownButton e a caixa numérica
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    width: 100.0, // Ajuste a largura conforme necessário
                    child: TextField(
                      controller: _distController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Distância',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Qual é sua rede social? ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'WorkSans',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Para que seus clientes possam te conhecer \nmelhor, que tal mostrar a eles sua rede social?',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'WorkSans',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              CustomInputField(
                keyboardType: TextInputType.text,
                hintText: "Instagram: @pessoa123 ou Linkedin:... ",
                controller: _redesocialController,
              ),
              SizedBox(height: 20.0),
              CustomCheckbox(
                label: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Text(
                        "Para a criação da conta, você concorda \ncom os termos:",
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
                              builder: (context) => TermosCuidadorPage()),
                          (route) => false,
                        );
                      },
                    ),
                  ],
                ),
                value: _agreeWithTermsAndConditions,
                onChanged: (checked) {
                  print("Checkbox value: $checked");
                  setState(
                      () => _agreeWithTermsAndConditions = checked ?? false);
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                child: Text("Registrar-se"),
                onPressed: !_agreeWithTermsAndConditions ? null : signUpUser,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffF06292),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: Size(200, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
