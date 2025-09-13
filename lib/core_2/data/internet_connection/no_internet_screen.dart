import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:invite_flare/core_2/core/values/app_strings.dart';
import 'package:invite_flare/core_2/core/values/dimens.dart';
import 'package:invite_flare/core_2/core/values/text_styles.dart';
import 'package:invite_flare/core_2/core/widgets/annotated_region_widget.dart';
import 'package:invite_flare/core_2/core/widgets/button_widget.dart';
import '../../../export.dart';

class NoInternetConnectionScreen extends StatefulWidget {
  final int? screenType;

  NoInternetConnectionScreen({super.key, this.screenType});

  @override
  State createState() => _NoInternetConnectionScreenState();
}

class _NoInternetConnectionScreenState extends State<NoInternetConnectionScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: AnnotatedRegionWidget(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SizedBox(
            height: Get.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // AssetImageWidget(
                //   imageUrl: iconNoSignal,
                //   imageHeight: height_40,
                // ).marginOnly(bottom: margin_10),
                Text(
                  "No Connection",
                  style: textStyleBodyMedium().copyWith(fontSize: font_18, fontFamily: strFontsBoldInter, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: height_10,
                ),
                Text(
                  "No internet connection found.Check your connection or try again.",
                  textAlign: TextAlign.center,
                  style: textStyleBodyMedium().copyWith(color: Colors.black45, fontSize: font_15, fontFamily: strFontMediumInter, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: height_15,
                ),
                SizedBox(
                  width: Get.width / 2.5,
                  child: MaterialButtonWidget(
                    onPressed: () {
                      checkInternet();
                    },
                    fontsize: font_15,
                    buttonRadius: radius_10,
                    textColor: Colors.white,
                    buttonText: "Try Again",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void checkInternet() async {
    final ConnectivityResult connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      // toast('No internet connection');
    } else {
      if (widget.screenType == 1) {
        // Get.put(SplashController());
        Get.offAllNamed(AppRoutes.splash);
      } else {
        Get.back();
      }
    }
  }
}
