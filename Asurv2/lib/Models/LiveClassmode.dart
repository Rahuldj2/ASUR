class LiveClass {
  final String coursecode;
  final String roomId;
  final double cenlatitude;
  final double cenlongitude;
  final double altitude;
  final double majorAxis;
  final double minorAxis;

  LiveClass(
    this.coursecode,
    this.cenlatitude,
    this.cenlongitude,
    this.altitude,
    this.majorAxis,
    this.minorAxis,
    this.roomId,
  );

  // Serialize the object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'coursecode': coursecode,
      'roomId': roomId,
      'cenlatitude': cenlatitude,
      'cenlongitude': cenlongitude,
      'altitude': altitude,
      'majorAxis': majorAxis,
      'minorAxis': minorAxis,
    };
  }

  // Deserialize the JSON map to an object
  factory LiveClass.fromJson(Map<String, dynamic> json) {
    return LiveClass(
      json['coursecode'],
      json['cenlatitude'],
      json['cenlongitude'],
      json['altitude'],
      json['majorAxis'],
      json['minorAxis'],
      json['roomId'],
    );
  }
}
