import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snemovna/bloc/meetings/MeetingBloc.dart';
import 'package:snemovna/bloc/meetings/MeetingEvent.dart';
import 'package:snemovna/bloc/meetings/MeetingState.dart';
import 'package:snemovna/repository/meetings/MeetingsRemoteRepository.dart';
import 'package:snemovna/screen/meetings/MeetingCard.dart';
import 'package:snemovna/utils/BaseTools.dart';

class MeetingsListScreen extends StatefulWidget {
  const MeetingsListScreen({super.key});

  @override
  State<MeetingsListScreen> createState() => _MeetingsListScreenState();
}

class _MeetingsListScreenState extends State<MeetingsListScreen> {
  final _controller = ScrollController();
  final MeetingBloc _meetingBloc = MeetingBloc(
    MeetingsFirstLoading(),
    dataProvider: MeetingRemoteRepository(),
  );
  int pageNumber = 0;
  bool hasReachedMax = false;

  @override
  void initState() {
    _controller.addListener(() {
      // Load new data when we are at the end of list and we are not reached max
      if (!hasReachedMax &&
          _controller.offset >= _controller.position.maxScrollExtent &&
          !_controller.position.outOfRange) {
        _meetingBloc.add(GetMeetings(pageNumber: pageNumber));
      }
    });

    _meetingBloc.add(GetMeetings(pageNumber: pageNumber));
    super.initState();
  }

  @override
  Widget build(final BuildContext context) => BlocBuilder(
        bloc: _meetingBloc,
        builder: (final BuildContext context, final MeetingState state) =>
            _buildBody(state),
      );

  Widget _buildBody(final MeetingState state) => Padding(
        padding: EdgeInsets.all(setWidth(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: setHeight(10)),
              child: Center(
                child: Text(
                  'Schůze',
                  style: TextStyle(
                    fontSize: setSp(20),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: state is MeetingsFirstLoading
                  ? const Center(child: CircularProgressIndicator())
                  : getMeetingList(state as GetMeetingsSuccessState),
            ),
          ],
        ),
      );

  Widget getMeetingList(final GetMeetingsSuccessState state) {
    pageNumber = state.pageNumber;
    hasReachedMax = state.hasReachedMax;
    return ListView.builder(
      controller: _controller,
      itemCount: state.hasReachedMax
          ? state.meetings.length
          : state.meetings.length + 1,
      itemBuilder: (final BuildContext _, final int index) =>
          index >= state.meetings.length
              ? Padding(
                  padding: EdgeInsets.symmetric(vertical: setHeight(5)),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : MeetingItemCard(state.meetings[index]),
    );
  }
}
