import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:teste/screens/tela_ajustes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teste/screens/resources/storage_methods.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:teste/screens/tela_inicial.dart';

class MyPerfilPetPage extends StatefulWidget {
  const MyPerfilPetPage({Key? key}) : super(key: key);

  @override
  _MyPerfilPetPage createState() => _MyPerfilPetPage();
}

class _MyPerfilPetPage extends State<MyPerfilPetPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idadeController = TextEditingController();
  final TextEditingController _especieController = TextEditingController();
  final TextEditingController _racaController = TextEditingController();
  final TextEditingController _pesoController = TextEditingController();
  final TextEditingController _sexoController = TextEditingController();
  final TextEditingController _castradoController = TextEditingController();
  final TextEditingController _deficienciaController = TextEditingController();
  final TextEditingController _microchipController = TextEditingController();

  Uint8List? _imagepet;

  bool _isLoading = false;
  bool _hasDeficiencia = false;
  bool _hasMicrochip = false;

  @override
  Widget build(BuildContext context) {
    AppTheme appTheme = Provider.of<AppTheme>(context);
    return Scaffold(
      backgroundColor:
          appTheme.modoNoturno ? Color(0xff353333) : Color(0xffF8CCCC),
      appBar: AppBar(
        elevation: 0,
        backgroundColor:
            appTheme.modoNoturno ? Color(0xff353333) : Color(0xffF8CCCC),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 32),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      'PERFIL DO SEU PET',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color:
                            appTheme.modoNoturno ? Colors.white : Colors.black,
                        fontSize: 20,
                        fontFamily: 'WorkSans',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Divider(
                  color:
                      appTheme.modoNoturno ? Colors.white : Color(0xffA45309),
                  thickness: 4,
                ),
                const SizedBox(height: 64),
                Stack(
                  children: [
                    _imagepet != null
                        ? CircleAvatar(
                            radius: 64,
                            backgroundImage: MemoryImage(_imagepet!),
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
                        color:
                            appTheme.modoNoturno ? Colors.white : Colors.black,
                        onPressed: selectImage,
                        icon: Icon(Icons.add_a_photo),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 60),
                TextFormField(
                  controller: _nameController,
                  style: TextStyle(
                    fontFamily: 'WorkSans',
                    color: appTheme.modoNoturno ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    hintText: "Como seu pet se chama?",
                    hintStyle: TextStyle(
                      color: appTheme.modoNoturno ? Colors.white : Colors.black,
                    ),
                    filled: true,
                    fillColor:
                        appTheme.modoNoturno ? Color(0xffB94F4F) : Colors.white,
                    border: OutlineInputBorder(
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
                const SizedBox(height: 24),
                TextFormField(
                  controller: _especieController,
                  style: TextStyle(
                    fontFamily: 'WorkSans',
                    color: appTheme.modoNoturno ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    hintText: "Qual a especie?(Cachorro, gato, papagaio...)",
                    hintStyle: TextStyle(
                      color: appTheme.modoNoturno ? Colors.white : Colors.black,
                    ),
                    filled: true,
                    fillColor:
                        appTheme.modoNoturno ? Color(0xffB94F4F) : Colors.white,
                    border: OutlineInputBorder(
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
                const SizedBox(height: 20),
                TextFormField(
                  controller: _racaController,
                  style: TextStyle(
                    fontFamily: 'WorkSans',
                    color: appTheme.modoNoturno ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    hintText: "Qual a raça?",
                    hintStyle: TextStyle(
                      color: appTheme.modoNoturno ? Colors.white : Colors.black,
                    ),
                    filled: true,
                    fillColor:
                        appTheme.modoNoturno ? Color(0xffB94F4F) : Colors.white,
                    border: OutlineInputBorder(
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
                const SizedBox(height: 24),
                TextField(
                  controller: _idadeController,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    fontFamily: 'WorkSans',
                    fontWeight: FontWeight.bold,
                    color: appTheme.modoNoturno ? Colors.white : Colors.black,
                  ),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                      color: appTheme.modoNoturno ? Colors.white : Colors.black,
                    ),
                    hintText: "Coloque a idade aproximada",
                    filled: true,
                    fillColor:
                        appTheme.modoNoturno ? Color(0xffB94F4F) : Colors.white,
                    border: OutlineInputBorder(
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
                const SizedBox(height: 24),
                TextField(
                  controller: _pesoController,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    fontFamily: 'WorkSans',
                    fontWeight: FontWeight.bold,
                    color: appTheme.modoNoturno ? Colors.white : Colors.black,
                  ),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                      color: appTheme.modoNoturno ? Colors.white : Colors.black,
                    ),
                    hintText: "Qual o peso do animal?",
                    filled: true,
                    fillColor:
                        appTheme.modoNoturno ? Color(0xffB94F4F) : Colors.white,
                    border: OutlineInputBorder(
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
                const SizedBox(height: 24),
                TextField(
                  controller: _sexoController,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    fontFamily: 'WorkSans',
                    fontWeight: FontWeight.bold,
                    color: appTheme.modoNoturno ? Colors.white : Colors.black,
                  ),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                      color: appTheme.modoNoturno ? Colors.white : Colors.black,
                    ),
                    hintText: "Qual o sexo do animal?",
                    filled: true,
                    fillColor:
                        appTheme.modoNoturno ? Color(0xffB94F4F) : Colors.white,
                    border: OutlineInputBorder(
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
                const SizedBox(height: 24),
                TextField(
                  controller: _castradoController,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    fontFamily: 'WorkSans',
                    fontWeight: FontWeight.bold,
                    color: appTheme.modoNoturno ? Colors.white : Colors.black,
                  ),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                      color: appTheme.modoNoturno ? Colors.white : Colors.black,
                    ),
                    hintText: "É castrado(escreva SIM ou NÃO)?",
                    filled: true,
                    fillColor:
                        appTheme.modoNoturno ? Color(0xffB94F4F) : Colors.white,
                    border: OutlineInputBorder(
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
                const SizedBox(height: 24),
                CheckboxListTile(
                  title: Text(
                    'Possui Deficiência',
                    style: TextStyle(
                      fontFamily: 'WorkSans',
                      fontWeight: FontWeight.bold,
                      color: appTheme.modoNoturno ? Colors.white : Colors.black,
                    ),
                  ),
                  tileColor: appTheme.modoNoturno ? Colors.white : Colors.white,
                  value: _hasDeficiencia,
                  onChanged: (value) {
                    setState(() {
                      _hasDeficiencia = value!;
                    });
                  },
                ),
                SizedBox(height: 5),
                if (_hasDeficiencia)
                  TextField(
                    controller: _deficienciaController,
                    style: TextStyle(
                      fontFamily: 'WorkSans',
                      fontWeight: FontWeight.bold,
                      color: appTheme.modoNoturno ? Colors.white : Colors.black,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Descrição da Deficiência',
                      hintStyle: TextStyle(
                        color:
                            appTheme.modoNoturno ? Colors.white : Colors.black,
                      ),
                      filled: true,
                      fillColor: appTheme.modoNoturno
                          ? Color(0xffB94F4F)
                          : Colors.white,
                      border: OutlineInputBorder(
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
                const SizedBox(height: 24),
                CheckboxListTile(
                  title: Text(
                    'Possui Microchip',
                    style: TextStyle(
                      fontFamily: 'WorkSans',
                      fontWeight: FontWeight.bold,
                      color: appTheme.modoNoturno ? Colors.white : Colors.black,
                    ),
                  ),
                  tileColor: appTheme.modoNoturno ? Colors.white : Colors.white,
                  value: _hasMicrochip,
                  onChanged: (value) {
                    setState(() {
                      _hasMicrochip = value!;
                    });
                  },
                ),
                SizedBox(height: 5),
                if (_hasMicrochip)
                  TextField(
                    controller: _microchipController,
                    style: TextStyle(
                      fontFamily: 'WorkSans',
                      fontWeight: FontWeight.bold,
                      color: appTheme.modoNoturno ? Colors.white : Colors.black,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Número do Microchip',
                      hintStyle: TextStyle(
                        color:
                            appTheme.modoNoturno ? Colors.white : Colors.black,
                      ),
                      filled: true,
                      fillColor: appTheme.modoNoturno
                          ? Color(0xffB94F4F)
                          : Colors.white,
                      border: OutlineInputBorder(
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
                const SizedBox(height: 24),
                TextField(
                  controller: _bioController,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    fontFamily: 'WorkSans',
                    fontWeight: FontWeight.bold,
                    color: appTheme.modoNoturno ? Colors.white : Colors.black,
                  ),
                  decoration: InputDecoration(
                    hintText:
                        "Diga um pouco sobre o nosso aumiguinho ou miaguinho...",
                    hintStyle: TextStyle(
                      color: appTheme.modoNoturno ? Colors.white : Colors.black,
                    ),
                    filled: true,
                    fillColor:
                        appTheme.modoNoturno ? Color(0xffB94F4F) : Colors.white,
                    border: OutlineInputBorder(
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
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 35.0, horizontal: 20.0),
                  ),
                ),
                const SizedBox(height: 24),
                InkWell(
                  onTap: savePetProfile,
                  child: Container(
                    child: _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Color.fromARGB(255, 188, 123, 214),
                            ),
                          )
                        : const Text(
                            "Salvar Perfil do Pet",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: appTheme.modoNoturno
                          ? Color(0xff754343)
                          : Color(0xffF06292),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<firebase_storage.TaskSnapshot> uploadImageToFirebaseStorage(
      String userId) async {
    try {
      String imagePath = 'profile_images/$userId.jpg';

      firebase_storage.Reference ref =
          firebase_storage.FirebaseStorage.instance.ref().child(imagePath);

      return await ref.putData(_imagepet!);
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<String?> uploadImageAndGetDownloadURL(String userId) async {
    try {
      setState(() {
        _isLoading = true;
      });

      if (_imagepet == null) {
        print('Selecione uma imagem.');
        return null;
      }

      // Obtenha a tarefa de upload diretamente da função
      firebase_storage.TaskSnapshot taskSnapshot =
          await uploadImageToFirebaseStorage(userId);

      await taskSnapshot.ref.getDownloadURL().then(
            (value) => print('Image uploaded successfully: $value'),
          );

      // Obter o URL de download após a conclusão da tarefa de upload
      String downloadURL = await taskSnapshot.ref.getDownloadURL();

      setState(() {
        _isLoading = false;
      });

      return downloadURL;
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Erro ao fazer upload da imagem: $e');
      return null;
    }
  }

  Future<void> selectImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final Uint8List? imageBytes = await pickedFile.readAsBytes();

      setState(() {
        _imagepet = imageBytes;
      });
    }
  }

  Future<void> savePetProfile() async {
    String userId = _auth.currentUser?.uid ?? '';

    try {
      setState(() {
        _isLoading = true;
      });

      if (_imagepet == null) {
        print('Selecione uma imagem.');
        setState(() {
          _isLoading = false;
        });
        return;
      }

      // Upload image and wait for the task to complete
      // Get the download URL after the upload is complete
      String imagePath = 'profile_images/$userId.jpg';
      String? downloadURLPet = await uploadImageAndGetDownloadURL(userId);

      // Check if downloadURL is not empty or null before using it
      if (downloadURLPet != null && downloadURLPet.isNotEmpty) {
        await _firestore.collection('pets').doc(userId).set({
          'name': _nameController.text,
          'bio': _bioController.text,
          'especie': _especieController.text,
          'raca': _racaController.text,
          'idade': _idadeController.text,
          'peso': _pesoController.text,
          'sexo': _sexoController.text,
          'castrado': _castradoController.text,
          'profileImagePet': downloadURLPet,
          'hasDeficiencia': _hasDeficiencia,
          'deficiencia': _hasDeficiencia ? _deficienciaController.text : null,
          'hasMicrochip': _hasMicrochip,
          'microchip': _hasMicrochip ? _microchipController.text : null,
        });

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => PetProfileScreen(
              petId: userId,
              name: _nameController.text,
              idade: _idadeController.text,
              bio: _bioController.text,
              raca: _racaController.text,
              especie: _especieController.text,
              peso: _pesoController.text,
              sexo: _sexoController.text,
              castrado: _castradoController.text,
              profileImagePet: downloadURLPet,
              hasDeficiencia: _hasDeficiencia,
              deficiencia: _hasDeficiencia ? _deficienciaController.text : '',
              hasMicrochip: _hasMicrochip,
              microchip: _hasMicrochip ? _microchipController.text : '',
            ),
          ),
        );
      } else {
        // Handle the case where downloadURL is empty or null
        print('Download URL is empty or null');
      }
    } catch (e) {
      print('Erro ao salvar perfil: $e');
      // Handle the error
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}

class PetProfileScreen extends StatelessWidget {
  final String petId;
  final String name;
  final String especie;
  final String raca;
  final String bio;
  final String peso;
  final String castrado;
  final String sexo;
  final String? profileImagePet;
  final String idade;
  final bool hasDeficiencia;
  final String deficiencia;
  final bool hasMicrochip;
  final String microchip;

  PetProfileScreen({
    Key? key,
    required this.petId,
    required this.name,
    required this.raca,
    required this.especie,
    required this.bio,
    required this.idade,
    required this.peso,
    required this.sexo,
    required this.castrado,
    this.profileImagePet,
    required this.hasDeficiencia,
    required this.deficiencia,
    required this.hasMicrochip,
    required this.microchip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppTheme appTheme = Provider.of<AppTheme>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor:
            appTheme.modoNoturno ? Color(0xff353333) : Color(0xffF8CCCC),
        title: Text('Perfil do Pet'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                CustomPageRouteBuilder(
                  page: MyHomePage(),
                ),
              );
            },
            icon: Icon(Icons.home),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(profileImagePet!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Text("${name}",
                style: TextStyle(
                  fontSize: 40,
                  fontFamily: 'Pangolin',
                  fontWeight: FontWeight.bold,
                  color: appTheme.modoNoturno ? Colors.white : Colors.black,
                )),
            Container(
              width: 500,
              height: 500,
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: appTheme.modoNoturno
                    ? Color(0xffB94F4F)
                    : Color(0xffF8CCCC),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xffffffff),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5),
                  Container(
                      decoration: BoxDecoration(
                        color: appTheme.modoNoturno
                            ? Color(0xffa83434)
                            : Color(0xffe79f9f),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xffffffff),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Descrição:",
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'WorkSans',
                                fontWeight: FontWeight.bold,
                                color: appTheme.modoNoturno
                                    ? Colors.white
                                    : Colors.black,
                              )),
                          Text("${bio}",
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'WorkSans',
                                fontWeight: FontWeight.bold,
                                color: appTheme.modoNoturno
                                    ? Colors.white
                                    : Colors.black,
                              )),
                        ],
                      )),
                  Divider(
                    thickness: 1,
                    indent: 15,
                    endIndent: 15,
                    color: appTheme.modoNoturno ? Colors.white : Colors.black,
                  ),
                  SizedBox(height: 5),
                  Text("Espécie: ${especie}",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'WorkSans',
                        fontWeight: FontWeight.bold,
                        color:
                            appTheme.modoNoturno ? Colors.white : Colors.black,
                      )),
                  SizedBox(height: 5),
                  Text("Raça: ${raca}",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'WorkSans',
                        fontWeight: FontWeight.bold,
                        color:
                            appTheme.modoNoturno ? Colors.white : Colors.black,
                      )),
                  SizedBox(height: 5),
                  Text("Idade: ${idade.toString()}",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'WorkSans',
                        fontWeight: FontWeight.bold,
                        color:
                            appTheme.modoNoturno ? Colors.white : Colors.black,
                      )),
                  SizedBox(height: 5),
                  Text("Sexo: ${sexo}",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'WorkSans',
                        fontWeight: FontWeight.bold,
                        color:
                            appTheme.modoNoturno ? Colors.white : Colors.black,
                      )),
                  SizedBox(height: 5),
                  Text("Peso: ${peso}",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'WorkSans',
                        fontWeight: FontWeight.bold,
                        color:
                            appTheme.modoNoturno ? Colors.white : Colors.black,
                      )),
                  SizedBox(height: 5),
                  Text("Castrado: ${castrado}",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'WorkSans',
                        fontWeight: FontWeight.bold,
                        color:
                            appTheme.modoNoturno ? Colors.white : Colors.black,
                      )),
                  SizedBox(height: 5),
                  if (hasDeficiencia)
                    Text('Deficiência: ${deficiencia}',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'WorkSans',
                          fontWeight: FontWeight.bold,
                          color: appTheme.modoNoturno
                              ? Colors.white
                              : Colors.black,
                        )),
                  SizedBox(height: 5),
                  Divider(
                    thickness: 1,
                    indent: 15,
                    endIndent: 15,
                    color: appTheme.modoNoturno ? Colors.white : Colors.black,
                  ),
                  SizedBox(height: 5),
                  if (hasMicrochip)
                    Text('Número do Microchip: ${microchip}',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'WorkSans',
                          fontWeight: FontWeight.bold,
                          color: appTheme.modoNoturno
                              ? Colors.white
                              : Colors.black,
                        )),
                  SizedBox(height: 5),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
