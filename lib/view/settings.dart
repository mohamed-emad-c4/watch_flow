import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:watch_flow/logic/shared_preferences.dart';
import 'package:watch_flow/view/setting_views/faq.dart';
import '../generated/l10n.dart';
import 'setting_views/about_us.dart';
import 'setting_views/help_and_support.dart';
import 'setting_views/privacy_and_security.dart';

class Setting extends StatelessWidget {
  final bool isDarkMode;

  const Setting({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).settings),
        centerTitle: true,
      ),
      body: SettingsListState(isDarkMode: isDarkMode),
    );
  }
}

class SettingsListState extends StatefulWidget {
  final bool isDarkMode;

  const SettingsListState({super.key, required this.isDarkMode});

  @override
  _SettingsListStateState createState() => _SettingsListStateState();
}

class _SettingsListStateState extends State<SettingsListState> {
  String selectedLanguage = 'en';
  bool isDarkMode = false;
  
  final SharePrefrenceClass sharePrefrenceClass = SharePrefrenceClass(); 

  @override
  void initState() {
    super.initState();
    _loadSavedPreferences();
  }

  Future<void> _loadSavedPreferences() async {
    final savedLanguage = await sharePrefrenceClass.getVlue(key: 'language', defaultValue: 'en');
    final savedTheme = await sharePrefrenceClass.getVlue(key: 'themeMode', defaultValue: false);
    
    setState(() {
      selectedLanguage = savedLanguage;
      isDarkMode = savedTheme;
    });
  }

  Future<void> _savePreferences(String language, bool theme) async {
    await sharePrefrenceClass.saveValueString(key: 'language', value: language);
    await sharePrefrenceClass.saveValuebool(key: 'themeMode', value: theme);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildLanguageTile(context),
        const Divider(),
        _buildThemeTile(context), // وضع التبديل للوضع الليلي
        const Divider(),
        _buildPrivacyTile(context),
        const Divider(),
        _buildHelpTile(context),
        const Divider(),
        _buildAboutTile(context),
        const Divider(),
        _buildFAQTile(context),
      ],
    );
  }

  // Language Dropdown Tile
  ListTile _buildLanguageTile(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.language),
      title: Text(S.of(context).settings),
      trailing: DropdownButton<String>(
        value: selectedLanguage,
        onChanged: (String? newValue) {
          setState(() {
            selectedLanguage = newValue!;
            _savePreferences(newValue, isDarkMode); // حفظ اللغة والوضع
          });
        },
        items: ['en', 'ar'].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(_getLanguageName(value)),
          );
        }).toList(),
      ),
    );
  }

  // Theme Mode Toggle
  ListTile _buildThemeTile(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.brightness_6),
      title: Text(S.of(context).darkMode),
      trailing: Switch(
        value: isDarkMode,
        onChanged: (bool value) {
          setState(() {
            isDarkMode = value;
            _savePreferences(selectedLanguage, value); 
          });
        },
      ),
    );
  }

  String _getLanguageName(String code) {
    switch (code) {
      case 'en':
        return S.of(context).english;
      case 'ar':
        return S.of(context).arabic;
      default:
        return 'Unknown';
    }
  }
}

// بلاطة الخصوصية والأمان
ListTile _buildPrivacyTile(BuildContext context) {
  return ListTile(
    leading: const Icon(Icons.lock),
    title: Text(S.of(context).PrivacyAndSecurity),
    onTap: () {
      Get.to(const PrivacyAndSecurityPage());
    },
  );
}

// بلاطة المساعدة والدعم
ListTile _buildHelpTile(BuildContext context) {
  return ListTile(
    leading: const Icon(Icons.help),
    title: Text(S.of(context).HelpSupport),
    onTap: () {
      Get.to(const HelpAndSupportPage());
    },
  );
}

// بلاطة "من نحن"
ListTile _buildAboutTile(BuildContext context) {
  return ListTile(
    leading: const Icon(Icons.info),
    title: Text(S.of(context).AboutUs),
    onTap: () {
      Get.to(const AboutUsPage());
    },
  );
}
ListTile _buildFAQTile(BuildContext context) {
  return ListTile(
    leading: const Icon(Icons.book),
    title: Text(S.of(context).FAQ),
    onTap: () {
      Get.to( const FAQSection());
    },
  );
}

Widget _buildSocialMediaButton(BuildContext context,
    {required FaIcon icon,
    required String label,
    required VoidCallback onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Theme.of(context).primaryColor,
          child: icon,
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 14),
        ),
      ],
    ),
  );
}

void _launchURL(String url) async {
  final Uri uri = Uri.parse(url);
  if (await canLaunch(uri.toString())) {
    await launch(uri.toString());
  } else {
    Get.snackbar("Error", "Could not launch");
  }
}

void _sendEmail() async {
  final Uri emailUri = Uri(
    scheme: 'mailto',
    path: 'zemax.c4@gmail.com',
    query: 'subject=Help%20Needed&body=Hi%20there,%0D%0A%0D%0A',
  );
  if (await canLaunch(emailUri.toString())) {
    await launch(emailUri.toString());
  } else {
    Get.snackbar("Error", "Could not launch");
  }
}

