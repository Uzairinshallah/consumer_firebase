class StaffModel{
  late String profName;
  late String age;
  late String subject;
  late String university;

  StaffModel({required this.profName, required this.age,required this.subject, required this.university});

  //getting data from firebase
  StaffModel.fromJson(Map <String, dynamic> staffData){
    profName = staffData['prof name'] ?? '';
    age = staffData['age'] ?? '';
    subject = staffData['subject'] ?? '';
    university = staffData['university'] ?? '';
  }

  // Map<String,dynamic> toJson() {
  //   return {
  //     "prof name":profName,
  //     "age":age,
  //     "subject":subject,
  //     "university":university,
  //   };
  // }



}