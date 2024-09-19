import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';

class RiskTextCondition {
  static Map<String, dynamic> getRiskText(double progress) {
    if (progress > 0.8) {
      return {
        'text': AppStrings.veryHighRiskText,
        'color': AppColors.redLevelTextColor,
      };
    } else if (progress > 0.6) {
      return {
        'text': AppStrings.highRiskText,
        'color': AppColors.orangeLevelTextColor,
      };
    } else if (progress > 0.4) {
      return {
        'text': AppStrings.moderateRiskText,
        'color': AppColors.yellowLevelTextColor,
      };
    } else {
      return {
        'text': AppStrings.lowRiskText,
        'color': AppColors.greenLevelTextColor,
      };
    }
  }
}
