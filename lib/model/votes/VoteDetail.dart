class VoteDetail {
  int voteId;
  String result;
  int aye;
  int no;
  int abstained;
  String date;
  int voteNumber;
  int pointNumber;
  int quorum;
  String psUrl;
  String longName;
  String pointName;
  String? pointState;
  String? pointType;
  int meetingNumber;

  VoteDetail({
    required this.voteId,
    required this.result,
    required this.aye,
    required this.no,
    required this.abstained,
    required this.date,
    required this.voteNumber,
    required this.pointNumber,
    required this.quorum,
    required this.psUrl,
    required this.longName,
    required this.pointName,
    required this.pointState,
    required this.pointType,
    required this.meetingNumber,
  });

  VoteDetail.fromJson(final Map<String, dynamic> parsedJson)
      : voteId = parsedJson['voteId'],
        result = parsedJson['result'],
        aye = parsedJson['aye'],
        no = parsedJson['no'],
        abstained = parsedJson['abstained'],
        date = parsedJson['date'],
        voteNumber = parsedJson['voteNumber'],
        pointNumber = parsedJson['pointNumber'],
        quorum = parsedJson['quorum'],
        psUrl = parsedJson['psUrl'],
        longName = parsedJson['longName'],
        pointName = parsedJson['pointName'],
        pointState = parsedJson['pointState'],
        pointType = parsedJson['pointType'],
        meetingNumber = parsedJson['meetingNumber'];
}
