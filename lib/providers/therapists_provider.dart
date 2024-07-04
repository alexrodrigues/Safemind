import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/therapist.dart';

class TherapistsProvider with ChangeNotifier {
  Future<List<Therapist>> fetchTherapists() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('therapists').get();
      List<Therapist> therapists = [];
      for (var doc in querySnapshot.docs) {
        therapists.add(Therapist.fromFirestore(doc));
      }
      return therapists;
    } catch (e) {
      // Handle any errors here
      print("Error fetching therapists: $e");
      throw e;
    }
  }
}
