import 'package:flutter/material.dart';

// globalVaribul.dart
int currentPageIndex = 0;

List<Widget> widgetIntial = []; // We will initialize this after defining the PageViewInitial

// PageView widget to display initial screens
class PageViewInitial extends StatefulWidget {
  const PageViewInitial({super.key});

  @override
  _PageViewInitialState createState() => _PageViewInitialState();
}

class _PageViewInitialState extends State<PageViewInitial> {
  final PageController _pageController = PageController(); // Single PageController for all pages

  @override
  void initState() {
    super.initState();

    // Initialize widgetIntial with the required PageController passed to the screens
    widgetIntial = [
      WelcomeScreen(pageController: _pageController),
      FeaturesScreen(pageController: _pageController),
      const InitialSettingsScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController, // Attach the PageController here
        itemBuilder: (context, index) => widgetIntial[index],
        itemCount: widgetIntial.length,
        onPageChanged: (index) {
          setState(() {
            currentPageIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPageIndex,
        onTap: (index) {
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'مرحبا'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'الميزات'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'الإعدادات'),
        ],
      ),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  final PageController pageController; // Required pageController parameter
  const WelcomeScreen({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Welcome to YouTube to Todo",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Image.asset("assets/images/welcome.png"),
              const SizedBox(height: 20),
              const Text(
                "استمتع بتجربة مشاهدة مقاطع الفيديو على يوتيوب بطريقة جديدة ومرتبة.",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  pageController.animateToPage(
                    1,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "التالي",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FeaturesScreen extends StatelessWidget {
  final PageController pageController; // Required pageController parameter
  const FeaturesScreen({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "الميزات الرئيسية",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Image.asset("assets/images/feture.png"),
              const SizedBox(height: 20),
              const Column(
                children: [
                  Text("• الحصول على روابط من يوتيوب."),
                  Text("• إضافة ملاحظات لكل فيديو."),
                  Text("• تصنيف مقاطع الفيديو."),
                ],
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  pageController.animateToPage(
                    2,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "التالي",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InitialSettingsScreen extends StatelessWidget {
  const InitialSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "إعدادات أولية",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Image.asset("assets/images/lan.png"),
              const SizedBox(height: 20),
              const Text("قبل أن تبدأ، دعنا نعرف بعض الإعدادات."),
              const SizedBox(height: 40),
              DropdownButton<String>(
                items: <String>['العربية', 'الإنجليزية'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (_) {},
                hint: const Text("اختر اللغة"),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  // Navigate to the main screen or save settings
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text("إنهاء"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
