class ProfDuty {
  final int id;
  final String building;
  final String date;
  final String startTime;
  final String endTime;
  final int duration;
  final String message;
  final int maxScholars;
  final int currentScholars;
  final int isLocked;
  final String dutyStatus;
  final int isCompleted;
  final int profId;

  ProfDuty({
    required this.id,
    required this.building,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.duration,
    required this.message,
    required this.maxScholars,
    required this.currentScholars,
    required this.isLocked,
    required this.dutyStatus,
    required this.isCompleted,
    required this.profId
  });

   factory ProfDuty.fromJson(Map<String, dynamic> json){
    return ProfDuty(
      id: json['id'],
      building: json['building'],
      date: json['date'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      duration: json['duration'],
      message: json['message'],
      maxScholars: json['max_scholars'],
      currentScholars: json['current_scholars'],
      isLocked: json['is_locked'],
      dutyStatus: json['duty_status'],
      isCompleted: json['is_completed'], 
      profId: json['prof_id']
    );
   }
}
