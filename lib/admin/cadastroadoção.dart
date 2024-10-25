import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'pet.dart';

class PetCadastroScreen extends StatefulWidget {
  @override
  _PetCadastroScreenState createState() => _PetCadastroScreenState();
}

class _PetCadastroScreenState extends State<PetCadastroScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _especieController = TextEditingController();
  TextEditingController _racaController = TextEditingController();
  TextEditingController _idadeController = TextEditingController();
  TextEditingController _pesoController = TextEditingController();
  TextEditingController _sexoController = TextEditingController();
  TextEditingController _deficienciaController = TextEditingController();
  TextEditingController _microchipController = TextEditingController();
  TextEditingController _bioController = TextEditingController();
  TextEditingController _castradoController = TextEditingController();

  Uint8List? _imageadoption;
  bool _hasDeficiencia = false;
  bool _hasMicrochip = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Pet'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                _imageadoption != null
                    ? CircleAvatar(
                        radius: 64,
                        backgroundImage: MemoryImage(_imageadoption!),
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
                  ),
                ),
              ],
            ),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: _especieController,
              decoration: InputDecoration(labelText: 'Espécie'),
            ),
            TextField(
              controller: _racaController,
              decoration: InputDecoration(labelText: 'Raça'),
            ),
            TextField(
              controller: _idadeController,
              decoration: InputDecoration(labelText: 'Idade Aproximada'),
            ),
            TextField(
              controller: _pesoController,
              decoration: InputDecoration(labelText: 'Peso do Animal'),
            ),
            TextField(
              controller: _sexoController,
              decoration: InputDecoration(labelText: 'Sexo do Animal'),
            ),
            TextField(
              controller: _bioController,
              decoration: InputDecoration(labelText: 'Descrição'),
            ),
            TextField(
              controller: _castradoController,
              decoration: InputDecoration(labelText: 'Castrado'),
            ),
            CheckboxListTile(
              title: Text('Possui Deficiência'),
              value: _hasDeficiencia,
              onChanged: (value) {
                setState(() {
                  _hasDeficiencia = value!;
                });
              },
            ),
            if (_hasDeficiencia)
              TextField(
                controller: _deficienciaController,
                decoration:
                    InputDecoration(labelText: 'Descrição da Deficiência'),
              ),
            CheckboxListTile(
              title: Text('Possui Microchip'),
              value: _hasMicrochip,
              onChanged: (value) {
                setState(() {
                  _hasMicrochip = value!;
                });
              },
            ),
            if (_hasMicrochip)
              TextField(
                controller: _microchipController,
                decoration: InputDecoration(labelText: 'Número do Microchip'),
              ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                Pet savedPet = await _savePet();

                if (savedPet != null) {
                  // Altere a navegação para retornar à tela de adoção
                  Navigator.pop(context);
                }
              },
              child: Text('Salvar Pet'),
            ),
          ],
        ),
      ),
    );
  }

  // Method to pick an image from the gallery
  Future<String> uploadImageToFirebaseStorage(String userId) async {
    try {
      if (_imageadoption == null) {
        print('Por favor, selecione uma imagem.');
        return ''; // Retorna uma string vazia em caso de falha.
      }

      String imagePath = 'profile_images/$userId.jpg';

      firebase_storage.Reference ref =
          firebase_storage.FirebaseStorage.instance.ref().child(imagePath);

      await ref.putData(_imageadoption!);

      String downloadURL = await ref.getDownloadURL();
      print('Imagem enviada com sucesso. URL: $downloadURL');

      return downloadURL; // Retorna a URL de download da imagem.
    } catch (e) {
      print('Erro ao enviar imagem: $e');
      return ''; // Retorna uma string vazia em caso de falha.
    }
  }

  Future<void> selectImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final Uint8List? imageBytes = await pickedFile.readAsBytes();

      setState(() {
        _imageadoption = imageBytes;
      });
    }
  }

  Future<Pet> _savePet() async {
    try {
      User? user = _auth.currentUser;

      if (user == null) {
        print('Usuário não autenticado. Faça login para salvar o pet.');
        throw Exception(
            'Usuário não autenticado.'); // Lança uma exceção para indicar o erro
      }
      String downloadURLAdoption = await uploadImageToFirebaseStorage(user.uid);

      // Create a map with pet information
      Map<String, dynamic> petData = {
        'name': _nameController.text,
        'especie': _especieController.text,
        'raca': _racaController.text,
        'idade': _idadeController.text,
        'peso': _pesoController.text,
        'sexo': _sexoController.text,
        'bio': _bioController.text,
        'castrado': _castradoController.text,
        'hasDeficiencia': _hasDeficiencia,
        'deficiencia': _hasDeficiencia ? _deficienciaController.text : null,
        'hasMicrochip': _hasMicrochip,
        'microchip': _hasMicrochip ? _microchipController.text : null,
      };

      // Save the photo of the pet in Firebase Storage and get the download URL

      // Add the photo URL to the data map
      petData['imagemAdocao'] = downloadURLAdoption;

      // Save the pet information in the 'pet-adoption' collection
      await FirebaseFirestore.instance.collection('pet-adoption').add(petData);

      print('Pet saved successfully.');

      Pet savedPet = Pet(
        name: _nameController.text,
        especie: _especieController.text,
        raca: _racaController.text,
        idade: _idadeController.text,
        peso: _pesoController.text,
        sexo: _sexoController.text,
        imageUrlAdc: downloadURLAdoption,
        bio: _bioController.text,
        castrado: _castradoController.text,
        hasDeficiencia: _hasDeficiencia,
        deficiencia: _hasDeficiencia ? _deficienciaController.text : '',
        hasMicrochip: _hasMicrochip,
        microchip: _hasMicrochip ? _microchipController.text : '',
      );

      return savedPet;
    } catch (e) {
      print('Erro ao salvar o pet: $e');
      throw e;
    }
  }
}
