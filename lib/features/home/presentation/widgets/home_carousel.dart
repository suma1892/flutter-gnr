import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_get_ride_app/core/helper/helper.dart';

class HomeCarousel extends StatelessWidget {
  final List<String> imageList = [
    'img_banner',
    'img_banner',
    'img_banner',
  ];

  HomeCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: FlutterCarousel(
      options: FlutterCarouselOptions(
          height: 95.0,
          indicatorMargin: 1,
          showIndicator: true,
          slideIndicator: CircularSlideIndicator(),
          enlargeCenterPage: true,
          viewportFraction: 1),
      items: imageList.map((imagePath) {
        return Builder(
          builder: (BuildContext context) {
            return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Image.asset(Helper.getImagePath(imagePath)));
          },
        );
      }).toList(),
    ));
  }
}
