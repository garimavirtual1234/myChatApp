
class MessageModel{
  String sender;
  String text;
  bool seen;
  DateTime createOn;

  MessageModel({required this.sender, required this.text,required this.seen,required this.createOn});

  Map<String,dynamic> toJson()=>{
    'sender':sender,
    'text':text,
    'seen':seen,
    'createOn':createOn
  };


  static MessageModel fromJson(Map<String , dynamic> json) => MessageModel(
      sender: json['sender'],
      text: json['text'],
    seen: json['seen'],
    createOn: json['createOn']

  );
}