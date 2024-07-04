import 'package:cloud_firestore/cloud_firestore.dart';

class Therapist {
  final String name;
  final String urlImage;
  final String description;
  final String crp;

  Therapist(this.name, this.urlImage, this.description, this.crp);

  factory Therapist.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Therapist(
      data['name'] ?? '',
      data['imageUrl'] ?? '',
      data['description'] ?? '',
      data['crp'] ?? '',
    );
  }
}
