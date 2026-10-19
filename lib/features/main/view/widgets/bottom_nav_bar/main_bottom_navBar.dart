part of '../../main_screen.dart';

class _MainBottomNavBar extends StatelessWidget {
  const _MainBottomNavBar();

  @override
  Widget build(BuildContext context) {
    final isTablet = Responsive.isTablet(context);

    return BlocBuilder<MainCubit, MainState>(
      buildWhen: (previous, current) {
        return current is MainChangeNavBarIndexState;
      },
      builder: (context, state) {
        final cubit = context.read<MainCubit>();

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Divider(height: 1, thickness: 0.4, color: Colors.grey),
            NavigationBar(
              height: Responsive.height(isTablet ? 85 : 75),
              selectedIndex: cubit.navBarIndex,
              onDestinationSelected: (index) {
                cubit.changeNavBarIndex(index: index);
              },
              indicatorShape: const CircleBorder(),
              labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
              destinations: [
                NavigationDestination(
                  icon: Icon(
                    Icons.home_outlined,
                    size: Responsive.width(isTablet ? 29 : 24),
                  ),
                  selectedIcon: Icon(
                    Icons.home,
                    size: Responsive.width(isTablet ? 29 : 24),
                  ),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(
                    Icons.favorite_border,
                    size: Responsive.width(isTablet ? 29 : 24),
                  ),
                  selectedIcon: Icon(
                    Icons.favorite,
                    size: Responsive.width(isTablet ? 29 : 24),
                  ),
                  label: 'Favorite',
                ),
                NavigationDestination(
                  icon: Icon(
                    Icons.shopping_bag_outlined,
                    size: Responsive.width(isTablet ? 29 : 24),
                  ),
                  selectedIcon: Icon(
                    Icons.shopping_bag,
                    size: Responsive.width(isTablet ? 29 : 24),
                  ),
                  label: 'Cart',
                ),
                NavigationDestination(
                  icon: Icon(
                    Icons.person_2_outlined,
                    size: Responsive.width(isTablet ? 29 : 24),
                  ),
                  selectedIcon: Icon(
                    Icons.person_2,
                    size: Responsive.width(isTablet ? 29 : 24),
                  ),
                  label: 'Profile',
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
