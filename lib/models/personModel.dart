class PersonModel{
  late String name;
  late String age;
  late String address;

  PersonModel({required this.name, required this.age});

  //to get data from firebase
  PersonModel.fromJson(Map < String,dynamic > stuData ){
    name = stuData['name'] ??  '';
    age = stuData['age'];
    address = stuData['address'] ?? '';
  }
  //to store data in firebase
   Map<String,dynamic> toJson() {
    return {
      "name":name,
      "age":age,
      "address":address,
    };
  }
  }


