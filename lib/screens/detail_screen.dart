import 'package:flutter/material.dart';
import 'package:safemind/model/therapist.dart';
import 'package:safemind/widget/sf_appbar.dart';

class DetailsScreen extends StatefulWidget {
  static const ROUTE_NAME = "_DetailsScreen";
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    Therapist? therapist =
        ModalRoute.of(context)?.settings.arguments as Therapist;
    return Scaffold(
      appBar: const SfAppBar(),
      body: Center(
        child: Text(
          therapist.name,
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
