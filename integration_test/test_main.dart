import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:matule/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  GetIt.I.registerSingleton(dio);

  runApp(const MatuleApp());
}