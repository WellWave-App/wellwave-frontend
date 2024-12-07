import 'package:flutter/material.dart';

class ArticleDetailScreen extends StatelessWidget {
  const ArticleDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          
          Image.network(
            'https://cdn.discordapp.com/attachments/1139256680174067827/1314853868353359922/IMG_1957.jpg?ex=67554897&is=6753f717&hm=d7ca051176f641e2e7119fcf4218d411fbd965883f06cc4a1a26deb09cac618c&',
            width: double.infinity,
            height: 250,
            fit: BoxFit.cover,
          ),

          
          Align(
            alignment: Alignment.topCenter, 
            child: Container(
              margin: EdgeInsets.only(top: 230), 
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  

                  SizedBox(height: 16),
                  Text(
                    'title title title title title title title title title title',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.menu_book_rounded,
                          size: 20, color: Colors.grey),
                      SizedBox(width: 4),
                      Text(
                        'readingTime',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'ภาวะเมทาบอลิกซินโดรม (Metabolic Syndrome) คือ ภาวะที่เกิดจากระบบการเผาผลาญของร่างกาย ทำงานผิดปกติไป ทำให้เกิดภาวะอ้วนลงพุง น้ำหนักตัวเกิน น้ำตาลในเลือดสูง ความดันโลหิตสูง และไขมันในเลือดสูง ซึ่งภาวะต่างๆ เหล่านี้ เมื่อเป็นนานๆ เข้าก็จะส่งผลให้เกิดโรคหลอดเลือดหัวใจ กล้ามเนื้อหัวใจขาดเลือด โรคหลอดเลือดสมองที่ทำให้เป็นอัมพฤกษ์ อัมพาต ตามมาได้ภาวะอ้วนลงพุง (Central Obesity) คือการที่ร่างกายมีไขมันสะสมบริเวณช่องท้องมากขึ้น ซึ่งไขมันเหล่านี้จะทำให้เกิดปฏิกิริยาการอักเสบ ความสมดุลของฮอร์โมนผิดปกติ และเกิดภาวะดื้อต่ออินซูลิน (Insulin Resistance) เมื่อการออกฤทธิ์ของอินซูลินทำได้ไม่ดี จึงมีน้ำตาลสะสมในเลือดสูง และทำให้เป็นโรคเบาหวานได้ในที่สุด',
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),

          
          Positioned(
            top: 40,
            left: 8,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Positioned(
            top: 40,
            right: 48,
            child: IconButton(
              icon: Icon(Icons.bookmark_border, color: Colors.white),
              onPressed: () {
                
              },
            ),
          ),
          Positioned(
            top: 40,
            right: 16,
            child: IconButton(
              icon: Icon(Icons.share, color: Colors.white),
              onPressed: () {
                
              },
            ),
          ),
        ],
      ),
    );
  }
}
