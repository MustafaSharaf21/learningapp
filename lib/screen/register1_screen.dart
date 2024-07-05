import 'dart:convert';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:learningapp/screen/home_screen.dart';
import 'package:lottie/lottie.dart';
import '../core/constants.dart';
import '../core/widgets/buildInputDecoration.dart';
import '../core/widgets/header_painater.dart';
import '../data/http.dart';
import '../generated/l10n.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:http/http.dart' as http;

import 'login_screen.dart';



class RegisterPage extends StatefulWidget {
  static String id = "RegisterPage";

  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  TextEditingController full_Name = TextEditingController();
  TextEditingController Student_or_teacher = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  TextEditingController idd = TextEditingController();
  TextEditingController countryIdd = TextEditingController();
  TextEditingController SpeIdd = TextEditingController();
  TextEditingController birthDate = TextEditingController();
  bool secureText = true,
      secureText2 = true;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final Map<String, int>roles = {'Student': 3, 'Teacher': 2};
  String? selectedRole;
  int? selectedRoleId;
  int? countryId;
  List<DropdownMenuItem<int>> countryItems = [];
  List<DropdownMenuItem<int>> SpecializationItems = [];
  Map<String, dynamic> countries = {};
  Map<String, dynamic> Specializations = {};
  int? selectedCountryId;
  int? selectedSpecializeId;

