import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:snemovna/bloc/votes/VoteBloc.dart';
import 'package:snemovna/bloc/votes/VoteEvent.dart';
import 'package:snemovna/bloc/votes/VoteState.dart';
import 'package:snemovna/model/votes/VoteDetail.dart';
import '../mocks/MockVoteRemoteRepository.dart';

void main() {
  group('VoteBloc test', () {
    late VoteBloc voteBloc;

    setUp(() {
      voteBloc = VoteBloc(
        VotesFirstLoading(),
        dataProvider: MockVoteRemoteRepository(),
      );
    });

    blocTest<VoteBloc, VoteState>(
      'test GetVotes first loading',
      build: () => voteBloc,
      act: (final bloc) => bloc.add(GetVotes(pageNumber: 0)),
      expect: () => [
        VotesFirstLoading(),
        GetVotesSuccessState(
          votes: const [],
          pageNumber: 1,
          hasReachedMax: true,
        ),
      ],
    );

    blocTest<VoteBloc, VoteState>(
      'test GetVotes',
      build: () => voteBloc,
      act: (final bloc) => bloc.add(GetVotes(pageNumber: 1)),
      expect: () => [
        GetVotesSuccessState(
          votes: const [],
          pageNumber: 2,
          hasReachedMax: true,
        ),
      ],
    );

    blocTest<VoteBloc, VoteState>(
      'test GetVoteMembers',
      build: () => voteBloc,
      act: (final bloc) => bloc.add(GetMembers(voteId: 1)),
      expect: () => [
        GetVoteMembersSuccessState(voteMembers: const []),
      ],
    );

    blocTest<VoteBloc, VoteState>(
      'test GetVoteDetail',
      build: () => voteBloc,
      act: (final bloc) => bloc.add(GetVoteDetail(voteId: 0)),
      expect: () => [
        VoteDetailLoading(),
        GetVoteDetailSuccessState(
          voteDetail: VoteDetail(
            voteId: 1,
            result: '',
            aye: 0,
            no: 0,
            abstained: 0,
            date: '',
            voteNumber: 0,
            pointNumber: 0,
            quorum: 0,
            psUrl: '',
            longName: '',
            pointName: '',
            pointState: null,
            pointType: null,
            meetingNumber: 0,
          ),
        )
      ],
    );

    tearDown(() {
      voteBloc.close();
    });
  });
}
