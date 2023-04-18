import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:snemovna/bloc/meetings/MeetingBloc.dart';
import 'package:snemovna/bloc/meetings/MeetingEvent.dart';
import 'package:snemovna/bloc/meetings/MeetingState.dart';
import 'package:snemovna/model/meetings/MeetingDetail.dart';
import '../mocks/MockMeetingRemoteRepository.dart';

void main() {
  group('MeetingBloc test', () {
    late MeetingBloc meetingBloc;

    setUp(() {
      meetingBloc = MeetingBloc(
        MeetingsFirstLoading(),
        dataProvider: MockMeetingRemoteRepository(),
      );
    });

    blocTest<MeetingBloc, MeetingState>(
      'test GetMeetings first loading',
      build: () => meetingBloc,
      act: (final bloc) => bloc.add(GetMeetings(pageNumber: 0)),
      expect: () => [
        MeetingsFirstLoading(),
        GetMeetingsSuccessState(
          meetings: const [],
          pageNumber: 1,
          hasReachedMax: true,
        )
      ],
    );

    blocTest<MeetingBloc, MeetingState>(
      'test GetMeetingDetail',
      build: () => meetingBloc,
      act: (final bloc) => bloc.add(GetMeetingDetail(meetingId: 0)),
      expect: () => [
        MeetingDetailLoading(),
        GetMeetingDetailSuccessState(
          proposed: MeetingDetail(points: []),
          approved: MeetingDetail(points: []),
        )
      ],
    );

    blocTest<MeetingBloc, MeetingState>(
      'test GetMeetings',
      build: () => meetingBloc,
      act: (final bloc) => bloc.add(GetMeetings(pageNumber: 1)),
      expect: () => [
        GetMeetingsSuccessState(
          meetings: const [],
          pageNumber: 2,
          hasReachedMax: true,
        )
      ],
    );

    tearDown(() {
      meetingBloc.close();
    });
  });
}
