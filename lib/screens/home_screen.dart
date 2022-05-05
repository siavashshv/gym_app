// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:Gym_app/constant.dart';
import 'package:Gym_app/main.dart';
import 'package:Gym_app/models/gym.dart';
import 'package:Gym_app/screens/new_user_screen.dart';
import 'package:Gym_app/utils/extension.dart';
import 'package:searchbar_animation/searchbar_animation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static List<Gym> Gyms = [];

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();
  Box<Gym> hiveBox = Hive.box<Gym>('gymBox');

  @override
  void initState() {
    MyApp.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: fabWidget(),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              headerWidget(),
              //const Expanded(child: EmptyWidget()),
              Expanded(
                child: HomeScreen.Gyms.isEmpty
                    ? const EmptyWidget()
                    : ListView.builder(
                        itemCount: HomeScreen.Gyms.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              //* Edit
                              onTap: () {
                                //
                                GymScreen.date =
                                    HomeScreen.Gyms[index].expiredate;
                                //
                                GymScreen.fullnameController.text =
                                    HomeScreen.Gyms[index].fullname;
                                //
                                GymScreen.priceController.text =
                                    HomeScreen.Gyms[index].price;
                                //
                                GymScreen.groupId =
                                    HomeScreen.Gyms[index].monthType == 1
                                        ? 1
                                        : 2;
                                //
                                GymScreen.isEditing = true;
                                //
                                GymScreen.id = HomeScreen.Gyms[index].id;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const GymScreen(),
                                  ),
                                ).then((value) {
                                  MyApp.getData();
                                  setState(() {});
                                });
                              },
                              //! Delete
                              onLongPress: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text(
                                      'Are you sure you want to delete this item?',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    actionsAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('No',
                                            style: TextStyle(
                                                color: Colors.black87)),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          hiveBox.deleteAt(index);
                                          MyApp.getData();
                                          setState(() {});
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          'Yes',
                                          style:
                                              TextStyle(color: Colors.black87),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: MyListTileWidget(index: index));
                        },
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }

  //! FAB Widget
  Widget fabWidget() {
    return FloatingActionButton(
      backgroundColor: kPurpleColor,
      elevation: 0,
      onPressed: () {
        GymScreen.date = 'Date';
        GymScreen.fullnameController.text = '';
        GymScreen.priceController.text = '';
        GymScreen.groupId = 0;
        GymScreen.isEditing = false;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const GymScreen(),
          ),
        ).then((value) {
          MyApp.getData();
          setState(() {});
        });
      },
      child: const Icon(Icons.add),
    );
  }

  //! Header Widget
  Widget headerWidget() {
    return Padding(
      padding: const EdgeInsets.only(right: 20, top: 20, left: 5),
      child: Row(
        children: [
          Expanded(
            child: SearchBarAnimation(
              hintText: 'Search here...',
              buttonElevation: 0,
              buttonShadowColour: Colors.black26,
              isOriginalAnimation: false,
              buttonBorderColour: Colors.black26,
              buttonIcon: Icons.search,
              onCollapseComplete: () {
                MyApp.getData();
                searchController.text = '';
                setState(() {});
              },
              onFieldSubmitted: (String text) {
                List<Gym> result = hiveBox.values
                    .where((value) =>
                        value.fullname.contains(text) ||
                        value.registerdate.contains(text) ||
                        value.expiredate.contains(text))
                    .toList();
                HomeScreen.Gyms.clear();

                setState(() {
                  for (var value in result) {
                    HomeScreen.Gyms.add(value);
                  }
                });
              },
              textEditingController: searchController,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            'Users',
            style: TextStyle(
                fontSize: ScreenSize(context).screenWidth < 1004
                    ? 18
                    : ScreenSize(context).screenWidth * 0.015),
          ),
        ],
      ),
    );
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
                      HomeScreen.Gyms[index].fullname,
                      style: TextStyle(
                          fontSize: ScreenSize(context).screenWidth < 1004
                              ? 14
                              : ScreenSize(context).screenWidth * 0.015),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      HomeScreen.Gyms[index].monthType == 1
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
                        'ِEuro',
                        style: TextStyle(
                          fontSize: ScreenSize(context).screenWidth < 1004
                              ? 14
                              : ScreenSize(context).screenWidth * 0.015,
                          color: kRedColor,
                        ),
                      ),
                      Text(
                        HomeScreen.Gyms[index].price,
                        style: TextStyle(
                            fontSize: ScreenSize(context).screenWidth < 1004
                                ? 14
                                : ScreenSize(context).screenWidth * 0.015,
                            color: kRedColor),
                      ),
                    ],
                  ),
                  Text(
                    HomeScreen.Gyms[index].expiredate,
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

//! Empty Widget
class EmptyWidget extends StatelessWidget {
  const EmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        SvgPicture.asset(
          'assets/images/empty.svg',
          height: 150,
          width: 150,
        ),
        const SizedBox(height: 10),
        const Text('No user available !'),
        const Spacer(),
      ],
    );
  }
}
