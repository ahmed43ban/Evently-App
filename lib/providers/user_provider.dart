import 'package:evently/core/fireStoreHandler.dart';
import 'package:evently/model/User.dart' as MyUser;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier{
  MyUser.User? user;
  bool isLoading=false;
  getUser()async{
    isLoading=true;
    notifyListeners();
    user =await FireStoreHandler.getUser(FirebaseAuth.instance.currentUser!.uid);
    isLoading=false;
    notifyListeners();
  }
}