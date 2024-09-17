class AppStrings {
  static String uppercaseFirst(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  static const emptyText = '';

  static const noRiskText = 'ไม่มีความเสี่ยง';
  static const veryLowRiskText = 'เสี่ยงต่ำมาก';
  static const lowRiskText = 'เสี่ยงต่ำ';
  static const moderateRiskText = 'เสี่ยงปานกลาง';
  static const highRiskText = 'เสี่ยงสูง';
  static const veryHighRiskText = 'เสี่ยงสูงมาก';

  static const diabetesText = 'โรคเบาหวาน';
  static const hypertensionText = 'โรคความดันโลหิตสูง';
  static const obesityText = 'โรคอ้วน';
  static const hyperlipidemiaText = 'โรคไขมันในเลือดสูง';
}
