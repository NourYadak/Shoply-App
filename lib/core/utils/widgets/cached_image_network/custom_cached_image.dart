
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shoply_app/core/utils/theme/app_colors.dart';

class CustomCachedImageNetwork extends StatelessWidget {
  const CustomCachedImageNetwork({
    super.key,
    required this.image,
    this.errorWidget,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
  });

  final String image;
  final Widget? errorWidget;
  final BoxFit fit;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) => Center(
        child: CircularProgressIndicator(
          color: AppColors.primaryColor,
        ),
      ),
      errorWidget: (context, url, error) =>
          errorWidget ??
          Icon(
            Icons.error_outline,
            size: 28,
            color: AppColors.error,
          ),
    );
  }
}
