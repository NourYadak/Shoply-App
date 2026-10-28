import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    this.validator,
    required this.hinText,
    this.prefixIcon,
    this.obscureText,
  });
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String hinText;
  final Widget? prefixIcon;
  final bool? obscureText;

  @override
  State<CustomTextField> createState() => _MainTextFieldState();
}

class _MainTextFieldState extends State<CustomTextField> {
  bool? isHide;

  @override
  void initState() {
    isHide = widget.obscureText;
    super.initState();
  }

  void changeIsHide() {
    isHide = !(isHide ?? false);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isHide ?? false,
      controller: widget.controller,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).dividerColor,
      ),
      textInputAction: TextInputAction.next,
      validator: widget.validator,
      cursorColor: Theme.of(context).cardColor,
      decoration: InputDecoration(
        helperText: '',
        helperStyle: TextStyle(fontSize: 10),
        hintText: widget.hinText,
        hintStyle: TextStyle(
          color: Theme.of(context).dividerColor,
          fontSize: 14,
        ),
        suffixIcon: widget.obscureText == true
            ? GestureDetector(
                onTap: () {
                  changeIsHide();
                },
                child: isHide ?? false
                    ? Icon(
                        Icons.visibility_off_outlined,
                        size: 22,
                        color: Colors.grey.shade800,
                      )
                    : Icon(
                        Icons.visibility_outlined,
                        size: 22,
                        color: Colors.grey.shade800,
                      ),
              )
            : null,
        contentPadding: EdgeInsets.symmetric(vertical: 17, horizontal: 10),
        prefixIcon: widget.prefixIcon,
        fillColor: Theme.of(context).cardColor,
        filled: true,
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.red, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            width: 0.8,
            color: Theme.of(context).primaryColor,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
