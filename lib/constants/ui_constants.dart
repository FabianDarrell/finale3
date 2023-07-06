import 'package:finale3/features/explore/view/explore_view.dart';
import 'package:finale3/features/notifications/views/notification_view.dart';
import 'package:finale3/features/tweet/widgets/tweet_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:finale3/theme/pallete.dart';
import 'package:finale3/constants/constants.dart';

class UIConstants {
  static AppBar appBar(){
    return AppBar(
      title: SvgPicture.asset(
        AssetsConstants.twitterLogo,
        color: Pallete.blueColor,
        height: 30,
      ),
      centerTitle: true,
    );
  }

  static const List<Widget> bottomTabBarPages = [
    TweetList(),
    ExploreView(),
    NotificationView(),
  ];
}