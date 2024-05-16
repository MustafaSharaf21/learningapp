import 'package:flutter/material.dart';
import 'package:learningapp/generated/l10n.dart';
import '../core/constants.dart';
import '../core/widgets/buildInputDecoration.dart';
import '../core/widgets/header_painater.dart';
import 'home_screen.dart';
import 'login_screen.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class RegisterPage2 extends StatefulWidget {
  static String id = " RegisterPage2";

  @override
  _RegisterPage2State createState() => _RegisterPage2State();
}

class _RegisterPage2State extends State<RegisterPage2> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController phone = TextEditingController();
  TextEditingController country = TextEditingController();
  DateTime date = DateTime.now();
  String? selectedGender;
  List<String> genderList = ['male', 'female'];
  String? selectedCountry;
  List<String> CountryList = [
    'Afghanistan',
    ' Albania',
    ' Algeria',
    ' Andorra',
    ' Angola',
    'Antigua and Barbuda',
    ' Argentina',
    'Armenia' 'Australia',
    'Austria',
    'Austrian Empire*',
    ' Azerbaijan',
    'Baden',
    ' Bahamas',
    'Bahrain',
    'Bangladesh',
    ' Barbados',
    'Bavaria',
    ' Belarus',
    'Belgium',
    'Belize',
    'Benin (Dahomey)',
    'Bolivia',
    'Bosnia and Herzegovina',
    'Botswana',
    ' Brazil',
    'Brunei',
    ' Brunswick and Lüneburg',
    ' Bulgaria',
    'Burkina Faso (Upper Volta)',
    'Burma',
    'Burundi',
    'CabonVerde',
    ' Cambodia',
    ' Cameroon',
    ' Canada',
    ' Cayman Islands',
    'Central African Republic',
    ' Central American Federation*',
    ' Chad',
    ' Chile',
    'China',
    ' Colombia',
    'Comoros',
    ' Congo Free State, The*',
    'Costa Rica',
    'Cote d’Ivoire ',
    ' Croatia',
    'Cuba',
    'Cyprus',
    'Czechia',
    'Czechoslovakia'
  ];

  static List<Specialist> _Specialties = [
    Specialist(id: 1, name: "Developer"),
    Specialist(id: 2, name: "UI"),
    Specialist(id: 3, name: "UX"),
    Specialist(id: 4, name: "Front-end Flutter"),
    Specialist(id: 5, name: "Front-end React"),
    Specialist(id: 6, name: "Front-end AngularJs"),
    Specialist(id: 7, name: "JavaScript"),
    Specialist(id: 8, name: " CSS"),
    Specialist(id: 9, name: "HTML"),
    Specialist(id: 10, name: "Backend Python"),
    Specialist(id: 11, name: "Backend Node.js"),
    Specialist(id: 12, name: "Backend Laravel"),
    Specialist(id: 13, name: "Backend Spring"),
    Specialist(id: 14, name: "Backend PHP"),
    Specialist(id: 15, name: "C++"),
    Specialist(id: 16, name: "C#"),
    Specialist(id: 17, name: "Java"),
    Specialist(id: 18, name: "Dart"),
  ];

  final _items = _Specialties.map((specialist) =>
      MultiSelectItem<Specialist>(specialist, specialist.name)).toList();
  List<Specialist> _selectedSpecialist = [];

  //final _multiSelectKey = GlobalKey<FormFieldState>();

  @override
  void initState() {
    _selectedSpecialist = _Specialties;
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.white,
            Color(0xFFB2CCC8),
          ], begin: Alignment.topRight, end: Alignment.bottomLeft),
        ),
        child: ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          children: [
            Form(
                key: _formkey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FullHeaderPainter(
                          HeaderText: S.of(context).titleRegister),
                      const SizedBox(
                        height: 150,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 15, left: 30, right: 30),
                        child: IntlPhoneField(
                          controller: phone,
                          autofocus: true,
                          initialCountryCode: 'SY',
                          keyboardType: TextInputType.phone,
                          onChanged: (value) {
                            value.completeNumber;
                          },
                          decoration: buildInputDecoration(
                              Icons.phone, S.of(context).Phone_Number),
                        ),
                      ),
                      Container(
                        width: 325,
                        height: 65,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 10, top: 5),
                              child: Icon(Icons.location_city,
                                  color: Color(0xFF413F3F)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, right: 20, top: 5),
                              child: DropdownButton(
                                borderRadius: BorderRadius.circular(30),
                                underline:
                                    const Divider(thickness: 0, height: 0),
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: Color(0xFF464241),
                                  size: 30,
                                ),
                                dropdownColor: Color(0xFFB2CCC8),
                                hint: Text(
                                  S.of(context).Country,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: Color(0xFF464241),
                                      fontFamily: 'Cairo'),
                                ),
                                items: CountryList.map(
                                  (item) => DropdownMenuItem(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontFamily: 'Cairo'),
                                    ),
                                  ),
                                ).toList(),
                                onChanged: (item) {
                                  setState(() {
                                    selectedCountry = item;
                                    // print( selectedGender);
                                  });
                                },
                                value: selectedCountry,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: 325,
                        height: 65,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 5, top: 11),
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(right: 15, bottom: 10),
                                child: Icon(Icons.school_sharp,
                                    color: Color(0xFF413F3F)),
                              ),
                              MultiSelectDialogField(
                                chipDisplay: MultiSelectChipDisplay.none(),
                                items: _items,
                                title: Text(S.of(context).specialization),
                                searchable: true,
                                selectedColor: Kcolor,
                                buttonText: Text(
                                  S.of(context).Favorite_specialization,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: Color(0xFF464241),
                                      fontFamily: 'Cairo'),
                                ),
                                buttonIcon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: Color(0xFF464241),
                                  size: 30,
                                ),
                                onConfirm: (results) {
                                  setState(() {
                                    _selectedSpecialist = results.cast<Specialist>();
                                    for (var specialist in _selectedSpecialist) {
                                      print(specialist.id);  // Assuming 'name' is a property of 'Specialist'
                                    }
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 10, right: 30, left: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () {
                                    _selectDate();
                                  },
                                  icon: const Icon(
                                    Icons.calendar_month,
                                    color: Color(0xFF565555),
                                  ),
                                  label: Text(
                                    S.of(context).Date_of_birth,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontFamily: 'Cairo',
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Kcolor,
                                    minimumSize: const Size(50, 50),
                                  ),
                                ),
                                Text(
                                  '${date.day}/${date.month}/${date.year}',
                                  style: const TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              children: [
                                Container(
                                  height: 50,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    color: Kcolor,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20, bottom: 5),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.wc_sharp,
                                          color: Color(0xFF565555),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        DropdownButton(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          underline: const Divider(
                                            color: Kcolor,
                                          ),
                                          icon: const Icon(
                                            Icons.arrow_drop_down,
                                            color: Colors.white,
                                          ),
                                          dropdownColor: Kcolor,
                                          hint: Text(
                                            S.of(context).Gender,
                                            style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                                fontFamily: 'Cairo'),
                                          ),
                                          items: genderList
                                              .map(
                                                (item) => DropdownMenuItem(
                                                  value: item,
                                                  child: Text(
                                                    item,
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.white,
                                                        fontFamily: 'Cairo'),
                                                  ),
                                                ),
                                              )
                                              .toList(),
                                          onChanged: (item) {
                                            setState(() {
                                              selectedGender = item;
                                            });
                                          },
                                          value: selectedGender,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 50),
                      GestureDetector(
                          onTap: () {
                            if (_formkey.currentState!.validate()) {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return HomePage();
                              }));
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 0.0, horizontal: 80.0),
                            child: Container(
                              height: 40,
                              width: 150,
                              decoration: const BoxDecoration(
                                  color: Kcolor,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30),
                                  )),
                              child: Center(
                                child: Text(
                                  S.of(context).titleRegister,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Cairo',
                                  ),
                                ),
                              ),
                            ),
                          )),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return LoginPage();
                          }));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(S.of(context).already_a_member,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Cairo',
                                )),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ])),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1975),
      lastDate: DateTime(2100),
    );
    if (_picked != null) {
      setState(() {
        date = _picked;
      });
    }
  }
}

class Specialist {
  final int id;
  final String name;

  Specialist({
    required this.id,
    required this.name,
  });
}
