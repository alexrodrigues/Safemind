import 'package:flutter/material.dart';
import 'package:safemind/model/therapist.dart';
import 'package:safemind/widget/sf_appbar.dart';
import 'package:safemind/widget/sf_primary_button.dart';

import '../widget/sf_details_top.dart';

class DetailsScreen extends StatefulWidget {
  static const ROUTE_NAME = "_DetailsScreen";
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final Therapist? therapist =
        ModalRoute.of(context)?.settings.arguments as Therapist?;
    if (therapist == null) {
      return Scaffold(
        appBar: SfAppBar("Error"),
        body: const Center(
          child: Text("No therapist data provided."),
        ),
      );
    }

    return Scaffold(
      appBar: SfAppBar(therapist.name),
      body: Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SfDetailsTopWidget(
                      therapist.urlImage,
                      therapist.name,
                      therapist.identifier,
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      _lorem,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 32.0),
                    SfPrimaryButton(
                      "Schedule a meet",
                      () {},
                    ),
                    const SizedBox(height: 16.0),
                    SfPrimaryButton(
                      "Instagram",
                      () {},
                    ),
                    const SizedBox(height: 16.0),
                    SfPrimaryButton(
                      "Website",
                      () {},
                    ),
                    const SizedBox(height: 16.0),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _lorem =
      "Therapy is important because it provides individuals with a safe and supportive environment to explore their thoughts, feelings, and behaviors, which can lead to greater self-awareness and understanding. Through therapy, individuals can develop healthier coping mechanisms, improve their emotional regulation, and address mental health issues such as anxiety, depression, and trauma. It also fosters personal growth, enhances relationships, and promotes overall well-being by helping people navigate life's challenges and transitions more effectively. By working with a trained therapist, individuals can gain valuable insights and skills that empower them to lead more fulfilling and balanced lives.";
}
