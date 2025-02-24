import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  String? title;
  String? description;
  String? category;
  Timestamp? date;
  double? lat;
  double? lng;
  String? userId;
  String? id;

  Event({
    this.id,
    this.userId,
    this.title,
    this.description,
    this.category,
    this.date,
    this.lat,
    this.lng,
  });

  Event.fromFireStore(Map<String, dynamic>? data) {
    title = data?["title"];
    description = data?["description"];
    category = data?["category"];
    date = data?["date"];
    lat = data?["lat"];
    lng = data?["lng"];
    userId = data?["userId"];
    id = data?["id"];
  }

  Map<String, dynamic> toFireStore() {
    return {
      "title": title,
      "description": description,
      "category": category,
      "date": date,
      "lat": lat,
      "lng": lng,
      "userId": userId,
      "id": id
    };
  }
}
