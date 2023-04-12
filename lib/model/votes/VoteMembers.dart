class VoteMembers {
  String name;
  String partyName;
  String photoUrl;
  String result;

  VoteMembers({
    required this.name,
    required this.partyName,
    required this.photoUrl,
    required this.result,
  });

  VoteMembers.fromJson(final Map<String, dynamic> parsedJson)
      : partyName = parsedJson['partyName'],
        result = parsedJson['result'],
        name = parsedJson['name'],
        photoUrl = parsedJson['photoUrl'];
}
