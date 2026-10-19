import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app/core/routes/app_pages.dart';
import 'package:shoply_app/core/utils/widgets/appBar/app_bar.dart';
import 'package:shoply_app/core/utils/widgets/cached_image_network/custom_cached_image.dart';
import 'package:shoply_app/core/utils/widgets/loading/custom_loading_data.dart';
import 'package:shoply_app/core/utils/widgets/refresh_indicator/custom_refresh_indicator.dart';
import 'package:shoply_app/core/utils/widgets/responsive/responsive.dart';
import 'package:shoply_app/features/categories/view_model/cubit.dart';
import 'package:shoply_app/features/categories/view_model/state.dart';
import 'package:shoply_app/features/main/view_model/cubit.dart';

part 'widgets/categories_card.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isTablet = Responsive.isTablet(context);

    return BlocProvider(
      create: (context) => CategoriesCubit()..getCategories(),
      child: Scaffold(
        appBar: CustomAppBar(titleText: 'Categories'),
        body: BlocBuilder<CategoriesCubit, CategoriesState>(
          builder: (context, state) {
            final cubit = context.read<CategoriesCubit>();

            if (state is CategoriesLoadingState) {
              return const CustomLoadingData();
            } else if (state is CategoriesErrorState) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(Responsive.width(16)),
                  child: Text(
                    state.errorMessage,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: Responsive.font(16)),
                  ),
                ),
              );
            }

            return CustomRefreshIndicator(
              onRefresh: () async {
                await cubit.refreshCategories();
              },
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: isTablet ? 1000 : double.infinity,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Responsive.width(isTablet ? 24 : 12),
                    ),
                    child: _CategoriesCard(),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
