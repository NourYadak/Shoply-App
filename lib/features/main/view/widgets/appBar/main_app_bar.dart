
part of '../../main_screen.dart';

class _MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _MainAppBar();

  @override
  Widget build(BuildContext context) {
    final isTablet = Responsive.isTablet(context);

    return CustomAppBar(
      title: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            'Shop',
            style: TextStyle(
              fontSize: Responsive.font(isTablet ? 30 : 25),
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontStyle: FontStyle.normal,
            ),
          ),
          Text(
            'ly',
            style: TextStyle(
              fontSize: Responsive.font(isTablet ? 30 : 25),
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
              fontStyle: FontStyle.normal,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
