class AppStrings {
  static String uppercaseFirst(String text) {
    if (text.isEmpty) return text; // Handle empty string case
    return text[0].toUpperCase() + text.substring(1);
  }

  static const emptyText = '';
  static const errorShow = 'Error:';
  static const nextText = 'ถัดไป';
  static const skipText = 'ข้าม';
  static const enterText = 'เข้าสู่แอพ';

  static const metabolicSyndromeText = 'ภาวะเมตาบอลิกซินโดรม';
  static const metabolicDescriptionText =
      'คือ ภาวะที่เกิดจากระบบการเผาผลาญของร่างกาย ทำงานผิดปกติไป ทำให้เกิดการอ้วนลงพุง น้ำหนักตัว เกินมาตรฐาน น้ำตาลในเลือดสูง ความดันโลหิตสูง';
  static const metaEffectText = 'ผลกระทบของโรค';
  static const metaEffectDescriptionText =
      'ภาวะนี้ส่งผลกระทบต่อคุณภาพชีวิตของผู้ป่วยในหลากหลายด้าน เช่น ความเสี่ยงในการเกิดโรคหัวใจ และหลอดเลือด เนื่องจากทำให้หลอดเลือดแดงอุดตัน ';
  static const metaBehaviorText = 'การปรับพฤติกรรม';
  static const metaBehaviorDescriptionText =
      'โดยการรับประทานอาหารที่เหมาะสม ออกกำลังกายอย่างสม่ำเสมอ โดย WellWave จะเป็นตัวช่วยสำคัญในการปรับพฤติกรรมของคุณ ';

  static const iDoTodayText = 'วันนี้ทำอะไรดี?';
  static const chooseActivityText = 'เลือกกิจกรรมที่คุณต้องการทำได้เลย!';
  static const dailyTaskEnterText = 'ภารกิจ\nประจำวัน';
  static const habitChallengeEnterText = 'ภารกิจ\nปรับนิสัย';
  static const dailyTaskText = 'ภารกิจประจำวัน';
  static const habitChallengeText = 'ภารกิจปรับนิสัย';
  static const questText = 'เควส';
  static const historyText = 'ประวัติ';

  static const suggestText = 'แนะนำ';
  static const eatingText = 'การทานอาหาร';
  static const exerciseText = 'การออกกำลังกาย';
  static const sleepText = 'การนอน';

  static const taskInProgressText = 'ทำกิจกรรมนี้';
  static const taskDoing = 'กำลังทำกิจกรรม';
  static const taskCompletedText = 'ทำสำเร็จ';

  static const taskCompletedWithGemText = 'ทำภารกิจให้ครบเพื่อรับ ';
  static const startText = 'เริ่ม ';

  static const setGoalText = 'กำหนดเป้าหมายภารกิจ ';
  static const tellGoalText = 'บอกให้เรารู้ถึงเป้าหมายของคุณ ';
  static const  setDayText = 'จำนวนวัน ';
  static const setTimeText = 'จำนวนนาทีในแต่ละวัน ';
  static const confirmText = 'ยืนยัน ';
}
