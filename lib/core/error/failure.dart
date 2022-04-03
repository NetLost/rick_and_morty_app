import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {

  @override
  List<Object?> get props => throw UnimplementedError();
}

class ServerFailure implements Failure {
  @override
  List<Object?> get props => throw UnimplementedError();

  @override
  bool? get stringify => throw UnimplementedError();
}

class CacheFailure implements Failure {
  @override
  List<Object?> get props => throw UnimplementedError();

  @override
  bool? get stringify => throw UnimplementedError();
}