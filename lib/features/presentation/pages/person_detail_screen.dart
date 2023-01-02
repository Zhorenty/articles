import 'package:flutter/material.dart';
import 'package:new_udemy_course/features/domain/entities/person_entity.dart';
import 'package:new_udemy_course/features/presentation/widgets/person_cache_image_widget.dart';

class PersonDetailPage extends StatelessWidget {
  final PersonEntity person;

  const PersonDetailPage({super.key, required this.person});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Character'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Text(
              person.name,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            PersonCacheImage(imageUrl: person.image, height: 320, width: 320),
            const SizedBox(height: 10),
            StatusRow(person: person),
            InfoBlock(upSideText: 'Gender:', personAdress: person.gender),
            InfoBlock(
                upSideText: 'Number of episodes:',
                personAdress: person.episode.length.toString()),
            InfoBlock(upSideText: 'Species:', personAdress: person.species),
            InfoBlock(
                upSideText: 'Last known location:',
                personAdress: person.location.name),
            InfoBlock(upSideText: 'Origin:', personAdress: person.origin.name),
            InfoBlock(
                upSideText: 'Was created:',
                personAdress: person.created.toString()),
          ],
        ),
      ),
    );
  }
}

class InfoBlock extends StatelessWidget {
  final String upSideText;
  final String personAdress;
  const InfoBlock({
    super.key,
    required this.upSideText,
    required this.personAdress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const SizedBox(height: 10),
          Text(
            upSideText,
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 3),
          Text(personAdress),
        ],
      ),
    );
  }
}

class StatusRow extends StatelessWidget {
  final PersonEntity person;
  const StatusRow({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 12,
          width: 12,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: person.status == 'Alive' ? Colors.green : Colors.red,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          person.status,
          style: const TextStyle(fontSize: 16),
          maxLines: 1,
        )
      ],
    );
  }
}
