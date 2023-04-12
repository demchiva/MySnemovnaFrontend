class Vote {
  int voteId;
  String result;
  String name;
  int aye;
  int no;
  int abstained;
  String date;

  Vote({
    required this.voteId,
    required this.result,
    required this.name,
    required this.aye,
    required this.no,
    required this.abstained,
    required this.date,
  });

  static List<Vote> listFromJson(final List<dynamic> list) {
    final List<Vote> votes = [];
    for (final value in list) {
      votes.add(Vote.fromJson(value));
    }
    return votes;
  }

  Vote.fromJson(final Map<String, dynamic> parsedJson)
      : voteId = parsedJson['voteId'],
        result = parsedJson['result'],
        name = parsedJson['name'],
        aye = parsedJson['aye'],
        no = parsedJson['no'],
        abstained = parsedJson['abstained'],
        date = parsedJson['date'];
}
