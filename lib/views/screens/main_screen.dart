import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Assistants/assistantMethods.dart';
import '../../Assistants/globals.dart';
import '../../controllers/account_controller.dart';
import '../../controllers/address_location_controller.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/lang_controller.dart';
import '../../controllers/product_controller.dart';
import 'auth/register.dart';
import 'categories/categories_screen.dart';
import 'offers_screen.dart';
import 'order/Cart.dart';
import 'account/account.dart';
import 'home/home.dart';

class MainScreen extends StatefulWidget {
  final index ;
  const MainScreen({Key? key,required this.index}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final AddressController addressController = Get.find();
  final cartController = Get.put(CartController());

  final List<Widget> screens = [
    const HomeScreen(),
    const CategoriesScreen(),
    const OffersScreen(),
    const Cart(),
    Account(),
  ];
  final ProductsController productController = Get.find();
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const HomeScreen();
  int? currentTp = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    autoLang();
    currentTp = widget.index;
    productController.listProductsByFavorite('a', langController.appLocal);
    productController.getMyFav();
    cartController.getMyOrders(langController.appLocal);
  }
//lng
  final LangController langController = Get.find();
  void autoLang()async{
    setState(() {
      currentScreen =screens[widget.index];
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var lang = await prefs.getString('lang');
    print("lang ====== lang === $lang");
    if(lang !=null){
      langController.changeLang(lang);
      Get.updateLocale(Locale(lang));
      langController.changeDIR(lang);
      print(Get.deviceLocale);
      print(Get.locale);
    }
    productController.getLatestProducts(langController.appLocal);
    productController.listProductsOffers('',langController.appLocal);

  }
  @override
  Widget build(BuildContext context) {
print("screen size : ${MediaQuery.of(context).size}");
    return Scaffold(
        body: PageStorage(
          bucket: bucket,
          child: currentScreen,
        ),
        bottomNavigationBar: NavigationBar(
            height:langController.appLocal=='en' ?55.0:62,
            backgroundColor: Colors.white,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            selectedIndex: currentTp!,
            onDestinationSelected: (index) {
              setState(() {
                currentScreen = screens[index];
                currentTp = index;
              });
            },
            animationDuration: const Duration(milliseconds: 1),
            destinations: [
              NavigationBarTheme(
                  data: NavigationBarThemeData(
                      indicatorColor: Colors.grey.shade200,
                      labelTextStyle: MaterialStateProperty.all(const TextStyle(
                          fontSize: 11, fontWeight: FontWeight.bold))),
                  child: NavigationDestination(
                    icon: SvgPicture.asset('assets/icons/home-fill.svg',
                        color: Colors.grey[600],
                        height: 22.00,
                        width: 22.0,
                        semanticsLabel: 'A red up arrow'),
                    label: 'home_btn'.tr,
                    selectedIcon: SvgPicture.asset('assets/icons/home-fill.svg',
                        height: 24.00,
                        width: 24.0,
                        color: myHexColor3,
                        semanticsLabel: 'A red up arrow'),
                  )),
              NavigationBarTheme(
                  data: NavigationBarThemeData(
                    indicatorColor: Colors.grey.shade200,
                    labelTextStyle: MaterialStateProperty.all(
                      const TextStyle(
                          fontSize: 11, fontWeight: FontWeight.bold),
                    ),
                  ),
                  child: NavigationDestination(
                    icon: SvgPicture.asset(
                        'assets/icons/categories-outline.svg',
                        color: Colors.grey[600],
                        height: 22.00,
                        width: 22.0,
                        semanticsLabel: 'A red up arrow'),
                    label: 'categories_btn'.tr,
                    selectedIcon: SvgPicture.asset(//assets/icons/categories-fill.svg
                        'assets/icons/categories-outline.svg',
                        color: myHexColor3,
                        height: 24.00,
                        width: 24.0,
                        semanticsLabel: 'A red up arrow'),
                  )),
              NavigationBarTheme(
                  data: NavigationBarThemeData(
                      indicatorColor: Colors.grey.shade200,
                      labelTextStyle: MaterialStateProperty.all(const TextStyle(
                          fontSize: 11, fontWeight: FontWeight.bold))),
                  child: NavigationDestination(
                    icon: SvgPicture.asset('assets/icons/offers-outline.svg',
                        color: Colors.grey[600],
                        height: 22.00,
                        width: 22.0,
                        semanticsLabel: 'A red up arrow'),
                    label: 'clearance_btn'.tr,
                    selectedIcon: SvgPicture.asset(//assets/icons/offers-fill.svg
                        'assets/icons/offers-outline.svg',
                        color: myHexColor3,
                        height: 24.00,
                        width: 24.0,
                        semanticsLabel: 'A red up arrow'),
                  )),
              NavigationBarTheme(
                  data: NavigationBarThemeData(
                      indicatorColor: Colors.grey.shade200,
                      labelTextStyle: MaterialStateProperty.all(const TextStyle(
                          fontSize: 11, fontWeight: FontWeight.bold))),
                  child: NavigationDestination(
                    icon: SvgPicture.asset('assets/icons/cart-outline.svg',
                        color: Colors.grey[600],
                        height: 22.00,
                        width: 22.0,
                        semanticsLabel: 'A red up arrow'),
                    label: 'cart_btn'.tr,
                    selectedIcon: SvgPicture.asset(//assets/icons/cart-fill.svg
                        'assets/icons/cart-outline.svg',
                        height: 24.00,
                        width: 24.0,
                        color: myHexColor3,
                        semanticsLabel: 'A red up arrow'),
                  )),
              NavigationBarTheme(
                  data: NavigationBarThemeData(
                      indicatorColor: Colors.grey.shade200,
                      labelTextStyle: MaterialStateProperty.all(const TextStyle(
                          fontSize: 11, fontWeight: FontWeight.bold))),
                  child: NavigationDestination(
                    icon: SvgPicture.asset('assets/icons/account-outline.svg',
                        height: 22.00,
                        width: 22.0,
                        color: Colors.grey[600],
                        semanticsLabel: 'A red up arrow'),
                    label: 'myAccount_btn'.tr,
                    selectedIcon: SvgPicture.asset( //assets/icons/account-fill.svg
                        'assets/icons/account-outline.svg',
                        height: 24.00,
                        width: 24.0,
                        color: myHexColor3,
                        semanticsLabel: 'A red up arrow'),
                  )),
            ]));
  }
}
