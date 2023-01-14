import 'package:dartz/dartz.dart';
import 'package:flutter_rick_and_morty/core/error/failure.dart';

abstract class AbstractUseCase<Type, Params> {
  Future<Either<AbstractFailure, Type>> call(Params params);
}
