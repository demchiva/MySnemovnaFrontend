import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:snemovna/bloc/meetings/MeetingEvent.dart';
import 'package:snemovna/bloc/meetings/MeetingState.dart';
import 'package:snemovna/model/meetings/Meeting.dart';
import 'package:snemovna/model/meetings/MeetingDetail.dart';
import 'package:snemovna/model/meetings/MeetingList.dart';
import 'package:snemovna/repository/meetings/MeetingsRemoteRepository.dart';

class MeetingBloc extends Bloc<MeetingEvent, MeetingState> {
  static const int PAGE_SIZE = 100;
  static const String AGENDA_TYPE_PROPOSED = 'PROPOSED';
  static const String AGENDA_TYPE_APPROVED = 'APPROVED';

  static final DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm');

  MeetingRemoteRepository dataProvider = MeetingRemoteRepository();
  final List<Meeting> _loadedMeetings = [];

  MeetingBloc(super.initialState) {
    on<GetMeetings>((final event, final emit) async {
      if (event.pageNumber == 0) {
        _loadedMeetings.clear();
        emit(MeetingsFirstLoading());
      }

      final MeetingList meetings =
          await dataProvider.getMeetings(event.pageNumber, PAGE_SIZE);
      _loadedMeetings.addAll(meetings.content);
      meetings.content.forEach(applyDateFormat);
      emit(
        GetMeetingsSuccessState(
          meetings: _loadedMeetings,
          pageNumber: event.pageNumber + 1,
          hasReachedMax: meetings.content.length < PAGE_SIZE,
        ),
      );
    });

    on<GetMeetingDetail>((final event, final emit) async {
      emit(MeetingDetailLoading());

      final MeetingDetail meetingDetailProposed =
          await dataProvider.getMeetingDetail(
        event.meetingId,
        AGENDA_TYPE_PROPOSED,
      );
      final MeetingDetail meetingDetailApproved =
          await dataProvider.getMeetingDetail(
        event.meetingId,
        AGENDA_TYPE_APPROVED,
      );
      emit(
        GetMeetingDetailSuccessState(
          proposed: meetingDetailProposed.points.isNotEmpty
              ? meetingDetailProposed
              : meetingDetailApproved,
          approved: meetingDetailApproved,
        ),
      );
    });
  }

  void applyDateFormat(final Meeting meeting) {
    meeting.dateFrom = dateFormat.format(DateTime.parse(meeting.dateFrom));
  }
}
