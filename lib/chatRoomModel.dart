
class ChatRoomModel{
  String chatroomid;
  List<String> participants;

  ChatRoomModel({required this.chatroomid, required this.participants});


  Map<String,dynamic> toJson()=>{
  'chatroomid':chatroomid,
  'participants':participants,
  };

  static ChatRoomModel fromJson(Map<String , dynamic> json) => ChatRoomModel(
      chatroomid: json['chatroomid'],
      participants: json[' participants'],

  );
}