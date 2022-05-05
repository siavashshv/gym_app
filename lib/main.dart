import 'package:Gym_app/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/gym.dart';
import 'screens/home_screen.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(GymAdapter());
  await Hive.openBox<Gym>('gymBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static void getData() {
    HomeScreen.Gyms.clear();
    Box<Gym> hiveBox = Hive.box<Gym>('gymBox');
    for (var value in hiveBox.values) {
      HomeScreen.Gyms.add(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'iransans'),
      debugShowCheckedModeBanner: false,
      title: 'Flex Gym',
      home: const MainScreen(),
    );
  }
}
