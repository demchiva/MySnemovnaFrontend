import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:snemovna/bloc/votes/VoteBloc.dart';
import 'package:snemovna/bloc/votes/VoteEvent.dart';
import 'package:snemovna/bloc/votes/VoteState.dart';
import 'package:snemovna/model/votes/VoteDetail.dart';
import 'package:snemovna/model/votes/VoteMembers.dart';
import 'package:snemovna/repository/votes/VotesRemoteRepository.dart';
import 'package:snemovna/screen/votes/VoteMemberCard.dart';
import 'package:snemovna/utils/BaseTools.dart';
import 'package:snemovna/utils/UrlUtils.dart';

class VoteDetailScreen extends StatefulWidget {
  static const String ROUTE_NAME = 'voteDetail';

  const VoteDetailScreen({super.key});

  @override
  State<VoteDetailScreen> createState() => _VoteDetailScreenState();
}

class _VoteDetailScreenState extends State<VoteDetailScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final VoteBloc _voteBloc =
      VoteBloc(VoteDetailLoading(), dataProvider: VoteRemoteRepository());

  late VoteDetail _voteDetail;
  List<VoteMembers>? _voteMembers;
  String pspLinkText = '';

  bool _expandVoteMembers = false;

  late int _voteId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _voteId = (ModalRoute.of(context)!.settings.arguments as int?)!;
    _voteBloc.add(GetVoteDetail(voteId: _voteId));
  }

  @override
  Widget build(final BuildContext context) => BlocBuilder(
        bloc: _voteBloc,
        builder: (final BuildContext context, final VoteState state) {
          if (state is GetVoteDetailSuccessState) {
            _voteDetail = state.voteDetail;
            pspLinkText = '${_voteDetail.meetingNumber} sch. '
                '${_voteDetail.voteNumber} hl. '
                '${_voteDetail.date}';
          }

          if (state is GetVoteMembersSuccessState) {
            _voteMembers = state.voteMembers;
          }

          return Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              iconTheme: const IconThemeData(color: Colors.black),
              actions: [
                Padding(
                  padding:
                      EdgeInsets.only(top: setWidth(24), right: setWidth(8)),
                  child: InkWell(
                    child: Text(
                      pspLinkText,
                      style: const TextStyle(color: Colors.blue),
                    ),
                    onTap: () => launchInBrowser(Uri.parse(_voteDetail.psUrl)),
                  ),
                )
              ],
            ),
            body: state is VoteDetailLoading
                ? const Center(child: CircularProgressIndicator())
                : _buildBody(),
          );
        },
      );

  Widget _buildBody() => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(setWidth(8)),
              child: Text(
                style: TextStyle(fontSize: setSp(22)),
                _voteDetail.longName,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: setWidth(8),
                right: setWidth(8),
                top: setHeight(16),
              ),
              child: Text(
                style: TextStyle(fontSize: setSp(14)),
                'Bod hlasování',
              ),
            ),
            _buildPointInfo(),
            _buildDiagram(),
            _buildVoteMembersToggle(),
            _expandVoteMembers
                ? _voteMembers != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _voteMembers!
                            .map(
                              (final member) => VoteMemberCard(member: member),
                            )
                            .toList(),
                      )
                    : Padding(
                        padding: EdgeInsets.only(top: setHeight(10)),
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                : SizedBox(height: setHeight(50))
          ],
        ),
      );

  Widget _buildPointInfo() => Padding(
        padding: EdgeInsets.only(
          left: setWidth(8),
          right: setWidth(8),
          top: setHeight(16),
        ),
        child: Column(
          children: [
            _buildTextWithDescription(
              'Název',
              _voteDetail.pointName,
            ),
            SizedBox(height: setWidth(16)),
            if (_voteDetail.pointType != null)
              _buildTextWithDescription(
                'Typ',
                _voteDetail.pointType!,
              ),
            SizedBox(height: setWidth(16)),
            _buildTextWithDescription(
              'Číslo bodu',
              _voteDetail.pointNumber.toString(),
            ),
            SizedBox(height: setWidth(16)),
            if (_voteDetail.pointState != null)
              _buildTextWithDescription(
                'Stav bodu',
                _voteDetail.pointState!,
              ),
            SizedBox(height: setWidth(16)),
            _buildTextWithDescription(
              'Kvorum pro přijetí',
              '${_voteDetail.quorum}',
            ),
          ],
        ),
      );

  Widget _buildDiagram() => Padding(
        padding: EdgeInsets.only(top: setWidth(24)),
        child: PieChart(
          dataMap: {
            'Ano': _voteDetail.aye.toDouble(),
            'Ne': _voteDetail.no.toDouble(),
            'Zdržel/a se/Nehlasoval/a': _voteDetail.abstained.toDouble(),
          },
          animationDuration: const Duration(milliseconds: 800),
          chartLegendSpacing: 32,
          chartRadius: MediaQuery.of(context).size.width / 1.5,
          colorList: const [Colors.green, Colors.red, Colors.grey],
          initialAngleInDegree: 0,
          ringStrokeWidth: 32,
          legendOptions: const LegendOptions(
            showLegendsInRow: true,
            legendPosition: LegendPosition.bottom,
            legendTextStyle: TextStyle(fontWeight: FontWeight.bold),
          ),
          chartValuesOptions: ChartValuesOptions(
            showChartValuesOutside: true,
            showChartValueBackground: false,
            decimalPlaces: 0,
            chartValueStyle: TextStyle(
              color: Colors.black,
              fontSize: setSp(14),
            ),
          ),
        ),
      );

  Widget _buildVoteMembersToggle() => GestureDetector(
        onTap: () {
          setState(() {
            if (_voteMembers == null) {
              _voteBloc.add(GetMembers(voteId: _voteId));
            }

            _expandVoteMembers = !_expandVoteMembers;
          });
        },
        child: Padding(
          padding: EdgeInsets.only(
            left: setWidth(8),
            right: setWidth(8),
            top: setHeight(16),
          ),
          child: Row(
            children: [
              Text(
                style: TextStyle(fontSize: setSp(14)),
                'Výsledky poslanců',
              ),
              Icon(
                _expandVoteMembers ? Icons.arrow_upward : Icons.arrow_downward,
              ),
            ],
          ),
        ),
      );

  // Widget _buildItemCard(final VoteMembers member) {
  //   final VoteResult result = getMemberVoteResult(member.result);
  //   return Padding(
  //     padding: EdgeInsets.all(setWidth(8)),
  //     child: Card(
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(5),
  //       ),
  //       elevation: 5,
  //       child: ListTile(
  //         onTap: () {
  //           Navigation.me.memberDetail(context, member.memberId);
  //         },
  //         leading: CachedNetworkImage(
  //           imageUrl: member.photoUrl,
  //           height: setHeight(100),
  //           width: setWidth(50),
  //           errorWidget: (final context, final url, final error) =>
  //               const Center(
  //             child: Icon(Icons.account_circle),
  //           ),
  //         ),
  //         title: Text(
  //           style: TextStyle(
  //             fontWeight: FontWeight.w600,
  //             fontSize: setSp(14),
  //           ),
  //           member.name,
  //         ),
  //         subtitle: Padding(
  //           padding: EdgeInsets.symmetric(vertical: setHeight(5)),
  //           child:
  //               Text(style: TextStyle(fontSize: setSp(12)), member.partyName),
  //         ),
  //         trailing: Container(
  //           width: setWidth(100),
  //           color: result.color,
  //           child: Padding(
  //             padding: EdgeInsets.all(setWidth(8)),
  //             child: Center(child: Text(result.text)),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
  //
  Widget _buildTextWithDescription(
    final String text,
    final String description,
  ) =>
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: setWidth(100),
            child: Text(style: TextStyle(fontSize: setSp(14)), text),
          ),
          SizedBox(
            width: setWidth(230),
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Text(style: TextStyle(fontSize: setSp(12)), description),
            ),
          ),
        ],
      );
}
