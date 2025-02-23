import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/core/DialogUtils.dart';
import 'package:evently/model/Event.dart';
import 'package:evently/model/User.dart' as Myuser;

class FireStoreHandler {
  static CollectionReference<Myuser.User> getUserCollection() {
    var collectionReference =
        FirebaseFirestore.instance.collection("User").withConverter(
      fromFirestore: (snapshot, options) {
        Map<String, dynamic>? data = snapshot.data();
        return Myuser.User.fromFireStore(data);
      },
      toFirestore: (user, options) {
        return user.toFireStore();
      },
    );
    return collectionReference;
  }

  static CollectionReference<Event> getEventCollection() {
    var collectionReference =
        FirebaseFirestore.instance.collection("event").withConverter(
      fromFirestore: (snapshot, options) {
        Map<String, dynamic>? data = snapshot.data();
        return Event.fromFireStore(data);
      },
      toFirestore: (event, options) {
        return event.toFireStore();
      },
    );
    return collectionReference;
  }

  static Future<void> AddUser(Myuser.User user) {
    var collection = getUserCollection();
    var document = collection.doc(user.id);
    return document.set(user);
  }

  static Future<Myuser.User?> getUser(String uId) async {
    var collection = getUserCollection();
    var document = collection.doc(uId);
    var snapshot = await document.get();
    return snapshot.data();
  }

  static Future<void> createEvent(Event event) {
    var collection = getEventCollection();
    var doc = collection.doc();
    event.id = doc.id;
    return doc.set(event);
  }

  static Future<List<Event>> getAllEvents() async {
    var collection = getEventCollection();
    var querySnap = await collection.get();
    var docList = querySnap.docs;
    var eventList = docList
        .map(
          (doc) => doc.data(),
        )
        .toList();
    return eventList;
  }
 static Stream<List<Event>> getAllEventStream()async*{
    var collection =getEventCollection();
    var snapshots=collection.snapshots();
    Stream<List<Event>>eventStream=snapshots.map((snapshots) =>snapshots.docs.map((doc)=>doc.data()).toList() ,);
    yield* eventStream;
 }
  static Future<List<Event>> getCategoryEvents(String category) async {
    var collection =
        getEventCollection().where("category", isEqualTo: category);
    var querySnap = await collection.get();
    var docList = querySnap.docs;
    var eventList = docList
        .map(
          (doc) => doc.data(),
        )
        .toList();
    return eventList;
  }
  static Stream<List<Event>> getEventCategoryStream(String category)async*{
    var collection =getEventCollection().where("category", isEqualTo: category);
    var snapshots=collection.snapshots();
    Stream<List<Event>>eventStream=snapshots.map((snapshots) =>snapshots.docs.map((doc)=>doc.data()).toList() ,);
    yield* eventStream;
  }

  static CollectionReference<Event> getWishListCollection(String uid) {
    var collection =
        getUserCollection().doc(uid).collection("WishList").withConverter(
      fromFirestore: (snapshot, options) {
        Map<String, dynamic>? data = snapshot.data();
        return Event.fromFireStore(data);
      },
      toFirestore: (event, options) {
        return event.toFireStore();
      },
    );
    return collection;
  }

  static Future<List<Event>> getLoveEvents(String uid) async {
    var collection = getWishListCollection(uid);
    var querySnap = await collection.get();
    var docList = querySnap.docs;
    var eventList = docList
        .map(
          (doc) => doc.data(),
        )
        .toList();
    return eventList;
  }
  static Stream<List<Event>> getLoveEventStream(String uid)async*{
    var collection =getWishListCollection(uid);
    var snapshots=collection.snapshots();
    Stream<List<Event>>eventStream=snapshots.map((snapshots) =>snapshots.docs.map((doc)=>doc.data()).toList() ,);
    yield* eventStream;
  }

  static Future<void> addToFavorite(String uid, Event event) {
    var collection = getWishListCollection(uid);
    var doc = collection.doc(event.id);
    return doc.set(event);
  }

  static Future<void> removeFromFavorite(String uid, String eventId) {
    var collection = getWishListCollection(uid);
    return collection.doc(eventId).delete();
  }
  static Future<void> updateUserFavorite(String uid,List<String>newFavorite){
    var collection=getUserCollection();
    var doc=collection.doc(uid);
    return doc.update({
      "favorite":newFavorite
    });
  }
  static Future<void> updateEvent(Event event){
    var collection = getEventCollection();
    var doc = collection.doc(event.id);
    return doc.update(event.toFireStore());
  }
  static Future<void> deleteEvent(Event event){
    var collection = getEventCollection();
    var doc = collection.doc(event.id);
    return doc.delete();
  }
}
