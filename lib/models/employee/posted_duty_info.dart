class PostedDutyInfo {
  int? confirmedDuty;
  int? activeDuty;
  int? postedDuty;

  PostedDutyInfo({
    this.confirmedDuty,
    this.activeDuty,
    this.postedDuty,
  });

  factory PostedDutyInfo.fromJson(Map<String, dynamic> json) {
    return PostedDutyInfo(
      confirmedDuty: json['confirmed_duty'] ?? 0,
      activeDuty: json['active_duty'] ?? 0,
      postedDuty: json['posted_duty'] ?? 0,
    );
  }
}