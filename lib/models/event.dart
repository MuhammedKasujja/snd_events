class Event {
  final String startDateTime;
  final String endDateTime;
  final String theme;
  final String district;
  final String street;

  Event(
      {this.startDateTime,
      this.endDateTime,
      this.theme,
      this.district,
      this.street});

  factory Event.fromJson(Map<String, dynamic> json){
    return Event();
  }
}
