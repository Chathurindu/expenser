import 'package:hive/hive.dart';
part 'user_profile.g.dart';

@HiveType(typeId: 1)
class UserProfile extends HiveObject {
  @HiveField(0)
  String username;
  @HiveField(1)
  String email;
  @HiveField(2)
  String address;
  @HiveField(3)
  String mobileNumber;
  @HiveField(4)
  String name;

  UserProfile(this.username, this.email, this.address, this.mobileNumber, this.name);
}
