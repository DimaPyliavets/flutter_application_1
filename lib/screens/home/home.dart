import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home/fragments/call_fragment.dart';
import 'package:flutter_application_1/screens/home/fragments/file_fragment.dart';
import 'package:flutter_application_1/screens/home/fragments/messege_fragment.dart';
import 'package:flutter_application_1/screens/home/fragments/settings_fragment.dart';
import 'package:flutter_application_1/screens/home/fragments/user_fragment.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> pages = <Widget>[
    const MessegeFragment(),
    const FileFragment(),
    const CallFragment(),
    const UserListFragment(),
    const SettingFragment(),
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 24,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        selectedItemColor: Colors.black54,
        unselectedItemColor: Colors.grey.withOpacity(0.5),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Messeges',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.share),
            label: 'Share',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_call),
            label: 'Meeting',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'People',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
