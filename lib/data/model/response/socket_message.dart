class SocketMessage {
  final String senderId;
  final String receiverId;
  final String? text;
  final Media? media;
  final bool seen;

  SocketMessage({
    required this.senderId,
    required this.receiverId,
    this.text,
    this.media,
    required this.seen,
  });

  Map<String, dynamic> toJson() => {
    'senderId': senderId,
    'receiverId': receiverId,
    'text': text,
    'media': media?.toJson(),
    'seen': seen,
  };

  factory SocketMessage.fromJson(Map<String, dynamic> json) => SocketMessage(
    senderId: json['senderId'],
    receiverId: json['receiverId'],
    text: json['text'],
    media: json['media'] != null ? Media.fromJson(json['media']) : null,
    seen: json['seen'],
  );
}

class Media {
  final String url;
  final String type;

  Media({required this.url, required this.type});

  Map<String, dynamic> toJson() => {
    'url': url,
    'type': type,
  };

  factory Media.fromJson(Map<String, dynamic> json) => Media(
    url: json['url'],
    type: json['type'],
  );
}
