class Meeting {
  int meetingId;
  int meetingNumber;
  String? state;
  String date;
  String type;
  String organName;
  String dateFrom;
  String? dateTo;

  Meeting({
    required this.meetingId,
    required this.meetingNumber,
    required this.state,
    required this.date,
    required this.type,
    required this.organName,
    required this.dateFrom,
    required this.dateTo,
  });

  static List<Meeting> listFromJson(final List<dynamic> list) {
    final List<Meeting> meetings = [];

    for (final value in list) {
      meetings.add(Meeting.fromJson(value));
    }

    return meetings;
  }

  Meeting.fromJson(final Map<String, dynamic> parsedJson)
      : meetingId = parsedJson['meetingId'],
        meetingNumber = parsedJson['meetingNumber'],
        state = parsedJson['state'],
        date = parsedJson['date'],
        type = parsedJson['type'],
        organName = parsedJson['organName'],
        dateFrom = parsedJson['dateFrom'],
        dateTo = parsedJson['dateTo'];
}
