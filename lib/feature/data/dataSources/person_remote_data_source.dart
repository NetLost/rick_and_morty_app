import 'dart:convert';

import 'package:rick_and_morty_app/core/error/exception.dart';
import 'package:rick_and_morty_app/feature/data/models/person_model.dart';
import 'package:http/http.dart' as http;

abstract class PersonRemoteDataSource {
  Future<List<PersonModel>> getAllPersons(int page);

  Future<List<PersonModel>> searcPerson(String query);
}

class PersonRemoteDataSourceImpl implements PersonRemoteDataSource {
  final http.Client client;

  PersonRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PersonModel>> getAllPersons(int page) => _getPersonsFromUrl(
      "https://rickandmortyapi.com/api/character/?page=$page");

  @override
  Future<List<PersonModel>> searcPerson(String query) => _getPersonsFromUrl(
      "https://rickandmortyapi.com/api/character/?name=$query");

  Future<List<PersonModel>> _getPersonsFromUrl(String url) async {
    final responce = await client
        .get(Uri.parse(url), headers: {'Content-type': 'application/json'});
    if (responce.statusCode == 200) {
      final persons = json.decode(responce.body);
      return (persons['results'] as List)
          .map((person) => PersonModel.fromJson(person))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
