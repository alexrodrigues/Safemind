import 'package:flutter/material.dart';
import 'package:safemind/model/therapist.dart';
import 'package:safemind/widget/sf_appbar.dart';
import 'package:safemind/widget/sf_primary_button.dart';
import '../widget/sf_details_top.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:url_launcher/url_launcher.dart';

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
    ModalRoute
        .of(context)
        ?.settings
        .arguments as Therapist?;
    if (therapist == null) {
      return Scaffold(
        appBar: SfAppBar("Error"),
        body: const Center(
          child: Text("No therapist data provided."),
        ),
      );
    }

    return Scaffold(
      appBar: SfAppBar(
        therapist.name,
        backIcon: Icons.arrow_back,
      ),
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
                      therapist.crp,
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      therapist.description,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 32.0),
                    SfPrimaryButton(
                      "Chamar no Whats",
                          () {
                        _launchWhatsApp(therapist.phoneNumber);
                      },
                    ),
                    const SizedBox(height: 16.0),
                    SfPrimaryButton(
                      "Instagram",
                          () {
                        _launchInstagram(therapist.instagramUrl);
                      },
                    ),
                    const SizedBox(height: 16.0),
                    SfPrimaryButton(
                      "Website",
                          () {
                        _openWebView(
                          context, therapist.name, therapist.websiteUrl,);
                      },
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

  void _openWebView(BuildContext context, String title, String url,) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WebViewScreen(title, url),
      ),
    );
  }

  void _launchInstagram(String instagramUrl) async {
    final String appUrl = 'instagram://user?username=$instagramUrl';
    final String webUrl = 'https://instagram.com/$instagramUrl';

    if (await canLaunch(appUrl)) {
      await launch(appUrl);
    } else if (await canLaunch(webUrl)) {
      await launch(webUrl);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Could not launch Instagram"),
        ),
      );
    }
  }

  void _launchWhatsApp(String phoneNumber) async {
    final String whatsappUrl = "https://wa.me/$phoneNumber";
    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Could not launch WhatsApp"),
        ),
      );
    }
  }
}

class WebViewScreen extends StatelessWidget {
  final String title;
  final String url;

  WebViewScreen(this.title, this.url);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
