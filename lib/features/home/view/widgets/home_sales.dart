part of '../home_screen.dart';

class _HomeSales extends StatelessWidget {
  const _HomeSales();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    final isTablet = Responsive.isTablet(context);

    return Container(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.symmetric(horizontal: Responsive.width(10)),
      height: Responsive.height(isTablet ? 260 : 170),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Responsive.radius(12)),
      ),
      child: CustomCachedImageNetwork(
        fit: BoxFit.contain,
        image: cubit.responseSales?.image ?? '',
      ),
    );
  }
}
