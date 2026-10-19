
part of '../on_boarding_screen.dart';

class _OnBoardingFooter extends StatelessWidget {
  const _OnBoardingFooter();

  @override
  Widget build(BuildContext context) {
    final isTablet = Responsive.isTablet(context);

    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.width(isTablet ? 40 : 24),
          vertical: Responsive.height(8),
        ),
        child: BlocBuilder<OnBoardingCubit, OnBoardingState>(
          buildWhen: (previous, current) {
            return current is OnBoardingChangeIndexState;
          },
          builder: (context, state) {
            final cubit = context.read<OnBoardingCubit>();

            return Column(
              children: [
                CustomSmoothIndicator(
                  pageController: cubit.pageController,
                  count: 3,
                ),
                SizedBox(
                  height: Responsive.height(isTablet ? 45 : 30),
                ),
                Column(
                  children: [
                    CustomButton(
                      buttonText: cubit.index != 2
                          ? 'Next'
                          : 'Get Started',
                      onPressed: cubit.index != 2
                          ? () {
                              cubit.nextPageController();
                            }
                          : () {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                AppPages.loginScreen,
                                (route) => false,
                              );
                              cubit.setShowOnBoarding();
                            },
                    ),
                    SizedBox(height: Responsive.height(12)),
                    if (cubit.index != 2)
                      CustomTextButton(
                        onTap: () {
                          cubit.skipOnBoarding();
                        },
                        textButton: 'Skip',
                      ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
