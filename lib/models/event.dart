class Event {
  int id;
  String startDate;
  String endDate;
  String theme;
  String street;
  String startTime;
  String endTime;
  String photo;
  String speaker;
  String locDistrict;
  String organizer;
  String country;
  bool isSaved;
  String createdBy;

  Event(
      {this.id,
      this.startTime,
      this.endTime,
      this.startDate,
      this.endDate,
      this.theme,
      this.street,
      this.photo,
      this.speaker,
      this.locDistrict,
      this.organizer,
      this.country,
      this.isSaved = false,
      this.createdBy});

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
        id: json['id'],
        theme: json['theme'],
        photo: json['photo'],
        speaker: json['speaker'],
        locDistrict: json['location_district'],
        organizer: json['organizer'],
        street: json['building_street'],
        startDate: json['start_date'],
        endDate: json['end_date'],
        startTime: json['start_time'],
        endTime: json['end_time'],
        country: json['location_country'],
        isSaved: json['is_saved'] == null ? false : json['is_saved'],
        createdBy: json['created_by']);
  }

  Map toMap() {
    var map = {
      'theme': this.theme,
      'speaker': this.speaker,
      'location_district': this.locDistrict,
      'organizer': this.organizer,
      'building_street': this.street,
      'start_date': this.startDate,
      'end_date': this.endDate,
      'start_time': this.startTime,
      'end_time': this.endTime,
      'location_country': this.country,
      'photo': this.photo,
    };
    return map;
  }
}
