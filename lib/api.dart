import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'api2.dart';

class Api extends StatefulWidget {
  const Api({Key? key}) : super(key: key);
  @override
  _ApiState createState() => _ApiState();
}

class _ApiState extends State<Api> {
  // api connection
  getuser() async {
    var response =
        await http.get(Uri.https('jsonplaceholder.typicode.com', 'users'));
    var jsonData = jsonDecode(response.body);
    var users = [];
    for (var i in jsonData) {
      UserModel user = UserModel(i['name'], i['username'], i['website']);
      users.add(user);
    }
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: getuser(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: Text('null'),
                );
              } else {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, i) {
                      return ListTile(
                        leading: Text(snapshot.data[i].name),
                        title: Text(snapshot.data[i].username),
                      );
                    });
              }
            }));
  }
}

class UserModel {
  var name;
  var username;
  var website;
  UserModel(this.name, this.username, this.website);
}
