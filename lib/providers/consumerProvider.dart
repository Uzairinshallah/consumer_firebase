import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consumer_firebase/models/staffModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/personModel.dart';

class Person with ChangeNotifier {
  Person() {
    getStuData();
  }

  List<PersonModel> personModel = [];

  void addPerson(var p) {
    personModel.add(p);
  }

  getStuData() async {
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

class Staff with ChangeNotifier {
  Staff() {
    getStaffData();
  }

  List<StaffModel> staffModel = [];

  void addStaff(var s) {
    staffModel.add(s);
  }

  getStaffData() async {
    try {
      var collectionRef =
      await FirebaseFirestore.instance.collection('staff').get();
      for (var obj in collectionRef.docs) {
        StaffModel model = StaffModel.fromJson(obj.data());
        addStaff(model);
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
        body: Column(
          children: [
            const Text(
              'Students Details',
              style: TextStyle(fontSize: 23, color: Colors.lightGreen),
            ),
            SingleChildScrollView(
              child: Container(
                color: Colors.orange,
                width: double.infinity,
                height: 200,
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
                    return CircularProgressIndicator();
                    // return CircularProgressIndicator();
                  }
                }),
              ),
            ),
            const Text(
              'Staff Details',
              style: TextStyle(fontSize: 23, color: Colors.lightGreen),
            ),
            SingleChildScrollView(
              child: Container(
                color: Colors.orange,
                width: double.infinity,
                height: 200,
                child: Consumer<Staff>(
                    builder: (BuildContext context, value, Widget? child) {
                  if (value.staffModel.isNotEmpty) {
                    print(value.staffModel);
                    return ListView.builder(
                        itemCount: value.staffModel.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Text(value.staffModel[index].profName),
                            subtitle: Text(value.staffModel[index].subject),
                            trailing: Text(value.staffModel[index].university),
                          );
                        });
                  } else {
                    return CircularProgressIndicator();
                    // return CircularProgressIndicator();
                  }
                }),
              ),
            ),
          ],
        ));
  }
}
