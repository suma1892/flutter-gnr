import 'package:flutter/widgets.dart';
import 'package:flutter_get_ride_app/features/home/presentation/widgets/home_form/rent_car/daily/without_driver/select_location.dart';

class WithoutDriverForm extends StatefulWidget {
  const WithoutDriverForm({super.key});

  @override
  State<WithoutDriverForm> createState() => _WithoutDriverFormState();
}

class _WithoutDriverFormState extends State<WithoutDriverForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [SelectLocation()],
    );
  }
}
