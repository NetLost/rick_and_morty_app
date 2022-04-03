import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/core/error/failure.dart';
import 'package:rick_and_morty_app/feature/domain/useCases/search_person.dart';
import 'package:rick_and_morty_app/feature/presentation/bloc/search_bloc/search_event.dart';
import 'package:rick_and_morty_app/feature/presentation/bloc/search_bloc/search_state.dart';

const SERVER_FAILURE_MESSAGE = 'Server Failure';
const CACHE_FAILURE_MESSAGE = 'Cache Failure';

class PersonSearchBloc extends Bloc<PersonSearchEvent, PersonSearchState> {
  final SearchPerson searchPerson;

  PersonSearchBloc({required this.searchPerson}) : super(PersonEmpty()) {
    on<SearchPersons>(
        (event, emit) => _mapFetchPersonToState(event.personQuery));
  }

  Stream<PersonSearchState> _mapFetchPersonToState(String personQuery) async* {
    yield PersonSearchLoading();

    final failureOrPerson =
        await searchPerson(SearchPersonParams(query: personQuery));
    yield failureOrPerson.fold(
        (failure) => PersonSearchError(message: _mapFailureToMessage(failure)),
        (person) => PersonSearchLoaded(persons: person));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
