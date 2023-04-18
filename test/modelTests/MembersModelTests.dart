import 'package:flutter_test/flutter_test.dart';
import 'package:snemovna/model/members/MemberDetail.dart';
import 'package:snemovna/model/members/MemberVotes.dart';
import 'package:snemovna/model/members/MembersList.dart';
import 'package:snemovna/model/members/OfficeAddress.dart';

void main() {
  test('MembersList parsing test', () {
    const json = {
      'totalPages': 10,
      'content': [
        {
          'memberId': 726,
          'photo': 'photo',
          'name': 'name',
          'party': 'party',
          'region': 'region',
          'dateFrom': '2023-04-19 15:00',
          'dateTo': '2023-04-19 15:00'
        }
      ]
    };
    final membersList = MembersList.fromJson(json);
    expect(membersList.totalPages, 10);
    expect(membersList.content.length, 1);
    expect(membersList.content.first.memberId, 726);
    expect(membersList.content.first.photo, 'photo');
    expect(membersList.content.first.name, 'name');
    expect(membersList.content.first.party, 'party');
    expect(membersList.content.first.region, 'region');
    expect(membersList.content.first.dateFrom, '2023-04-19 15:00');
    expect(membersList.content.first.dateTo, '2023-04-19 15:00');
  });

  test('Test MemberVotes.fromJson with valid JSON input', () {
    final Map<String, dynamic> json = {
      'name': 'John',
      'date': '2023-04-15',
      'result': 'Passed',
      'voteId': 12345,
    };

    final MemberVotes memberVotes = MemberVotes.fromJson(json);

    expect(memberVotes.name, 'John');
    expect(memberVotes.date, '2023-04-15');
    expect(memberVotes.result, 'Passed');
    expect(memberVotes.voteId, 12345);
  });

  test('Test MemberDetail.fromJson with valid JSON input', () {
    final Map<String, dynamic> json = {
      'memberId': 12345,
      'photo': 'https://example.com/photo.jpg',
      'name': 'John Doe',
      'party': 'ABC Party',
      'region': 'Region ABC',
      'dateFrom': '2022-01-01',
      'dateTo': '2022-12-31',
      'officeAddress': {
        'street': '123 Main St',
        'city': 'City ABC',
        'state': 'State ABC',
        'country': 'Country ABC',
      },
      'ownPageUrl': 'https://example.com/ownPage',
      'facebook': 'https://www.facebook.com/johndoe',
      'pspUrl': 'https://example.com/psp',
      'email': 'johndoe@example.com',
      'birthDate': '1990-01-01',
    };

    final MemberDetail memberDetail = MemberDetail.fromJson(json);

    expect(memberDetail.memberId, 12345);
    expect(memberDetail.photo, 'https://example.com/photo.jpg');
    expect(memberDetail.name, 'John Doe');
    expect(memberDetail.party, 'ABC Party');
    expect(memberDetail.region, 'Region ABC');
    expect(memberDetail.dateFrom, '2022-01-01');
    expect(memberDetail.dateTo, '2022-12-31');
    expect(memberDetail.officeAddress, isNotNull);
    expect(memberDetail.ownPageUrl, 'https://example.com/ownPage');
    expect(memberDetail.facebook, 'https://www.facebook.com/johndoe');
    expect(memberDetail.pspUrl, 'https://example.com/psp');
    expect(memberDetail.email, 'johndoe@example.com');
    expect(memberDetail.birthDate, '1990-01-01');
  });

  test('should parse valid JSON correctly', () {
    final Map<String, dynamic> json = {
      'street': '1234 Elm St',
      'municipality': 'City A',
      'zip': '12345',
      'phone': '123-456-7890'
    };

    final officeAddress = OfficeAddress.fromJson(json);

    expect(officeAddress.street, '1234 Elm St');
    expect(officeAddress.municipality, 'City A');
    expect(officeAddress.zip, '12345');
    expect(officeAddress.phone, '123-456-7890');
  });

  test('should handle null values in JSON correctly', () {
    final Map<String, dynamic> json = {
      'street': null,
      'municipality': null,
      'zip': null,
      'phone': null
    };

    final officeAddress = OfficeAddress.fromJson(json);
    expect(officeAddress.street, null);
    expect(officeAddress.municipality, null);
    expect(officeAddress.zip, null);
    expect(officeAddress.phone, null);
  });
}
