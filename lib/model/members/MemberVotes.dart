class MemberVotes {
  String name;
  String date;
  String result;
  int voteId;

  MemberVotes({
    required this.name,
    required this.date,
    required this.result,
    required this.voteId,
  });

  MemberVotes.fromJson(final Map<String, dynamic> parsedJson)
      : name = parsedJson['name'],
        date = parsedJson['date'],
        result = parsedJson['result'],
        voteId = parsedJson['voteId'];
}
