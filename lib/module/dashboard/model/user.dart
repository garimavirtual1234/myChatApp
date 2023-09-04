

class UserModel {
  String? id;
  final String email;
  final String name;
  final String? imageUrl;
  final String? phoneNumber;
  final String password;

  UserModel({
    this.id = '',
    required this.email,
    required this.name,
    required this.password,
    this.imageUrl,
    this.phoneNumber
  });

  Map<String, dynamic> toMap() {
     return {
       'id': id,
       'email': email,
       'name': name,
       'imageUrl':imageUrl,
       'phoneNumber':phoneNumber,
       'password': password
     };
      }

  UserModel.fromDocumentSnapshot(doc, this.imageUrl, this.phoneNumber,) :
      id= doc.id,
      email= doc.data()!["email"],
      name=doc.data()!['name'],
      password= doc.data()!['password'];

}