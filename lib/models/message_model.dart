class MessageModel {

  int? id;
  int senderId;
  int receiverId;
  String message;
  String date;

  MessageModel({
    this.id,
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "senderId": senderId,
      "receiverId": receiverId,
      "message": message,
      "date": date,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map["id"],
      senderId: map["senderId"],
      receiverId: map["receiverId"],
      message: map["message"],
      date: map["date"],
    );
  }
}