import 'package:Gym_app/constant.dart';
import 'package:Gym_app/main.dart';
import 'package:Gym_app/models/gym.dart';
import 'package:Gym_app/screens/home_screen.dart';
import 'package:Gym_app/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class TodayUsersScreen extends StatefulWidget {
  const TodayUsersScreen({Key? key}) : super(key: key);

  static List<Gym> todayUsers = [];
  static String date = '';

  @override
  _TodayUsersScreenState createState() => _TodayUsersScreenState();
}

class _TodayUsersScreenState extends State<TodayUsersScreen> {
  @override
  void initState() {
    //
    var pickedDate = Jalali.now();
    //
    String year = pickedDate.year.toString();
    //
    String month = pickedDate.month.toString().length == 1
        ? '0${pickedDate.month.toString()}'
        : pickedDate.month.toString();
    //
    String day = pickedDate.day.toString().length == 1
        ? '0${pickedDate.day.toString()}'
        : pickedDate.day.toString();
    //
    TodayUsersScreen.date = year + '/' + month + '/' + day;

    //

    MyApp.getData();
    //

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    refreshList();
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              headerWidget(),
              Expanded(
                child: ListView.builder(
                  itemCount: TodayUsersScreen.todayUsers.length,
                  itemBuilder: ((context, index) {
                    return MyListTileWidget(index: index);
                  }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  //! Header Widget
  Widget headerWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(width: 10),
          Text(
            'Completion of tuition list',
            style: TextStyle(
                fontSize: ScreenSize(context).screenWidth < 1004
                    ? 18
                    : ScreenSize(context).screenWidth * 0.015),
          ),
        ],
      ),
    );
  }

  void refreshList() {
    Gregorian today = Jalali.now().toGregorian();

    TodayUsersScreen.todayUsers.clear();

    HomeScreen.Gyms.forEach((item) {
      Gregorian expireDate = Jalali(
        int.parse(
          item.expiredate.substring(0, 4).toString(),
        ),
        int.parse(
          item.expiredate.substring(5, 7).toString(),
        ),
        int.parse(
          item.expiredate.substring(8, 10).toString(),
        ),
      ).toGregorian();

      if (item.expiredate == TodayUsersScreen.date || expireDate <= today) {
        setState(() {
          TodayUsersScreen.todayUsers.add(item);
        });
      }
    });
  }
}

class MyListTileWidget extends StatelessWidget {
  final int index;
  const MyListTileWidget({Key? key, required this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      TodayUsersScreen.todayUsers[index].fullname,
                      style: TextStyle(
                          fontSize: ScreenSize(context).screenWidth < 1004
                              ? 14
                              : ScreenSize(context).screenWidth * 0.015),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      TodayUsersScreen.todayUsers[index].monthType == 1
                          ? 'One month'
                          : 'Three monthes',
                    ),
                  )
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Text(
                        'Euro',
                        style: TextStyle(
                          fontSize: ScreenSize(context).screenWidth < 1004
                              ? 14
                              : ScreenSize(context).screenWidth * 0.015,
                          color: kRedColor,
                        ),
                      ),
                      Text(
                        TodayUsersScreen.todayUsers[index].price,
                        style: TextStyle(
                            fontSize: ScreenSize(context).screenWidth < 1004
                                ? 14
                                : ScreenSize(context).screenWidth * 0.015,
                            color: kRedColor),
                      ),
                    ],
                  ),
                  Text(
                    TodayUsersScreen.todayUsers[index].expiredate,
                    style: TextStyle(
                      fontSize: ScreenSize(context).screenWidth < 1004
                          ? 12
                          : ScreenSize(context).screenWidth * 0.01,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
