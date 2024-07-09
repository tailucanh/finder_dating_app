class Message {
  String? idItemChat;
  String? idUser;
  String? message;
  String? imageUrl;
  String? audioUrl;
  String? createAt;
  int? type;

  Message(
      {this.idItemChat,
      this.idUser,
      this.message,
      this.imageUrl,
      this.audioUrl,
      this.createAt,
      this.type});

  Map<String, dynamic> toJson() {
    return {
      "idItemChat": idItemChat,
      "idUser": idUser,
      "message": message,
      "imageUrl": imageUrl,
      "audioUrl": audioUrl,
      "createAt": createAt,
      "type": type,
    };
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      idItemChat: json["idItemChat"],
      idUser: json["idUser"],
      message: json["message"],
      imageUrl: json["imageUrl"],
      audioUrl: json["audioUrl"],
      createAt: json["createAt"],
      type: json["type"] ?? 0,
    );
  }
//
}
