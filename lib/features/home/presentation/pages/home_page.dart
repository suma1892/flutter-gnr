import 'package:flutter/material.dart';
import 'package:flutter_get_ride_app/features/home/presentation/widgets/Influencer_testimoni.dart';
import 'package:flutter_get_ride_app/features/home/presentation/widgets/article.dart';
import 'package:flutter_get_ride_app/features/home/presentation/widgets/get_ride_description.dart';
import 'package:flutter_get_ride_app/features/home/presentation/widgets/home_form/rent_car/daily/daily_tab.dart';
import 'package:flutter_get_ride_app/features/home/presentation/widgets/rental_completeness.dart';
import 'package:flutter_get_ride_app/features/home/presentation/widgets/type_of_cars.dart';
import 'package:flutter_get_ride_app/features/home/presentation/widgets/home_form/home_header.dart';
import 'package:flutter_get_ride_app/features/home/presentation/widgets/home_form/home_hero.dart';
import 'package:flutter_get_ride_app/features/home/presentation/widgets/home_form/rent_car/rent_car_tab.dart';
import 'package:flutter_get_ride_app/features/home/presentation/widgets/why_choose_us.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              HomeHeader(),
              HomeHero(),
              RentCarTab(),
              TypeOfCars(),
              GetRideDescription(),
              WhyChooseUs(),
              RentalCompleteness(),
              InfluencerTestimoni(),
              Article()
            ],
          ),
        ),
      ),
    );
  }
}
