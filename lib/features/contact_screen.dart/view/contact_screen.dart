import 'package:flutter/material.dart';
import 'package:shoply_app/core/utils/widgets/responsive/responsive.dart';
import 'package:shoply_app/core/utils/widgets/textField/custom_textfield.dart';

part 'widgets/contact_header.dart';
part 'widgets/contact_form.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final _formKey = GlobalKey<FormState>();

  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  String? _selectedSubject;

  final List<String> _subjects = [
    'Order Inquiry',
    'Payment Issue',
    'Shipping & Delivery',
    'Returns & Refunds',
    'Product Information',
    'Other',
  ];

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedSubject == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please choose a subject')));
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Your message is ready! Email sending is not connected yet.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = Responsive.isTablet(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Contact Us',
          style: TextStyle(
            fontSize: Responsive.font(isTablet ? 23 : 20),
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.width(isTablet ? 32 : 16),
            vertical: Responsive.height(isTablet ? 20 : 12),
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: isTablet ? 600 : double.infinity,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const _ContactHeader(),

                    SizedBox(height: Responsive.height(isTablet ? 32 : 24)),

                    _ContactForm(
                      fullNameController: _fullNameController,
                      emailController: _emailController,
                      messageController: _messageController,
                      subjects: _subjects,
                      selectedSubject: _selectedSubject,
                      onSubjectChanged: (value) {
                        setState(() {
                          _selectedSubject = value;
                        });
                      },
                      onSend: _sendMessage,
                    ),

                    SizedBox(height: Responsive.height(16)),

                    // Text(
                    //   'Made for better shopping ♥',
                    //   textAlign: TextAlign.center,
                    //   style: TextStyle(
                    //     fontSize: Responsive.font(isTablet ? 16 : 13),
                    //     color: Colors.grey.shade500,
                    //     fontWeight: FontWeight.w500,
                    //   ),
                    // ),
                    SizedBox(height: Responsive.height(16)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
