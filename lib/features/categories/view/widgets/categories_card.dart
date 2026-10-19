part of '../categories_screen.dart';

class _CategoriesCard extends StatelessWidget {
  const _CategoriesCard();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CategoriesCubit>();
    final isTablet = Responsive.isTablet(context);

    return ListView.separated(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.width(isTablet ? 16 : 4),
        vertical: Responsive.height(10),
      ),
      separatorBuilder: (context, index) {
        return SizedBox(height: Responsive.height(12));
      },
      itemCount: cubit.ressponseCategories.length,
      itemBuilder: (context, index) {
        final categoriesData = cubit.ressponseCategories[index];

        return GestureDetector(
          onTap: () {
            final mainCubit = context.read<MainCubit>();
            Navigator.pushNamed(
              context,
              AppPages.productsScreen,
              arguments: {
                'titleText': categoriesData.name,
                'categoryId': categoriesData.id,
                'mainCubit': mainCubit,
              },
            );
          },
          child: Container(
            padding: EdgeInsets.all(Responsive.width(10)),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(Responsive.radius(16)),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(Responsive.radius(12)),
                  child: SizedBox(
                    width: Responsive.width(isTablet ? 120 : 90),
                    height: Responsive.height(isTablet ? 100 : 80),
                    child: CustomCachedImageNetwork(
                      image: categoriesData.image ?? '',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: Responsive.width(12)),
                Expanded(
                  child: Text(
                    categoriesData.name ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: Responsive.font(isTablet ? 22 : 18),
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(width: Responsive.width(8)),
                Icon(Icons.arrow_forward_ios, size: Responsive.width(18)),
                SizedBox(width: Responsive.width(6)),
              ],
            ),
          ),
        );
      },
    );
  }
}
