import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../core/widgets/buildInputDecoration.dart';
import '../core/widgets/header_painater.dart';
import 'home_screen.dart';
import 'login_screen.dart';
import 'package:intl_phone_field/intl_phone_field.dart';



class RegisterPage2 extends StatefulWidget {
  static String id = " RegisterPage2";
  @override
  _RegisterPage2State createState() => _RegisterPage2State();
}

class _RegisterPage2State extends State<RegisterPage2> {
  TextEditingController phone = TextEditingController();
  TextEditingController country = TextEditingController();
  DateTime date=DateTime.now();
  String? selectedGender;
  List<String>genderList=['male','female'];
  String? selectedCountry;
  List<String>CountryList=['Afghanistan',' Albania', ' Algeria',' Andorra',' Angola','Antigua and Barbuda',' Argentina',
    'Armenia''Australia','Austria','Austrian Empire*',' Azerbaijan','Baden',' Bahamas', 'Bahrain','Bangladesh',' Barbados'
    ,'Bavaria',' Belarus','Belgium','Belize','Benin (Dahomey)', 'Bolivia','Bosnia and Herzegovina','Botswana',' Brazil','Brunei'
    ,' Brunswick and Lüneburg',' Bulgaria','Burkina Faso (Upper Volta)','Burma','Burundi', 'CabonVerde',' Cambodia',' Cameroon'
    ,' Canada',' Cayman Islands','Central African Republic',' Central American Federation*',' Chad',' Chile', 'China',' Colombia',
    'Comoros',' Congo Free State, The*','Costa Rica', 'Cote d’Ivoire ',' Croatia','Cuba','Cyprus','Czechia','Czechoslovakia'
  ];
  String? selectedSpecialization;
  List<String>SpecializationList=['Ui','Ux','Frontend Developer','Backend Developer'];

  final GlobalKey<FormState>_formkey = GlobalKey<FormState>();



  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        decoration:const  BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Colors.white,
                    Color(0xFFB2CCC8),],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft
              ),
        ),
        child: ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          children:[ Form(
              key: _formkey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FullHeaderPainter(HeaderText:"Register"),
                    const  SizedBox(height: 150,),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15, left: 30, right: 30),
                      child: IntlPhoneField(
                        controller:phone ,
                        autofocus: true,
                        initialCountryCode: 'SY',
                        keyboardType: TextInputType.phone,
                        onChanged: (value){
                          value.completeNumber;
                        },
                        decoration:buildInputDecoration(Icons.phone,"Phone Number"),
                      ),
                    ),
                    Container(
                      width: 325,
                      height: 65,
                      decoration:BoxDecoration(
                        border: Border.all(color: Colors.grey,width: 1),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child:Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left:8,top: 5),
                            child:Icon(Icons.location_city,color: Color(0xFF413F3F)) ,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:16,right: 20,top: 5),
                            child:DropdownButton(
                              borderRadius: BorderRadius.circular(30),
                              underline:const Divider( thickness:0,height:0),
                              icon:const Icon(Icons.arrow_drop_down, color: Color(0xFF464241),size: 30,),
                              dropdownColor: Kcolor,
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

                            ) ,),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10,right: 30,left: 30),
                      child:Row(
                        mainAxisAlignment:MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              ElevatedButton.icon(
                                onPressed:(){
                                  _selectDate();
                                } ,
                                icon:const  Icon(Icons.calendar_month,color:Color(0xFF565555),),
                                label:const Text('Date of birth',
                                  style: TextStyle(
                                    fontSize:15 ,
                                    color: Colors.white,
                                    fontFamily:'Cairo',
                                  ),
                                ),
                                style:ElevatedButton.styleFrom(
                                  backgroundColor: Kcolor,
                                  minimumSize:const Size(50,50),
                                ),
                              ),
                              Text('${date.day}/${date.month}/${date.year}',
                                style:const TextStyle(
                                  fontFamily:'Cairo',
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          const  SizedBox(width:10,),
                          Column(
                            children: [
                              Container(
                                height: 50,
                                width: 150,
                                decoration: BoxDecoration(
                                  color:Kcolor ,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child:Padding(
                                  padding:const  EdgeInsets.only(left: 20,right:20,bottom:5),
                                  child:Row(
                                    children: [
                                      const Icon(Icons.wc_sharp,color:Color(0xFF565555),),
                                      const SizedBox(width: 10,),
                                      DropdownButton(
                                        borderRadius: BorderRadius.circular(30),
                                        underline:const Divider(color: Kcolor,),
                                        icon:const Icon(Icons.arrow_drop_down,color: Colors.white,),
                                        dropdownColor: Kcolor,
                                        hint:const  Text('Gender',
                                          style: TextStyle(
                                              fontSize:15,
                                              color: Colors.white,
                                              fontFamily:'Cairo'),
                                        ),
                                        items:genderList.map((item) =>DropdownMenuItem(
                                          value: item,
                                          child: Text(item,
                                            style:const  TextStyle(fontSize: 15,
                                                color: Colors.white,
                                                fontFamily:'Cairo'),
                                          ),
                                        ),
                                        ).toList(),
                                        onChanged: (item){
                                          setState((){
                                            selectedGender=item;
                                          });
                                        },
                                        value: selectedGender,

                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              const  SizedBox(height: 25,),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height:50),
                    GestureDetector(
                        onTap: (){
                          if (_formkey.currentState!.validate()){
                            Navigator.push(context,MaterialPageRoute(builder: (context){
                              return HomePage();
                            }));
                          }
                        },
                        child:Padding(padding:const EdgeInsets.symmetric(vertical:0.0 ,horizontal:80.0 ) ,
                          child:Container(
                            height: 40,
                            width: 150,
                            decoration: const BoxDecoration(
                                color: Kcolor,
                                borderRadius: BorderRadius.all(Radius.circular(30),)
                            ),
                            child:const Center(child: Text("Register",
                              style: TextStyle(color: Colors.white,
                                fontSize:25,
                                fontWeight:FontWeight.w500,
                                fontFamily: 'Cairo',
                              ),), ),
                          ),)
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context){
                          return LoginPage();
                        }));

                      },
                      child:const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("I'm already a member",
                              style: TextStyle(color: Colors.grey,
                                fontSize: 15,
                                fontWeight:FontWeight.w700,
                                fontFamily: 'Cairo',)),
                        ],
                      ),
                    ),
                    const  SizedBox(height: 30,),
                  ])
          ),
          ],
        ),
      ),
    );
  }

  Future<void>_selectDate()async{
    DateTime? _picked=await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1975),
      lastDate:DateTime(2100) ,
    );
    if(_picked!=null)
    {setState((){
      date=_picked;
    });}
  }
}



