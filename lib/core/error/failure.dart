import 'package:equatable/equatable.dart';

abstract class AbstractFailure extends Equatable {
  @override
  List<Object?> get props => [];
}

class ServerFailure extends AbstractFailure {}

class CacheFailure extends AbstractFailure {}
