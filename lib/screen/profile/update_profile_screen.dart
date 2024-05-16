import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class UpdateProfileScreen extends StatefulWidget {
  static String id = " UpdateProfileScreen";
  @override
  _EditImagePageState createState() => _EditImagePageState();
}

class _EditImagePageState extends State<UpdateProfileScreen> {

  XFile? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final XFile? selectedImage = await _picker.pickImage(source: source);
    if (selectedImage != null) {
      setState(() {
        _image = selectedImage;
      });
    }
  }
  bool pass = true;
  GlobalKey<FormState> formstate = GlobalKey();

  TextEditingController phone_num=TextEditingController();

 // TextEditingController password=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Image Example'),
      ),
      body:
        SingleChildScrollView(
    child: Container(height:700,
    decoration:const  BoxDecoration(
    gradient: LinearGradient(
    colors: [
    Colors.white,
    Color(0xFFE6E8E7)],//Color(0xFFBCF3E2)
    begin: Alignment.bottomLeft,
    end: Alignment.topRight
    ),
    ),
    padding: EdgeInsets.only(left: 35,right: 35,bottom: 35),
    child: Column(
            children: [
              SizedBox(height: 50,),
              Stack(
                alignment: Alignment.bottomRight,
                children: <Widget>[
                  SizedBox(
                    width: 120.0,
                    height: 120.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100.0),
                      child: _image != null
                          ? Image.file(
                        File(_image!.path),
                        fit: BoxFit.cover,
                      )
                          : Image.asset(
                        'assets/placeholder.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Color(0xFF399679),
                        ),
                        child:  IconButton(icon:Icon(Icons.camera_alt_outlined,size: 15),onPressed: (){showModalBottomSheet(
                          context: context,
                          builder: (context) => BottomSheet(
                            builder: (context) => Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  leading: Icon(Icons.camera),
                                  title: Text('Camera'),
                                  onTap: () {
                                    _pickImage(ImageSource.camera);
                                    Navigator.of(context).pop();
                                  },
                                ),
                                ListTile(
                                  leading: Icon(Icons.image),
                                  title: Text('Gallery'),
                                  onTap: () {
                                    _pickImage(ImageSource.gallery);
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                            onClosing: () {},
                          ),
                        );}),
                      ),

                    ),

                ],
              ),
              const SizedBox(height:80),
              Form(
                  key: formstate,
                  child: Column(children: [
                    TextFormField(
                      decoration: InputDecoration(
                          isDense:true,border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                          label: Text("Phone Number"),prefixIcon: Icon(Icons.person,size: 20,)
                      ),
                    ),
                    const SizedBox(height: 24,),
                    // TextFormField(
                    //   decoration: InputDecoration(isDense:true,border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                    //       label: Text("Email"),prefixIcon: Icon(Icons.email_outlined,size: 20,)
                    //   ),
                    // ),

                    SizedBox(height: 60,),
                    SizedBox(child:  Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF399679)),
                          onPressed: (){
                          if (_image!=null&& phone_num.text.isNotEmpty){
                            _updateProfile(File(_image!.path),
                            phone_num.text);
                          }else{
                            print('Please select an image and enter your phone number');
                          }
                          }, child: const Text("Save",style: TextStyle(color: Colors.white),) ,),
                        ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                            onPressed: (){}, child: const Text("cancel") ),
                      ],
                    )
                    ),
                  ],))
            ],
    ),
    )
        ));
  }
  Future<void> _updateProfile(File image,String phone)async{
    var uri = Uri.parse('http://192.168.43.63:8000/api/profile');
    var request =http.MultipartRequest('Post',uri)..fields['mobile_number']=phone
    ..files.add(await http.MultipartFile.fromPath('image',image.path));
    var response =await request.send();
    if(response.statusCode==200){
      print('Profile updated successfully');
    }else{
      print('Profile update failed with status:${response.statusCode}');
    }
  }
  @override
  void dispose(){
    phone_num.dispose();
    super.dispose();
  }
}
