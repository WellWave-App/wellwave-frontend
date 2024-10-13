import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('สมัครสมาชิก')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                  hintText: 'ชื่อ', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                  hintText: 'อีเมล', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                  hintText: 'รหัสผ่าน', border: OutlineInputBorder()),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle registration
              },
              child: const Text('สมัครสมาชิก'),
            ),
            TextButton(
              onPressed: () {
                // Handle Google registration
              },
              child: const Text('สมัครสมาชิกด้วย Google'),
            ),
          ],
        ),
      ),
    );
  }
}
