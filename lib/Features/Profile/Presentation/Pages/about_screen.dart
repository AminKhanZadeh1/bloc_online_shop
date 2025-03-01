import 'package:bloc_online_shop/Config/links.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  Future<void> _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    // var pcolor = Theme.of(context).primaryColor;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Gratitude✨',
            style: GoogleFonts.aladin(),
          ),
          centerTitle: true,
        ),
        body: Center(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                textAlign: TextAlign.center,
                'I hope you enjoyed using the app :).\nThis app is using Flutter and Dart language\nwith Bloc state management and clean architecture. APIs: (Firebase & Fakestore).\n\nPlease follow me on Social Media:',
                style: TextStyle(fontSize: Checkbox.width * 1.2),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                textAlign: TextAlign.center,
                'Linkedin:',
                style: TextStyle(fontSize: Checkbox.width * 1.3),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () => _launchURL(Links.linkedin),
                child: Text(
                  textAlign: TextAlign.center,
                  Links.linkedin,
                  style: const TextStyle(color: Colors.blue),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                  textAlign: TextAlign.center,
                  'GitHub:',
                  style: TextStyle(fontSize: Checkbox.width * 1.3)),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () => _launchURL(Links.github),
                child: Text(
                    textAlign: TextAlign.center,
                    Links.github,
                    style: const TextStyle(color: Colors.blue)),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
