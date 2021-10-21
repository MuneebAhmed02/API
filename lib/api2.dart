import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class Api2 extends StatefulWidget {
  const Api2({Key? key}) : super(key: key);

  @override
  _Api2State createState() => _Api2State();
}

class _Api2State extends State<Api2> {
  getuser() async {
    var result =
        await http.get(Uri.https('jsonplaceholder.typicode.com', 'users'));
    var jsonData = jsonDecode(result.body);
    var users = [];
    for (var i in jsonData) {
      UserModel user = UserModel(i['website'], i['email']);
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
                  child: Text('Nothing'),
                );
              } else {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, i) {
                      return ListTile(
                        title: Text(snapshot.data[i].website),
                        subtitle: Text(snapshot.data[i].email),
                      );
                    });
              }
            }));
  }
}

class UserModel {
  var website;
  var email;
  UserModel(this.website, this.email);
}
