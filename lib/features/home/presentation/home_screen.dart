import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:matule/core/navigation/navigation.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // AutoRouter.of(context).push(LoginRoute());
    return Scaffold(
      backgroundColor: Colors.green,
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
                Icon(Icons.heart_broken),
                IconButton.filled(padding: EdgeInsets.all(15), onPressed: () {}, icon: SvgPicture.asset('assets/icons/bag.svg', width: 40,)),
                Icon(Icons.heart_broken),
              ],
            )
          ),
        ],
      ),
    );
  }
}
