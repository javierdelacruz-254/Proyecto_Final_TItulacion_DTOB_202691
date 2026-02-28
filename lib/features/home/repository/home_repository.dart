import 'package:lactaamor/features/home/models/user_profile_model.dart';

abstract class HomeRepository {
  Future<UserProfileModel> getUserProfile(String uid);
}
