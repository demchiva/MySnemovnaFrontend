import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snemovna/bloc/members/MemberBloc.dart';
import 'package:snemovna/bloc/members/MemberEvent.dart';
import 'package:snemovna/bloc/members/MemberState.dart';
import 'package:snemovna/model/members/MemberDetail.dart';
import 'package:snemovna/model/members/MemberVotes.dart';
import 'package:snemovna/service/VotesResultService.dart';
import 'package:snemovna/utils/BaseTools.dart';
import 'package:snemovna/utils/UrlUtils.dart';

class MemberDetailScreen extends StatefulWidget {
  static const String ROUTE_NAME = 'memberDetail';

  const MemberDetailScreen({super.key});

  @override
  State<MemberDetailScreen> createState() => _MemberDetailScreenState();
}

class _MemberDetailScreenState extends State<MemberDetailScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final MemberBloc _memberBloc = MemberBloc(MembersDetailLoading());

  late int _memberId;
  late MemberDetail _memberDetail;
  List<MemberVotes>? _memberVotes;

  bool _expandPersonalInfo = true;
  bool _expandMemberVotes = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _memberId = (ModalRoute.of(context)!.settings.arguments as int?)!;
    _memberBloc.add(GetMemberDetail(memberId: _memberId));
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: BlocBuilder(
          bloc: _memberBloc,
          builder: (final BuildContext context, final MemberState state) {
            if (state is GetMemberDetailSuccessState) {
              _memberDetail = state.memberDetail;
            }

            if (state is GetMemberVotesSuccessState) {
              _memberVotes = state.memberVotes;
            }

            return state is MembersDetailLoading
                ? const Center(child: CircularProgressIndicator())
                : _buildBody();
          },
        ),
      );

  Widget _buildBody() => Column(
        children: [
          SizedBox(
            width: setWidth(200),
            height: setWidth(200),
            child: CachedNetworkImage(
              imageUrl: _memberDetail.photo,
              errorWidget: (final context, final url, final error) =>
                  const Center(
                child: Icon(
                  Icons.account_circle,
                  size: 100,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: setWidth(10)),
            child: Text(
              _memberDetail.name,
              style: TextStyle(fontSize: setSp(18)),
            ),
          ),
          if (_memberDetail.email != null)
            Padding(
              padding: EdgeInsets.only(top: setWidth(10)),
              child: Text(_memberDetail.email!),
            ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: setWidth(10)),
            child: Column(
              children: [
                _personalInfoToggle(),
                ..._getMemberInfoList(),
                if (_expandPersonalInfo) _buildExternalSystemsLinks(),
                _buildMemberVotesToggle(),
              ],
            ),
          ),
          if (_expandMemberVotes)
            _memberVotes != null
                ? _memberVotes!.isNotEmpty
                    ? Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(setWidth(8)),
                          child: ListView.builder(
                            itemCount: _memberVotes!.length,
                            itemBuilder:
                                (final BuildContext _, final int index) =>
                                    _buildItemCard(_memberVotes![index]),
                          ),
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.only(top: setHeight(20)),
                        child: const Center(
                          child: Text(
                            'Poslanec nemá evidované výsledky hlasování.',
                          ),
                        ),
                      )
                : Padding(
                    padding: EdgeInsets.only(top: setHeight(10)),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
        ],
      );

  Widget _personalInfoToggle() => GestureDetector(
        onTap: () {
          setState(() {
            _expandPersonalInfo = !_expandPersonalInfo;
          });
        },
        child: Padding(
          padding: EdgeInsets.only(top: setHeight(20)),
          child: Row(
            children: [
              Text(style: TextStyle(fontSize: setSp(14)), 'Osobní informace'),
              Icon(
                _expandPersonalInfo ? Icons.arrow_upward : Icons.arrow_downward,
              )
            ],
          ),
        ),
      );

  List<Widget> _getMemberInfoList() => _expandPersonalInfo
      ? [
          if (_memberDetail.party != null)
            _buildTextWithDescription('Volební strana:', _memberDetail.party!),
          if (_memberDetail.region != null)
            _buildTextWithDescription('Volební kraj:', _memberDetail.region!),
          _buildTextWithDescription(
            'Volební obdobi:',
            '${_memberDetail.dateFrom} - ${_memberDetail.dateTo ?? '...'}',
          ),
          if (_memberDetail.birthDate != null)
            _buildTextWithDescription(
              'Datum narození:',
              _memberDetail.birthDate!,
            ),
          if (_memberDetail.officeAddress != null)
            _buildTextWithDescription(
              'Regionální kancelář:',
              getRegionalOfficeAddress(),
            ),
        ]
      : [];

  String getRegionalOfficeAddress() =>
      '${_memberDetail.officeAddress?.street?.trim() ?? ''}, '
      '${_memberDetail.officeAddress?.municipality?.trim() ?? ''}, '
      '${_memberDetail.officeAddress?.zip ?? ''}';

  Widget _buildTextWithDescription(final String name, final String value) =>
      Padding(
        padding: EdgeInsets.only(top: setHeight(20)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: setWidth(140),
              child: Text(style: TextStyle(fontSize: setSp(14)), name),
            ),
            SizedBox(
              width: setWidth(200),
              child: Text(style: TextStyle(fontSize: setSp(12)), value),
            ),
          ],
        ),
      );

  Widget _buildExternalSystemsLinks() => Padding(
        padding: EdgeInsets.only(top: setWidth(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                if (_memberDetail.facebook != null) {
                  launchInBrowser(Uri.parse(_memberDetail.facebook!));
                }
              },
              child: Text(
                style: TextStyle(
                  color: _memberDetail.facebook != null ? Colors.blue : null,
                ),
                'Facebook',
              ),
            ),
            GestureDetector(
              onTap: () {
                if (_memberDetail.ownPageUrl != null) {
                  launchInBrowser(Uri.parse(_memberDetail.ownPageUrl!));
                }
              },
              child: Text(
                style: TextStyle(
                  color: _memberDetail.ownPageUrl != null ? Colors.blue : null,
                ),
                'Vlastní stranky',
              ),
            ),
            GestureDetector(
              onTap: () => launchInBrowser(Uri.parse(_memberDetail.pspUrl)),
              child: const Text(
                style: TextStyle(
                  color: Colors.blue,
                ),
                'Stranky PS',
              ),
            ),
          ],
        ),
      );

  Widget _buildMemberVotesToggle() => Padding(
        padding: EdgeInsets.only(top: setWidth(20)),
        child: GestureDetector(
          onTap: () {
            setState(() {
              if (_memberVotes == null) {
                _memberBloc.add(GetVotes(memberId: _memberId));
              }

              _expandMemberVotes = !_expandMemberVotes;
            });
          },
          child: Row(
            children: [
              Text(
                style: TextStyle(fontSize: setSp(14)),
                'Jak poslanec hlasoval',
              ),
              Icon(
                _expandMemberVotes ? Icons.arrow_upward : Icons.arrow_downward,
              )
            ],
          ),
        ),
      );

  Widget _buildItemCard(final MemberVotes memberVote) {
    final VoteResult result = getMemberVoteResult(memberVote.result);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      elevation: 5,
      child: ListTile(
        title: Text(memberVote.name),
        subtitle: Padding(
          padding: EdgeInsets.symmetric(vertical: setHeight(5)),
          child: Text(memberVote.date),
        ),
        trailing: Container(
          width: setWidth(100),
          color: result.color,
          child: Padding(
            padding: EdgeInsets.all(setWidth(8)),
            child: Center(child: Text(result.text)),
          ),
        ),
      ),
    );
  }
}
