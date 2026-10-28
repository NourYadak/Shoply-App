part of '../../main_screen.dart';

class _MainDrawer extends StatelessWidget {
  const _MainDrawer();

  @override
  Widget build(BuildContext context) {
    final isTablet = Responsive.isTablet(context);
    final cubit = context.read<MainCubit>();
    return Drawer(
      width: Responsive.width(
        isTablet ? 400 : 330,
      ).clamp(0.0, MediaQuery.sizeOf(context).width * 0.85),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.width(isTablet ? 16 : 8),
          ),
          child: Column(
            children: [
              SizedBox(height: Responsive.height(15)),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 14),
                  Container(
                    height: Responsive.width(isTablet ? 110 : 85),
                    width: Responsive.width(isTablet ? 110 : 85),
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: CustomCachedImageNetwork(
                      errorWidget: Image(
                        image: AssetImage(AppImages.profilePicture),
                        fit: BoxFit.cover,
                      ),
                      image: LocalStorageUser.instance.profileImage,
                      fit: BoxFit.cover,
                    ),
                  ),

                  SizedBox(width: Responsive.width(12)),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocalStorageUser.instance.fullName,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: Responsive.font(isTablet ? 20 : 17),
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(height: Responsive.height(6)),
                        Text(
                          LocalStorageUser.instance.email,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: Responsive.font(isTablet ? 16 : 14),
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: Responsive.height(10)),

              const Divider(thickness: 0.1, color: Colors.grey),

              CustomListTile(
                iconData: Icons.language_outlined,
                title: LocaleKeys.Language_language.tr(),

                onTap: () {
                  Navigator.pushNamed(context, AppPages.languageScreen);
                },
              ),

              SizedBox(height: Responsive.height(20)),

              CustomListTile(
                iconData: Icons.shopping_bag_outlined,
                title: LocaleKeys.Language_myOrders.tr(),
                onTap: () {
                  Navigator.pushNamed(context, AppPages.ordersScreen);
                },
              ),

              SizedBox(height: Responsive.height(20)),

              CustomListTile(
                iconData: Icons.settings_outlined,
                title: LocaleKeys.Language_setting.tr(),

                onTap: () {
                  Navigator.pushNamed(context, AppPages.settingsScreen);
                },
              ),

              SizedBox(height: Responsive.height(20)),

              CustomListTile(
                iconData: Icons.dark_mode_outlined,
                title: LocaleKeys.Language_theme.tr(),

                onTap: () {
                  Navigator.pushNamed(context, AppPages.themeScreen);
                },
              ),

              SizedBox(height: Responsive.height(20)),

              CustomListTile(
                iconData: Icons.info_outline,
                title: LocaleKeys.Language_about.tr(),

                onTap: () {
                  Navigator.pushNamed(context, AppPages.aboutScreen);
                },
              ),

              const Spacer(),

              // CustomListTile(
              //   iconData: Icons.logout,
              //   title: 'Logout',
              //   color: Colors.red,
              // ),
              CustomListTile(
                onTap: () {
                  CustomDialog.showCustomProDialog(
                    context: context,
                    title: LocaleKeys.Language_logout.tr(),
                    description: LocaleKeys.Language_logoutMessage.tr(),
                    dialogType: DialogType.error,
                    iconBackgroundColor: Colors.red,
                    iconColor: Colors.white,
                    icon: Icons.logout,
                    buttons: [
                      DialogButton(
                        text: LocaleKeys.Language_cancel.tr(),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      DialogButton(
                        text: LocaleKeys.Language_logout.tr(),
                        isPrimary: true,
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            AppPages.loginScreen,
                            (route) => false,
                          );
                          cubit.logout();
                        },
                      ),
                    ],
                  );
                },

                iconData: Icons.logout,
                title: LocaleKeys.Language_logout.tr(),

                color: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
