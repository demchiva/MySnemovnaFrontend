class Member {
  int memberId;
  String photo;
  String name;
  String? party;
  String region;
  String dateFrom;
  String? dateTo;

  Member({
    required this.memberId,
    required this.photo,
    required this.name,
    required this.party,
    required this.region,
    required this.dateFrom,
    required this.dateTo,
  });

  static List<Member> listFromJson(final List<dynamic> list) {
    final List<Member> meetings = [];

    for (final value in list) {
      meetings.add(Member.fromJson(value));
    }

    return meetings;
  }

  Member.fromJson(final Map<String, dynamic> parsedJson)
      : memberId = parsedJson['memberId'],
        photo = parsedJson['photo'],
        name = parsedJson['name'],
        party = parsedJson['party'],
        region = parsedJson['region'],
        dateFrom = parsedJson['dateFrom'],
        dateTo = parsedJson['dateTo'];
}
