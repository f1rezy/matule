import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matule/features/user/bloc/user_bloc.dart';

@RoutePage()
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
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
        if (state is UserOtpCodeNotSent) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Ошибка')),
            );
        }
        if (state is UserOtpCodeSent) {
          showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                    title: Text("Проверьте Ваш Email"),
                    content: Text(
                        "Мы отправили код восстановления пароля на вашу электронную почту."),
                  ));
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
                      child: Text('Забыл пароль',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.displayLarge),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 250),
                        child: Text('Введите свою учетную запись для сброса',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.displaySmall),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    TextField(
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
                      height: 40,
                    ),
                    SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: FilledButton(
                            onPressed: () {
                              context.read<UserBloc>().add(ForgotPasswordUser(
                                  email: _emailController.text));
                            },
                            child: const Text('Отправить'))),
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
