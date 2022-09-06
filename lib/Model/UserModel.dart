class UserModel{

  int id = 0;
  String email = '';
  String first_name = '';
  String last_name = '';
  String avatar = '';

  UserModel();

  UserModel.fromJSON(Map<String, dynamic> toJSON){
    id = toJSON['id'] ?? 0;
    email = toJSON['email'] ?? '';
    first_name = toJSON['first_name'] ?? '';
    last_name = toJSON['last_name'] ?? '';
    avatar = toJSON['avatar'] ?? '';
  }

  Map toMAP(){
    var map = new Map<String,dynamic>();
    map['id'] = id;
    map['email'] = email;
    map['first_name'] = first_name;
    map['last_name'] = last_name;
    map['avatar'] = avatar;
    return map;
  }

}