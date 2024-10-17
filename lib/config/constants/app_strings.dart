class AppStrings {
  static String uppercaseFirst(String text) {
    if (text.isEmpty) return text; // Handle empty string case
    return text[0].toUpperCase() + text.substring(1);
  }

  static const emptyText = '';

  //logs screen
  static const historyText = 'ประวัติ';
  static const dailyLogsText = 'บันทึกสุขภาพประจำวัน';
  static const amoutOfWaterText = 'จำนวนน้ำ';
  static const glassesText = 'แก้ว';
  static const hoursOfSleepText = 'ชั่วโมงการนอน';
  static const hoursText = 'ชั่วโมง';
  static const weeklyLogsText = 'บันทึกสุขภาพประจำสัปดาห์';
  static const hdlText = 'HDL';
  static const ldlText = 'LDL';
  static const mgPerDlText = 'มก./ดล';
  static const confirmText = 'ยืนยัน';
  static const weightRecordText = 'บันทึกค่าน้ำหนัก';
  static const kgText = 'กก.';
  static const waistLineRecordText = 'บันทึกรอบเอว';
  static const cmText = 'ซม.';
  static const hdlRecordText = 'บันทึกค่า HDL';
  static const ldlRecordText = 'บันทึกค่า LDL';
  static const chooseMoodsText = 'คุณรู้สึกอย่างไรกับภารกิจ';
  static const dataRecordingText = 'บันทึกข้อมูล';
  static const dataRecordingCompletedText = 'บันทึกข้อมูลเสร็จสิ้น';
  static const nextText = 'ถัดไป';
  static const cancleText = 'ยกเลิก';
  static const completedText = 'เสร็จสิ้น';
  static const weightText = 'น้ำหนัก';
  static const skipText = 'ข้าม';
  static const backText = 'ย้อนกลับ';

  //logs history screen
  static const healthHistoryText = 'ประวัติบันทึกสุขภาพ';
  static const sleepText = 'การนอน';
  static const stepText = 'ก้าว';
  static const stepWalkText = 'ก้าวเดิน';
  static const drinkText = 'ดื่มน้ำ';
  static const enterText = 'เข้าสู่แอพ';
  static const waistLineText = 'รอบเอว';
  static const xdateText = 'วันที่';
  static const goodCriteria = 'ค่าตามเกณฑ์';
  static const aboveCriteria = 'ค่าเกินเกณฑ์';
  static const underCriteria = 'ค่าต่ำกว่าเกณฑ์';

  //profile screen
  static const userNameText = 'ชื่อผู้ใช้';
  static const idText = 'ไอดี';
  static const leagueText = 'ระดับ';
  static const bronzeLeaugeText = 'ทองแดง';
  static const silverLeaugeText = 'เงิน';
  static const goldLeaugeText = 'ทอง';
  static const diamondLeaugeText = 'ไดมอนด์';
  static const emeraldLeaugeText = 'มรกต';
  static const gemText = 'gem';
  static const expText = 'exp';
  static const checkinText = 'เช็คอินเพื่อสะสมคะแนน';
  static const xdayText = 'วันที่';
  static const archeivementText = 'ความสำเร็จ';
  static const seeAllText = 'ดูทั้งหมด';
  static const dayText = 'วัน';
  static const googleConnectText = 'Google Connect';
  static const signOutText = 'ออกจากระบบ';
  static const rewardRedeemText = 'แลกรางวัล';
  static const progressText = 'ความก้าวหน้า';
  static const exerciseProgressText = 'ออกกำลังกายไปแล้ว';
  static const taskProgressText = 'จำนวนทำภารกิจ';
  static const taskText = 'ภารกิจ';
  static const minuteText = 'นาที';
  static const alertText = 'แจ้งเตือน';
  static const youReceivedText = 'คุณได้รับ';
  static const closeWindowText = 'ปิดหน้าต่างนี้';


  static const metabolicSyndromeText = 'ภาวะเมตาบอลิกซินโดรม';
  static const metabolicDescriptionText =
      'คือ ภาวะที่เกิดจากระบบการเผาผลาญของร่างกาย ทำงานผิดปกติไป ทำให้เกิดการอ้วนลงพุง น้ำหนักตัว เกินมาตรฐาน น้ำตาลในเลือดสูง ความดันโลหิตสูง';
  static const metaEffectText = 'ผลกระทบของโรค';
  static const metaEffectDescriptionText =
      'ภาวะนี้ส่งผลกระทบต่อคุณภาพชีวิตของผู้ป่วยในหลากหลายด้าน เช่น ความเสี่ยงในการเกิดโรคหัวใจ และหลอดเลือด เนื่องจากทำให้หลอดเลือดแดงอุดตัน ';
  static const metaBehaviorText = 'การปรับพฤติกรรม';
  static const metaBehaviorDescriptionText =
      'โดยการรับประทานอาหารที่เหมาะสม ออกกำลังกายอย่างสม่ำเสมอ โดย WellWave จะเป็นตัวช่วยสำคัญในการปรับพฤติกรรมของคุณ ';

  //Chart
  static const errorShow = 'Error';
  static const noLogsAvailableText = 'No logs available';
  static const errorLoadingLogsText = 'Error loading logs.';
  static const noDataForTodayText = 'ไม่มีข้อมูลสำหรับวันนี้';
  static const noDataForWeekText = 'ไม่มีข้อมูลสำหรับสัปดาห์นี้';
  static const stepNumber = 'ขั้นตอนที่';
  static const weightLogText = 'WEIGHT_LOG';
  static const waistLineLogText = 'WAIST_LINE_LOG';
  static const hdlLogText = 'HDL_LOG';
  static const ldlLogText = 'LDL_LOG';
  static const stepLogText = 'STEP_LOG';
}
