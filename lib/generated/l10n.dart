// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `All Playlists`
  String get all_Playlists {
    return Intl.message(
      'All Playlists',
      name: 'all_Playlists',
      desc: '',
      args: [],
    );
  }

  /// `All Videos`
  String get all_Videos {
    return Intl.message(
      'All Videos',
      name: 'all_Videos',
      desc: '',
      args: [],
    );
  }

  /// `Add Playlist`
  String get add_Playlist {
    return Intl.message(
      'Add Playlist',
      name: 'add_Playlist',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get total_Time {
    return Intl.message(
      'Time',
      name: 'total_Time',
      desc: '',
      args: [],
    );
  }

  /// `Videos`
  String get total_Videos {
    return Intl.message(
      'Videos',
      name: 'total_Videos',
      desc: '',
      args: [],
    );
  }

  /// `Insert`
  String get insert {
    return Intl.message(
      'Insert',
      name: 'insert',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `View Playlist`
  String get view_Playlist {
    return Intl.message(
      'View Playlist',
      name: 'view_Playlist',
      desc: '',
      args: [],
    );
  }

  /// `View Playlist Roadmap`
  String get view_Playlist_Roadmap {
    return Intl.message(
      'View Playlist Roadmap',
      name: 'view_Playlist_Roadmap',
      desc: '',
      args: [],
    );
  }

  /// `Duration`
  String get duration {
    return Intl.message(
      'Duration',
      name: 'duration',
      desc: '',
      args: [],
    );
  }

  /// `The Playlist Roadmap`
  String get the_Playlist_Roadmap {
    return Intl.message(
      'The Playlist Roadmap',
      name: 'the_Playlist_Roadmap',
      desc: '',
      args: [],
    );
  }

  /// `Video`
  String get video {
    return Intl.message(
      'Video',
      name: 'video',
      desc: '',
      args: [],
    );
  }

  /// `Title`
  String get title {
    return Intl.message(
      'Title',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `No playlists found`
  String get no_playlists_found {
    return Intl.message(
      'No playlists found',
      name: 'no_playlists_found',
      desc: '',
      args: [],
    );
  }

  /// `Enter any notes about the playlist`
  String get enter_any_notes_about_the_playlist {
    return Intl.message(
      'Enter any notes about the playlist',
      name: 'enter_any_notes_about_the_playlist',
      desc: '',
      args: [],
    );
  }

  /// `Notes`
  String get notes {
    return Intl.message(
      'Notes',
      name: 'notes',
      desc: '',
      args: [],
    );
  }

  /// `Enter the URL of the playlist`
  String get enter_the_URL_of_the_playlist {
    return Intl.message(
      'Enter the URL of the playlist',
      name: 'enter_the_URL_of_the_playlist',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a URL`
  String get please_enter_a_URL {
    return Intl.message(
      'Please enter a URL',
      name: 'please_enter_a_URL',
      desc: '',
      args: [],
    );
  }

  /// `error`
  String get error {
    return Intl.message(
      'error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Invalid playlist URL`
  String get invalid_playlist_URL {
    return Intl.message(
      'Invalid playlist URL',
      name: 'invalid_playlist_URL',
      desc: '',
      args: [],
    );
  }

  /// `URL`
  String get url {
    return Intl.message(
      'URL',
      name: 'url',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid YouTube playlist URL`
  String get please_enter_a_valid_youtube_playlist_URL {
    return Intl.message(
      'Please enter a valid YouTube playlist URL',
      name: 'please_enter_a_valid_youtube_playlist_URL',
      desc: '',
      args: [],
    );
  }

  /// `Playlist URL`
  String get playlist_url {
    return Intl.message(
      'Playlist URL',
      name: 'playlist_url',
      desc: '',
      args: [],
    );
  }

  /// `Playlist Notes`
  String get playlist_notes {
    return Intl.message(
      'Playlist Notes',
      name: 'playlist_notes',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong`
  String get something_went_wrong {
    return Intl.message(
      'Something went wrong',
      name: 'something_went_wrong',
      desc: '',
      args: [],
    );
  }

  /// `All Days Roadmap`
  String get all_days_roadmap {
    return Intl.message(
      'All Days Roadmap',
      name: 'all_days_roadmap',
      desc: '',
      args: [],
    );
  }

  /// `Loading...`
  String get loading {
    return Intl.message(
      'Loading...',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `No videos found`
  String get no_videos_found {
    return Intl.message(
      'No videos found',
      name: 'no_videos_found',
      desc: '',
      args: [],
    );
  }

  /// `Could not launch`
  String get could_not_launch {
    return Intl.message(
      'Could not launch',
      name: 'could_not_launch',
      desc: '',
      args: [],
    );
  }

  /// `Notes `
  String get Notes {
    return Intl.message(
      'Notes ',
      name: 'Notes',
      desc: '',
      args: [],
    );
  }

  /// `About Us`
  String get AboutUs {
    return Intl.message(
      'About Us',
      name: 'AboutUs',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to our app! We are dedicated to providing you with the best service and experience. Our team is committed to continuous improvement and innovation to meet your needs.`
  String get WelcomeMessage {
    return Intl.message(
      'Welcome to our app! We are dedicated to providing you with the best service and experience. Our team is committed to continuous improvement and innovation to meet your needs.',
      name: 'WelcomeMessage',
      desc: '',
      args: [],
    );
  }

  /// `Our mission is to deliver high-quality solutions that improve your daily life and provide a seamless user experience.`
  String get OurMission {
    return Intl.message(
      'Our mission is to deliver high-quality solutions that improve your daily life and provide a seamless user experience.',
      name: 'OurMission',
      desc: '',
      args: [],
    );
  }

  /// `Contact Us`
  String get ContactUs {
    return Intl.message(
      'Contact Us',
      name: 'ContactUs',
      desc: '',
      args: [],
    );
  }

  /// `If you have any questions, feedback, or just want to get in touch, feel free to contact us.`
  String get QuestionsFeedback {
    return Intl.message(
      'If you have any questions, feedback, or just want to get in touch, feel free to contact us.',
      name: 'QuestionsFeedback',
      desc: '',
      args: [],
    );
  }

  /// `Email Us`
  String get EmailUs {
    return Intl.message(
      'Email Us',
      name: 'EmailUs',
      desc: '',
      args: [],
    );
  }

  /// `Follow us on social media:`
  String get FollowUs {
    return Intl.message(
      'Follow us on social media:',
      name: 'FollowUs',
      desc: '',
      args: [],
    );
  }

  /// `Facebook`
  String get Facebook {
    return Intl.message(
      'Facebook',
      name: 'Facebook',
      desc: '',
      args: [],
    );
  }

  /// `Twitter`
  String get Twitter {
    return Intl.message(
      'Twitter',
      name: 'Twitter',
      desc: '',
      args: [],
    );
  }

  /// `Instagram`
  String get Instagram {
    return Intl.message(
      'Instagram',
      name: 'Instagram',
      desc: '',
      args: [],
    );
  }

  /// `Could not launch`
  String get CouldNotLaunch {
    return Intl.message(
      'Could not launch',
      name: 'CouldNotLaunch',
      desc: '',
      args: [],
    );
  }

  /// `Help & Support`
  String get HelpSupport {
    return Intl.message(
      'Help & Support',
      name: 'HelpSupport',
      desc: '',
      args: [],
    );
  }

  /// `We are here to help! Whether you have a question, encounter an issue, or need further assistance, our support team is ready to assist you.`
  String get WeAreHereToHelp {
    return Intl.message(
      'We are here to help! Whether you have a question, encounter an issue, or need further assistance, our support team is ready to assist you.',
      name: 'WeAreHereToHelp',
      desc: '',
      args: [],
    );
  }

  /// `FAQ`
  String get FAQ {
    return Intl.message(
      'FAQ',
      name: 'FAQ',
      desc: '',
      args: [],
    );
  }

  /// `How can I reset my password?`
  String get ResetPassword {
    return Intl.message(
      'How can I reset my password?',
      name: 'ResetPassword',
      desc: '',
      args: [],
    );
  }

  /// `How to change my email address?`
  String get ChangeEmail {
    return Intl.message(
      'How to change my email address?',
      name: 'ChangeEmail',
      desc: '',
      args: [],
    );
  }

  /// `How to contact customer support?`
  String get ContactSupport {
    return Intl.message(
      'How to contact customer support?',
      name: 'ContactSupport',
      desc: '',
      args: [],
    );
  }

  /// `If you didn't find the answer you're looking for, feel free to contact us directly:`
  String get DidntFindAnswer {
    return Intl.message(
      'If you didn\'t find the answer you\'re looking for, feel free to contact us directly:',
      name: 'DidntFindAnswer',
      desc: '',
      args: [],
    );
  }

  /// `Connect with us on social media:`
  String get ConnectWithUs {
    return Intl.message(
      'Connect with us on social media:',
      name: 'ConnectWithUs',
      desc: '',
      args: [],
    );
  }

  /// `WhatsApp`
  String get WhatsApp {
    return Intl.message(
      'WhatsApp',
      name: 'WhatsApp',
      desc: '',
      args: [],
    );
  }

  /// `Messenger`
  String get Messenger {
    return Intl.message(
      'Messenger',
      name: 'Messenger',
      desc: '',
      args: [],
    );
  }

  /// `We appreciate your feedback and strive to improve our service continuously.`
  String get WeAppreciateFeedback {
    return Intl.message(
      'We appreciate your feedback and strive to improve our service continuously.',
      name: 'WeAppreciateFeedback',
      desc: '',
      args: [],
    );
  }

  /// `Privacy and Security`
  String get PrivacyAndSecurity {
    return Intl.message(
      'Privacy and Security',
      name: 'PrivacyAndSecurity',
      desc: '',
      args: [],
    );
  }

  /// `Your privacy and security are important to us. We take the following measures to ensure that your data is protected:`
  String get YourPrivacyAndSecurity {
    return Intl.message(
      'Your privacy and security are important to us. We take the following measures to ensure that your data is protected:',
      name: 'YourPrivacyAndSecurity',
      desc: '',
      args: [],
    );
  }

  /// `Data Encryption: We use industry-standard encryption to protect your data.`
  String get DataEncryption {
    return Intl.message(
      'Data Encryption: We use industry-standard encryption to protect your data.',
      name: 'DataEncryption',
      desc: '',
      args: [],
    );
  }

  /// `Access Control: No personnel can access your data.`
  String get AccessControl {
    return Intl.message(
      'Access Control: No personnel can access your data.',
      name: 'AccessControl',
      desc: '',
      args: [],
    );
  }

  /// `Regular Audits: We conduct regular security audits to identify and fix vulnerabilities.`
  String get RegularAudits {
    return Intl.message(
      'Regular Audits: We conduct regular security audits to identify and fix vulnerabilities.',
      name: 'RegularAudits',
      desc: '',
      args: [],
    );
  }

  /// `User Control: You have control over your data and can manage your settings at any time.`
  String get UserControl {
    return Intl.message(
      'User Control: You have control over your data and can manage your settings at any time.',
      name: 'UserControl',
      desc: '',
      args: [],
    );
  }

  /// `PIN: We use PIN codes to protect your notes and ensure that only you can access them.`
  String get PIN {
    return Intl.message(
      'PIN: We use PIN codes to protect your notes and ensure that only you can access them.',
      name: 'PIN',
      desc: '',
      args: [],
    );
  }

  /// `For any questions or concerns, please contact our support team.`
  String get ForAnyQuestions {
    return Intl.message(
      'For any questions or concerns, please contact our support team.',
      name: 'ForAnyQuestions',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get Close {
    return Intl.message(
      'Close',
      name: 'Close',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get arabic {
    return Intl.message(
      'Arabic',
      name: 'arabic',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get theme {
    return Intl.message(
      'Theme',
      name: 'theme',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get darkMode {
    return Intl.message(
      'Dark Mode',
      name: 'darkMode',
      desc: '',
      args: [],
    );
  }

  /// `Light Mode`
  String get lightMode {
    return Intl.message(
      'Light Mode',
      name: 'lightMode',
      desc: '',
      args: [],
    );
  }

  /// `Q: Why does it take a long time to load data in the app?`
  String get q1 {
    return Intl.message(
      'Q: Why does it take a long time to load data in the app?',
      name: 'q1',
      desc: '',
      args: [],
    );
  }

  /// `A: There can be several factors contributing to data loading delays, including:`
  String get a_q1 {
    return Intl.message(
      'A: There can be several factors contributing to data loading delays, including:',
      name: 'a_q1',
      desc: '',
      args: [],
    );
  }

  /// `A: We are continuously working to improve the apps performance to reduce loading times. Thank you for your understanding!`
  String get a1_q1 {
    return Intl.message(
      'A: We are continuously working to improve the apps performance to reduce loading times. Thank you for your understanding!',
      name: 'a1_q1',
      desc: '',
      args: [],
    );
  }

  /// `A:Internet Connection: Ensure that your internet connection is stable and fast.`
  String get a2_q1 {
    return Intl.message(
      'A:Internet Connection: Ensure that your internet connection is stable and fast.',
      name: 'a2_q1',
      desc: '',
      args: [],
    );
  }

  /// `A:Data Size: Loading large amounts of data may take longer.`
  String get a3_q1 {
    return Intl.message(
      'A:Data Size: Loading large amounts of data may take longer.',
      name: 'a3_q1',
      desc: '',
      args: [],
    );
  }

  /// `A:Server Performance: Sometimes, there may be delays from the server hosting the data.`
  String get a4_q1 {
    return Intl.message(
      'A:Server Performance: Sometimes, there may be delays from the server hosting the data.',
      name: 'a4_q1',
      desc: '',
      args: [],
    );
  }

  /// `A:App Updates: Updates or maintenance may temporarily slow down the app.`
  String get a5_q1 {
    return Intl.message(
      'A:App Updates: Updates or maintenance may temporarily slow down the app.',
      name: 'a5_q1',
      desc: '',
      args: [],
    );
  }

  /// `Q: How can I add a YouTube playlist?`
  String get q2 {
    return Intl.message(
      'Q: How can I add a YouTube playlist?',
      name: 'q2',
      desc: '',
      args: [],
    );
  }

  /// `A: You can add a YouTube playlist by entering the playlist link into the app. The app will analyze the link and retrieve all the videos within it.`
  String get a1_q2 {
    return Intl.message(
      'A: You can add a YouTube playlist by entering the playlist link into the app. The app will analyze the link and retrieve all the videos within it.',
      name: 'a1_q2',
      desc: '',
      args: [],
    );
  }

  /// `Q: What does the app display after adding a playlist?`
  String get q3 {
    return Intl.message(
      'Q: What does the app display after adding a playlist?',
      name: 'q3',
      desc: '',
      args: [],
    );
  }

  /// `A: After adding the playlist, the app will display all the videos contained within it, along with the duration of each video and the total duration of all videos.`
  String get a1_q3 {
    return Intl.message(
      'A: After adding the playlist, the app will display all the videos contained within it, along with the duration of each video and the total duration of all videos.',
      name: 'a1_q3',
      desc: '',
      args: [],
    );
  }

  /// `Q: What is the roadmap that is created?`
  String get q4 {
    return Intl.message(
      'Q: What is the roadmap that is created?',
      name: 'q4',
      desc: '',
      args: [],
    );
  }

  /// `A: The roadmap is a suggested timeline for watching the videos based on the duration you specify. You can set the amount of time you want to dedicate to watching the videos, and the app will provide a plan for you to follow.`
  String get a1_q4 {
    return Intl.message(
      'A: The roadmap is a suggested timeline for watching the videos based on the duration you specify. You can set the amount of time you want to dedicate to watching the videos, and the app will provide a plan for you to follow.',
      name: 'a1_q4',
      desc: '',
      args: [],
    );
  }

  /// `Q: Can I modify the durations of the videos in the roadmap?`
  String get q5 {
    return Intl.message(
      'Q: Can I modify the durations of the videos in the roadmap?',
      name: 'q5',
      desc: '',
      args: [],
    );
  }

  /// `A: Currently, you cannot modify the durations of the videos in the roadmap, but you can choose a different duration when setting up the roadmap for a different plan.`
  String get a1_q5 {
    return Intl.message(
      'A: Currently, you cannot modify the durations of the videos in the roadmap, but you can choose a different duration when setting up the roadmap for a different plan.',
      name: 'a1_q5',
      desc: '',
      args: [],
    );
  }

  /// `Q: Does the app work with all YouTube playlists?`
  String get q6 {
    return Intl.message(
      'Q: Does the app work with all YouTube playlists?',
      name: 'q6',
      desc: '',
      args: [],
    );
  }

  /// `A: Yes, the app works with any public YouTube playlist. Just make sure to enter the correct link for the playlist.`
  String get a1_q6 {
    return Intl.message(
      'A: Yes, the app works with any public YouTube playlist. Just make sure to enter the correct link for the playlist.',
      name: 'a1_q6',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Publishing Date : October 1, 2024`
  String get effective_date {
    return Intl.message(
      'Publishing Date : October 1, 2024',
      name: 'effective_date',
      desc: '',
      args: [],
    );
  }

  /// `We take your privacy seriously. By using our app, we are committed to protecting your privacy. This privacy policy outlines how we collect, use, and safeguard your information when you use our app [App Name].`
  String get we_take_privacy_seriously {
    return Intl.message(
      'We take your privacy seriously. By using our app, we are committed to protecting your privacy. This privacy policy outlines how we collect, use, and safeguard your information when you use our app [App Name].',
      name: 'we_take_privacy_seriously',
      desc: '',
      args: [],
    );
  }

  /// `Information We Collect`
  String get information_we_collect {
    return Intl.message(
      'Information We Collect',
      name: 'information_we_collect',
      desc: '',
      args: [],
    );
  }

  /// `Personal Information`
  String get personal_information {
    return Intl.message(
      'Personal Information',
      name: 'personal_information',
      desc: '',
      args: [],
    );
  }

  /// `1. Personal Information: When you use our app, we may collect personal information such as your name, email address, and any other information you provide voluntarily.`
  String get personal_information1 {
    return Intl.message(
      '1. Personal Information: When you use our app, we may collect personal information such as your name, email address, and any other information you provide voluntarily.',
      name: 'personal_information1',
      desc: '',
      args: [],
    );
  }

  /// `2. Usage Data: We may collect information about how you access and use the app, including device information, IP address, browser type, and pages you visit.`
  String get personal_information2 {
    return Intl.message(
      '2. Usage Data: We may collect information about how you access and use the app, including device information, IP address, browser type, and pages you visit.',
      name: 'personal_information2',
      desc: '',
      args: [],
    );
  }

  /// `How We Use Your Information`
  String get how_we_use_your_information {
    return Intl.message(
      'How We Use Your Information',
      name: 'how_we_use_your_information',
      desc: '',
      args: [],
    );
  }

  /// `• To provide and maintain our app.`
  String get to_provide_and_maintain {
    return Intl.message(
      '• To provide and maintain our app.',
      name: 'to_provide_and_maintain',
      desc: '',
      args: [],
    );
  }

  /// `• To notify you about changes to our app.`
  String get to_notify_you_about {
    return Intl.message(
      '• To notify you about changes to our app.',
      name: 'to_notify_you_about',
      desc: '',
      args: [],
    );
  }

  /// `• To allow you to participate in interactive features when you choose to do so.`
  String get to_allow_you_to_participate {
    return Intl.message(
      '• To allow you to participate in interactive features when you choose to do so.',
      name: 'to_allow_you_to_participate',
      desc: '',
      args: [],
    );
  }

  /// `• To provide customer support.`
  String get to_provide_support_for {
    return Intl.message(
      '• To provide customer support.',
      name: 'to_provide_support_for',
      desc: '',
      args: [],
    );
  }

  /// `• To gather analysis or valuable information so that we can improve the app.`
  String get to_gather_analyze_data {
    return Intl.message(
      '• To gather analysis or valuable information so that we can improve the app.',
      name: 'to_gather_analyze_data',
      desc: '',
      args: [],
    );
  }

  /// `• To monitor the usage of the app.`
  String get to_monitor {
    return Intl.message(
      '• To monitor the usage of the app.',
      name: 'to_monitor',
      desc: '',
      args: [],
    );
  }

  /// `• To detect, prevent, and address technical issues.`
  String get to_detect {
    return Intl.message(
      '• To detect, prevent, and address technical issues.',
      name: 'to_detect',
      desc: '',
      args: [],
    );
  }

  /// `Data Security`
  String get data_security {
    return Intl.message(
      'Data Security',
      name: 'data_security',
      desc: '',
      args: [],
    );
  }

  /// `We take the security of your personal information seriously and implement reasonable measures to protect it. However, please remember that no method of transmission over the Internet or method of electronic storage is 100% secure.`
  String get we_take_security {
    return Intl.message(
      'We take the security of your personal information seriously and implement reasonable measures to protect it. However, please remember that no method of transmission over the Internet or method of electronic storage is 100% secure.',
      name: 'we_take_security',
      desc: '',
      args: [],
    );
  }

  /// `Third Party Services`
  String get third_party {
    return Intl.message(
      'Third Party Services',
      name: 'third_party',
      desc: '',
      args: [],
    );
  }

  /// `Our app may contain links to third-party sites or services. We have no control over, and assume no responsibility for, the content or privacy policies of any third-party sites or services.`
  String get our_app {
    return Intl.message(
      'Our app may contain links to third-party sites or services. We have no control over, and assume no responsibility for, the content or privacy policies of any third-party sites or services.',
      name: 'our_app',
      desc: '',
      args: [],
    );
  }

  /// `Changes to This Privacy Policy`
  String get change_this {
    return Intl.message(
      'Changes to This Privacy Policy',
      name: 'change_this',
      desc: '',
      args: [],
    );
  }

  /// `We may update our privacy policy from time to time. We will notify you of any changes by posting the new privacy policy on this page. You are advised to review this privacy policy periodically for any changes.`
  String get we_may_update {
    return Intl.message(
      'We may update our privacy policy from time to time. We will notify you of any changes by posting the new privacy policy on this page. You are advised to review this privacy policy periodically for any changes.',
      name: 'we_may_update',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get time {
    return Intl.message(
      'Time',
      name: 'time',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the time in minutes`
  String get enter_time_in_minutes {
    return Intl.message(
      'Please enter the time in minutes',
      name: 'enter_time_in_minutes',
      desc: '',
      args: [],
    );
  }

  /// `Invalid playlist URL`
  String get invalid_playlist_url {
    return Intl.message(
      'Invalid playlist URL',
      name: 'invalid_playlist_url',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid time`
  String get please_enter_a_valid_time {
    return Intl.message(
      'Please enter a valid time',
      name: 'please_enter_a_valid_time',
      desc: '',
      args: [],
    );
  }

  /// `Please enter time`
  String get please_enter_time {
    return Intl.message(
      'Please enter time',
      name: 'please_enter_time',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
