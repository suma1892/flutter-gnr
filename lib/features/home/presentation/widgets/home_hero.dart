import 'package:flutter/material.dart';
import 'package:flutter_get_ride_app/core/helper/helper.dart';
import 'package:flutter_get_ride_app/features/home/presentation/widgets/home_carousel.dart';
import 'package:flutter_get_ride_app/features/home/presentation/widgets/main_service_tab.dart';

class HomeHero extends StatelessWidget {
  const HomeHero({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width, // Lebar layar penuh
      height: MediaQuery.of(context).size.height / 3, // Tinggi 1/3 layar
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Helper.getImagePath('img_bg_hero')),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
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
    );
    ;
  }
}
