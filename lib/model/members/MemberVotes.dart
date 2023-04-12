class MemberVotes {
  String name;
  String date;
  String result;

  MemberVotes({
    required this.name,
    required this.date,
    required this.result,
  });

  MemberVotes.fromJson(final Map<String, dynamic> parsedJson)
      : name = parsedJson['name'],
        date = parsedJson['date'],
        result = parsedJson['result'];
}
