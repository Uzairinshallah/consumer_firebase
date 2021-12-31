import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/personModel.dart';

class Person with ChangeNotifier {
  Person() {
    readProvider();
  }

  List<PersonModel> personModel = [];

  void addPerson(var p) {
    personModel.add(p);


  }

  readProvider() async {

    try {
      var collectionRef =
          await FirebaseFirestore.instance.collection('person').get();
      for (var obj in collectionRef.docs) {
        PersonModel model = PersonModel.fromJson(obj.data());
        addPerson(model);
      }
      notifyListeners();
      // print(collectionRef.docs.length);
    } on FirebaseException catch (e) {
      print(e.toString());
    }

  }
}


class MyApp_c extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  // const MyHomePage({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Comsumer Provider"),
        ),
        body: Container(
          color: Colors.orange,
          height: 700,
          child: Consumer<Person>(
              builder: (BuildContext context, value, Widget? child) {
              if (value.personModel.isNotEmpty) {
                print(value.personModel);
                return ListView.builder(
                    itemCount: value.personModel.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(value.personModel[index].name),
                        subtitle: Text(value.personModel[index].address),
                        trailing: Text(value.personModel[index].age),
                      );
                    });
              } else {
                return Text('Empty Data');
                // return CircularProgressIndicator();
              }
            }),
        )
        );
  }
}
