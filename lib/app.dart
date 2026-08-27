import 'package:device_preview/device_preview.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:you_app/core/theme/app_colors.dart';
import 'core/constants/api_constants.dart';
import 'core/constants/cache_keys.dart';
import 'core/helpers/cache_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'core/constants/api_constants.dart';
import 'core/constants/cache_keys.dart';
import 'core/helpers/cache_helper.dart';
import 'core/routing/router.dart';
import 'core/theme/app_theme.dart';

class ElectroLinkApp extends StatelessWidget {
  const ElectroLinkApp({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    EasyLoading.instance
      ..maskType = EasyLoadingMaskType.black
      ..indicatorType = EasyLoadingIndicatorType.circle
      ..indicatorSize = 50.0
      ..loadingStyle = EasyLoadingStyle.custom
      ..backgroundColor = Colors.transparent
      ..indicatorColor =
          isDark ? context.colors.mainColor : context.colors.background
      ..textColor =
          isDark ? context.colors.mainColor : context.colors.background
      ..maskColor = Colors.black.withOpacity(isDark ? 0.9 : 0.75)
      ..userInteractions = false
      ..dismissOnTap = false
      ..boxShadow = [];
    final dioOptions = BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 10),
    );

    final myDio = Dio(dioOptions);

    myDio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await CacheHelper.getData(key: CacheKeys.token);
          if (token != null && token.toString().isNotEmpty) {
            options.headers[ApiKeys.authorization] = '${ApiKeys.bearer}$token';
          }
          return handler.next(options);
        },
      ),
    );

    return MultiRepositoryProvider(
      providers: [
        // RepositoryProvider<Dio>.value(value: myDio),
        // RepositoryProvider(create: (_) => ProfileService(myDio)),
        // RepositoryProvider(create: (_) => CategoryService(dio: myDio)),
        // RepositoryProvider(
        //   create:
        //       (_) => WishlistRepository(service: WishlistService(dio: myDio)),
        // ),
      ],
      // child: MultiBlocProvider(
      //   providers: [
      //     BlocProvider<CountriesCubit>(
      //       create:
      //           (context) =>
      //               CountriesCubit(CountriesService(myDio))..fetchCountries(),
      //     ),
      //     BlocProvider<LocationCubit>(create: (context) => LocationCubit()),
      //     BlocProvider<SelectionCubit>(create: (context) => SelectionCubit()),
      //     BlocProvider<ViewTypeCubit>(create: (context) => ViewTypeCubit()),
      //     BlocProvider<AuthCubit>(
      //       create: (context) => AuthCubit(AuthService(myDio))..checkAuth(),
      //     ),
      //     BlocProvider<CategoryCubit>(
      //       create:
      //           (context) => CategoryCubit(
      //             categoryService: context.read<CategoryService>(),
      //           )..fetchCategories(),
      //     ),
      //     BlocProvider<ProductsCubit>(
      //       create:
      //           (context) =>
      //               ProductsCubit(ProductsRepository(dio: myDio))
      //                 ..fetchProducts(),
      //     ),
      //     BlocProvider<RecentProductsCubit>(
      //       create:
      //           (context) =>
      //               RecentProductsCubit(ProductsRepository(dio: myDio))
      //                 ..fetchProducts(),
      //     ),
      //     BlocProvider<RecommendedProductsCubit>(
      //       create:
      //           (context) =>
      //               RecommendedProductsCubit(ProductsRepository(dio: myDio))
      //                 ..fetchProducts(),
      //     ),
      //     BlocProvider<WishlistCubit>(
      //       create:
      //           (context) => WishlistCubit(
      //             repository: context.read<WishlistRepository>(),
      //           )..fetchWishlist(),
      //     ),
      //     BlocProvider<MyListingsCubit>(
      //       create:
      //           (context) => MyListingsCubit(
      //             repository: ProductsRepository(dio: context.read<Dio>()),
      //           )..fetchMyListings(),
      //     ),
      //   ],
        child: MaterialApp.router(
          routerConfig: AppRouter.router,
          locale: DevicePreview.locale(context),
          builder: EasyLoading.init(
            builder: (context, widget) {
              return DevicePreview.appBuilder(context, widget!);
            },
          ),
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,
          debugShowCheckedModeBanner: false,
        ),
  }
}
