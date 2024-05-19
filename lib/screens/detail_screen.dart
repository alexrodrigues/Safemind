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
    Therapist? therapist =
        ModalRoute.of(context)?.settings.arguments as Therapist;
    return Scaffold(
      appBar: const SfAppBar(),
      body: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 16.0,
            bottom: 32.0,
            left: 16.0,
            right: 16.0,
          ),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SfDetailsTopWidget(
                      therapist.urlImage,
                      therapist.name,
                    ),
                    Text(
                      _lorem,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16.0, bottom: 16.0),
                      child: Expanded(
                        child: SfPrimaryButton(
                          "Schedule a meet",
                          () {},
                        ),
                      ),
                    ),
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
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Convallis aenean et tortor at risus viverra adipiscing at in. Feugiat in fermentum posuere urna. Libero id faucibus nisl tincidunt eget nullam non. Egestas congue quisque egestas diam in arcu cursus euismod quis. Etiam tempor orci eu lobortis elementum nibh tellus. Tincidunt lobortis feugiat vivamus at augue eget arcu dictum varius. Ultrices dui sapien eget mi proin sed libero. Nisl nisi scelerisque eu ultrices. Neque gravida in fermentum et sollicitudin ac orci phasellus egestas.\n\nEleifend donec pretium vulputate sapien nec. Vitae nunc sed velit dignissim sodales ut eu sem. Nunc sed augue lacus viverra vitae congue. Pretium aenean pharetra magna ac. Sollicitudin tempor id eu nisl. Gravida cum sociis natoque penatibus et. Accumsan lacus vel facilisis volutpat est velit egestas dui. Nulla porttitor massa id neque aliquam vestibulum morbi blandit cursus. Nunc faucibus a pellentesque sit amet porttitor eget dolor morbi. Eget nullam non nisi est sit amet facilisis magna. Porta nibh venenatis cras sed felis eget velit aliquet sagittis. Purus non enim praesent elementum facilisis leo. Sed vulputate mi sit amet mauris. Nunc mi ipsum faucibus vitae. Vel orci porta non pulvinar. Ante metus dictum at tempor commodo. Metus aliquam eleifend mi in. Sit amet commodo nulla facilisi nullam. Nec nam aliquam sem et tortor consequat. Non curabitur gravida arcu ac tortor.\n\nMagna eget est lorem ipsum dolor sit amet consectetur adipiscing. Libero justo laoreet sit amet cursus sit. Urna porttitor rhoncus dolor purus non enim praesent elementum facilisis. In pellentesque massa placerat duis ultricies. Dolor sit amet consectetur adipiscing elit duis tristique sollicitudin nibh. Vulputate enim nulla aliquet porttitor lacus luctus accumsan tortor posuere. Sit amet mauris commodo quis. Pellentesque elit eget gravida cum sociis. Pellentesque adipiscing commodo elit at imperdiet. Adipiscing elit duis tristique sollicitudin nibh sit. Dictumst quisque sagittis purus sit amet volutpat. Scelerisque eleifend donec pretium vulputate sapien nec.";
}
