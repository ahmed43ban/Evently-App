class User{
  String? id;
  String? email;
  String? name;
  List<String>? favorite;
  User({this.favorite,this.id,this.email,this.name});
  User.fromFireStore(Map<String,dynamic>? data){
    id =data?["id"];
    name =data?["name"];
    email =data?["email"];
    favorite=List<String>.from(data?["favorite"]);
  }
  Map<String,dynamic>toFireStore(){
    return{
      "id":id,
      "name":name,
      "email":email,
      "favorite":favorite
    };
  }
}