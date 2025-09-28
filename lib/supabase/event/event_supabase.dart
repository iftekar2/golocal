class EventSupabase {
  int? id;
  String? eventName;
  String? eventDescription;
  String? eventCity;
  String? eventCountry;
  String? eventImage;
  DateTime? eventDate;
  String? eventType;
  DateTime? eventStartTime;
  DateTime? eventEndTime;

  EventSupabase({
    this.id,
    this.eventName,
    this.eventDescription,
    this.eventCity,
    this.eventCountry,
    this.eventImage,
    this.eventDate,
    this.eventType,
    this.eventStartTime,
    this.eventEndTime,
  });

  factory EventSupabase.fromMap(Map<String, dynamic> map) {
    return EventSupabase(
      id: map['id'] as int?,
      eventName: map['event_name'] as String?,
      eventDescription: map['event_description'] as String?,
      eventCity: map['event_city'] as String?,
      eventCountry: map['event_country'] as String?,
      eventImage: map['event_image'] as String?,
      eventDate: map['event_date'] != null
          ? DateTime.tryParse(map['event_date'])
          : null,
      eventType: map['event_type'] as String?,
      eventStartTime: map['event_start_time'] != null
          ? DateTime.tryParse(map['event_start_time'])
          : null,
      eventEndTime: map['event_end_time'] != null
          ? DateTime.tryParse(map['event_end_time'])
          : null,
    );
  }
}
