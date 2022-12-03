import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/datas.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TextEditingController categoryController = TextEditingController();
  TextEditingController languageController = TextEditingController();
  TextEditingController genreController = TextEditingController();
  TextEditingController votingController = TextEditingController();
  String valueChanged = "";
  List<String> selected = [];
  bool like = false;
  bool unlike = false;
  var vote = 0;
  var jsonData;
  List<Result>  myList =[] ;
  List<Result> results = [];
  var length = 0;



  Future postData() async{
    var response = await http.post(
        Uri.parse("https://hoblist.com/api/movieList"),
        body: {
          "category":"movies",
          "language":"kannada",
          "genre":"all",
          "sort":"voting"
        }
    );
    if (response.statusCode == 200) {
      setState(() {
        jsonData = jsonDecode(response.body);
      });
      length = (jsonData as Map).length;

      debugPrint("response true");
    } else {
      print(response.statusCode);
      debugPrint("response false");
    }

    for(int i = 0 ; i<10; i++){
      Result result = Result(
        title: jsonData["result"][i]["title"],
        language: jsonData["result"][i]["language"],
        genre: jsonData["result"][i]["genre"],
        voting: jsonData["result"][i]["voting"],
      );
      results.add(result);
    }
    print("length ${results}");

  }

  @override
  void initState(){
    super.initState();
    postData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies List"),
        centerTitle: true,
        elevation: 0,
      ),
      drawer: Drawer(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text("Company Info"),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20,),
                  Row(children: [
                    Text("Company: ",style: TextStyle(fontWeight: FontWeight.w500),),
                    SizedBox(width: 200,child: Text("Geeksynergy Technologies Pvt Ltd",overflow: TextOverflow.ellipsis,))
                  ],),
                  SizedBox(height: 10,),
                  Row(children: [
                    Text("Address: ",style: TextStyle(fontWeight: FontWeight.w500),),
                    Text("Sanjayanagar, Bengaluru-56")
                  ],),
                  SizedBox(height: 10,),
                  Row(children: [
                    Text("Phone: ",style: TextStyle(fontWeight: FontWeight.w500),),
                    Text("XXXXXXXX99")
                  ],),
                  SizedBox(height: 10,),
                  Row(children: [
                    Text("Email: ",style: TextStyle(fontWeight: FontWeight.w500),),
                    Text("XXXXXX@gmail.com")
                  ],),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: ListView.builder(itemCount: length,itemBuilder: (context,index){
            length >= 0 ? CircularProgressIndicator() :
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black)
              ),
              height: 200,
              child: Column(
                children: [
                  Row(
                    children: [
                      Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(Icons.arrow_upward),
                               Text(jsonData["result"][index]["voting"].toString()),
                              const Icon(Icons.arrow_downward),
                              const Text("votes",)
                            ],
                          )
                        ],
                      ),
                      const SizedBox(width: 3,),
                      Row(
                        children: [
                          Image.network(jsonData["result"][index]['poster'],width: 50,height: 100,)
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(width: 5,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10,),
                              Text(jsonData["result"][index]['title'],style: TextStyle(
                                  fontSize: 18
                              ),),
                              Row(
                                children: [
                                  Text("Genre: "),
                                  Text(jsonData["result"][index]['genre']),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Director: "),
                                  Text(jsonData["result"][index]['director'][0]),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Starring: "),
                                  SizedBox(width: 200,child: Text(jsonData["result"][index]['stars'][0],overflow: TextOverflow.ellipsis,)),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("language: "),
                                  Text(jsonData["result"][index]['language']),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(jsonData["result"][index]['runTime'].toString()),
                                  Text(" | "),
                                  Text(jsonData["result"][index]['language']),
                                  Text(" | "),
                                  Text(jsonData["result"][index]['releasedDate'].toString()),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(jsonData["result"][index]['pageViews'].toString(),style: TextStyle(color: Colors.blueAccent),),
                                  Text(" views",style: TextStyle(color: Colors.blueAccent),),
                                  Text(" | ",style: TextStyle(color: Colors.blueAccent),),
                                  Text(" views",style: TextStyle(color: Colors.blueAccent),),
                                  Text(" voted by ",style: TextStyle(color: Colors.blueAccent),),
                                  Text(jsonData["result"][index]['voting'].toString(),style: TextStyle(color: Colors.blueAccent),),
                                  Text(" people",style: TextStyle(color: Colors.blueAccent),),
                                ],
                              )

                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 10,),
                  Container(margin: EdgeInsets.symmetric(horizontal: 10),width: double.maxFinite,child: ElevatedButton(onPressed: (){}, child: Text("Watch Trailer"),))
                ],
              ),
            );
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black)
              ),
              height: 200,
              child: Column(
                children: [
                  Row(
                    children: [
                      Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(Icons.arrow_upward),
                              Text(jsonData["result"][index]["voting"].toString()),
                              const Icon(Icons.arrow_downward),
                              const Text("votes",)
                            ],
                          )
                        ],
                      ),
                      const SizedBox(width: 3,),
                      Row(
                        children: [
                          Image.network(jsonData["result"][index]['poster'],width: 50,height: 100,)
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(width: 5,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10,),
                              Text(jsonData["result"][index]['title'],style: TextStyle(
                                  fontSize: 18
                              ),),
                              Row(
                                children: [
                                  Text("Genre: "),
                                  Text(jsonData["result"][index]['genre']),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Director: "),
                                  Text(jsonData["result"][index]['director'][0]),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Starring: "),
                                  SizedBox(width: 200,child: Text(jsonData["result"][index]['stars'][0],overflow: TextOverflow.ellipsis,)),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("language: "),
                                  Text(jsonData["result"][index]['language']),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(jsonData["result"][index]['runTime'].toString()),
                                  Text(" | "),
                                  Text(jsonData["result"][index]['language']),
                                  Text(" | "),
                                  Text(jsonData["result"][index]['releasedDate'].toString()),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(jsonData["result"][index]['pageViews'].toString(),style: TextStyle(color: Colors.blueAccent),),
                                  Text(" views",style: TextStyle(color: Colors.blueAccent),),
                                  Text(" | ",style: TextStyle(color: Colors.blueAccent),),
                                  Text(" views",style: TextStyle(color: Colors.blueAccent),),
                                  Text(" voted by ",style: TextStyle(color: Colors.blueAccent),),
                                  Text(jsonData["result"][index]['voting'].toString(),style: TextStyle(color: Colors.blueAccent),),
                                  Text(" people",style: TextStyle(color: Colors.blueAccent),),
                                ],
                              )

                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 10,),
                  Container(margin: EdgeInsets.symmetric(horizontal: 10),width: double.maxFinite,child: ElevatedButton(onPressed: (){}, child: Text("Watch Trailer"),))
                ],
              ),
            );
          }

          )
        ),
      ),
    );
  }
}
