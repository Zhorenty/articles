import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_udemy_course/bloc/character_bloc.dart';
import 'package:new_udemy_course/data/repository/character_repo.dart';
import 'package:new_udemy_course/ui/pages/search_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key, required this.title});

  final String title;
  final repository = CharacterRepo();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(title, style: Theme.of(context).textTheme.headline3),
      ),
      body: BlocProvider(
        create: (context) => CharacterBloc(repository: repository),
        child: Container(
            decoration: const BoxDecoration(color: Colors.black87),
            child: const SearchPage()),
      ),
    );
  }
}
