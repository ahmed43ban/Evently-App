class User{
  String? id;
  String? email;
  String? name;
  User({this.id,this.email,this.name});
  User.fromFireStore(Map<String,dynamic>? data){
    id =data?["id"];
    name =data?["name"];
    email =data?["email"];
  }
  Map<String,dynamic>toFireStore(){
    return{
      "id":id,
      "name":name,
      "email":email
    };
  }
}