import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty_app/core/error/failure.dart';
import 'package:rick_and_morty_app/core/useCases/use_case.dart';
import 'package:rick_and_morty_app/feature/domain/entities/person_entity.dart';
import 'package:rick_and_morty_app/feature/domain/repository/person_repository.dart';

class SearchPerson extends UseCase<List<PersonEntity>, SearchPersonParams>{
  final PersonRepository _personRepository;

  SearchPerson(this._personRepository);

  @override
  Future<Either<Failure, List<PersonEntity>>> call(SearchPersonParams params) async {
    return await _personRepository.searchPerson(params.query);
  }
}

class SearchPersonParams extends Equatable{
  final String query;

  const SearchPersonParams({required this.query});

  @override
  List<Object?> get props => [query];
}