import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app/core/routes/app_pages.dart';
import 'package:shoply_app/core/utils/widgets/cached_image_network/custom_cached_image.dart';
import 'package:shoply_app/core/utils/widgets/loading/custom_loading_data.dart';
import 'package:shoply_app/core/utils/widgets/refresh_indicator/custom_refresh_indicator.dart';
import 'package:shoply_app/core/utils/widgets/view_all/custom_view_all.dart';
import 'package:shoply_app/features/home/view_model/cubit.dart';
import 'package:shoply_app/features/home/view_model/state.dart';
import 'package:shoply_app/core/utils/widgets/responsive/responsive.dart';
import 'package:shoply_app/features/main/view_model/cubit.dart';
part 'widgets/home_sales.dart';
part 'widgets/home_categories.dart';
part 'widgets/home_trending_products.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getHome(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final cubit = context.read<HomeCubit>();

          if (state is HomeLoadingState) {
            return CustomLoadingData();
          } else if (state is HomeErrorState) {
            return Center(
              child: Text(state.errorMessage, textAlign: TextAlign.center),
            );
          }

          final isTablet = Responsive.isTablet(context);

          return CustomRefreshIndicator(
            onRefresh: () async {
              await cubit.refreshData();
            },
            child: SingleChildScrollView(
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: isTablet ? 1000 : double.infinity,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Responsive.width(isTablet ? 24 : 16),
                    ),
                    child: Column(
                      children: [
                        _HomeSales(),
                        SizedBox(height: Responsive.height(20)),
                        _HomeCategories(),
                        SizedBox(height: Responsive.height(20)),
                        _HomeTrendingProducts(),
                        SizedBox(height: Responsive.height(20)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
