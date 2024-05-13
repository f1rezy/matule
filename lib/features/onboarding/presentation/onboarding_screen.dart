// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matule/core/navigation/navigation.dart';

import 'package:matule/features/onboarding/cubit/onboarding_cubit.dart';

@RoutePage()
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({
    super.key,
    required this.initialPage,
  });

  final int initialPage;

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController? controller;
  int _currentPage = 0;

  @override
  void initState() {
    controller = PageController(initialPage: widget.initialPage);
    _currentPage = widget.initialPage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        return Scaffold(
          body: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    Color(0xFF48B2E7),
                    Color(0xFF0076B1),
                  ],
                  tileMode: TileMode.mirror,
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  PageView(
                    controller: controller,
                    onPageChanged: (value) {
                      setState(() => _currentPage = value);
                      context
                          .read<OnboardingCubit>()
                          .setOnboardingInitialPage(value);
                    },
                    children: [
                      _firstPage(
                        context: context,
                        pageIndex: 0,
                        imageUrl: 'assets/images/page1.png',
                        title: 'ДОБРО ПОЖАЛОВАТЬ',
                      ),
                      _page(
                        context: context,
                        pageIndex: 1,
                        imageUrl: 'assets/images/page2.png',
                        title: 'Начнем путешествие',
                        desc:
                            'Умная, великолепная и модная коллекция Изучите сейчас',
                      ),
                      _page(
                        context: context,
                        pageIndex: 2,
                        imageUrl: 'assets/images/page3.png',
                        title: 'У Вас Есть Сила, Чтобы',
                        desc:
                            'В вашей комнате много красивых и привлекательных растений',
                      ),
                    ],
                  ),
                  Positioned(
                      bottom: 36,
                      child: FilledButton(
                        key: const Key("btnNext"),
                        onPressed: _currentPage == 2
                            ? () {
                                AutoRouter.of(context).push(const LoginRoute());
                                context
                                    .read<OnboardingCubit>()
                                    .setOnboardingInitialPage(3);
                              }
                            : () {
                                controller?.nextPage(
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.easeIn,
                                );
                              },
                        style: FilledButton.styleFrom(
                          fixedSize:
                              Size(MediaQuery.of(context).size.width * 0.9, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13),
                          ),
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.white,
                          textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        child: _currentPage == 0
                            ? const Text('Начать')
                            : const Text('Далее'),
                      )),
                ],
              )),
        );
      },
    );
  }

  Widget _firstPage({
    required pageIndex,
    required imageUrl,
    required title,
    required BuildContext context,
  }) {
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imageUrl),
            fit: BoxFit.contain,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 140,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 70,
              ),
              child: Text(title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      color: Colors.white)),
            ),
            const SizedBox(
              height: 430,
            ),
            DotsIndicator(
              dotsCount: 3,
              position: _currentPage.toDouble(),
              decorator: DotsDecorator(
                color: const Color(0xFF2B6B8B),
                activeColor: Colors.white,
                size: const Size(35, 8),
                activeSize: const Size(60, 8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
              ),
            ),
          ],
        ));
  }

  Widget _page({
    required pageIndex,
    required imageUrl,
    required title,
    required desc,
    required BuildContext context,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          imageUrl,
        ),
        const SizedBox(height: 40),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 70,
          ),
          child: Text(title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w700,
                  color: Colors.white)),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 80,
          ),
          child: Text(
            desc,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xFFD8D8D8),
                fontFamily: 'Poppins'),
          ),
        ),
        const SizedBox(height: 40),
        DotsIndicator(
          dotsCount: 3,
          position: _currentPage.toDouble(),
          decorator: DotsDecorator(
            color: const Color(0xFF2B6B8B),
            activeColor: Colors.white,
            size: const Size(35, 8),
            activeSize: const Size(60, 8),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
          ),
        ),
      ],
    );
  }
}
