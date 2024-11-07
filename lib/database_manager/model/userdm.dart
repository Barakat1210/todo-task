import 'package:intl/intl.dart';

class UserDM{
  static const String collectionName='users';
  static UserDM?userDM;
  String id;
  String fullName;
  String userName;
  String email;
  UserDM(
      {required this.id, required this.fullName, required this.userName, required this.email});
  Map<String,dynamic>toFireStore()=>{
    'id':id,
    'fullName':fullName,
    'userName':userName,
    'email':email,
  };
  UserDM.fromFireStore(Map<String,dynamic>json):this(
    id: json['id'],
    fullName: json['fullName'],
    userName: json['userName'],
    email: json['email'],
  );
}