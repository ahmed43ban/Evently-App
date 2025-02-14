import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/model/User.dart';

class FireStoreHandler{
  static CollectionReference<User>  getUserCollection(){
    var collectionReference= FirebaseFirestore.instance.collection("User").withConverter(
      fromFirestore: (snapshot, options) {
        Map<String,dynamic>? data=snapshot.data();
        return User.fromFireStore(data);
      },
      toFirestore:(user, options) {
        return user.toFireStore();
      }, );
    return collectionReference;
  }
  static Future<void> AddUser(User user){
    var collection=getUserCollection();
    var document=collection.doc(user.id);
    return document.set(user);
  }
  static Future<User?>getUser(String uId)async{
    var collection=getUserCollection();
    var document=collection.doc(uId);
    var snapshot=await document.get();
    return snapshot.data();
  }
}