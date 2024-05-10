import 'package:flutter/material.dart';

import '../core/constants.dart';

class Filtering extends StatefulWidget {
  @override
  State<Filtering> createState() => _SearchPageState();
}

class _SearchPageState extends State<Filtering> {
  List<String>CountryList=['Afghanistan',' Albania', ' Algeria',' Andorra',' Angola','Antigua and Barbuda',' Argentina',
    'Armenia''Australia','Austria','Austrian Empire*',' Azerbaijan','Baden',' Bahamas', 'Bahrain','Bangladesh',' Barbados'
    ,'Bavaria',' Belarus','Belgium','Belize','Benin (Dahomey)', 'Bolivia','Bosnia and Herzegovina','Botswana',' Brazil','Brunei'
    ,' Brunswick and Lüneburg',' Bulgaria','Burkina Faso (Upper Volta)','Burma','Burundi', 'CabonVerde',' Cambodia',' Cameroon'
    ,' Canada',' Cayman Islands','Central African Republic',' Central American Federation*',' Chad',' Chile', 'China',' Colombia',
    'Comoros',' Congo Free State, The*','Costa Rica', 'Cote d’Ivoire ',' Croatia','Cuba','Cyprus','Czechia','Czechoslovakia'
  ];
  List<String>SpecializationList=['Ui','Ux','Frontend Developer','Backend Developer'];

  String? selectedCountry;
  String? selectedSpecialization;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(contentPadding: EdgeInsets.symmetric(vertical: 24),
        title: Text('Filter by'),backgroundColor: Colors.white,
        content:
        Column(mainAxisSize:MainAxisSize.min,children: [
          DropdownButton(//padding: EdgeInsets.symmetric(horizontal: 2,vertical: 24),
            borderRadius: BorderRadius.circular(2),
            underline:const Divider( thickness:0,height:0),
            icon:const Icon(Icons.arrow_drop_down, color: Color(0xFF464241),size: 30,),
            dropdownColor: Colors.white,
            hint:const  Text(
              'Country                                            ',
              style: TextStyle(
                  fontSize:15,
                  color: Color(0xFF464241),
                  fontFamily:'Cairo'),
            ),
            items:CountryList.map((item) =>DropdownMenuItem(
              value: item,
              child: Text(item,
                style:const  TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontFamily:'Cairo'),
              ),
            ),
            ).toList(),
            onChanged: (item){
              setState((){
                selectedCountry=item;
                // print( selectedGender);
              });
            },
            value: selectedCountry,

          ),
          DropdownButton(padding: EdgeInsets.symmetric(horizontal: 2,vertical: 24),
            borderRadius: BorderRadius.circular(10),
            underline:const Divider( thickness:0,height:0),
            icon:const Icon(Icons.arrow_drop_down, color: Color(0xFF464241),size: 30,),
            dropdownColor: Colors.white,
            hint:const  Text(
              'Specialization                                            ',
              style: TextStyle(
                  fontSize:15,
                  color: Color(0xFF464241),
                  fontFamily:'Cairo'),
            ),
            items:SpecializationList.map((item) =>DropdownMenuItem(
              value: item,
              child: Text(item,
                style:const  TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontFamily:'Cairo'),
              ),
            ),
            ).toList(),
            onChanged: (item){
              setState((){
                selectedSpecialization=item;
                // print( selectedGender);
              });
            },
            value: selectedSpecialization,

          )

        ],)
    );
  }

}
