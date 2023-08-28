class UserModel{
  String? id;
  final String email;
  final String name;
  final String password;

  UserModel({
    this.id='',
    required this.email,
    required this.name,
    required this.password
  });

  Map<String,dynamic> toJson()=>{
    'id':id,
    'email':email,
    'name':name,
    'password':password
  };

  static UserModel fromJson(Map<String , dynamic> json) => UserModel(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      password: json['password']
  );
}