class TripSupabase {
  int? id;
  int? userId;
  int? destinationId;
  int? days;
  DateTime? startDate;
  DateTime? endDate;

  TripSupabase({
    this.id,
    this.userId,
    this.destinationId,
    this.days,
    this.startDate,
    this.endDate,
  });

  factory TripSupabase.fromMap(Map<String, dynamic> map) {
    return TripSupabase(
      id: map['id'] as int?,
      userId: map['user_id'] as int?,
      destinationId: map['destination_id'] as int?,
      days: map['days'] as int?,
      startDate: map['start_date'] as DateTime?,
      endDate: map['end_date'] as DateTime?,
    );
  }
}
