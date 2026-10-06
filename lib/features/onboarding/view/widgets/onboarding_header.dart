part of '../on_boarding_screen.dart';


class _OnBoardingHeader extends StatelessWidget {
  const _OnBoardingHeader();

  @override
  Widget build(BuildContext context) {
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
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage(cubit.onBoardingImage[index]),
                      height: 420,
                      width: double.infinity,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      cubit.onBoardingTitle[index],
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      cubit.onBoardingDescription[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade600,
                      ),
                                            

                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
