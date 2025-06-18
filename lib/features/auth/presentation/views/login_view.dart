import 'package:auvnet_app/features/auth/presentation/views/signup_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/assets.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0.w),
          child: Column(
            children: [
              SizedBox(height: 80.h),
              Image.asset(kAppLogo, width: 336.w, height: 336.h),
              // Input Fields
              _buildInputField(
                controller: _emailController,
                hintText: 'mail',
                icon: Icons.mail_outline,
              ),

              SizedBox(height: 16.h),

              _buildInputField(
                controller: _passwordController,
                hintText: 'password',
                icon: Icons.lock_outline,
                isPassword: true,
              ),

              SizedBox(height: 32.h),

              // Login Button
              SizedBox(
                width: double.infinity,
                height: 56.h,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle login logic here
                    print('Email: ${_emailController.text}');
                    print('Password: ${_passwordController.text}');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8A2BE2),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Log in',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 24.h),

              // Create Account Link
              TextButton(
                onPressed: () {
                  // Handle create account navigation
                  print('Navigate to create account');
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignUpView()),
                  );
                },
                child: Text(
                  'Create an account',
                  style: TextStyle(
                    color: Color(0xFF2196F3),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              const Spacer(flex: 1),

              // Bottom indicator (home indicator simulation)
              Container(
                width: 134.w,
                height: 5.h,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(2.5.r),
                ),
              ),

              SizedBox(height: 8.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool isPassword = false,
  }) {
    return Container(
      height: 56.h,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword && !_isPasswordVisible,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[600], fontSize: 16.sp),
          prefixIcon: Icon(icon, color: Colors.grey[600], size: 22.sp),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.grey[600],
                    size: 22.sp,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                )
              : null,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.h,
            vertical: 16.w,
          ),
        ),
      ),
    );
  }
}
