import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:matule/core/navigation/navigation.dart';
import 'package:matule/core/theme/theme.dart';
import 'package:matule/features/home/bloc/category_bloc.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();

  @override
  void initState() {
    context.read<CategoryBloc>().add(LoadCategory());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // AutoRouter.of(context).push(LoginRoute());
    return SideMenu(
      closeIcon: null,
      radius: BorderRadius.circular(25),
      maxMenuWidth: 300,
      key: _sideMenuKey,
      background: primaryColor,
      menu: Menu(),
      type: SideMenuType.shrikNRotate,
      child: GestureDetector(
        onTap: () {
          final state = _sideMenuKey.currentState;
          if (state!.isOpened) state.closeSideMenu();
        },
        child: Scaffold(
          backgroundColor: Color.fromARGB(255, 231, 231, 231),
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 231, 231, 231),
            leading: IconButton(
              onPressed: () {},
              icon: SvgPicture.asset('assets/icons/hamburger.svg'),
              style: IconButton.styleFrom(),
            ),
            title: Text('Главная',
                style: Theme.of(context).textTheme.displayLarge),
          ),
          body: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Категории',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 16,
                ),
                // Pinput(
                //   length: 6,
                //   defaultPinTheme: PinTheme(textStyle: TextStyle()),
                // )
                // BlocBuilder<CategoryBloc, CategoryState>(
                //   builder: (context, state) {
                //     if (state is CategoryLoaded) {
                //       return SingleChildScrollView(
                //           // scrollDirection: Axis.horizontal,
                //           child: Row(
                //         children: state.categories
                //             .map((e) => SizedBox(
                //                   width: 100,
                //                   height: 100,
                //                   child: Container(
                //                       decoration:
                //                           BoxDecoration(color: Colors.blue),
                //                       child: Text(e.title)),
                //                 ))
                //             .toList(),
                //       ));
                //     }
                //     if (state is CategoryLoadingFailure) {
                //       return Text(state.exception.toString());
                //     }
                //     return Text('aboba');
                //   },
                // )
              ],
            ),
          ),
          bottomNavigationBar: Stack(
            children: [
              SvgPicture.asset(
                'assets/icons/bottom_bar.svg',
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
              ),
              Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton.filled(
                      padding: EdgeInsets.all(20),
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        'assets/icons/bag.svg',
                        width: 40,
                      )),
                ],
              )),
              Container(
                  padding: EdgeInsets.only(top: 60),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: SvgPicture.asset('assets/icons/home.svg'),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: SvgPicture.asset('assets/icons/heart.svg'),
                        onPressed: () {},
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      IconButton(
                        icon: SvgPicture.asset('assets/icons/ring.svg'),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: SvgPicture.asset('assets/icons/profile.svg'),
                        onPressed: () {
                          final state = _sideMenuKey.currentState;
                          if (state!.isOpened) {
                            state.closeSideMenu();
                          } else {
                            state.openSideMenu();
                          }
                        },
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class Menu extends StatelessWidget {
  const Menu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset('assets/images/image.png'),
          SizedBox(
            height: 15,
          ),
          Text(
            'Эмануэль Кверти',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
          ),
          SizedBox(
            height: 55,
          ),
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/profile.svg',
                colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
              TextButton(
                child: Text('Профиль',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white)),
                onPressed: () {
                  AutoRouter.of(context).push(const ProfileRoute());
                },
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/bag.svg',
                colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    'Корзина',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ))
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/heart.svg',
                colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    'Избранное',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ))
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/car.svg',
                colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    'Заказы',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ))
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/ring.svg',
                colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    'Уведомления',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ))
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/settings.svg',
                colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    'Настройки',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ))
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Divider(
            endIndent: 0,
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/exit.svg',
                colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                'Выйти',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              )
            ],
          ),
        ],
      ),
    );
  }
}
