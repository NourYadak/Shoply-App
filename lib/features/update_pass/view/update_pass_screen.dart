// lib/features/update_pass_screen.dart/view/update_pass_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app/features/update_pass/view_model/cubit.dart';
import 'package:shoply_app/features/update_pass/view_model/state.dart';

class UpdatePassScreen extends StatelessWidget {
  const UpdatePassScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdatePassCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'Change Password',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: BlocConsumer<UpdatePassCubit, UpdatePassState>(
          listener: (context, state) {
            if (state is UpdatePassSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Password updated successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.pop(context);
            } else if (state is UpdatePassErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            final cubit = BlocProvider.of<UpdatePassCubit>(context);

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Form(
                key: cubit.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    // Lock Icon Header
                    CircleAvatar(
                      radius: 45,
                      backgroundColor: const Color(0xFFE8F5E9),
                      child: const Icon(
                        Icons.lock,
                        size: 45,
                        color: Color(0xFF0D5C3A),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Keep your account secure',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Update your password regularly\nto keep your account safe.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 25),

                    // Current Password
                    _buildPasswordField(
                      label: 'Current Password',
                      controller: cubit.currentPasswordController,
                      isObscure: cubit.isCurrentPasswordObscure,
                      onToggleVisibility: cubit.toggleCurrentPasswordVisibility,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter current password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // New Password
                    _buildPasswordField(
                      label: 'New Password',
                      controller: cubit.newPasswordController,
                      isObscure: cubit.isNewPasswordObscure,
                      onToggleVisibility: cubit.toggleNewPasswordVisibility,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter new password';
                        }
                        if (value.length < 8) {
                          return 'Password must be at least 8 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Confirm New Password
                    _buildPasswordField(
                      label: 'Confirm New Password',
                      controller: cubit.confirmPasswordController,
                      isObscure: cubit.isConfirmPasswordObscure,
                      onToggleVisibility: cubit.toggleConfirmPasswordVisibility,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != cubit.newPasswordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 8),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Use at least 8 characters.',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ), // مسافة صغيرة إضافية لتجنب تداخل المحتوى مع الـ Footer
                  ],
                ),
              ),
            );
          },
        ),
        // استخدام كلاس الفوتر المنفصل وتثبيته أسفل الشاشة
        bottomNavigationBar: const UpdatePassFooter(),
      ),
    );
  }

  Widget _buildPasswordField({
    required String label,
    required TextEditingController controller,
    required bool isObscure,
    required VoidCallback onToggleVisibility,
    required String? Function(String?) validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          obscureText: isObscure,
          validator: validator,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFF5F5F5),
            prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey),
            suffixIcon: IconButton(
              icon: Icon(
                isObscure
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: Colors.grey,
              ),
              onPressed: onToggleVisibility,
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------
// كلاس الفوتر (Footer Widget) المنفصل الخاص بالزر
// ---------------------------------------------------------
class UpdatePassFooter extends StatelessWidget {
  const UpdatePassFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // نحصل على الـ Cubit للتحقق من حالة التحميل (Loading) واستدعاء دالة التحديث
    final cubit = BlocProvider.of<UpdatePassCubit>(context);

    return BlocBuilder<UpdatePassCubit, UpdatePassState>(
      builder: (context, state) {
        final isLoading = state is UpdatePassLoadingState;

        return Container(
          padding: const EdgeInsets.fromLTRB(
            20,
            10,
            20,
            50,
          ), // مسافات داخلية مع مراعاة أمان الشاشة من الأسفل
          color: Colors.white,
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0D5C3A),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: isLoading ? null : () => cubit.updatePassword(),
              child: isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text(
                      'Update Password',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}
