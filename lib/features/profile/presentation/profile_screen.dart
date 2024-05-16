import 'package:auto_route/auto_route.dart';
import 'package:barcode/barcode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final dm = Barcode.telepen();
    final svg = dm.toSvg('Hello World!', width: 300, height: 50, drawText: false);

    return Scaffold(
      body: SafeArea(
          child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            AppBar(
              leading: IconButton.filled(
                onPressed: () {
                  AutoRouter.of(context).back();
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 15,
                ),
                style: IconButton.styleFrom(
                  padding: const EdgeInsets.all(18),
                  backgroundColor: const Color.fromARGB(255, 236, 236, 236),
                  foregroundColor: Colors.black,
                ),
              ),
              title: Text(
                'Профиль',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              centerTitle: true,
            ),
            SvgPicture.string(svg),
          ],
        ),
      )),
    );
  }
}
