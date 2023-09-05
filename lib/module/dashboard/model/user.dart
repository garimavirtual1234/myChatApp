

class UserModel {
  String? id;
   String? email;
   String? name;
 String? imageUrl;
   String? phoneNumber;
   String? password;
  String? userLastMessage;
 String? lastMessageTime;

  UserModel({
    this.id = '',
     this.email,
     this.name,
     this.password,
    this.imageUrl,
    this.phoneNumber,
    this.lastMessageTime,
    this.userLastMessage
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

  UserModel.fromDocumentSnapshot(doc,
      this.imageUrl, this.phoneNumber, this.userLastMessage, this.lastMessageTime,) :
      id= doc.id,
      email= doc.data()!["email"],
      name=doc.data()!['name'],
      password= doc.data()!['password'];

}