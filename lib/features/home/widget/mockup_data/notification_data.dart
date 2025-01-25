import 'package:wellwave_frontend/config/constants/app_pages.dart';
import 'package:wellwave_frontend/features/home/data/models/notifications.dart';

final List<Map<String, dynamic>> notificationsMockData = [
  {
    "id": 1,
    "image": "AppImages.fireIcon",
    "message": "คุณได้ก้าวสู่สัปดาห์ที่สมบูรณ์แบบระดับ 2!",
    "route": AppPages.friendName,
    "isRead": false
  },
  {
    "id": 2,
    "image": "AppImages.fireIcon",
    "message": "สกาย ทักทายคุณ",
    "route": AppPages.friendName,
    "isRead": false
  },
  {
    "id": 3,
    "image": "AppImages.fireIcon",
    "message": "สกาย ทักทายคุณ",
    "route": AppPages.friendName,
    "isRead": true
  },
  {
    "id": 4,
    "image": "AppImages.fireIcon",
    "message": "คุณได้รับคะแนนสะสม 100 คะแนน",
    "route": AppPages.friendName,
    "isRead": false
  },
  {
    "id": 5,
    "image": "AppImages.fireIcon",
    "message": "กิจกรรมใหม่: วิ่ง 5K เพื่อสุขภาพ",
    "route": AppPages.friendName,
    "isRead": true
  },
  {
    "id": 6,
    "image": "AppImages.fireIcon",
    "message": "คุณได้เลื่อนระดับเป็น Bronze Member",
    "route": AppPages.friendName,
    "isRead": false
  },
  {
    "id": 7,
    "image": "AppImages.fireIcon",
    "message": "โปรโมชั่นพิเศษสำหรับสมาชิกเท่านั้น",
    "route": AppPages.friendName,
    "isRead": true
  },
  {
    "id": 8,
    "image": "AppImages.fireIcon",
    "message": "คุณมี 1 ข้อความที่ยังไม่ได้อ่าน",
    "route": AppPages.friendName,
    "isRead": false
  },
  {
    "id": 9,
    "image": "AppImages.fireIcon",
    "message": "กิจกรรมประจำสัปดาห์เริ่มแล้ว!",
    "route": AppPages.friendName,
    "isRead": true
  },
  {
    "id": 10,
    "image": "AppImages.fireIcon",
    "message": "คุณได้คะแนนโบนัส 50 คะแนน",
    "route": AppPages.friendName,
    "isRead": false
  },
  {
    "id": 11,
    "image": "AppImages.fireIcon",
    "message": "ยินดีต้อนรับสู่แอปพลิเคชันใหม่ของเรา",
    "route": AppPages.friendName,
    "isRead": true
  },
  {
    "id": 12,
    "image": "AppImages.fireIcon",
    "message": "คุณได้เข้าร่วมกิจกรรมวิ่งมาราธอน",
    "route": AppPages.friendName,
    "isRead": false
  },
  {
    "id": 13,
    "image": "AppImages.fireIcon",
    "message": "โปรดตรวจสอบโปรไฟล์ของคุณ",
    "route": AppPages.friendName,
    "isRead": true
  },
  {
    "id": 14,
    "image": "AppImages.fireIcon",
    "message": "คุณมี 3 กิจกรรมที่รอการยืนยัน",
    "route": AppPages.friendName,
    "isRead": false
  },
  {
    "id": 15,
    "image": "AppImages.fireIcon",
    "message": "กิจกรรมใหม่: ปั่นจักรยานเพื่อสิ่งแวดล้อม",
    "route": AppPages.friendName,
    "isRead": true
  },
  {
    "id": 16,
    "image": "AppImages.fireIcon",
    "message": "คุณได้คะแนนสะสม 200 คะแนน",
    "route": AppPages.friendName,
    "isRead": false
  },
  {
    "id": 17,
    "image": "AppImages.fireIcon",
    "message": "โปรดอัปเดตข้อมูลส่วนตัวของคุณ",
    "route": AppPages.friendName,
    "isRead": true
  },
  {
    "id": 18,
    "image": "AppImages.fireIcon",
    "message": "คุณได้เข้าร่วมกิจกรรมเดินเพื่อสุขภาพ",
    "route": AppPages.friendName,
    "isRead": false
  },
  {
    "id": 19,
    "image": "AppImages.fireIcon",
    "message": "กิจกรรมใหม่: ว่ายน้ำเพื่อสุขภาพ",
    "route": AppPages.friendName,
    "isRead": true
  },
  {
    "id": 20,
    "image": "AppImages.fireIcon",
    "message": "friendName",
    "route": AppPages.friendName,
    "isRead": false
  },
];

List<Notifications> getMockNotificationsData() {
  return notificationsMockData
      .map((data) => Notifications.fromJson(data))
      .toList();
}
