import 'package:snemovna/model/members/MemberDetail.dart';
import 'package:snemovna/model/members/MemberVotes.dart';
import 'package:snemovna/model/members/MembersList.dart';
import 'package:snemovna/repository/members/MemberRemoteRepository.dart';

class MockMemberRemoteRepository implements MemberRemoteRepository {
  @override
  Future<MemberDetail> getMemberDetail(final int memberId) async =>
      MemberDetail(
        memberId: 0,
        photo: '',
        name: '',
        party: '',
        region: '',
        dateFrom: '',
        dateTo: '',
        officeAddress: null,
        ownPageUrl: '',
        facebook: '',
        pspUrl: '',
        email: '',
        birthDate: '',
      );

  @override
  Future<List<MemberVotes>> getMemberVotes(final int memberId) async => [];

  @override
  Future<MembersList> getMembers(
    final int pageNumber,
    final int pageSize,
    final String? search,
  ) async =>
      const MembersList(totalPages: 0, content: []);
}
