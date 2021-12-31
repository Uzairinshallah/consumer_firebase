class PersonModel{
  late String name;
  late String age;
  late String address;

  PersonModel({required this.name, required this.age});

  //to get data from firebase
  PersonModel.fromJson(Map < String,dynamic > data ){
    name = data['name'] ??  '';
    age = data['age'];
    address = data['address'] ?? '';
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


