import 'package:wellwave_frontend/features/home/widget/check_weight_and_waist.dart';

class AppStrings {
  static String uppercaseFirst(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  static const emptyText = '';
  static const baseUrl = 'http://10.0.2.2:3000';
  static const token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJFTUFJTCI6InVzZXIxM0BleGFtcGxlLmNvbSIsIlVJRCI6MTMsIlJPTEUiOiJ1c2VyIiwiaWF0IjoxNzM5NDM2MTUxLCJleHAiOjE3Mzk1MjI1NTF9.O5JIoXG2tjXDuzLNcvqmA18JvaJMwtyzxp6HtWPXxyQ';
  static const userID = '13';
  static const riskText = 'เสี่ยง';
  static const lowRiskText = 'เสี่ยงต่ำ';
  static const moderateRiskText = 'เสี่ยงปานกลาง';
  static const highRiskText = 'เสี่ยงสูง';
  static const veryHighRiskText = 'เสี่ยงสูงมาก';

  static const recommendMuscleText =
      'เพิ่มโปรตีนในแต่ละมื้อ เช่น เนื้อไม่ติดมัน ไข่ หรือผลิตภัณฑ์นม ออกกำลังกายสม่ำเสมอ 3-4 ครั้งต่อสัปดาห์ ครั้งละ 45-60 นาที';
  static const recommendLoseWeightText =
      'ลดอาหารไขมันสูงและคาร์โบไฮเดรตขัดสี เช่น ขนมปังขาว ขนมหวาน ร่วมกับการออกกำลังกาย 3 ครั้งต่อสัปดาห์ ครั้งละ 30-60 นาที';
  static const recommendHealthyText =
      'รับประทานอาหารที่มีคุณค่าทางโภชนาการครบถ้วน เน้นผัก ผลไม้ โปรตีนที่ดี และไขมันดี พร้อมทั้งออกกำลังกายอย่างสม่ำเสมอ';

  static const diabetesText = 'โรคเบาหวาน';
  static const hypertensionText = 'โรคความดันโลหิตสูง';
  static const obesityText = 'โรคอ้วน';
  static const hyperlipidemiaText = 'โรคไขมันในเลือดสูง';
  static const coronaryArteryText = 'โรคหลอดเลือดหัวใจ';
  static const paralysisText = 'โรคอัมพาต';
  static const unknownDiseaseText = 'ไม่ทราบ / ไม่มีประวัติเจ็บป่วย';

  static const setNameandPicText = 'ตั้งชื่อและรูปผู้ใช้';
  static const callNameAskText = 'ต้องการให้เราเรียกคุณว่าอะไรดี';
  static const drinkalcoholAskText = 'คุณดื่มเครื่องดื่มแอลกอฮอล์หรือไม่?';
  static const famhisAskText = 'คนในครอบครัวมีประวัติการเจ็บป่วยเหล่านี้ไหม?';
  static const goalAskText =
      'สุดท้ายแล้ว! บอกเป้าหมายของคุณให้เรารู้หน่อยได้ไหม?';
  static const connectHealthAskText = 'ต้องการเชื่อมต่อข้อมูลสุขภาพหรือไม่?';
  static const connectHealthDetailsText =
      'เชื่อมต่อกับ Google Fit เพื่อให้การติดตามสุขภาพของคุณแม่นยำยิ่งขึ้น';
  static const healthPlanDetailsText =
      'แผนสุขภาพส่วนตัวของคุณพร้อมแล้ว \nเริ่มต้นการดูแลสุขภาพที่ดีที่สุดสำหรับคุณได้เลย';
  static const healthAssessmentDetailsText =
      'คัดกรองความเสี่ยงในกลุ่มภาวะโรคเมตาบอลิก (เบาหวาน ความดันโลหิตสูง ไขมัน และโรคอ้วน)';
  static const drinkUsuallyText = 'ดื่มเป็นประจำ';
  static const drinkSometimesText = 'ดื่มเป็นครั้งคราว';
  static const smokeUsuallyText = 'สูบเป็นประจำ';
  static const smokeUedtoText = 'เลิกสูบแล้ว';
  static const smokeNeverText = 'ไม่สูบ';

  static const more5timesText = '(เกิน 5 ครั้ง / สัปดาห์)';
  static const less5timesText = '(ไม่เกิน 5 ครั้ง / สัปดาห์)';
  static const drinkUsedtoText = 'เคยดื่มแต่เลิกแล้ว';
  static const drinkNeverText = 'ไม่ดื่มแอลกอฮอล์';
  static const usernameText = 'ชื่อผู้ใช้';
  static const genderMaleText = 'ชาย';
  static const genderFemaleText = 'หญิง';
  static const healthDataText = 'ข้อมูลสุขภาพ';
  static const personalDataText = 'ข้อมูลส่วนตัว';
  static const yearOfBirthText = 'ปีเกิด';
  static const highText = 'ส่วนสูง';
  static const weightText = 'น้ำหนัก';
  static const ifYouKnowText =
      'หากทราบข้อมูล โปรดระบุเพื่อผลลัพธ์ที่แม่นยำยิ่งขึ้น';

  static const systolicBloodPressureText = 'ความดันโลหิตขณะบีบตัว';
  static const diastolicBloodPressureText = 'ความดันโลหิตขณะคลายตัว';
  static const hdlText = 'คอเลสเตอรอลชนิดดี (HDL)';
  static const ldlText = 'คอเลสเตอรอลชนิดไม่ดี (LDL)';
  static const waistLineText = 'รอบเอว';

  static const suffixMillimetersText = 'มิลลิเมตรปรอท';
  static const suffixcmText = 'ซม.';
  static const suffixkgText = 'กก.';
  static const suffixmgPerdLText = 'มก./ดล.';
  static const goalMuscleText = 'สร้างกล้ามเนื้อ';
  static const goalHealthyText = 'สุขภาพดี';
  static const goalLoseweightText = 'ลดน้ำหนัก';

  static const progressText = 'ความคืบหน้า';
  static const challengeText = 'พิสูจน์ฝีมือ';
  static const healthdataText = 'ข้อมูลสุขภาพประจำสัปดาห์';

  static const seeMissionText = 'ดูภารกิจ';
  static const continueMissionText = 'ทำต่อ';

  static const stepText = 'ก้าวเดิน';
  static const exerciseText = 'ออกกำลังกาย';
  static const gotoAssessmentPageText = 'เข้าสู่หน้าประเมิน';
  static const timeToAssessmentText = 'ถึงเวลาประเมินสุขภาพอีกครั้ง';
  static const howMuchHaveYouChangedText = 'คุณเปลี่ยนแปลงไปมากแค่ไหนกันนะ?';

  static const resultThisWeekText = 'สรุปผลสัปดาห์ที่ผ่านมา';
  static const greatjobText = 'สุดยอดไปเลย! สัปดาห์นี้ไปกันต่อ~';

  static const noNotiText = 'ยังไม่มีการแจ้งเตือน';
  static const weightAndWaistReAssessmentText = 'อันดับแรก มาเช็กหุ่นกันหน่อย!';
  static const pressureReAssessmentText =
      'มาต่อกันที่ความดัน เดือนนี้เป็นไงบ้าง?';
  static const fatReAssessmentText = 'แล้วระดับไขมันของคุณโอเคไหม?';
  static const nextTimeFieldText = 'ไว้กรอกทีหลัง';
}
