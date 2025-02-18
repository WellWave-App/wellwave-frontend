class ExerciseTrendTracker {
  void getExerciseTrend(List<int> data) {
    if (data.length < 8) {
      print("ข้อมูลไม่เพียงพอ ต้องมีอย่างน้อย 8 ตัวเลข");
      return;
    }

    String currentTrend =
        ""; // ตัวแปรที่จะเก็บแนวโน้มปัจจุบัน ("up" หรือ "down")
    List<int> streakValues = [data[0]]; // เก็บค่าของช่วงที่ต่อเนื่อง
    int streakCount = 1; // จำนวนสัปดาห์ในช่วงที่ต่อเนื่อง
    List<String> results = []; // รายการผลลัพธ์ที่เก็บทุกช่วง

    for (int i = 1; i < data.length; i++) {
      if (data[i] > data[i - 1]) {
        // แนวโน้มเพิ่มขึ้น
        if (currentTrend == "down") {
          // หากก่อนหน้านี้ลดลง แล้วตอนนี้เพิ่มขึ้น
          results.add(
              "ลดลงติดต่อกัน $streakCount สัปดาห์ (${streakValues.join(', ')})");
          streakValues = [data[i - 1]]; // เริ่มนับใหม่จากตัวก่อนหน้า
          streakCount = 1;
          results.add("สัปดาห์นี้เพิ่มขึ้น (ค่าตัวเลขคือ ${data[i]})");
          currentTrend = "up";
        } else if (currentTrend == "up") {
          // หากแนวโน้มยังเพิ่มขึ้น
          streakValues.add(data[i]);
          streakCount++;
        } else {
          // หากยังไม่กำหนดแนวโน้ม (กรณีแรก)
          currentTrend = "up";
          streakValues.add(data[i]);
          streakCount++;
        }
      } else if (data[i] < data[i - 1]) {
        // แนวโน้มลดลง
        if (currentTrend == "up") {
          // หากก่อนหน้านี้เพิ่มขึ้น แล้วตอนนี้ลดลง
          results.add(
              "เพิ่มขึ้นติดต่อกัน $streakCount สัปดาห์ (${streakValues.join(', ')})");
          streakValues = [data[i - 1]]; // เริ่มนับใหม่จากตัวก่อนหน้า
          streakCount = 1;
          results.add("สัปดาห์นี้ลดลง (ค่าตัวเลขคือ ${data[i]})");
          currentTrend = "down";
        } else if (currentTrend == "down") {
          // หากแนวโน้มยังลดลง
          streakValues.add(data[i]);
          streakCount++;
        } else {
          // หากยังไม่กำหนดแนวโน้ม (กรณีแรก)
          currentTrend = "down";
          streakValues.add(data[i]);
          streakCount++;
        }
      } else {
        // ค่าคงที่
        streakValues.add(data[i]);
        streakCount++;
      }

      // เมื่อถึงค่าข้อมูลสุดท้าย ให้พิมพ์ผลลัพธ์ช่วงนั้น
      if (i == data.length - 1) {
        if (currentTrend == "up") {
          if (streakCount == 1) {
            results.add(
                "สัปดาห์นี้เพิ่มขึ้น (ค่าตัวเลขคือ ${streakValues.join(', ')})");
          } else {
            results.add(
                "เพิ่มขึ้นติดต่อกัน $streakCount สัปดาห์ (${streakValues.join(', ')})");
          }
        } else if (currentTrend == "down") {
          if (streakCount == 1) {
            results.add(
                "สัปดาห์นี้ลดลง (ค่าตัวเลขคือ ${streakValues.join(', ')})");
          } else {
            results.add(
                "ลดลงติดต่อกัน $streakCount สัปดาห์ (${streakValues.join(', ')})");
          }
        }
      }
    }

    // แสดงผลลัพธ์ทั้งหมด
    for (String result in results) {
      print(result);
    }
  }
}
