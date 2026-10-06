part of '../on_boarding_screen.dart';

class _OnBoardingFooter extends StatelessWidget {
  const _OnBoardingFooter();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
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
                SizedBox(height: 55),
                Column(
                  children: [
                    CustomButton(
                      buttonText: cubit.index != 2 ? 'Next' : 'Get Started',
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
                    SizedBox(height: 20),
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