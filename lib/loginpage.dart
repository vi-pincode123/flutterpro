import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'mainpage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController nameController =  TextEditingController();
  TextEditingController passwordController =  TextEditingController();

  loginUser(String lName,String lPassword) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/datafile.txt');
      final text = (await file.readAsLines());
      for(int i = 0; i<text.length; i++){
        var string = text[2];
        var map = jsonDecode(string);
        print(map["name"]);
        if(map["name"] == lName && map["password"] == lPassword){
          Navigator.push(context, MaterialPageRoute(builder: (_)=>MainPage()));
          break;
        }
        else{
          showDialog(barrierDismissible: true,context: context, builder: (_){
            return const AlertDialog(
              title: Text("Invalid Credentials"),
              content: Text("You've entered worng password or username"),

            );
          });
          break;
        }
      }

    } catch (e) {
      print("Couldn't read file");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              const SizedBox(height: 25,),
              const Text("Welcome Back",style: TextStyle(fontSize: 20),),
              const SizedBox(height: 25,),
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
                  autocorrect: false,
                  obscureText: true,
                  enableSuggestions: false,
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
              ElevatedButton(onPressed: (){
                loginUser(nameController.text, passwordController.text);
              }, child:const Text("Login"))

            ],
          ),
        ),
      ),
    );
  }
}
