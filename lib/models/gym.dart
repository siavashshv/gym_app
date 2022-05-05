import 'package:hive/hive.dart';

part 'gym.g.dart';

@HiveType(typeId: 0)
class Gym {
  @HiveField(1)
  int id;
  @HiveField(2)
  String fullname;
  @HiveField(3)
  int monthType;
  @HiveField(4)
  String registerdate;
  @HiveField(5)
  String expiredate;
  @HiveField(6)
  String price;

  Gym({
    required this.id,
    required this.fullname,
    required this.monthType,
    required this.registerdate,
    required this.expiredate,
    required this.price,
  });
}
