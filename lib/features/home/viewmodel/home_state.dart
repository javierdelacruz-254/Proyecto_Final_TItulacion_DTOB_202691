import 'package:lactaamor/features/home/models/user_profile_model.dart';

class HomeState {
  final bool isLoading;
  final UserProfileModel? profile;
  final String? error;

  HomeState({this.isLoading = false, this.profile, this.error});

  HomeState copyWith({
    bool? isLoading,
    UserProfileModel? profile,
    String? error,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      profile: profile ?? this.profile,
      error: error,
    );
  }
}
