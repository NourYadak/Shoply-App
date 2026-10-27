import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app/core/regex/app_regex.dart';
import 'package:shoply_app/core/utils/images/app_images.dart';
import 'package:shoply_app/core/utils/theme/app_colors.dart';
import 'package:shoply_app/core/utils/widgets/appBar/app_bar.dart';
import 'package:shoply_app/core/utils/widgets/button/custom_button.dart';
import 'package:shoply_app/core/utils/widgets/dialog/custom_error.dart';
import 'package:shoply_app/core/utils/widgets/dialog/custom_success.dart';
import 'package:shoply_app/core/utils/widgets/loading/custom_loading.dart';
import 'package:shoply_app/core/utils/widgets/textField/custom_textfield.dart';
import 'package:shoply_app/core/utils/widgets/responsive/responsive.dart';
import 'package:shoply_app/features/update_profile/view_model/cubit.dart';
import 'package:shoply_app/features/update_profile/view_model/state.dart';

part 'widgets/update_profile_header.dart';
part 'widgets/update_profile_textfields.dart';
part 'widgets/update_profile_footer.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isTablet = Responsive.isTablet(context);

    return BlocProvider(
      create: (_) => UpdateProfileCubit()..init(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F8FA),
        appBar: const CustomAppBar(titleText: 'Update Profile'),
        body: BlocListener<UpdateProfileCubit, UpdateProfileState>(
          listener: (context, state) {
            if (state is UpdateProfileLoadingState) {
              CustomLoading.showDialogLoading(context: context);
            } else if (state is UpdateProfileErrorState) {
              Navigator.of(context, rootNavigator: true).pop();

              CustomDialogError.showProDialogError(
                context: context,
                title: 'Update Error',
                description: state.errorMessage,
                onPressed: () => Navigator.pop(context),
              );
            } else if (state is UpdateProfileSuccessState) {
              Navigator.of(context, rootNavigator: true).pop();

              CustomSuccessDialog.showProSuccessDialog(
                context: context,
                title: 'Success',
                description: state.successMessage,
                onPressed: () => Navigator.pop(context),
              );
            }
          },
          child: Builder(
            builder: (context) {
              final cubit = context.read<UpdateProfileCubit>();

              return SafeArea(
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: isTablet ? 650 : double.infinity,
                    ),
                    child: Form(
                      key: cubit.formKey,
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(
                          horizontal: Responsive.width(isTablet ? 28 : 16),
                          vertical: Responsive.height(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const _UpdateProfileHeader(),
                            SizedBox(height: Responsive.height(24)),

                            Container(
                              padding: EdgeInsets.all(
                                Responsive.width(isTablet ? 24 : 18),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                  Responsive.radius(20),
                                ),
                                border: Border.all(color: Colors.grey.shade200),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.03),
                                    blurRadius: 18,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: const _UpdateProfileTextfields(),
                            ),

                            SizedBox(height: Responsive.height(22)),
                            const _UpdateProfileFooter(),
                            SizedBox(height: Responsive.height(12)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
