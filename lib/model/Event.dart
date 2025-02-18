import 'package:cloud_firestore/cloud_firestore.dart';

class Event{
  String? title;
  String? description;
  String? category;
  Timestamp? date;
  double? lat;
  double? lng;
  bool? isWishList;
  String? userId;
  String? id;
  Event({this.id,this.userId,this.title,this.description,this.category,this.date,this.lat,this.lng,this.isWishList});
  Event.fromFireStore(Map<String,dynamic>?data){
    title=data?["title"];
    description=data?["description"];
    category=data?["category"];
    date=data?["date"];
    lat=data?["lat"];
    lng=data?["lng"];
    isWishList=data?["isWishList"];
    userId=data?["userId"];
    id=data?["id"];
  }

  Map<String,dynamic>toFireStore(){
    return{
      "title":title,
      "description":description,
      "category":category,
      "date":date,
      "lat":lat,
      "lng":lng,
      "isWishList":isWishList,
      "userId":userId,
      "id":id
    };
}

}