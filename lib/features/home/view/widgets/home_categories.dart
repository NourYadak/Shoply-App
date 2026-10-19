part of '../home_screen.dart';

class _HomeCategories extends StatelessWidget {
  const _HomeCategories();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    final isTablet = Responsive.isTablet(context);

    return Column(
      children: [
        CustomViewAll(
          text: 'Categories',
          onTapViewAll: () {
            final mainCubit = context.read<MainCubit>();

            Navigator.pushNamed(
              context,
              AppPages.categoriesScreen,
              arguments: {'mainCubit': mainCubit},
            );
          },
        ),
        SizedBox(
          height: Responsive.height(isTablet ? 200 : 170),
          child: ListView.separated(
            separatorBuilder: (context, index) {
              return SizedBox(width: Responsive.width(10));
            },
            scrollDirection: Axis.horizontal,
            itemCount: cubit.responseCategories.length,
            padding: EdgeInsets.symmetric(horizontal: Responsive.width(12)),
            itemBuilder: (context, index) {
              final categoryData = cubit.responseCategories[index];

              return GestureDetector(
                onTap: () {
                  final mainCubit = context.read<MainCubit>();
                  Navigator.pushNamed(
                    context,
                    AppPages.productsScreen,
                    arguments: {
                      'titleText': categoryData.name,
                      'categoryId': categoryData.id,
                      'mainCubit': mainCubit,
                    },
                  );
                },
                child: SizedBox(
                  width: Responsive.width(isTablet ? 170 : 150),
                  child: Column(
                    children: [
                      SizedBox(height: Responsive.height(12)),
                      Container(
                        width: Responsive.width(isTablet ? 150 : 130),
                        height: Responsive.height(isTablet ? 120 : 100),
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            Responsive.radius(16),
                          ),
                          color: Colors.grey.shade200,
                        ),
                        child: CustomCachedImageNetwork(
                          image: categoryData.image ?? '',
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: Responsive.height(8)),
                      Text(
                        categoryData.name ?? '',
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: Responsive.font(15),
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
