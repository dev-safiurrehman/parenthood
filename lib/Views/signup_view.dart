import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parenthood/Controllers/auth_controller.dart';

class SignupView extends GetWidget<AuthController> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(hintText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(hintText: 'Password'),
            ),
            ElevatedButton(
              onPressed: () {
                controller.createUser(emailController.text, passwordController.text);
              },
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
