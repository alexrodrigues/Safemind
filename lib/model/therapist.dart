import 'package:cloud_firestore/cloud_firestore.dart';

class Therapist {
  final String name;
  final String urlImage;
  final String description;
  final String crp;
  final String instagramUrl;
  final String websiteUrl;

  Therapist(
    this.name,
    this.urlImage,
    this.description,
    this.crp,
    this.instagramUrl,
    this.websiteUrl,
  );

  factory Therapist.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Therapist(
      data['name'] ?? '',
      data['imageUrl'] ?? '',
      data['description'] ?? '',
      data['crp'] ?? '',
      data['instagramUrl'] ?? '',
      data['websiteUrl'] ?? '',
    );
  }
}
