class Announcement {
  final int id;
  final String heading;
  final String description;
  final String? announcementImg;
  final String time;

  Announcement({
    required this.id,
    required this.heading,
    required this.description,
    required this.announcementImg,
    required this.time
  });

  factory Announcement.fromJson(Map<String, dynamic> json){
    return Announcement(
      id: json['id'], 
      heading: json['heading'], 
      description: json['description'], 
      announcementImg: json['announcement_image'],
      time: json['created_at']
    );
  }
}