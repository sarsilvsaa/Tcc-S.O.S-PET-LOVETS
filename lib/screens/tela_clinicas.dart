import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MapPage(),
    );
  }
}

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final String googleMapsUrl =
      "https://www.google.com.br/maps/search/cl%C3%ADnicas+veterin%C3%A1rias/@-22.7244794,-47.3412927,15z/data=!3m1!4b1?entry=ttu";

  String searchQuery = '';

  List<ClinicData> filteredClinics = [];

  void openGoogleMaps() async {
    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      throw "Um erro ocorreu para abrir o Google Maps";
    }
  }

  void filterClinics() {
    setState(() {
      filteredClinics = clinics.where((clinic) {
        final clinicName = clinic.clinicName.toLowerCase();
        final query = searchQuery.toLowerCase();
        return clinicName.contains(query);
      }).toList();
    });
  }

  final List<ClinicData> clinics = [
    ClinicData(
      clinicName: "ClinPetLife Veterinária - AMERICANA",
      imageAssetPath: "assets/images/clinicas/clinpet.jpg",
    ),
    ClinicData(
      clinicName: "MedClin Veterinária - AMERICANA",
      imageAssetPath: "assets/images/clinicas/medclinica.jpg",
    ),
    ClinicData(
      clinicName: "LM Hospital Veterinário - AMERICANA",
      imageAssetPath: "assets/images/clinicas/lmclinica.png",
    ),
    ClinicData(
      clinicName: "Clínica Veterinária Padovani - AMERICANA",
      imageAssetPath: "assets/images/clinicas/padovani.png",
    ),
    ClinicData(
      clinicName: "Animed Hospital Veterinário - AMERICANA",
      imageAssetPath: "assets/imagvees/clinicas/animed.png",
    ),
    ClinicData(
      clinicName: "Clínica Veterinária Paulista - AMERICANA",
      imageAssetPath: "assets/images/clinicas/vetzan.png",
    ),
    ClinicData(
      clinicName: "Clínica Veterinária europa - SANTA BARBÁRA DO OESTE",
      imageAssetPath: "assets/images/clinicas/lmclinica.png",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffF8CCCC),
        title: Text('Clínicas Veterinárias'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                'CLÍNICAS VETERINARIAS MAIS PRÓXIMAS DE VOCÊ!',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'WorkSans',
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Divider(
              color: Color(0xffA45309),
              thickness: 4,
            ),
            Padding(padding: EdgeInsets.only(top: 8)),
            Text(
              'Encontre uma clínica 24 horas ou até em horários fixos!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'WorkSans',
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: 300,
              height: 60,
              decoration: BoxDecoration(
                color: Color(0xffF8CCCC),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xffF8CCCC),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: openGoogleMaps,
                child: Text('VEJA AS CLÍNICAS MAIS PRÓXIMAS DE VOCÊ'),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Color(0xffF8CCCC),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  hintText: 'Pesquisar',
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (query) {
                  setState(() {
                    searchQuery = query;
                  });
                  filterClinics();
                },
              ),
            ),
            ClinicList(
                clinics:
                    filteredClinics.isNotEmpty ? filteredClinics : clinics),
          ],
        ),
      ),
    );
  }
}

class ClinicList extends StatelessWidget {
  final List<ClinicData> clinics;

  ClinicList({required this.clinics});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: clinics.length,
      itemBuilder: (BuildContext context, int index) {
        return ClinicCard(clinicData: clinics[index]);
      },
    );
  }
}

class ClinicCard extends StatelessWidget {
  final ClinicData clinicData;

  ClinicCard({required this.clinicData});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Image.asset(
            clinicData.imageAssetPath,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          ListTile(
            title: Text(
              clinicData.clinicName,
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              // Navigator.push(
              //  context,
              // MaterialPageRoute(
              // builder: (context) =>
              //  ClinicDetails(clinicName: clinicData.clinicName)));
            },
          ),
        ],
      ),
    );
  }
}

class ClinicData {
  final String clinicName;
  final String imageAssetPath;

  ClinicData({
    required this.clinicName,
    required this.imageAssetPath,
  });
}
