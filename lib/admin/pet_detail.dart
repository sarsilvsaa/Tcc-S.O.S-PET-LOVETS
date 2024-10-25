import 'package:flutter/material.dart';
import 'pet.dart';
import 'package:provider/provider.dart';
import 'package:teste/screens/tela_ajustes.dart';

class PetDetalhesScreen extends StatelessWidget {
  final Pet pet;

  PetDetalhesScreen({required this.pet});

  @override
  Widget build(BuildContext context) {
    AppTheme appTheme = Provider.of<AppTheme>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(pet.name),
        backgroundColor:
            appTheme.modoNoturno ? Color(0xffB94F4F) : Color(0xffF8CCCC),
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
                      image: NetworkImage(pet.imageUrlAdc),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Text("${pet.name}",
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
                          Text("${pet.bio}",
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
                  Text("Espécie: ${pet.especie}",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'WorkSans',
                        fontWeight: FontWeight.bold,
                        color:
                            appTheme.modoNoturno ? Colors.white : Colors.black,
                      )),
                  SizedBox(height: 5),
                  Text("Raça: ${pet.raca}",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'WorkSans',
                        fontWeight: FontWeight.bold,
                        color:
                            appTheme.modoNoturno ? Colors.white : Colors.black,
                      )),
                  SizedBox(height: 5),
                  Text("Idade: ${pet.idade.toString()}",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'WorkSans',
                        fontWeight: FontWeight.bold,
                        color:
                            appTheme.modoNoturno ? Colors.white : Colors.black,
                      )),
                  SizedBox(height: 5),
                  Text("Sexo: ${pet.sexo}",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'WorkSans',
                        fontWeight: FontWeight.bold,
                        color:
                            appTheme.modoNoturno ? Colors.white : Colors.black,
                      )),
                  SizedBox(height: 5),
                  Text("Peso: ${pet.peso}",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'WorkSans',
                        fontWeight: FontWeight.bold,
                        color:
                            appTheme.modoNoturno ? Colors.white : Colors.black,
                      )),
                  SizedBox(height: 5),
                  Text("Castrado: ${pet.castrado}",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'WorkSans',
                        fontWeight: FontWeight.bold,
                        color:
                            appTheme.modoNoturno ? Colors.white : Colors.black,
                      )),
                  SizedBox(height: 5),
                  if (pet.hasDeficiencia)
                    Text('Deficiência: ${pet.deficiencia}',
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
                  if (pet.hasMicrochip)
                    Text('Número do Microchip: ${pet.microchip}',
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
