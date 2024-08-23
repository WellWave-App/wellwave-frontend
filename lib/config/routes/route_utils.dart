import 'package:wellwave_frontend/config/constants/app_pages.dart';

bool isTargetPageCheck(String uri) {
  return uri.contains(AppPages.homePage) ||
      uri.contains(AppPages.missionPage) ||
      uri.contains(AppPages.friendPage) ||
      uri.contains(AppPages.articlePage) ||
      uri.contains(AppPages.logPage);
}