  @override
  void initState() {
    super.initState();

    fetchCountries();
    // _selectedSpecialist = _Specialties;
    super.initState();
    fetchSpesialization();
    super.initState();
  }
  TextEditingController phone = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController gender =TextEditingController();
  DateTime date = DateTime.now();
  String? selectedGender;
  List<String> genderList = ['male', 'female'];
  String? selectedCountry;
  String? selectedSpe;
  List<String> CountryList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Colors.white,
                Color(0xFFB2CCC8),
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft
          ),
        ),
        child: ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          children: [Form(
            key: _formkey,
            child: Column(
              children: [
                FullHeaderPainter(HeaderText: S.of(context).titleRegister),
                const SizedBox(height: 50),
                DefaultTextStyle(
                  style: const TextStyle(
                      fontSize: 15,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold,
                      color: Kcolor
                  ),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(S
                          .of(context)
                          .Teacher_or_Student),
                    ],
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
                        child: Icon(Icons.person, color: Color(0xFF413F3F)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 5),
                        child: DropdownButton<String>(
                          borderRadius: BorderRadius.circular(30),
                          // underline:const Divider( thickness:0,height:0),
                          icon: const Icon(
                            Icons.arrow_drop_down, color: Color(0xFF464241),
                            size: 30,),
                          dropdownColor:Colors.white,
                          hint: Text(
                            S.of(context).Choose_Teacher_or_Student,
                            style: const TextStyle(
                                fontSize: 15,
                                color: Color(0xFF464241),
                                fontFamily: 'Cairo'),
                          ),
                          items: roles.entries.map((entry) {
                            return
                              DropdownMenuItem<String>(
                                value: entry.key.toString(),
                                child: Text(entry.key,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontFamily: 'Cairo'),
                                ),
                              );
                          }).toList(),
                          onChanged: (String?newValue) {
                            setState(() {
                              selectedRole = newValue;
                              selectedRoleId = roles[newValue];
                              idd.text=selectedRoleId.toString();
                              print(
                                  'Selected role: $selectedRole, ID: $selectedRoleId');
                            });
                          },
                          value: selectedRole,

                        ),),
                    ],
                  ),

                ),
                const SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 15, left: 30, right: 30,),
                  child: TextFormField(
                    controller: full_Name,
                    keyboardType: TextInputType.text,
                    decoration: buildInputDecoration(Icons.person, S
                        .of(context)
                        .Full_Name),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return S
                            .of(context)
                            .Enter_a_name;
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 15, left: 30, right: 30),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: email,
                    decoration: buildInputDecoration(Icons.email, S
                        .of(context)
                        .email),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return S
                            .of(context)
                            .enter_an_email;
                      }
                      if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                          .hasMatch(value)) {
                        return S
                            .of(context)
                            .enter_a_valid_Email;
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 15, left: 30, right: 30),
                  child: TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: password,
                    obscureText: secureText,
                    decoration: InputDecoration(
                      labelText: S
                          .of(context)
                          .password,
                      hintText: S
                          .of(context)
                          .password,
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              secureText = !secureText;
                            });
                          },
                          icon: Icon(secureText ? Icons.visibility_off : Icons
                              .visibility)),
                      prefixIcon: const Icon(Icons.lock),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: Kcolor, width: 1),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return S
                            .of(context)
                            .enter_a_password;
                      }
                      if (value.length < 6) {
                        return S
                            .of(context)
                            .Password_characters;
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 15, left: 30, right: 30),
                  child: TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: secureText2,
                    controller: confirmpassword,
                    decoration: InputDecoration(
                      labelText: S
                          .of(context)
                          .Confirm_Password,
                      hintText: S
                          .of(context)
                          .Confirm_Password,
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              secureText2 = !secureText2;
                            });
                          },
                          icon: Icon(secureText2 ? Icons.visibility_off : Icons
                              .visibility)),
                      prefixIcon: const Icon(Icons.lock),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: Kcolor,
                            width: 1
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return S
                            .of(context)
                            .Reenter_Password;
                      }
                      print(password.text);

                      print(confirmpassword.text);

                      if (password.text != confirmpassword.text) {
                        return S
                            .of(context)
                            .Enter_the_Password_Correctly;
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10, left: 30, right: 30),
                  child: IntlPhoneField(
                    controller: phone,
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
                  width: 300,
                  height: 65,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 10, top: 5),
                        child: Icon(Icons.location_city, color: Color(0xFF413F3F)),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5), // تعديل الحشوات
                          child:DropdownButton<int>(
                            borderRadius: BorderRadius.circular(30),
                            underline: const Divider(thickness: 0, height: 0),
                            icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF464241)),
                            dropdownColor: Color(0xFFB2CCC8),
                            hint: Text(
                              selectedCountry ?? S.of(context).Country,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xFF464241),
                                fontFamily: 'Cairo',
                              ),
                            ),
                            items: countryItems,
                            onChanged: (int? item) {
                              setState(() {
                                GetStorage().write('selectedCountryId', item);
                                selectedCountry = countries['data'].firstWhere((c) => c['id'] == item)['name'];
                                selectedCountryId=item;
                                countryIdd.text=selectedCountryId.toString();
                              });
                              print('Selected country ID: $item');
                              print('country id to back:$selectedCountryId');
                              //sendSelectedCountryToBackend(item);
                            },
                            value: selectedCountryId,
                            isExpanded: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),const SizedBox(
                  height: 15,
                ),
                Container(
                  width: 300,
                  height: 65,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 10, top: 5),
                        child: Icon( Icons.school_sharp, color: Color(0xFF413F3F)),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5), // تعديل الحشوات
                          child:DropdownButton<int>(
                            borderRadius: BorderRadius.circular(30),
                            underline: const Divider(thickness: 0, height: 0),
                            icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF464241)),
                            dropdownColor: Color(0xFFB2CCC8),
                            hint: Text(
                              selectedSpe ?? S.of(context).specialization,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xFF464241),
                                fontFamily: 'Cairo',
                              ),
                            ),
                            items: SpecializationItems,
                            onChanged: (int? item) {
                              setState(() {
                                GetStorage().write('selectedCountryId', item);
                                selectedSpe = Specializations['data'].firstWhere((c) => c['id'] == item)['name'];
                                selectedSpecializeId=item;
                                SpeIdd.text=selectedSpecializeId.toString();
                              });
                              print('Selected Specialize ID: $item');
                              print('Specialize id to back:$selectedSpecializeId');
//sendSelectedCountryToBackend(item);
                            },
                            value: selectedSpecializeId,
                            isExpanded: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 10, right: 30, left: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Container(width: 140,
                            child: ElevatedButton.icon(
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
                                        gender.text=selectedGender.toString();
                                        print('gender is : $selectedGender');
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
                        signup();
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) {
                        //       return HomePage();
                        //     }));
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
              ],
            ),
          ),
          ],
        ),
      ),
    );
  }

  // Future<void> signup1() async {
  // String apiUrl='http://192.168.43.63:8000/api/register';
  // int? id = roles[selectedGender];
  // try{
  //   var response = await http.post(Uri.parse(apiUrl),
  //   body: json.encode({
  //     'name':full_Name.text,
  //     'email':email.text,
  //     'password':password.text,
  //     'confirm_password':confirmpassword.text,
  //     'role_id':id
  //   }),
  //   );
  //   if (response.statusCode==200){
  //     print('User registered successfully');
  //     navigatorToRegister2();
  //   }else{
  //     print(res);
  //     print('Failed to register user');
  //   }
  // }catch(e){
  //   print(e.toString());
  // }
  // }
  signup() async {
    int? id = roles[selectedGender];
    int?countryId=selectedCountryId;

    await HttpHelper.postData(url: 'register', body: {
      'name': full_Name.text,
      'email': email.text,
      'password': password.text,
      'confirm_password': confirmpassword.text,
      'role_id': idd.text,
      'country_id':countryIdd.text,
      'specialization_id[]':SpeIdd.text,
      'gender':gender.text,
      'birth_date':birthDate.text,
      'mobile_number':phone.text


    }).then((value) {
      Map<String, dynamic> res = jsonDecode(value.body);
      print(res);
      if (value.statusCode == 200 || value.statusCode == 201) {
        token = res['data']['token'];
        GetStorage _box = GetStorage();
        _box.write('token', token);
        Get.snackbar(
            ' ', res['status'].toString(),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.black,
            colorText: Colors.white
        );
        print(res);
        print(token);
        Get.to((HomePage()));
      } else {
        print(res);
        Get.snackbar(
            'Error', res['status'].toString(),
            backgroundColor: Colors.black,
            colorText: Colors.white

        );
      }
    });

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
        birthDate.text='${_picked.year}-${_picked.month.toString().padLeft(2,'0')}-${_picked.day.toString().padLeft(2,'0')}';
        print(' birth_date:$date');
      });
    }
  }
  Future<void> fetchCountries() async {
    final response = await http.get(
      Uri.parse('http://192.168.118.128:8000/api/getCountries'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      setState(() {
        countries = jsonDecode(response.body);
        countryItems = (countries['data'] as List)
            .map((country) => DropdownMenuItem<int>(
          value: country['id'],
          child: Text(country['name']),
        ))
            .toList();
      });
    } else {
      print('Error fetching countries');
    }
  }
  Future<void> fetchSpesialization() async {
    final response = await http.get(
      Uri.parse('http://192.168.118.128:8000/api/getSpecializations'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      setState(() {
        Specializations = jsonDecode(response.body);
        SpecializationItems = (Specializations['data'] as List)
            .map((Specialize) => DropdownMenuItem<int>(
          value: Specialize['id'],
          child: Text(Specialize['name']),
        ))
            .toList();
      });
    } else {
      print('Error fetching countries');
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
/* GestureDetector(
                  onTap: () {
                    if (_formkey.currentState!.validate()) {
                      signup();
                  Get.to(

                    RegisterPage2()
                  );
                    }
                  },
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 80.0),
                      child: Lottie.asset(
                        'assets/images/next2.json', height: 150, width: 150,)
                  ),
                ),*/
// MultiSelectDialogField(
// chipDisplay: MultiSelectChipDisplay.none(),
// items: _items,
// title: Text(S.of(context).specialization),
// searchable: true,
// selectedColor: Kcolor,
// buttonText: Text(
// S.of(context).Favorite_specialization,
// style: const TextStyle(
// fontSize: 15,
// color: Color(0xFF464241),
// fontFamily: 'Cairo'),
//
// ),
// buttonIcon: const Icon(
// Icons.arrow_drop_down,
// color: Color(0xFF464241),
// size: 30,
// ),
// onConfirm: (results) {
// setState(() {
// _selectedSpecialist = results.cast<Specialist>();
// for (var specialist in _selectedSpecialist) {
// print(specialist.id);  // Assuming 'name' is a property of 'Specialist'
// }
// });
// },
// ),

//eee