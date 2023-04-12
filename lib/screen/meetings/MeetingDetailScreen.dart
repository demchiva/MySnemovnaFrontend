import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snemovna/bloc/meetings/MeetingBloc.dart';
import 'package:snemovna/bloc/meetings/MeetingEvent.dart';
import 'package:snemovna/bloc/meetings/MeetingState.dart';
import 'package:snemovna/model/meetings/Meeting.dart';
import 'package:snemovna/model/meetings/MeetingDetail.dart';
import 'package:snemovna/service/MeetingService.dart';
import 'package:snemovna/utils/BaseTools.dart';

class MeetingDetailScreen extends StatefulWidget {
  static const String ROUTE_NAME = 'meetingDetail';

  const MeetingDetailScreen({super.key});

  @override
  State<MeetingDetailScreen> createState() => _MeetingDetailScreenState();
}

class _MeetingDetailScreenState extends State<MeetingDetailScreen>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final MeetingBloc _meetingBloc = MeetingBloc(MeetingDetailLoading());

  late TabController _tabController;

  late Meeting meeting;
  late MeetingDetail _proposedMeetingDetail;
  late MeetingDetail _approvedMeetingDetail;
  late MeetingStateDisplay stateDisplay;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _tabController = TabController(length: 2, vsync: this);
    meeting = (ModalRoute.of(context)!.settings.arguments as Meeting?)!;
    stateDisplay = getMeetingState(meeting);
    _meetingBloc.add(GetMeetingDetail(meetingId: meeting.meetingId));
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.black),
          actions: [
            Padding(
              padding: EdgeInsets.only(top: setWidth(24), right: setWidth(8)),
              child: InkWell(
                child: Text(
                  stateDisplay.text,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            )
          ],
        ),
        body: BlocBuilder(
          bloc: _meetingBloc,
          builder: (final BuildContext context, final MeetingState state) {
            if (state is GetMeetingDetailSuccessState) {
              _proposedMeetingDetail = state.proposed;
              _approvedMeetingDetail = state.approved;
            }

            return state is MeetingDetailLoading
                ? const Center(child: CircularProgressIndicator())
                : _buildBody();
          },
        ),
      );

  Widget _buildBody() => Center(
        child: Column(
          children: [
            SizedBox(height: setWidth(20)),
            Text(
              style: TextStyle(fontSize: setSp(20)),
              '${meeting.meetingNumber} schůze (${meeting.organName})',
            ),
            SizedBox(height: setWidth(10)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: setWidth(15)),
              child: Text(meeting.date),
            ),
            SizedBox(height: setWidth(10)),
            Text(meeting.type),
            TabBar(
              physics: const NeverScrollableScrollPhysics(),
              tabs: const [
                Tab(
                  child: Text(
                    'Návrh pořadu',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Tab(
                  child: Text(
                    'Schválený pořad',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
              controller: _tabController,
              onTap: (final int index) => setState(() {}),
            ),
            Expanded(child: _buildList()),
          ],
        ),
      );

  Widget _buildList() {
    final MeetingDetail detail = _tabController.index == 0
        ? _proposedMeetingDetail
        : _approvedMeetingDetail;
    return detail.points.isEmpty
        ? const Center(child: Text('Nejsou nalezené žádné body'))
        : ListView.builder(
            itemCount: detail.points.length,
            itemBuilder: (final BuildContext context, final int index) =>
                _buildMeetingPoint(detail.points[index]),
          );
  }

  Widget _buildMeetingPoint(final MeetingPoint point) => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        elevation: 5,
        child: ListTile(
          // isThreeLine: true,
          title: Text(point.name),
          subtitle: point.type != null ||
                  (point.state != null && _tabController.index == 1)
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (point.type != null)
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: setHeight(5)),
                        child: Text(
                          '${point.type}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    if (point.state != null && _tabController.index == 1)
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: setHeight(5)),
                        child: SizedBox(
                          width: setWidth(100),
                          child: Text(
                            point.state!,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                  ],
                )
              : null,
        ),
      );
}
