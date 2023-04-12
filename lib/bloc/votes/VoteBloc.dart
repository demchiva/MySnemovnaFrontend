import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:snemovna/bloc/votes/VoteEvent.dart';
import 'package:snemovna/bloc/votes/VoteState.dart';
import 'package:snemovna/model/votes/Vote.dart';
import 'package:snemovna/model/votes/VoteDetail.dart';
import 'package:snemovna/model/votes/VoteList.dart';
import 'package:snemovna/model/votes/VoteMembers.dart';
import 'package:snemovna/repository/votes/VotesRemoteRepository.dart';

class VoteBloc extends Bloc<VoteEvent, VoteState> {
  static const int PAGE_SIZE = 100;
  static final DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm');

  VoteRemoteRepository dataProvider = VoteRemoteRepository();
  final List<Vote> _loadedVotes = [];

  VoteBloc(super.initialState) {
    on<GetVotes>((final event, final emit) async {
      if (event.pageNumber == 0) {
        _loadedVotes.clear();
        emit(VotesFirstLoading());
      }

      final VoteList votes = await dataProvider.getVotes(
        event.pageNumber,
        PAGE_SIZE,
      );
      votes.content.forEach(applyDateFormat);
      _loadedVotes.addAll(votes.content);

      emit(
        GetVotesSuccessState(
          votes: _loadedVotes,
          pageNumber: event.pageNumber + 1,
          hasReachedMax: votes.content.length < PAGE_SIZE,
        ),
      );
    });

    on<GetVoteDetail>((final event, final emit) async {
      emit(VoteDetailLoading());

      final VoteDetail voteDetail =
          await dataProvider.getVoteDetail(event.voteId);
      voteDetail.date = dateFormat.format(DateTime.parse(voteDetail.date));
      emit(GetVoteDetailSuccessState(voteDetail: voteDetail));
    });

    on<GetMembers>((final event, final emit) async {
      final List<VoteMembers> votesMembers =
          await dataProvider.getVoteMembers(event.voteId);
      emit(GetVoteMembersSuccessState(voteMembers: votesMembers));
    });
  }

  void applyDateFormat(final Vote vote) {
    vote.date = dateFormat.format(DateTime.parse(vote.date));
  }
}
