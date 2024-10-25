import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:teste/screens/tela_ajustes.dart';
import 'package:provider/provider.dart';
import 'package:teste/telas_cuidadores/tela2_perfil.dart';

class CuidadoresScreen extends StatefulWidget {
  const CuidadoresScreen({Key? key}) : super(key: key);

  @override
  State<CuidadoresScreen> createState() => _CuidadoresScreenState();
}

class _CuidadoresScreenState extends State<CuidadoresScreen> {
  @override
  Widget build(BuildContext context) {
    AppTheme appTheme = Provider.of<AppTheme>(context);

    return Scaffold(
      backgroundColor:
          appTheme.modoNoturno ? Color(0xff353333) : Color(0xffffffff),
      appBar: AppBar(
        backgroundColor:
            appTheme.modoNoturno ? Color(0xffB94F4F) : Color(0xffF8CCCC),
        title: Text('Cuidadores'),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection('users-caregivers').get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: (snapshot.data! as dynamic).docs.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProfileCuidadorUserScreen(
                      uid: (snapshot.data! as dynamic).docs[index]['uid'],
                    ),
                  ),
                ),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                          (snapshot.data! as dynamic).docs[index]['photoUrl'],
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.pets,
                            color: Colors.black,
                          ),
                          SizedBox(width: 4),
                          Text(
                            (snapshot.data! as dynamic).docs[index]['name'],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
