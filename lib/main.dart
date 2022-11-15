import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:geolocator/geolocator.dart' as geo;
import 'package:lottie/lottie.dart';
import 'package:newdream/controllers/banners_controller.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'Assistants/globals.dart';
import 'controllers/address_location_controller.dart';
import 'controllers/cart_controller.dart';
import 'controllers/catgories_controller.dart';
import 'controllers/lang_controller.dart';
import 'controllers/payment_controller.dart';
import 'controllers/product_controller.dart';
import 'controllers/register_controller.dart';
import 'controllers/start_up_controller.dart';
import 'services/localization/localization.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  final addressController =
      Get.putAsync(() async => AddressController(), permanent: true);
  final productController =
      Get.putAsync(() async => ProductsController(), permanent: true);
  final categoriesController =
      Get.putAsync(() async => CategoriesController(), permanent: true);
  final cartController =
      Get.putAsync(() async => CartController(), permanent: true);
  final langController =Get.putAsync(() async => LangController(),permanent: true);
  final paymentController =Get.putAsync(() async => PaymentController(),permanent: true);
  final registerController =Get.putAsync(() async => RegisterController(),permanent: true);
  final bannerController =Get.putAsync(() async => BannerController(),permanent: true);

  runApp( ScreenUtilInit(
      designSize: const Size(380, 810),

      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context , child) {
    return GetMaterialApp(
      builder:(context, widget) =>ResponsiveWrapper.builder(
        BouncingScrollWrapper.builder(context, widget!),
        maxWidth: 1200,
        minWidth: 400.0,
        defaultScale: true,
        breakpoints: const [
          ResponsiveBreakpoint.resize(450, name: MOBILE),
          ResponsiveBreakpoint.autoScale(800, name: TABLET),
          ResponsiveBreakpoint.autoScale(1000, name: TABLET),
          ResponsiveBreakpoint.resize(1200, name: DESKTOP),
          ResponsiveBreakpoint.autoScale(2460, name: "4K"),
        ],
        background: Container(
          color: const Color(0xFFF5F5F5),
        ),
      ),
      locale: Locale('en'),
      fallbackLocale: Locale('en'),
      translations: Localization(),
      home: MyApp(),
      debugShowCheckedModeBanner: false,
    );}
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AddressController addressController = Get.find();
  final startUpController = Get.put(StartUpController());
  late loc.PermissionStatus _permissionGranted;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    locatePosition();
    startUpController.fetchUserLoginPreference();
  }

  var geoLocator = geo.Geolocator();
  loc.Location location = loc.Location.instance;

  geo.Position? currentPos;
  void locatePosition() async {
    loc.PermissionStatus permissionStatus = await location.hasPermission();
    _permissionGranted = permissionStatus;
    if (_permissionGranted != loc.PermissionStatus.granted) {
      final loc.PermissionStatus permissionStatusReqResult =
          await location.requestPermission();

      _permissionGranted = permissionStatusReqResult;
    }
    loc.LocationData loca = await location.getLocation();
    print('loca ...............  $loca');
    if(loca.latitude !=null){
      addressController.areaLoc.value =
          LatLng(loca.latitude!, loca.longitude!);
    }else{

    }

  }
  final screenSize = Get.size;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(140),
      margin: EdgeInsets.zero,
      color: Colors.white,
      child: FittedBox(
        child: SizedBox(
          width: 80,
          height: 80,

          child: Lottie.asset(
            'assets/animations/loading_black_background_editor.json',
            width: 80,
            height: 80,

          ),
        )
      ),
    );
  }
}
