import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty_app/core/error/failure.dart';
import 'package:rick_and_morty_app/core/useCases/use_case.dart';
import 'package:rick_and_morty_app/feature/domain/entities/person_entity.dart';
import 'package:rick_and_morty_app/feature/domain/repository/person_repository.dart';

class GetAllPersons extends UseCase<List<PersonEntity>, PagePersonParams> {
  final PersonRepository _personRepository;

  GetAllPersons(this._personRepository);

  @override
  Future<Either<Failure, List<PersonEntity>>> call(PagePersonParams params) async {
    return await _personRepository.getAllPersons(params.page);
  }
}

class PagePersonParams extends Equatable{
  final int page;

  const PagePersonParams({required this.page});

  @override
  List<Object?> get props => [page];
}