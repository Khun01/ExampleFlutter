class Comment {
  final String? rating;
  final String comment;
  final String createdAt;
  final String commenterFirstName;
  final String commenterLastName;
  final String? commenterProfileImg;

  Comment(
      {required this.rating,
      required this.comment,
      required this.createdAt,
      required this.commenterFirstName,
      required this.commenterLastName,
      this.commenterProfileImg});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      rating: json['rating']?.toString(),
      comment: json['comment'],
      createdAt: json['created_at'],
      commenterFirstName: json['commenter_first_name'],
      commenterLastName: json['commenter_last_name'],
      commenterProfileImg: json['commenter_profile_img'],
    );
  }

  String get formattedTime => _formatTime(createdAt);

  String _formatTime(String time) {
    return time.substring(0, 10);
  }
}
