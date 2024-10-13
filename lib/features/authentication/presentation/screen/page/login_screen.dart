import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo.png'), // Replace with your logo
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                hintText: 'อีเมล',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                hintText: 'รหัสผ่าน',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.visibility),
                  onPressed: () {},
                ),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle login
              },
              child: const Text('เข้าสู่ระบบ'),
            ),
            TextButton(
              onPressed: () {
                context.go('/register'); // Navigate to register screen
              },
              child: const Text('สมัครสมาชิก'),
            ),
            TextButton(
              onPressed: () {
                // Handle Google login
              },
              child: const Text('ลงชื่อเข้าใช้ด้วย Google'),
            ),
          ],
        ),
      ),
    );
  }
}
