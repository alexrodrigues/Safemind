import 'package:flutter/material.dart';
import 'package:safemind/model/therapist.dart';

class TherapistCard extends StatelessWidget {
  final Therapist model;

  TherapistCard(this.model);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(
          model.urlImage,
          fit: BoxFit.scaleDown,
        ),
        title: Text(
          model.name,
          style: TextStyle(fontSize: 13.0),
        ),
        subtitle: Text(
          model.description,
          style: TextStyle(fontSize: 11.0, color: Colors.grey),
        ),
      ),
    );
  }
}
