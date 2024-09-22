import 'package:flutter/material.dart';
import 'package:wellwave_frontend/config/constants/app_colors.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';

class ScoreCalculator {
  int calculateScore(Map<String, dynamic> formData) {
    int riskScore = 0;

    if (formData['gender'] == 'male') {
      riskScore += 2;
      // debugPrint('riskScore: $riskScore');
    }

    if (formData['birthYear'] != null) {
      int birthYear = int.tryParse(formData['birthYear']) ?? 0;
      int currentYear = DateTime.now().year + 543;
      int age = currentYear - birthYear;

      if (age >= 45 && age <= 49) {
        riskScore += 1;
      } else if (age >= 50) {
        riskScore += 2;
      }
      debugPrint('age: $age, riskScore: $riskScore');
    }

    return riskScore;
  }
}

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
