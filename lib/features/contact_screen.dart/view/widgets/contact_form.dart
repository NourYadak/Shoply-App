part of '../contact_screen.dart';

class _ContactForm extends StatelessWidget {
  const _ContactForm({
    required this.fullNameController,
    required this.emailController,
    required this.messageController,
    required this.subjects,
    required this.selectedSubject,
    required this.onSubjectChanged,
    required this.onSend,
  });

  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController messageController;
  final List<String> subjects;
  final String? selectedSubject;
  final ValueChanged<String?> onSubjectChanged;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    final isTablet = Responsive.isTablet(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomTextField(
          controller: fullNameController,
          hinText: 'Full Name',
          prefixIcon: Icon(
            Icons.person_outline,
            size: Responsive.width(isTablet ? 28 : 24),
            color: Colors.grey.shade800,
          ),
          validator: (value) {
            if (value?.trim().isEmpty ?? true) {
              return 'Full name is required';
            }
            return null;
          },
        ),

        SizedBox(height: Responsive.height(5)),

        CustomTextField(
          controller: emailController,
          hinText: 'Email Address',
          prefixIcon: Icon(
            Icons.email_outlined,
            size: Responsive.width(isTablet ? 28 : 24),
            color: Colors.grey.shade800,
          ),
          validator: (value) {
            final email = value?.trim() ?? '';

            if (email.isEmpty) {
              return 'Email is required';
            }

            if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email)) {
              return 'Please enter a valid email';
            }

            return null;
          },
        ),

        SizedBox(height: Responsive.height(5)),

        DropdownButtonFormField<String>(
          value: selectedSubject,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          style: TextStyle(
            fontFamily: 'quickSand',
            fontWeight: FontWeight.w500,
            fontSize: Responsive.font(isTablet ? 16 : 14),
            color: Colors.grey.shade600,
          ),
          decoration: InputDecoration(
            hintText: 'Choose a subject',
            hintStyle: TextStyle(
              color: Colors.grey.shade600,
              fontSize: Responsive.font(isTablet ? 16 : 14),
              fontFamily: 'quicksand',
            ),
            prefixIcon: Icon(
              Icons.subject_rounded,
              size: Responsive.width(isTablet ? 28 : 24),
              color: Colors.grey.shade800,
            ),
            filled: true,
            fillColor: Colors.grey.shade300.withValues(alpha: 0.5),

            contentPadding: EdgeInsets.symmetric(
              horizontal: Responsive.width(14),
              vertical: Responsive.height(isTablet ? 20 : 16),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Responsive.radius(14)),
              borderSide: const BorderSide(color: Color(0xFFE0E5E0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Responsive.radius(14)),
              borderSide: const BorderSide(color: Color(0xFFE0E5E0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
          ),
          items: subjects.map((subject) {
            return DropdownMenuItem<String>(
              value: subject,
              child: Text(subject, overflow: TextOverflow.ellipsis),
            );
          }).toList(),
          onChanged: onSubjectChanged,
        ),

        SizedBox(height: Responsive.height(14)),

        TextFormField(
          controller: messageController,
          minLines: isTablet ? 6 : 5,
          maxLines: isTablet ? 8 : 7,
          style: TextStyle(
            fontSize: Responsive.font(isTablet ? 16 : 14),
            fontFamily: 'quickSand',
          ),
          decoration: InputDecoration(
            hintText: 'Write your message here...',
            hintStyle: TextStyle(
              fontWeight: FontWeight.w500,

              fontSize: Responsive.font(isTablet ? 16 : 14),
              fontFamily: 'quickSand',
              color: Colors.grey.shade600,
            ),
            alignLabelWithHint: true,
            prefixIcon: Padding(
              padding: EdgeInsets.only(bottom: Responsive.height(80)),

              child: Icon(
                Icons.message_outlined,
                size: Responsive.width(isTablet ? 28 : 24),
                color: Colors.grey.shade800,
              ),
            ),
            filled: true,
            fillColor: Colors.grey.shade300.withValues(alpha: 0.5),

            contentPadding: EdgeInsets.all(Responsive.width(16)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Responsive.radius(14)),
              borderSide: const BorderSide(color: Color(0xFFE0E5E0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Responsive.radius(14)),
              borderSide: const BorderSide(color: Color(0xFFE0E5E0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
          ),
          validator: (value) {
            if (value?.trim().isEmpty ?? true) {
              return 'Message is required';
            }

            if (value!.trim().length < 10) {
              return 'Message must be at least 10 characters';
            }

            return null;
          },
        ),

        SizedBox(height: Responsive.height(isTablet ? 24 : 20)),

        SizedBox(
          height: Responsive.height(isTablet ? 60 : 54),
          width: Responsive.height(isTablet ? 400 : 350),
          child: ElevatedButton.icon(
            onPressed: onSend,

            label: Text(
              'Send Message',
              style: TextStyle(
                fontSize: Responsive.font(isTablet ? 18 : 16),
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF218C61),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Responsive.radius(14)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
