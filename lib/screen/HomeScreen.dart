import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snemovna/screen/meetings/MeetingsListScreen.dart';
import 'package:snemovna/screen/members/MembersListScreen.dart';
import 'package:snemovna/screen/votes/VotesListScreen.dart';
import 'package:snemovna/utils/BaseTools.dart';

class HomeScreen extends StatefulWidget {
  static const String ROUTE_NAME = '/';

  final int barIndex;

  const HomeScreen({required this.barIndex, final Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  static const List<Widget> _children = [
    VotesListScreen(),
    MembersListScreen(),
    MeetingsListScreen()
  ];

  late int index;

  @override
  void initState() {
    super.initState();
    index = widget.barIndex;
  }

  @override
  Widget build(final BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.zero,
        child: Container(),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
      body: _children[index],
    );
  }

  Widget _buildBottomNavigationBar() => SizedBox(
        height: setWidth(75),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          iconSize: setHeight(16),
          currentIndex: index,
          onTap: _onTabTapped,
          selectedFontSize: setSp(12),
          items: const [
            BottomNavigationBarItem(
              label: 'Hlasování',
              icon: Icon(Icons.check),
            ),
            BottomNavigationBarItem(
              label: 'Poslance',
              icon: Icon(Icons.man),
            ),
            BottomNavigationBarItem(
              label: 'Schůze',
              icon: Icon(Icons.meeting_room),
            ),
          ],
        ),
      );

  void _onTabTapped(final int tappedIndex) {
    setState(() {
      index = tappedIndex;
    });
  }
}
