import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:matule/core/navigation/navigation.dart';
import 'package:matule/features/user/bloc/user_bloc.dart';

@RoutePage()
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _hidden = true;
  bool _checked = false;

  @override
  void dispose() {
    _usernameController.dispose();
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
        if (state is UserUnregistered) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Ошибка регистрации')),
            );
        }
        if (state is UserRegistered) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Подтвердите почту')),
            );
          AutoRouter.of(context).push(const LoginRoute());
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
                      child: Text('Регистрация',
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
                    Text('Ваше имя',
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(
                      height: 12,
                    ),
                    TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          fillColor: const Color(0xFFF7F7F9),
                          filled: true,
                          hintText: 'xxxxxxxx',
                          hintStyle: Theme.of(context).textTheme.titleSmall),
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
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          fillColor: const Color(0xFFF7F7F9),
                          filled: true,
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
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: _checked
                                ? const Color(0xFF48B2E7)
                                : const Color(0xFFF7F7F9),
                          ),
                          child: IconButton(
                            onPressed: () => setState(() {
                              _checked = !_checked;
                            }),
                            icon: SvgPicture.asset(
                              'assets/icons/shield.svg',
                              width: 20,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 300),
                            child: const Text(
                              'Даю согласие на обработку персональных данных',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF6A6A6A),
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: FilledButton(
                            onPressed: () {
                              if (_checked) {
                                context.read<UserBloc>().add(RegisterUser(
                                    username: _usernameController.text,
                                    email: _emailController.text,
                                    password: _passwordController.text));
                              } else {
                                ScaffoldMessenger.of(context)
                                  ..hideCurrentSnackBar()
                                  ..showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Дайте согласие на обработку персональных данных')),
                                  );
                              }
                            },
                            child: const Text('Зарегистрироваться'))),
                  ],
                ),
                Text.rich(TextSpan(
                    text: 'Есть аккаунт? ',
                    style: Theme.of(context).textTheme.labelMedium,
                    children: [
                      TextSpan(
                        text: 'Войти',
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => AutoRouter.of(context)
                              .replace(const LoginRoute()),
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
