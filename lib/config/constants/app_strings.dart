class AppStrings {
  static String uppercaseFirst(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  static const emptyText = '';
  static const baseUrl = 'http://10.0.2.2:3000';
  static const userNotFoundText = 'ไม่พบข้อมูลผู้ใช้';
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
  static const archeivementText = 'ความสำเร็จ';
  static const archeiveText = 'สำเร็จ';
  static const seeAllText = 'ดูทั้งหมด';
  static const dayText = 'วัน';
  static const googleConnectText = 'Google Connect';
  static const signOutText = 'ออกจากระบบ';
  static const rewardRedeemText = 'แลกรางวัล';
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
    AppStrings.bronzeLeaugeText,
    AppStrings.silverLeaugeText,
    AppStrings.goldLeaugeText,
    AppStrings.diamondLeaugeText,
    AppStrings.emeraldLeaugeText,
  ];

  //logs history screen
  static const healthHistoryText = 'ประวัติบันทึกสุขภาพ';
  static const sleepText = 'การนอน';
  static const stepText = 'ก้าว';
  static const stepWalkText = 'ก้าวเดิน';
  static const drinkText = 'ดื่มน้ำ';
  static const enterText = 'เข้าสู่แอพ';
  static const xdateText = 'วันที่';
  static const goodCriteria = 'ค่าตามเกณฑ์';
  static const aboveCriteria = 'ค่าเกินเกณฑ์';
  static const underCriteria = 'ค่าต่ำกว่าเกณฑ์';
}
