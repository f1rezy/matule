// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:matule/features/home/bloc/category_bloc.dart';
import 'package:matule/features/home/data/repositories/category_repository.dart';
import 'package:matule/features/user/bloc/user_bloc.dart';
import 'package:matule/features/user/data/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:matule/core/navigation/navigation.dart';
import 'package:matule/core/theme/theme.dart';
import 'package:matule/features/onboarding/cubit/onboarding_cubit.dart';
import 'package:matule/features/onboarding/data/onboarding_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var logger = Logger();
  GetIt.I.registerSingleton(logger);

  FlutterError.onError = (details) => logger.e(
        'Uncaught exception:',
        error: details.exception,
        stackTrace: details.stack,
      );

  final preferences = await SharedPreferences.getInstance();
  GetIt.I.registerSingleton(preferences);

  final options = BaseOptions(
      baseUrl: 'https://kigxncopjnpfhnnlqmqf.supabase.co',
      headers: {
        'apikey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtpZ3huY29wam5wZmhubmxxbXFmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTUyNzgyNDcsImV4cCI6MjAzMDg1NDI0N30.G51chKUkj2lZvjV_LV100v_jpfIKiGG1qPsTPPaVjWw'
      });
  final dio = Dio(options);
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
        logger.i('REQUEST[${options.method}] => PATH: ${options.path}');
        return handler.next(options);
      },
      onResponse: (Response response, ResponseInterceptorHandler handler) {
        logger.i('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
        return handler.next(response);
      },
      onError: (DioException error, ErrorInterceptorHandler handler) {
        logger.e('ERROR[${error.response?.statusCode}] => PATH: ${error.requestOptions.path}');
        logger.e(error.response?.data);
        return handler.next(error);
      },
    ),
  );
  GetIt.I.registerSingleton(dio);

  runApp(const MatuleApp());
}

class MatuleApp extends StatefulWidget {
  const MatuleApp({
    super.key,
  });

  @override
  State<MatuleApp> createState() => _MatuleAppState();
}

class _MatuleAppState extends State<MatuleApp> {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    final onboardingRepository =
        OnboardingRepository(prefs: GetIt.I<SharedPreferences>());
    final userRepository = UserRepository(
        dio: GetIt.I<Dio>(), preferences: GetIt.I<SharedPreferences>());
    final categoryRepository = CategoryRepository(
        dio: GetIt.I<Dio>());

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              OnboardingCubit(onboardingRepository: onboardingRepository),
        ),
        BlocProvider(
          create: (context) => UserBloc(userRepository: userRepository),
        ),
        BlocProvider(
          create: (context) => CategoryBloc(categoryRepository: categoryRepository),
        ),
      ],
      child: MaterialApp.router(
        title: 'Matule',
        debugShowCheckedModeBanner: false,
        theme: themeData,
        routerConfig: _appRouter.config(),
      ),
    );
  }
}
