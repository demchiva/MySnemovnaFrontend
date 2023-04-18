import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snemovna/bloc/votes/VoteBloc.dart';
import 'package:snemovna/bloc/votes/VoteEvent.dart';
import 'package:snemovna/bloc/votes/VoteState.dart';
import 'package:snemovna/repository/votes/VotesRemoteRepository.dart';
import 'package:snemovna/screen/votes/VoteCard.dart';
import 'package:snemovna/utils/BaseTools.dart';

class VotesListScreen extends StatefulWidget {
  const VotesListScreen({super.key});

  @override
  State<VotesListScreen> createState() => _VotesListScreenState();
}

class _VotesListScreenState extends State<VotesListScreen> {
  final _controller = ScrollController();
  final VoteBloc _voteBloc =
      VoteBloc(VotesFirstLoading(), dataProvider: VoteRemoteRepository());
  int pageNumber = 0;
  bool hasReachedMax = false;

  @override
  void initState() {
    _controller.addListener(() {
      // Load new data when we are at the end of list and we are not reached max
      if (!hasReachedMax &&
          _controller.offset >= _controller.position.maxScrollExtent &&
          !_controller.position.outOfRange) {
        _voteBloc.add(GetVotes(pageNumber: pageNumber));
      }
    });

    _voteBloc.add(GetVotes(pageNumber: pageNumber));
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    ScreenUtil.init(context);
    return BlocBuilder(
      bloc: _voteBloc,
      builder: (final BuildContext context, final VoteState state) =>
          buildBody(state),
    );
  }

  Widget buildBody(final VoteState state) => Padding(
        padding: EdgeInsets.all(setWidth(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: setHeight(10)),
              child: Center(
                child: Text(
                  'Hlasování',
                  style: TextStyle(
                    fontSize: setSp(20),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: state is VotesFirstLoading
                  ? const Center(child: CircularProgressIndicator())
                  : getVotesList(state as GetVotesSuccessState),
            ),
          ],
        ),
      );

  Widget getVotesList(final GetVotesSuccessState state) {
    pageNumber = state.pageNumber;
    hasReachedMax = state.hasReachedMax;
    return ListView.builder(
      controller: _controller,
      itemCount:
          state.hasReachedMax ? state.votes.length : state.votes.length + 1,
      itemBuilder: (final BuildContext _, final int index) =>
          index >= state.votes.length
              ? Padding(
                  padding: EdgeInsets.symmetric(vertical: setHeight(5)),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : VoteCard(
                  vote: state.votes[index],
                ),
    );
  }
}
