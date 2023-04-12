class MeetingDetail {
  List<MeetingPoint> points;

  MeetingDetail({required this.points});

  MeetingDetail.fromJson(final Map<String, dynamic> parsedJson) : points = [] {
    for (final point in parsedJson['meetingPoints']) {
      points.add(MeetingPoint.fromJson(point));
    }
  }
}

class MeetingPoint {
  String name;
  String? state;
  String? type;

  MeetingPoint({required this.name, required this.state, required this.type});

  MeetingPoint.fromJson(final Map<String, dynamic> parsedJson)
      : name = parsedJson['name'],
        state = parsedJson['state'],
        type = parsedJson['type'];
}
