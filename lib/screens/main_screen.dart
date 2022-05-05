import 'package:Gym_app/screens/home_screen.dart';
import 'package:Gym_app/screens/today_users_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  Widget body = HomeScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
            if (value == 0) {
              body = HomeScreen();
            } else if (value == 1) {
              body = TodayUsersScreen();
            }
          });
        },
        selectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            label: 'Users',
            icon: Icon(Icons.person),
          ),
          BottomNavigationBarItem(
            label: 'Completion of tuition',
            icon: Icon(Icons.info),
          ),

        ],
      ),
      body: body,
    );
  }
}
