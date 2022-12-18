// ignore_for_file: void_checks

import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:new_udemy_course/core/error/exception.dart';
import 'package:new_udemy_course/features/data/models/person_model.dart';

abstract class PersonLocalDataSource {
  Future<List<PersonModel>> getLastPersonsFromCache();
  Future<void> personsToCache(List<PersonModel> persons);
}

const CACHED_PERSONS_LIST = 'CACHED_PERSONS_LIST';

class PersonLocalDataSourceImplement implements PersonLocalDataSource {
  final SharedPreferences sharedPreferences;
  PersonLocalDataSourceImplement({required this.sharedPreferences});

//Получение кеша с устройства
  @override
  Future<List<PersonModel>> getLastPersonsFromCache() {
    final jsonPersonsList =
        sharedPreferences.getStringList(CACHED_PERSONS_LIST);
    if (jsonPersonsList != null) {
      return Future.value(jsonPersonsList
          .map((person) => PersonModel.fromJson(json.decode(person)))
          .toList());
    } else {
      throw CacheException();
    }
  }

//Запись кеша на устройство
  @override
  Future<void> personsToCache(List<PersonModel> persons) {
    final List<String> jsonPersonsList =
        persons.map((person) => json.encode(person.toJson())).toList();
    //Теперь данную мапу(в кодировке json) нужно сохранить в shar. pref.
    sharedPreferences.setStringList(CACHED_PERSONS_LIST, jsonPersonsList);
    log('Persons to write cache: ${jsonPersonsList.length}');
    return Future.value(jsonPersonsList);
  }
}
