import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:matule/features/home/presentation/home_screen.dart';
import 'package:matule/features/onboarding/presentation/onboarding_screen.dart';
import 'package:matule/features/profile/presentation/profile_screen.dart';
import 'package:matule/features/user/presentation/forgot_password_screen.dart';
import 'package:matule/features/user/presentation/login_screen.dart';
import 'package:matule/features/user/presentation/register_screen.dart';

part 'navigation.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        // AutoRoute(
        //   page: HomeRoute.page,
        //   path: '/',
        //   children: [
        //     AutoRoute(page: HomeRoute.page, path: 'home'),
        //     AutoRoute(
        //       page: SearchRoute.page,
        //       path: 'search',
        //     ),
        //     AutoRoute(
        //       page: FavoritesRoute.page,
        //       path: 'favorites',
        //     ),
        //     AutoRoute(
        //       page: HistoryRoute.page,
        //       path: 'poems',
        //     ),
        //     AutoRoute(
        //       page: SettingsRoute.page,
        //       path: 'settings',
        //     ),
        //   ],
        // ),
        AutoRoute(page: HomeRoute.page, path: '/'),
        AutoRoute(page: OnboardingRoute.page),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: RegisterRoute.page),
        AutoRoute(page: ForgotPasswordRoute.page),
        AutoRoute(page: ProfileRoute.page),
      ];
}