import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'package:json_parsing/model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // String personName, personAddress;
  // int personAge;

  loadPersonFromAssets() async {
    return await rootBundle.loadString('json/person.json');
  }

  List<Person> alldata = [];
  Person person;

  loadPerson() async {
    String jsonString = await loadPersonFromAssets();
    print('.............');

    final jsonResponse = json.decode(jsonString);
    print('.............');
    person = Person.fromJson(jsonResponse);
    //print(person);
    setState(() {
      alldata.add(person);
    });
    print('.............');
    print('name of the person ${person.name}');
  }

  @override
  void initState() {
    loadPerson();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      
      child: Scaffold(
        key: _scaffoldKey,
        body: Container(
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  child: ListView.builder(
                    itemCount: alldata.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text('Name ${alldata[index].name}'),
                        subtitle: Text('Address ${alldata[index].address}'),
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  child: FutureBuilder(
                    builder: (context, snapshoot) {
                      var personData = json.decode(snapshoot.data.toString());
                      return ListView.builder(
                        itemCount: personData.length,
                        itemBuilder: (context, index) {
                          var name = personData[index]['name'];
                          return ListTile(
                            onTap: (){
                               showInSnackBar(name);
                            },
                            title:
                                Text('Name : $name'),
                            subtitle: Text(
                                'Address : ${personData[index]['address']}'),
                          );
                        },
                      );
                    },
                    future: DefaultAssetBundle.of(context)
                        .loadString('json/another.json'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: Text(
        value,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.green,
      duration: Duration(milliseconds: 100),
    ));
  }
}
