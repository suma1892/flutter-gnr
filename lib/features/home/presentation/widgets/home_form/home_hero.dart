import 'package:flutter/material.dart';
import 'package:flutter_get_ride_app/core/helper/helper.dart';
import 'package:flutter_get_ride_app/features/home/presentation/widgets/home_form/home_carousel.dart';
import 'package:flutter_get_ride_app/features/home/presentation/widgets/home_form/main_service_tab.dart';

class HomeHero extends StatelessWidget {
  const HomeHero({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 3.8,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Helper.getImagePath('img_bg_hero')),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            HomeCarousel(),
            SizedBox(
              height: 20,
            ),
            MainServiceTab()
          ],
        ),
      ),
    );
    ;
  }
}
