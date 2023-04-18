import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:snemovna/bloc/members/MemberEvent.dart';
import 'package:snemovna/bloc/members/MemberState.dart';
import 'package:snemovna/model/members/Member.dart';
import 'package:snemovna/model/members/MemberDetail.dart';
import 'package:snemovna/model/members/MemberVotes.dart';
import 'package:snemovna/model/members/MembersList.dart';
import 'package:snemovna/repository/members/MemberRemoteRepository.dart';

class MemberBloc extends Bloc<MemberEvent, MemberState> {
  static const int PAGE_SIZE = 100;
  static final DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm');

  MemberRemoteRepository dataProvider;
  final List<Member> _loadedMembers = [];

  MemberBloc(super.initialState, {required this.dataProvider}) {
    on<GetMembers>((final event, final emit) async {
      if (event.pageNumber == 0) {
        _loadedMembers.clear();
        emit(MembersFirstLoading());
      }

      final MembersList members = await dataProvider.getMembers(
        event.pageNumber,
        PAGE_SIZE,
        event.search,
      );
      _loadedMembers.addAll(members.content);
      emit(
        GetMembersSuccessState(
          members: _loadedMembers,
          pageNumber: event.pageNumber + 1,
          hasReachedMax: members.content.length < PAGE_SIZE,
        ),
      );
    });

    on<GetMemberDetail>((final event, final emit) async {
      emit(MembersDetailLoading());

      final MemberDetail memberDetail =
          await dataProvider.getMemberDetail(event.memberId);
      emit(GetMemberDetailSuccessState(memberDetail: memberDetail));
    });

    on<GetVotes>((final event, final emit) async {
      final List<MemberVotes> memberVotes =
          await dataProvider.getMemberVotes(event.memberId);
      memberVotes.forEach(applyDateFormat);
      emit(GetMemberVotesSuccessState(memberVotes: memberVotes));
    });
  }

  void applyDateFormat(final MemberVotes memberVotes) {
    memberVotes.date = dateFormat.format(DateTime.parse(memberVotes.date));
  }
}
