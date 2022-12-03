import 'package:flutter/material.dart';
import 'package:project/loginpage.dart';
import 'package:project/signuppage.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage>with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    var _tabController = TabController(length: 2, vsync: this);
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          TabBar(
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.black,
            tabs: const [
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text("Login"),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text("SignUp"),
              )
            ],
            controller: _tabController,
          ),
          Expanded(
            child: TabBarView(
              children: [
                LoginPage(),
                SignUpPage()
              ],
              controller: _tabController,
            ),
          )
        ],
      ),
    );
  }

}
