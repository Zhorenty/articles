import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:new_udemy_course/features/domain/entities/person_entity.dart';
import 'package:new_udemy_course/features/presentation/bloc/person_list_cubit/person_list_cubit.dart';
import 'package:new_udemy_course/features/presentation/bloc/person_list_cubit/person_list_state.dart';
import 'package:new_udemy_course/features/presentation/widgets/person_card_widget.dart';

class PersonList extends StatelessWidget {
  const PersonList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonListCubit, PersonState>(
      builder: (context, state) {
        List<PersonEntity> persons = [];
        if (state is PersonLoading && state.isFirstFetch) {
          return _loadingIndicator();
        } else if (state is PersonLoaded) {
          persons = state.personsList;
        }
        return ListView.separated(
            itemBuilder: ((context, index) {
              return PersonCard(person: persons[index]);
            }),
            separatorBuilder: ((context, index) {
              return Divider(
                color: Colors.grey[400],
              );
            }),
            itemCount: persons.length);
      },
    );
  }

  Widget _loadingIndicator() {
    return const Center(
      child: SpinKitChasingDots(color: Colors.black),
    );
  }
}
