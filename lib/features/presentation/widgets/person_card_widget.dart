import 'package:flutter/material.dart';
import 'package:new_udemy_course/common/app_colors.dart';
import 'package:new_udemy_course/features/domain/entities/person_entity.dart';

class PersonCard extends StatelessWidget {
  final PersonEntity person;
  const PersonCard({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cellBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 166,
            height: 166,
            child: Image.network(person.image),
          ),
          const SizedBox(height: 6, width: 16),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              Text(person.name,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  )),
              const SizedBox(height: 4),
              Row(
                children: [
                  Container(
                    height: 12,
                    width: 12,
                    decoration: BoxDecoration(
                        color: person.status == 'Alive'
                            ? Colors.green
                            : Colors.red,
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                      child: Text(
                    '${person.status} - ${person.species}',
                    style: const TextStyle(color: Colors.white),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ))
                ],
              ),
              const SizedBox(height: 10),
              const Text('Last known location:',
                  style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 4),
              Text(person.location.name),
              const SizedBox(height: 10),
              const Text('Origin:', style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 3),
              Text(person.origin.name),
              const SizedBox(height: 12),
            ],
          ))
        ],
      ),
    );
  }
}
