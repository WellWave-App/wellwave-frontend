class AppStrings {
  static String uppercaseFirst(String text) {
    if (text.isEmpty) return text; // Handle empty string case
    return text[0].toUpperCase() + text.substring(1);
  }

  static const emptyText = '';

  static const baseUrl = 'http://10.0.2.2:3000';
  static String token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJFTUFJTCI6InRlc3R4eEBleGFtcGxlLmNvbSIsIlVJRCI6NSwiUk9MRSI6InVzZXIiLCJpYXQiOjE3Mzk4MTIyMzYsImV4cCI6MTczOTg5ODYzNn0.w7S2Z_ZOwmPPAsNg2wLmKxc8OsudPwYu5O1WpHjL4vU';
  static const uid = 5;

  //logs screen
  static const historyText = 'ประวัติ';
  static const dailyLogsText = 'บันทึกสุขภาพประจำวัน';
  static const amoutOfWaterText = 'จำนวนน้ำ';
  static const glassesText = 'แก้ว';
  static const hoursOfSleepText = 'ชั่วโมงการนอน';
  static const hoursText = 'ชั่วโมง';
  static const shortHoursText = 'ชม.';
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
  static const firstLeaugeText = 'มือใหม่สุขภาพดี';
  static const secondLeaugeText = 'ผู้เสาะหาความแข็งแรง';
  static const thirdLeaugeText = 'ยอดนักรบสุดฟิต';
  static const forthLeaugeText = 'ปรมาจารย์ด้านสุขภาพ';
  static const fifthLeaugeText = 'ตำนานแชมป์สุดแข็งแกร่ง';
  static const gemText = 'gem';
  static const expText = 'exp';
  static const checkinText = 'เช็คอินเพื่อสะสมคะแนน';
  static const archeivementText = 'ความสำเร็จ';
  static const archeiveText = 'สำเร็จ';
  static const seeAllText = 'ดูทั้งหมด';
  static const dayText = 'วัน';
  static const googleConnectText = 'Google Connect';
  static const signOutText = 'ออกจากระบบ';
  static const rewardRedeemText = 'แลกรางวัล';
  static const progressText = 'ความก้าวหน้า';
  static const exerciseProgressText = 'ออกกำลังกายไปแล้ว';
  static const copyToClipboardText = 'คัดลอกไปยังคลิปบอร์ด';

  static const taskProgressText = 'จำนวนทำภารกิจ';
  static const taskText = 'ภารกิจ';
  static const minuteText = 'นาที';
  static const alertText = 'แจ้งเตือน';
  static const youReceivedText = 'คุณได้รับ';
  static const closeWindowText = 'ปิดหน้าต่างนี้';
  static const genderText = 'เพศ';
  static const birthYearText = 'ปีเกิด';
  static const heightText = 'ส่วนสูง';

  static const metabolicSyndromeText = 'ภาวะเมตาบอลิกซินโดรม';
  static const metabolicDescriptionText =
      'คือ ภาวะที่เกิดจากระบบการเผาผลาญของร่างกาย ทำงานผิดปกติไป ทำให้เกิดการอ้วนลงพุง น้ำหนักตัว เกินมาตรฐาน น้ำตาลในเลือดสูง ความดันโลหิตสูง';
  static const metaEffectText = 'ผลกระทบของโรค';
  static const metaEffectDescriptionText =
      'ภาวะนี้ส่งผลกระทบต่อคุณภาพชีวิตของผู้ป่วยในหลากหลายด้าน เช่น ความเสี่ยงในการเกิดโรคหัวใจ และหลอดเลือด เนื่องจากทำให้หลอดเลือดแดงอุดตัน ';
  static const metaBehaviorText = 'การปรับพฤติกรรม';
  static const metaBehaviorDescriptionText =
      'โดยการรับประทานอาหารที่เหมาะสม ออกกำลังกายอย่างสม่ำเสมอ โดย WellWave จะเป็นตัวช่วยสำคัญในการปรับพฤติกรรมของคุณ ';

  static const leagueList = [
    AppStrings.firstLeaugeText,
    AppStrings.secondLeaugeText,
    AppStrings.thirdLeaugeText,
    AppStrings.forthLeaugeText,
    AppStrings.fifthLeaugeText,
  ];

  //arcievement
  static const yourRecordText = 'สถิติของคุณ';
  static const medalText = 'เหรียญรางวัล';

  //notification
  static const selectAllText = 'เลือกทั้งหมด';
  static const drinkingText = 'การดื่มน้ำ';
  static const timeText = 'เวลา';
  static const setTimeText = 'ตั้งเวลา';
  static const startTimeText = 'เวลาเริ่ม';
  static const endTimeText = 'เวลาจบ';
  static const notiEveryText = 'แจ้งเตือนทุก';
  static const setDrinkPlanText = 'กำหนดแผนดื่มน้ำโดยละเอียด >';
  static const sleepingText = 'การเข้านอน';
  static const drinkPlanText = 'แผนการดื่มน้ำ';

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
  static const sleepLogText = 'SLEEP_LOG';
  static const drinkLogText = 'DRINK_LOG';

  static const amoutOfStepText = 'จำนวนก้าวเดิน';
  static const goalText = 'เป้าหมาย';

  static const thaiMonths = [
    'มกราคม',
    'กุมภาพันธ์',
    'มีนาคม',
    'เมษายน',
    'พฤษภาคม',
    'มิถุนายน',
    'กรกฎาคม',
    'สิงหาคม',
    'กันยายน',
    'ตุลาคม',
    'พฤศจิกายน',
    'ธันวาคม'
  ];

  //goal
  static const goalAmountText = 'จำนวนเป้าหมาย';
  static const stepPerWeekText = 'ก้าวเดินต่อสัปดาห์';
  static const exercisePerWeekText = 'ออกกำลังกายต่อสัปดาห์';

  static const noDataAvaliableText = 'No data available.';
  static const clickToEditText = 'กดเพื่อแก้ไข';

  //leaderboard
  static const leaderboardText = 'กระดานจัดอันดับ';
}
