import 'package:dartz/dartz.dart';
import 'package:flutter_get_ride_app/core/network/error/failures.dart';
// import 'package:ny_times_app/src/core/network/error/failures.dart';

abstract class UseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

class NoParams {}
