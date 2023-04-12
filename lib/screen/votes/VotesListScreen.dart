import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snemovna/bloc/votes/VoteBloc.dart';
import 'package:snemovna/bloc/votes/VoteEvent.dart';
import 'package:snemovna/bloc/votes/VoteState.dart';
import 'package:snemovna/model/votes/Vote.dart';
import 'package:snemovna/navigation/Navigation.dart';
import 'package:snemovna/service/VotesResultService.dart';
import 'package:snemovna/utils/BaseTools.dart';

class VotesListScreen extends StatefulWidget {
  const VotesListScreen({super.key});

  @override
  State<VotesListScreen> createState() => _VotesListScreenState();
}

class _VotesListScreenState extends State<VotesListScreen> {
  final _controller = ScrollController();
  final VoteBloc _voteBloc = VoteBloc(VotesFirstLoading());
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
  Widget build(final BuildContext context) => BlocBuilder(
        bloc: _voteBloc,
        builder: (final BuildContext context, final VoteState state) =>
            _buildBody(state),
      );

  Widget _buildBody(final VoteState state) => Padding(
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
              : _buildItemCard(state.votes[index]),
    );
  }

  Widget _buildItemCard(final Vote vote) {
    final VoteResult voteResult = getVoteResult(vote.result);
    return GestureDetector(
      onTap: () {
        Navigation.me.voteDetail(context, vote.voteId);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(setHeight(8)),
              child: Text(vote.name, style: TextStyle(fontSize: setSp(14))),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: setWidth(8),
                right: setWidth(24),
                bottom: setHeight(8),
              ),
              child: Text(style: TextStyle(fontSize: setSp(11)), vote.date),
            ),
            Row(
              children: <Widget>[
                Container(
                  color: voteResult.color,
                  width: setWidth(80),
                  child: Padding(
                    padding: EdgeInsets.all(setWidth(8)),
                    child: Center(child: Text(voteResult.text)),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.only(right: setWidth(24)),
                  child: Row(
                    children: <Widget>[
                      _buildTextWithIcon(
                        vote.aye.toString(),
                        Icons.arrow_upward,
                        Colors.green,
                      ),
                      _buildTextWithIcon(
                        vote.no.toString(),
                        Icons.arrow_downward,
                        Colors.red,
                      ),
                      _buildTextWithIcon(
                        vote.abstained.toString(),
                        Icons.output,
                        Colors.grey,
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTextWithIcon(
    final String text,
    final IconData icon,
    final Color iconColor,
  ) =>
      Padding(
        padding: EdgeInsets.symmetric(horizontal: setWidth(3)),
        child: Row(
          children: [
            Text(style: TextStyle(fontSize: setSp(11)), text),
            const SizedBox(width: 2),
            Icon(
              icon,
              color: iconColor,
            )
          ],
        ),
      );
}
