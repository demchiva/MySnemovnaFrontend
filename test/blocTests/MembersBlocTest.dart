import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:snemovna/bloc/members/MemberBloc.dart';
import 'package:snemovna/bloc/members/MemberEvent.dart';
import 'package:snemovna/bloc/members/MemberState.dart';
import 'package:snemovna/model/members/MemberDetail.dart';
import '../mocks/MockMemberRemoteRepository.dart';

void main() {
  group('MeetingBloc test', () {
    late MemberBloc memberBloc;

    setUp(() {
      memberBloc = MemberBloc(
        MembersFirstLoading(),
        dataProvider: MockMemberRemoteRepository(),
      );
    });

    blocTest<MemberBloc, MemberState>(
      'test GetMembers first loading',
      build: () => memberBloc,
      act: (final bloc) => bloc.add(GetMembers(pageNumber: 0)),
      expect: () => [
        MembersFirstLoading(),
        GetMembersSuccessState(
          members: const [],
          pageNumber: 1,
          hasReachedMax: true,
        )
      ],
    );

    blocTest<MemberBloc, MemberState>(
      'test GetMembersDetail',
      build: () => memberBloc,
      act: (final bloc) => bloc.add(GetMemberDetail(memberId: 0)),
      expect: () => [
        MembersDetailLoading(),
        GetMemberDetailSuccessState(
          memberDetail: MemberDetail(
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
          ),
        )
      ],
    );

    blocTest<MemberBloc, MemberState>(
      'test GetMembers',
      build: () => memberBloc,
      act: (final bloc) => bloc.add(GetMembers(pageNumber: 1)),
      expect: () => [
        GetMembersSuccessState(
          members: const [],
          pageNumber: 2,
          hasReachedMax: true,
        )
      ],
    );

    blocTest<MemberBloc, MemberState>(
      'test getMemberVotes',
      build: () => memberBloc,
      act: (final bloc) => bloc.add(GetVotes(memberId: 1)),
      expect: () => [GetMemberVotesSuccessState(memberVotes: const [])],
    );

    tearDown(() {
      memberBloc.close();
    });
  });
}
