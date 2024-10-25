import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teste/admin/cadastroadoção.dart';
import 'package:teste/admin/pet_detail.dart';
import 'package:teste/screens/tela_ajustes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:teste/admin/pet.dart';

class AdocaoPage extends StatefulWidget {
  AdocaoPage({Key? key}) : super(key: key);

  @override
  _AdocaoPageState createState() => _AdocaoPageState();
}

class _AdocaoPageState extends State<AdocaoPage> {
  List<Pet> pets = [];

  String textoComQuebrasDeLinha =
      "Primeira linha\nSegunda linha\nTerceira linha";
  // UIDs dos usuários que você deseja definir como administradores
  String targetUserUid1 = 'i4QFWhx5atbhqQTRxCngPdJzFlJ2';
  String targetUserUid2 = 'rQRVnC0cgEUFNgUxTuZqcIatOHj1';

  @override
  Widget build(BuildContext context) {
    AppTheme appTheme = Provider.of<AppTheme>(context);
    // Obter a instância do usuário atual usando o Firebase Authentication
    User? currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor:
          appTheme.modoNoturno ? Color(0xff353333) : Color(0xffFFFFFF),
      appBar: AppBar(
        title: Text('Adoção'),
        backgroundColor:
            appTheme.modoNoturno ? Color(0xffB94F4F) : Color(0xffF8CCCC),
        actions: [
          if (currentUser != null &&
              (currentUser.uid == targetUserUid1 ||
                  currentUser.uid == targetUserUid2))
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PetCadastroScreen(),
                  ),
                );
              },
            ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () async {
              await _refreshPage();
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('pet-adoption').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child:
                  Text('Infelizmente não há animais disponíveis para adoção'),
            );
          }

          pets = snapshot.data!.docs.map((doc) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

            return Pet(
              name: data['name'],
              especie: data['especie'],
              idade: data['idade'],
              sexo: data['sexo'],
              imageUrlAdc: data['imagemAdocao'],
              raca: data['raca'],
              peso: data['peso'],
              bio: data['bio'],
              castrado: data['castrado'],
              hasDeficiencia: data['hasDeficiencia'],
              deficiencia: data['deficiencia'],
              hasMicrochip: data['hasMicrochip'],
              microchip: data['microchip'],
            );
          }).toList();

          return ListView.builder(
            itemCount: pets.length,
            itemBuilder: (context, index) {
              Pet pet = pets[index];

              return InkWell(
                  onTap: () {
                    _navigateToPetDetails(pet);
                  },
                  child: Card(
                    color: appTheme.modoNoturno
                        ? Color(0xffB94F4F)
                        : Color(0xffECD1D1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(10),
                      leading: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          image: DecorationImage(
                            image: NetworkImage(pet.imageUrlAdc),
                            fit: BoxFit.cover,
                          ),
                        ),
                        width: 50,
                        height: 50,
                      ),
                      title: Text(
                        pet.name,
                        style: TextStyle(
                          fontSize: 35,
                          fontFamily: 'WorkSans',
                          fontWeight: FontWeight.bold,
                          color: appTheme.modoNoturno
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        '${pet.especie}\n${pet.idade}\n${pet.sexo}',
                        style: TextStyle(
                          fontSize: 17,
                          fontFamily: 'WorkSans',
                          fontWeight: FontWeight.bold,
                          color: appTheme.modoNoturno
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      trailing: _buildDeleteButton(pet),
                    ),
                  ));
            },
          );
        },
      ),
    );
  }

  Widget _buildDeleteButton(Pet pet) {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null &&
        (currentUser.uid == targetUserUid1 ||
            currentUser.uid == targetUserUid2)) {
      return IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          _showDeleteConfirmationDialog(pet);
        },
      );
    } else {
      return SizedBox.shrink();
    }
  }

  void _showDeleteConfirmationDialog(Pet pet) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Excluir Pet'),
        content: Text('Tem certeza que deseja excluir ${pet.name}?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              await _deletePet(pet);
              Navigator.pop(context);
            },
            child: Text('Excluir'),
          ),
        ],
      ),
    );
  }

  Future<void> _deletePet(Pet pet) async {
    try {
      await FirebaseFirestore.instance
          .collection('pet-adoption')
          .where('name', isEqualTo: pet.name)
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.first.reference.delete();
      });
    } catch (error) {
      print('Erro ao excluir o pet: $error');
    }
  }

  Future<void> _refreshPage() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('pet-adoption').get();

      List<Pet> refreshedPets = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        return Pet(
          name: data['name'],
          especie: data['especie'],
          idade: data['idade'],
          sexo: data['sexo'],
          imageUrlAdc: data['imagemAdocao'],
          raca: data['raca'],
          peso: data['peso'],
          bio: data['bio'],
          castrado: data['castrado'],
          hasDeficiencia: data['hasDeficiencia'],
          deficiencia: data['deficiencia'],
          hasMicrochip: data['hasMicrochip'],
          microchip: data['microchip'],
        );
      }).toList();

      setState(() {
        pets = refreshedPets;
      });
    } catch (error) {
      print('Erro ao recarregar os dados: $error');
    }
  }

  void _navigateToPetDetails(Pet pet) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PetDetalhesScreen(pet: pet),
      ),
    );
  }
}
