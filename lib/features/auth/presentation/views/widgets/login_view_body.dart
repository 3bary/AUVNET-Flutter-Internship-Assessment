import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/utils/assets.dart';
import '../../../../home/presentation/views/home_view.dart';
import '../../view_model/auth_bloc/auth_bloc.dart';
import '../signup_view.dart';
import 'auth_button.dart';
import 'auth_input_field.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    context.read<AuthBloc>().add(AuthLoginRequested(email, password));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeView()),
          );
        } else if (state.status == AuthStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage ?? 'Login Failed')),
          );
        }
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              SizedBox(height: 60.h),
              Image.asset(
                kAppLogo,
                width: 336.w,
                height: 336.h,
                fit: BoxFit.contain,
              ),

              // Email Field
              AuthInputField(
                controller: _emailController,
                hintText: 'mail',
                icon: Icons.mail_outline,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
              ),

              SizedBox(height: 16.h),

              // Password Field
              AuthInputField(
                controller: _passwordController,
                hintText: 'password',
                icon: Icons.lock_outline,
                isPassword: true,
                isVisible: _isPasswordVisible,
                toggleVisibility: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _login(),
              ),
              SizedBox(height: 32.h),
              // Login Button
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  final isLoading = state.status == AuthStatus.loading;
                  return AuthButton(
                    width: double.infinity,
                    height: 56.h,
                    text: 'Log In',
                    onPressed: _login,
                    isLoading: isLoading,
                  );
                },
              ),

              SizedBox(height: 24.h),

              // Don't have an account
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const SignUpView()),
                  );
                },
                child: Text(
                  'Don\'t have an account? Sign up',
                  style: TextStyle(
                    color: const Color(0xFF2196F3),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }
}
