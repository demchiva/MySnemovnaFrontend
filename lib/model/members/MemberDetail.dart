import 'package:snemovna/model/members/OfficeAddress.dart';

class MemberDetail {
  int memberId;
  String photo;
  String name;
  String? party;
  String? region;
  String dateFrom;
  String? dateTo;
  OfficeAddress? officeAddress;
  String? ownPageUrl;
  String? facebook;
  String pspUrl;
  String? email;
  String? birthDate;

  MemberDetail({
    required this.memberId,
    required this.photo,
    required this.name,
    required this.party,
    required this.region,
    required this.dateFrom,
    required this.dateTo,
    required this.officeAddress,
    required this.ownPageUrl,
    required this.facebook,
    required this.pspUrl,
    required this.email,
    required this.birthDate,
  });

  MemberDetail.fromJson(final Map<String, dynamic> parsedJson)
      : memberId = parsedJson['memberId'],
        photo = parsedJson['photo'],
        name = parsedJson['name'],
        party = parsedJson['party'],
        region = parsedJson['region'],
        dateFrom = parsedJson['dateFrom'],
        dateTo = parsedJson['dateTo'],
        officeAddress = parsedJson['officeAddress'] != null
            ? OfficeAddress.fromJson(parsedJson['officeAddress'])
            : null,
        ownPageUrl = parsedJson['ownPageUrl'],
        facebook = parsedJson['facebook'],
        pspUrl = parsedJson['pspUrl'],
        email = parsedJson['email'],
        birthDate = parsedJson['birthDate'];
}
