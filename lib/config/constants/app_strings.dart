class AppStrings {
  static String uppercaseFirst(String text) {
    if (text.isEmpty) return text; // Handle empty string case
    return text[0].toUpperCase() + text.substring(1);
  }

  static const emptyText = '';

  //note screen
  static const historyText = 'ประวัติ';
  static const dailyLogsText = 'บันทึกสุขภาพประจำวัน';
  static const amoutOfWaterText = 'จำนวนน้ำ';
  static const glassesText = 'แก้ว';
  static const hoursOfSleepText = 'ชั่วโมงการนอน';
  static const hoursText = 'ชั่วโมง';
  static const weeklyLogsText = 'ความก้าวหน้าประจำสัปดาห์';
  static const hdlText = 'HDL';
  static const ldlText = 'LDL';
  static const mgPerDlText = 'มก./ดล';
  static const confirmText = 'ยืนยัน';
  static const weightRecordText = 'บันทึกค่าน้ำหนัก';
  static const kgText = 'กก.';
  static const hdlRecordText = 'บันทึกค่า HDL';
  static const ldlRecordText = 'บันทึกค่า LDL';
  static const chooseMoodsText = 'เลือกอารมณ์';
  static const dataRecordingText = 'บันทึกข้อมูล';
  static const dataRecordingCompletedText = 'บันทึกข้อมูลเสร็จสิ้น';
  static const nextText = 'ถัดไป';
  static const cancleText = 'ยกเลิก';
  static const completedText = 'เสร็จสิ้น';
  static const weightText = 'น้ำหนัก';

  //note history screen
  static const healthHistoryText = 'ประวัติบันทึกสุขภาพ';
  static const sleepText = 'การนอน';
  static const stepText = 'ก้าว';
  static const stepWalkText = 'ก้าวเดิน';
  static const drinkText = 'ดื่มน้ำ';
}
