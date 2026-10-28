part of '../on_boarding_screen.dart';

class _OnBoardingHeader extends StatelessWidget {
  const _OnBoardingHeader();

  @override
  Widget build(BuildContext context) {
    final isTablet = Responsive.isTablet(context);

    return Expanded(
      flex: 2,
      child: BlocBuilder<OnBoardingCubit, OnBoardingState>(
        buildWhen: (previous, current) {
          return current is! OnBoardingChangeIndexState;
        },
        builder: (context, state) {
          final cubit = context.read<OnBoardingCubit>();

          return PageView.builder(
            onPageChanged: (index) {
              cubit.changeIndex(newIndex: index);
            },
            controller: cubit.pageController,
            itemCount: 3,
            itemBuilder: (context, index) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Responsive.width(isTablet ? 40 : 20),
                          vertical: Responsive.height(8),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage(cubit.onBoardingImage[index]),
                              height: Responsive.height(isTablet ? 380 : 280),
                              width: double.infinity,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(height: Responsive.height(16)),
                            Text(
                              cubit.onBoardingTitle[index],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: Responsive.font(isTablet ? 30 : 25),
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: Responsive.height(10)),
                            Text(
                              cubit.onBoardingDescription[index],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: Responsive.font(isTablet ? 18 : 15),
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
