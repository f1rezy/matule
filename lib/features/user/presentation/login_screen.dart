import 'package:auto_route/auto_route.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:matule/core/navigation/navigation.dart';
import 'package:matule/features/user/bloc/user_bloc.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _hidden = true;
  bool _emailValidate = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserUnknown) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Загрузка')),
            );
        }
        if (state is UserUnauthenticated) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Ошибка авторизации')),
            );
        }
        if (state is UserAuthenticated) {
          AutoRouter.of(context).replace(const HomeRoute());
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton.filled(
                      onPressed: () {
                        AutoRouter.of(context).back();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 18,
                      ),
                      style: IconButton.styleFrom(
                        padding: const EdgeInsets.all(18),
                        backgroundColor:
                            const Color.fromARGB(255, 236, 236, 236),
                        foregroundColor: Colors.black,
                      ),
                    ),
                    Center(
                      child: Text('Привет!',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.displayLarge),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 300),
                        child: Text(
                            'Заполните cвои данные или продолжите через социальные медиа',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.displaySmall),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text('Email',
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(
                      height: 12,
                    ),
                    TextField(
                      controller: _emailController,
                      onChanged: (value) {
                        if (!EmailValidator.validate(value)) {
                          setState(() {
                            _emailValidate = true;
                          });
                        } else {
                          setState(() {
                            _emailValidate = false;
                          });
                        }
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          fillColor: const Color(0xFFF7F7F9),
                          filled: true,
                          errorText: _emailValidate ? "Плохой email" : null,
                          hintText: 'xyz@gmail.com',
                          hintStyle: Theme.of(context).textTheme.titleSmall),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text('Пароль',
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(
                      height: 12,
                    ),
                    TextField(
                      controller: _passwordController,
                      obscureText: _hidden,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          fillColor: const Color(0xFFF7F7F9),
                          filled: true,
                          hintText: '********',
                          hintStyle: Theme.of(context).textTheme.titleSmall,
                          suffixIcon: IconButton(
                              onPressed: () => setState(() {
                                    _hidden = !_hidden;
                                  }),
                              icon: SvgPicture.asset('assets/icons/eye.svg',
                                  width: 24))),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              AutoRouter.of(context)
                                  .push(ForgotPasswordRoute());
                            },
                            child: Text(
                              'Восстановить',
                              style: Theme.of(context).textTheme.labelSmall,
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: FilledButton(
                            onPressed: () {
                              context.read<UserBloc>().add(LoginUser(
                                  email: _emailController.text,
                                  password: _passwordController.text));
                            },
                            child: const Text('Войти'))),
                  ],
                ),
                Text.rich(TextSpan(
                    text: 'Вы впервые? ',
                    style: Theme.of(context).textTheme.labelMedium,
                    children: [
                      TextSpan(
                        text: 'Создать пользователя',
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => AutoRouter.of(context)
                              .replace(const RegisterRoute()),
                      )
                    ]))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
