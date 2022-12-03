import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import 'loginpage.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String valueChanged = "Profession";
  TextEditingController nameController =  TextEditingController();
  TextEditingController passwordController =  TextEditingController();
  TextEditingController emailController =  TextEditingController();
  TextEditingController phoneController =  TextEditingController();
  

  createAccount(String dName,String dPassword,String dEmail,String dNumber,String dProfession) async{
    var itemList = [];
    var items =
      {
        "name":dName,
        "password":dPassword,
        "email":dEmail,
        "phone":dNumber,
        "profession":dProfession
      };

    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/datafile.txt');
    // final text = items.toString();
    // itemList.add(items);
    var json = jsonEncode(items);
    await file.writeAsString("\n",mode: FileMode.append);
    await file.writeAsString(json,mode: FileMode.append);
    print('saved');
    showDialog(context: context, builder: (_){
      return AlertDialog(
        content: SizedBox(
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Account Created Successfully."),
              SizedBox(height: 15,),
              ElevatedButton(onPressed: (){
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginPage()));
              }, child: Text("Login"))
            ],
          ),
        ),
      );
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  "Join With Us",
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  height: 45,
                  child: TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: "Enter Name",
                      fillColor: Colors.white,
                      border:  OutlineInputBorder(
                        borderRadius:  BorderRadius.circular(25.0),
                        borderSide: const BorderSide(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                SizedBox(
                  height: 45,
                  child: TextFormField(
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: "Password",
                      fillColor: Colors.white,
                      border:  OutlineInputBorder(
                        borderRadius:  BorderRadius.circular(25.0),
                        borderSide: const BorderSide(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                SizedBox(
                  height: 45,
                  child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: "Email",
                      fillColor: Colors.white,
                      border:  OutlineInputBorder(
                        borderRadius:  BorderRadius.circular(25.0),
                        borderSide: const BorderSide(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                SizedBox(
                  height: 45,
                  child: TextFormField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      labelText: "Phone Number",
                      fillColor: Colors.white,
                      border:  OutlineInputBorder(
                        borderRadius:  BorderRadius.circular(25.0),
                        borderSide: const BorderSide(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                Stack(
                  children: [
                    Container(
                      height: 45,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: Colors.grey)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Align(alignment: Alignment.centerLeft,child: Text(valueChanged,)),
                      ),
                    ),
                    Positioned(
                      left: 200,
                        child: DropdownButton<String>(
                          onChanged: (newValue) {
                            setState(() {
                              valueChanged = newValue!;
                            });
                          },
                          items: <String>['Developer', 'QA Engineer', 'Designer', 'HR Manager'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),

                        ),
                    )
                  ],
                ),
                const SizedBox(height: 10,),
                GestureDetector(onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                },child: const Text("Already have an account? Login.")),
                const SizedBox(height: 10,),
                ElevatedButton(onPressed: (){
                  createAccount(nameController.text, passwordController.text, emailController.text, phoneController.text,valueChanged);
                }, child: const Text("Sign Up"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
