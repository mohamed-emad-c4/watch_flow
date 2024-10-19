import 'package:flutter/material.dart';

import '../../generated/l10n.dart';

class PrivacyAndSecurityPage extends StatelessWidget {
  const PrivacyAndSecurityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).PrivacyAndSecurity),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).effective_date,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 10),
            Text(
              S.of(context).we_take_privacy_seriously,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Text(
              S.of(context).information_we_collect,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 10),
            Text(
              S.of(context).personal_information1,
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              S.of(context).personal_information2,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Text(
              S.of(context).how_we_use_your_information,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 10),
            Text(
              S.of(context).to_provide_and_maintain,
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              S.of(context).to_notify_you_about,
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              S.of(context).to_allow_you_to_participate,
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              S.of(context).to_provide_support_for,
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              S.of(context).to_gather_analyze_data,
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              S.of(context).to_monitor,
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              S.of(context).to_detect,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Text(
            S.of(context).data_security,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 10),
            Text(
              S.of(context).we_take_security,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Text(
              S.of(context).third_party,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 10),
            Text(
              S.of(context).our_app,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Text(
              S.of(context).change_this,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 10),
            Text(
              S.of(context).we_may_update,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
           
          ],
        ),
        ),
      ),
    );
  }
}

