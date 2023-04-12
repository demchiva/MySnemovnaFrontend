import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snemovna/bloc/members/MemberBloc.dart';
import 'package:snemovna/bloc/members/MemberEvent.dart';
import 'package:snemovna/bloc/members/MemberState.dart';
import 'package:snemovna/model/members/Member.dart';
import 'package:snemovna/navigation/Navigation.dart';
import 'package:snemovna/utils/BaseTools.dart';

class MembersListScreen extends StatefulWidget {
  const MembersListScreen({super.key});

  @override
  State<MembersListScreen> createState() => _MembersListScreenState();
}

class _MembersListScreenState extends State<MembersListScreen> {
  final ScrollController _controller = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  final MemberBloc _memberBloc = MemberBloc(MembersFirstLoading());
  int pageNumber = 0;
  bool hasReachedMax = false;

  @override
  void initState() {
    _controller.addListener(() {
      // Load new data when we are at the end of list and we are not reached max
      if (!hasReachedMax &&
          _controller.offset >= _controller.position.maxScrollExtent &&
          !_controller.position.outOfRange) {
        _memberBloc.add(
          GetMembers(
            pageNumber: pageNumber,
            search: _searchController.text,
          ),
        );
      }
    });

    _memberBloc.add(GetMembers(pageNumber: pageNumber));
    super.initState();
  }

  @override
  Widget build(final BuildContext context) => BlocBuilder(
        bloc: _memberBloc,
        builder: (final BuildContext context, final MemberState state) =>
            _buildBody(state),
      );

  Widget _buildBody(final MemberState state) => Padding(
        padding: EdgeInsets.all(setWidth(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: setHeight(10)),
              child: Center(
                child: Text(
                  'Poslanci',
                  style: TextStyle(
                    fontSize: setSp(20),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            _buildSearchField(),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: setWidth(5),
                vertical: setHeight(2),
              ),
              child: Text(
                style: TextStyle(fontSize: setSp(10)),
                '*Vyhledávání podle jména, volebního kraje, volební strany'
                ' a volebního období',
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: setWidth(5)),
              child: Text(
                style: TextStyle(fontSize: setSp(10)),
                '**formát data je yyyy-MM-dd',
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: state is MembersFirstLoading
                  ? const Center(child: CircularProgressIndicator())
                  : getMembersList(state as GetMembersSuccessState),
            ),
          ],
        ),
      );

  Widget _buildSearchField() => TextField(
        controller: _searchController,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(),
          hintText: 'Search...',
        ),
        onChanged: (final String? value) {
          pageNumber = 0;
          _memberBloc.add(
            GetMembers(
              pageNumber: pageNumber,
              search: value != null && value.isNotEmpty && value.length > 2
                  ? value
                  : null,
            ),
          );
        },
      );

  Widget getMembersList(final GetMembersSuccessState state) {
    pageNumber = state.pageNumber;
    hasReachedMax = state.hasReachedMax;
    return ListView.builder(
      controller: _controller,
      itemCount:
          state.hasReachedMax ? state.members.length : state.members.length + 1,
      itemBuilder: (final BuildContext _, final int index) =>
          index >= state.members.length
              ? Padding(
                  padding: EdgeInsets.symmetric(vertical: setHeight(5)),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : _buildItemCard(state.members[index]),
    );
  }

  Widget _buildItemCard(final Member member) => GestureDetector(
        onTap: () {
          Navigation.me.memberDetail(context, member.memberId);
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          elevation: 5,
          child: ListTile(
            // leading: Image.network(member.photo),
            leading: CachedNetworkImage(
              imageUrl: member.photo,
              height: setHeight(100),
              width: setWidth(50),
              errorWidget: (final context, final url, final error) =>
                  const Center(
                child: Icon(
                  Icons.account_circle,
                  size: 50,
                ),
              ),
            ),
            visualDensity: const VisualDensity(
              vertical: 3,
              horizontal: 3,
            ),
            isThreeLine: true,
            title: Text(
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: setSp(14),
              ),
              member.name,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  style: TextStyle(fontSize: setSp(12)),
                  member.party!,
                ),
                Padding(
                  padding: EdgeInsets.only(top: setHeight(5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        style: TextStyle(fontSize: setSp(10)),
                        member.region,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: setWidth(5)),
                        child: Text(
                          style: TextStyle(fontSize: setSp(10)),
                          '${member.dateFrom} - ${member.dateTo ?? '...'}',
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
}