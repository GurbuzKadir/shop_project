import 'package:eshop/common/common.dart';
import 'package:eshop/ui/home/view/home_screen.dart';
import 'package:flutter_onboarding_screen/OnbordingData.dart';
import 'package:flutter_onboarding_screen/flutteronboardingscreens.dart';

class OnBoardingScreen extends StatelessWidget {
  final List<OnbordingData> list = [
    OnbordingData(
      imagePath: "images/pic11.png",
      title: "Ara",
      desc:
          "Yemek türüne göre restoranları keşfedin, Yakındaki restoranlar için menüleri ve fotoğrafları görün ve hareket halindeyken favori yerlerinizi işaretleyin",
    ),
    OnbordingData(
      imagePath: "images/pic12.png",
      title: "Satış",
      desc:
          "Kapınıza kadar gelen en iyi restoranlar, Menülere göz atın ve siparişinizi saniyeler içinde oluşturun",
    ),
    OnbordingData(
      imagePath: "images/pic13.png",
      title: "Yemek",
      desc:
          "Trendlere göre en iyi restoran, kafe, marketlerin derlenmiş listelerini keşfedin.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return new IntroScreen(
      list,
      MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ),
    );
  }
}
