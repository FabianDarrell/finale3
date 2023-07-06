import 'package:finale3/common/error.dart';
import 'package:finale3/common/loading.dart';
import 'package:finale3/constants/constants.dart';
import 'package:finale3/features/user_profile/controller/user_profile_controller.dart';
import 'package:finale3/features/user_profile/widgets/user_profile.dart';
import 'package:finale3/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserProfileView extends ConsumerWidget {
  static route(UserModel userModel) => MaterialPageRoute(builder: (context) => UserProfileView(userModel: userModel,),);
  final UserModel userModel;
  const UserProfileView({
    super.key,
    required this.userModel,});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    UserModel copyOfUser = userModel;
    return Scaffold(
      body: ref.watch(getLatestUserProfileDataProvider).when(data: (data) {
        if (data.events.contains('databases.*.collections.${AppwriteConstants.usersCollection}.documents.${copyOfUser.uid}.update')) {
          copyOfUser = UserModel.fromMap(data.payload);
        }
        return UserProfile(user: userModel);
      }, error: (error, stackTrace) => ErrorText(error: error.toString(),), 
      loading: () {
        return UserProfile(user: copyOfUser);
      })
      );
  }
}