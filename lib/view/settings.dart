
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:watch_flow/logic/shared_preferences.dart';
import 'package:watch_flow/view/screens/intail/widgets/build_tablet.dart';
import 'package:watch_flow/view/setting_views/faq.dart';
import '../generated/l10n.dart';
import '../logic/cubit/updata_app_cubit.dart';
import 'setting_views/about_us.dart';
import 'setting_views/help_and_support.dart';
import 'setting_views/privacy_and_security.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).settings),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: const SettingsListState(),
    );
  }
}

class SettingsListState extends StatefulWidget {
  const SettingsListState({super.key});

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
    final savedLanguage =
        await sharePrefrenceClass.getVlue(key: 'language', defaultValue: 'en');
    final savedTheme = await sharePrefrenceClass.getVlue(
        key: 'themeMode', defaultValue: false);

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
        _buildThemeTile(context),
        const Divider(),
        build_tablet(
          title: S.of(context).PrivacyAndSecurity,
          onTap: () => Get.to(const PrivacyAndSecurityPage()),
          icon: Icons.security,
        ),
        const Divider(),
        build_tablet(
          title: S.of(context).HelpSupport,
          onTap: () => Get.to(const HelpAndSupportPage()),
          icon: Icons.help,
        ),
        const Divider(),
        build_tablet(
          title: S.of(context).AboutUs,
          onTap: () => Get.to(const AboutUsPage()),
          icon: Icons.info,
        ),
        const Divider(),
        build_tablet(
          title: S.of(context).FAQ,
          onTap: () => Get.to(const FAQSection()),
          icon: Icons.question_answer,
        ),
     
      ],
    );
  }

  // Language Dropdown Tile
  ListTile _buildLanguageTile(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.language),
      title: Text(S.of(context).language),
      trailing: DropdownButton<String>(
        value: selectedLanguage,
        onChanged: (String? newValue) {
          Get.snackbar(S.of(context).language_changed,
              S.of(context).restartTheApplicationToSeeChanges);
          setState(() {
            selectedLanguage = newValue!;
            _savePreferences(newValue, isDarkMode);
            BlocProvider.of<UpdataAppCubit>(context).updateLanguage(newValue);
             Get.forceAppUpdate();
            // تحديث اللغة
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
    final cubit = BlocProvider.of<UpdataAppCubit>(context);
    return ListTile(
      leading: const Icon(Icons.brightness_6),
      title: Text(S.of(context).darkMode),
      trailing: Switch(
        activeColor: Colors.blue[800],
        value: isDarkMode,
        onChanged: (bool value) {
          setState(() {
            isDarkMode = value;
            cubit.updateTheme(value);
            BlocProvider.of<UpdataAppCubit>(context).updateTheme(value);
            Get.snackbar(S.of(context).theme_changed,
                "${S.of(context).restartTheApplicationToSeeChanges} \n ${S.of(context).or_click_save}");
          });
           Get.forceAppUpdate();
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
        return S.of(context).unkown;
    }
  }
}

class FeaturesScreen extends StatelessWidget {
  const FeaturesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Text(S.of(context).main_features
                ,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Image.asset("assets/images/feature.png"),
              const SizedBox(height: 20),
               Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(S.of(context).feature1)   ,
                  Text(S.of(context).feature2),
                  Text(S.of(context).feature3),],
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  // Action on button press
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child:  Text(S.of(context).next),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
