import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../generated/l10n.dart';
import '../screens/intail/widgets/build_circle_button.dart';
import '../screens/intail/widgets/social_media_bottum.dart';

class HelpAndSupportPage extends StatelessWidget {
  const HelpAndSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).HelpSupport),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).HelpSupport,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                S.of(context).WeAreHereToHelp,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BuildCircleButton(
                    icon: const FaIcon(FontAwesomeIcons.envelope),
                    label: S.of(context).EmailUs,
                    onTap: _sendEmail,
                    color: Colors.red[400]!,
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Text(
                S.of(context).ConnectWithUs,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: 20),
                      BuildSocialMediaButton(
                        context,
                        icon: const FaIcon(FontAwesomeIcons.facebook),
                        label: S.of(context).Messenger,
                        color: Colors.blue[700]!,
                        onTap: _contactViaMessenger,
                      ),
                      const SizedBox(width: 20),
                      BuildSocialMediaButton(
                        context,
                        icon: const FaIcon(FontAwesomeIcons.twitter),
                        label: S.of(context).Twitter,
                        color: Colors.lightBlue,
                        onTap: _contactViaTwitter,
                      ),
                      const SizedBox(width: 20),
                      BuildSocialMediaButton(
                        context,
                        icon: const FaIcon(FontAwesomeIcons.instagram),
                        label: S.of(context).Instagram,
                        color: Colors.purpleAccent,
                        onTap: _contactViaInstagram,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                S.of(context).WeAppreciateFeedback,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _sendEmail() async {
  final Uri emailUri = Uri(
    scheme: 'mailto',
    path: 'zemax.c4@gmail.com',
    query:
        'subject=Help%20Needed&body=Hi%20there,%0D%0A%0D%0A', // Add more query parameters as needed
  );

  // استخدام canLaunchUrl و launchUrl بدلاً من canLaunch و launch
  if (await canLaunchUrl(emailUri)) {
    await launchUrl(emailUri);
  } else {
    // Could not launch the email app
    Get.snackbar(S.of(context as BuildContext).error,
        "${S.of(context as BuildContext).could_not_launch} \n $emailUri");
  }
}

/// Launches WhatsApp app to contact the developer for help.
///
/// Uses the `wa.me` URL scheme to open the WhatsApp app.
/// The [phoneNumber] is the developer's phone number without the
/// international dialing code (+).
/// The [message] is the pre-filled message to send to the developer.
///
/// If the WhatsApp app is not installed on the device,
/// a snackbar will be shown with an error message.

void _contactViaMessenger() async {
  // Replace with your Facebook page URL or Messenger link
  final Uri messengerUri = Uri.parse('https://m.me/zemax.c4');
  if (await canLaunch(messengerUri.toString())) {
    await launch(messengerUri.toString());
  } else {
    // Could not launch Messenger
    Get.snackbar(S.of(context as BuildContext).error,
        "${S.of(context as BuildContext).could_not_launch} Messenger");
  }
}

void _contactViaTwitter() async {
  // Replace with your Twitter handle
  final Uri twitterUri = Uri.parse('https://twitter.com/zemax_c4');
  if (await canLaunch(twitterUri.toString())) {
    await launch(twitterUri.toString());
  } else {
    // Could not launch Twitter
    Get.snackbar(S.of(context as BuildContext).error,
        "'${S.of(context as BuildContext).could_not_launch} Twitter");
  }
}

void _contactViaInstagram() async {
  final Uri instagramUri = Uri.parse('https://instagram.com/mohamed_emad_c4');
  if (await canLaunch(instagramUri.toString())) {
    await launch(instagramUri.toString());
  } else {
    Get.snackbar(S.of(context as BuildContext).error,
        "${S.of(context as BuildContext).could_not_launch} Instagram");
  }
}
