import 'package:flutter/material.dart';
import 'package:shoply_app/core/utils/theme/app_colors.dart';
import 'package:shoply_app/core/utils/widgets/responsive/responsive.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.buttonText,
    this.style,
    this.onPressed,
  });

  final String buttonText;
  final TextStyle? style;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Responsive.height(55),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Responsive.radius(18)),
          ),
          backgroundColor: AppColors.primaryColor,
          padding: EdgeInsets.symmetric(horizontal: Responsive.width(16)),
        ),
        child: Text(
          buttonText,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style:
              style ??
              TextStyle(
                fontSize: Responsive.font(20),
                color: AppColors.onPrimary,
                fontWeight: FontWeight.w700,
              ),
        ),
      ),
    );
  }
}
