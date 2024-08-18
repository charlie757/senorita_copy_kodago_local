
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:senorita/CommonScreens/notification/notification_binding.dart';
import 'package:senorita/CommonScreens/notification/notification_screen.dart';
import 'package:senorita/ExpertApp/BottomMenuScreen/addPhotos/addPhotosScreen.dart';
import 'package:senorita/ExpertApp/BottomMenuScreen/addPhotos/binding/addPhotosBinding.dart';
import 'package:senorita/ExpertApp/BottomMenuScreen/expert_edit_profile_screen/binding/expert_edit_profile_binding.dart';
import 'package:senorita/ExpertApp/BottomMenuScreen/expert_edit_profile_screen/expert_edit_profile_screen.dart';
import 'package:senorita/ExpertApp/BottomMenuScreen/expert_wallet_screen/binding/expert_wallet_binding.dart';
import 'package:senorita/ExpertApp/BottomMenuScreen/expert_wallet_screen/expert_wallet.dart';
import 'package:senorita/ExpertApp/BottomMenuScreen/specialoffers/add_offer_screen.dart';
import 'package:senorita/ExpertApp/BottomMenuScreen/specialoffers/binding/add_offer_binding.dart';
import 'package:senorita/ExpertApp/BottomMenuScreen/specialoffers/binding/special_offer_binding.dart';
import 'package:senorita/ExpertApp/BottomMenuScreen/specialoffers/special_offer_screen.dart';
import 'package:senorita/ExpertApp/expert_registration_screen/googleMap/googleMapScreen.dart';
import 'package:senorita/ExpertApp/expert_registration_screen/googleMapAnimation/binding/googleMapAnimationBinding.dart';
import 'package:senorita/ExpertApp/expert_registration_screen/googleMapAnimation/googleMapAnimation.dart';
import 'package:senorita/ExpertApp/searchLocationMap/searchLocationScreen.dart';
import 'package:senorita/ScreenRoutes/routes.dart';
import 'package:senorita/UserApp/BottomMenuScreen/change_location/change_location_binding.dart';
import 'package:senorita/UserApp/BottomMenuScreen/change_location/change_location_screen.dart';
import 'package:senorita/UserApp/BottomMenuScreen/editProfile/binding/editProfile_binding.dart';
import 'package:senorita/UserApp/BottomMenuScreen/editProfile/editProfile_screen.dart';
import 'package:senorita/UserApp/BottomMenuScreen/filter/filter_binding.dart';
import 'package:senorita/UserApp/BottomMenuScreen/filter/filter_screen.dart';
import 'package:senorita/UserApp/BottomMenuScreen/home_screen/binding/search_binding.dart';
import 'package:senorita/UserApp/BottomMenuScreen/home_screen/search_screen.dart';
import 'package:senorita/UserApp/BottomMenuScreen/payment_screen/binding/payment_binding.dart';
import 'package:senorita/UserApp/BottomMenuScreen/refer_earn/referearn_binidng.dart';
import 'package:senorita/UserApp/BottomMenuScreen/report_screen/binding/report_binding.dart';
import 'package:senorita/UserApp/BottomMenuScreen/report_screen/report_screen.dart';
import 'package:senorita/UserApp/BottomMenuScreen/wallet_screen/binding/wallet_binding.dart';
import 'package:senorita/UserApp/BottomMenuScreen/wallet_screen/wallet.dart';
import '../CommonScreens/forgotPassword_screen/binding/forgotPassword_binding.dart';
import '../CommonScreens/forgotPassword_screen/forgotPassword_screen.dart';
import '../CommonScreens/loginScreen/binding/expert_login_binding.dart';
import '../CommonScreens/loginScreen/loginScreen.dart';
import '../CommonScreens/otp_screen/binding/otp_binding.dart';
import '../CommonScreens/otp_screen/otp_screen.dart';
import '../CommonScreens/select_createAccount_screen/binding/createAccount_type.dart';
import '../CommonScreens/select_createAccount_screen/select_createAccount_screen.dart';
import '../CommonScreens/splashScreen/binding/splash_binding.dart';
import '../CommonScreens/splashScreen/splash_screen.dart';
import '../ExpertApp/BottomMenuScreen/addPriceList/AddPriceListScreen.dart';
import '../ExpertApp/BottomMenuScreen/addPriceList/binding/priceListbinding.dart';
import '../ExpertApp/BottomMenuScreen/expert_dashboard_screen/binding/dashboard_binding.dart';
import '../ExpertApp/BottomMenuScreen/expert_dashboard_screen/dashboard_screen.dart';
import '../ExpertApp/BottomMenuScreen/expert_edit_profile_screen/edit_googleMap/binding/googleEditMapBinding.dart';
import '../ExpertApp/BottomMenuScreen/expert_edit_profile_screen/edit_googleMap/edit_googleMapScreen.dart';
import '../ExpertApp/BottomMenuScreen/expert_edit_profile_screen/searchLocationEditMap/binding/locationSearchBinding.dart';
import '../ExpertApp/BottomMenuScreen/expert_edit_profile_screen/searchLocationEditMap/searchLocationEditScreen.dart';
import '../ExpertApp/BottomMenuScreen/expert_qr_screen/binding/expert_QrCode_binding.dart';
import '../ExpertApp/BottomMenuScreen/expert_qr_screen/expertQrScreen.dart';
import '../ExpertApp/BottomMenuScreen/menu_priceList/binding/menupPriceListbinding.dart';
import '../ExpertApp/BottomMenuScreen/menu_priceList/menuPriceScreen.dart';
import '../ExpertApp/expert_registration_screen/binding/expert_registration_binding.dart';
import '../ExpertApp/expert_registration_screen/expert_registration_screen.dart';
import '../ExpertApp/expert_registration_screen/googleMap/binding/googleMapBinding.dart';
import '../ExpertApp/searchLocationMap/binding/locationSearchBinding.dart';
import '../UserApp/BottomMenuScreen/all_category_screen/all_category_screen.dart';
import '../UserApp/BottomMenuScreen/all_category_screen/binding/all_category_binding.dart';
import '../UserApp/BottomMenuScreen/dashboard_screen/binding/dashboard_binding.dart';
import '../UserApp/BottomMenuScreen/dashboard_screen/dashboard_screen.dart';
import '../UserApp/BottomMenuScreen/home_screen/binding/home_binding.dart';
import '../UserApp/BottomMenuScreen/home_screen/homescreen.dart';
import '../UserApp/BottomMenuScreen/payment_screen/payment.dart';
import '../UserApp/BottomMenuScreen/profile_screen/binding/profile_binding.dart';
import '../UserApp/BottomMenuScreen/profile_screen/profile.dart';
import '../UserApp/BottomMenuScreen/refer_earn/referearn_screen.dart';
import '../UserApp/BottomMenuScreen/scan_qr_code/binding/scan_qr_code_binding.dart';
import '../UserApp/BottomMenuScreen/scan_qr_code/scan_qr_code_screen.dart';
import '../UserApp/BottomMenuScreen/single_category_list_screen/binding/single_category_list_binding.dart';
import '../UserApp/BottomMenuScreen/single_category_list_screen/single_category_list_screen.dart';
import '../UserApp/change_password_screen/binding/changePassword_binding.dart';
import '../UserApp/change_password_screen/change_password_screen.dart';
import '../UserApp/help_screen/binding/help_binding.dart';
import '../UserApp/help_screen/help_screen.dart';
import '../UserApp/otp_screen_profile/binding/otp_profile_binding.dart';
import '../UserApp/otp_screen_profile/otp_screen_profile.dart';
import '../UserApp/salon_details_screen/binding/salon_details_binding.dart';
import '../UserApp/salon_details_screen/salon_details_screen.dart';
import '../UserApp/user_register_account_screen/binding/user_registration_binding.dart';
import '../UserApp/user_register_account_screen/user_registration_screen.dart';

class AppPages {
  static var initialRoute = AppRoutes.splash;

  static List<GetPage> pages = [

    GetPage(
        name: AppRoutes.splash,
        page: () =>  SplashScreen(),
        binding: SplashBinding(),
        transitionDuration:  Duration(milliseconds: 50),
        transition: Transition.rightToLeft),

    GetPage(
        name: AppRoutes.loginScreen,
        page: () =>  LoginScreen(),
        binding: LoginBinding(),
        
        transitionDuration:  Duration(milliseconds: 50),
        transition: Transition.rightToLeft),

    GetPage(
        name: AppRoutes.otpScreen,
        page: () =>  OtpScreen(),
        binding: OtpBinding(),
        
        transitionDuration:  Duration(milliseconds: 50),
        transition: Transition.rightToLeft),


    ///Expert Screens



    ///UserScreen
    GetPage(
        name: AppRoutes.userRegistrationScreen,
        page: () =>  UserRegistrationScreen(),
        binding: UserRegistrationBinding(),
        
        transitionDuration:  Duration(milliseconds: 50),
        transition: Transition.rightToLeft),


    GetPage(
        name: AppRoutes.forgotPasswordScreen,
        page: () =>  ForgotPasswordScreen(),
        binding: ForgotPasswordBinding(),
        
        transitionDuration:  Duration(milliseconds: 50),
        transition: Transition.rightToLeft),



    GetPage(
        name: AppRoutes.homeScreen,
        page: () =>  HomeScreen(),
        binding: HomeBinding(),
        
        transitionDuration:  Duration(milliseconds: 50),
        transition: Transition.rightToLeft),


    GetPage(
        name: AppRoutes.dashboardScreen,
        page: () =>  DashboardScreen(),
        binding: DashboardBinding(),
        
        transitionDuration: const Duration(milliseconds: 50),
        transition: Transition.rightToLeft),

    GetPage(
        name: AppRoutes.searchScreen,
        page: () =>  SearchScreen(),
        binding: SearchBinding(),
        transition: Transition.cupertino),


    GetPage(
        name: AppRoutes.editProfile,
        page: () =>  EditProfileScreen(),
        binding: EditProfileBinding(),
        
        transitionDuration:  Duration(milliseconds: 50),
        transition: Transition.rightToLeft),

    GetPage(
        name: AppRoutes.changePasswordScreen,
        page: () =>  ChangePasswordScreen(),
        binding: ChangePasswordBinding(),
        
        transitionDuration:  Duration(milliseconds: 50),
        transition: Transition.rightToLeft),



    GetPage(
        name: AppRoutes.homeScreen,
        page: () =>  helpScreen(),
        binding: helpBinding(),
        transitionDuration:  Duration(milliseconds: 50),
        transition: Transition.rightToLeft),


    GetPage(
        name: AppRoutes.changeLocationScreen,
        page: () => const ChangeLocationScreen(),
        binding: ChangeLocationBinding(),
        transition: Transition.cupertino),

    GetPage(
        name: AppRoutes.categoryListScreen,
        page: () =>  AllCategoryScreen(),
        binding: AllCategoryBinding (),
        
        transitionDuration:  Duration(milliseconds: 50),
        transition: Transition.rightToLeft),


    GetPage(
        name: AppRoutes.singleCategoryListScreen,
        page: () =>  SingleCategoryListScreen(),
        binding: SingleCategoryListBinding(),
        
        transitionDuration:  Duration(milliseconds: 50),
        transition: Transition.rightToLeft),


   /* GetPage(
        name: AppRoutes.categoryDetailsScreen,
        page: () =>  CategoryDetailScreen(),
        binding: CategoryDetailBinding (),
        curve: Curves.easeInOutExpo,
        transitionDuration:  Duration(milliseconds: 110),
        transition: Transition.leftToRight),*/

    GetPage(
        name: AppRoutes.salonDetailsScreen,
        page: () => SalonDetailScreen(),
        binding: SalonDetailBinding (),
        transition: Transition.rightToLeft
    ),
    GetPage(
        name: AppRoutes.selectCreateAccount,
        page: () =>  SelectCreateAccountScreen(),
        binding: CreateAccountTypeBinding (),
        
        transitionDuration:  Duration(milliseconds: 50),
        transition: Transition.rightToLeft),


    ///Dashboard Screen



    GetPage(
        name: AppRoutes.myProfileScreen,
        page: () =>  EditProfileScreen(),
        binding: EditProfileBinding (),
        
        transitionDuration:  Duration(milliseconds: 50),
        transition: Transition.rightToLeft),

    GetPage(
        name: AppRoutes.helpSupportScreen,
        page: () =>  helpScreen(),
        binding: helpBinding (),
        
        transitionDuration:  Duration(milliseconds: 50),
        transition: Transition.rightToLeft),

    GetPage(
        name: AppRoutes.otpProfileScreen,
        page: () =>  OtpScreenProfile(),
        binding: OtpProfileBinding(),
        
        transitionDuration:  Duration(milliseconds: 50),
        transition: Transition.rightToLeft),

    GetPage(
        name: AppRoutes.profile,
        page: () =>   Profile(),
        binding:  ProfileBinding(),
        
        transitionDuration:  Duration(milliseconds: 50),
        transition: Transition.rightToLeft),

    GetPage(
        name: AppRoutes.walletScreen,
        page: () =>   Wallet(),
        binding: WalletBinding(),
        
        transitionDuration:  Duration(milliseconds: 50),
        transition: Transition.rightToLeft),

    GetPage(
        name: AppRoutes.qrCodeScreen,
        page: () =>  ScanQrCodeScreen(),
        binding: ScanQrCodeBinding(),

        transitionDuration:  Duration(milliseconds: 50),
        transition: Transition.rightToLeft),

    GetPage(
        name: AppRoutes.paymentScreen,
        page: () =>  PaymentScreen(),
        binding: PaymentBinding(),
        
        transitionDuration:  Duration(milliseconds: 50),
        transition: Transition.rightToLeft),




    ///Expert All Screen

    GetPage(
        name: AppRoutes.expertRegistrationScreen,
        page: () =>  ExpertRegistrationScreen(),
        binding: ExpertRegistrationBinding(),
        
        transitionDuration:  Duration(milliseconds: 50),
        transition: Transition.rightToLeft),

    GetPage(
        name: AppRoutes.expertDashboardScreen,
        page: () =>  ExpertDashboardScreen(),
        binding: ExpertDashboardBinding(),
        
        transitionDuration:  Duration(milliseconds: 50),
        transition: Transition.rightToLeft),

    GetPage(
        name: AppRoutes.referEarnScreen,
        page: () =>  ReferEarnScreen(),
        binding: ReferEarnBinding(),

        transitionDuration:  Duration(milliseconds: 50),
        transition: Transition.cupertino),

    GetPage(
        name: AppRoutes.expertEditProfileScreen,
        page: () =>  ExpertEditProfileScreen(),
        binding: ExpertEditProfileBinding(),
        transitionDuration:  Duration(milliseconds: 50),
        transition: Transition.rightToLeft),

    GetPage(
        name: AppRoutes.addOfferScreen,
        page: () => AddOfferScreen(),
        binding: AddOfferBinding(),
        transition: Transition.cupertino),
    GetPage(
        name: AppRoutes.specialOfferScreen,
        page: () => SpecialOfferScreen(),
        binding: SpecialOfferBinding(),
        transition: Transition.cupertino),

    GetPage(
        name: AppRoutes.expertWalletScreen,
        page: () =>   ExpertWalletScreen(),
        binding: ExpertWalletBinding(),

        transitionDuration:  Duration(milliseconds: 50),
        transition: Transition.rightToLeft),

    GetPage(
      name: AppRoutes.googleMap,
      page: () => GoogleMapScreen(),
      binding: GoogleMapBinding(),
      transitionDuration:  Duration(milliseconds: 50),
      
      transition: Transition.rightToLeftWithFade,
      // transition: Transition.rightToLeftWithFade
    ),
    GetPage(
      name: AppRoutes.googleMapAnimation,
      page: () => GoogleMapAnimation(),
      binding: GoogleMapAnimationBinding(),
      transitionDuration:  Duration(milliseconds: 50),
      
      transition: Transition.rightToLeftWithFade,
      // transition: Transition.rightToLeftWithFade
    ),


    GetPage(
      name: AppRoutes.addPhotos,
      page: () => AddPhotosScreen(),
      binding: AddPhotosBinding(),
      transitionDuration:  Duration(milliseconds: 50),
      
      transition: Transition.rightToLeftWithFade,
      // transition: Transition.rightToLeftWithFade
    ),

    GetPage(
      name: AppRoutes.addPriceList,
      page: () => AddPriceListScreen(),
      binding: PriceListBinding(),
      transitionDuration:  Duration(milliseconds: 50),
      
      transition: Transition.rightToLeftWithFade,
      // transition: Transition.rightToLeftWithFade
    ),

    GetPage(
      name: AppRoutes.reportScreen,
      page: () => ReportScreen(),
      binding: ReportBinding(),
      transitionDuration:  Duration(milliseconds: 50),
      
      transition: Transition.rightToLeftWithFade,
      // transition: Transition.rightToLeftWithFade
    ),

    GetPage(
      name: AppRoutes.addPriceList,
      page: () => AddPriceListScreen(),
      binding: PriceListBinding(),
      transitionDuration:  Duration(milliseconds: 50),
      
      transition: Transition.rightToLeftWithFade,
      // transition: Transition.rightToLeftWithFade
    ),

    GetPage(
      name: AppRoutes.notificationScreen,
      page: () => NotificationScreen(),
      binding: NotificationBinding(),
      // transitionDuration:  Duration(milliseconds: 50),

      transition: Transition.cupertino,
      // transition: Transition.rightToLeftWithFade
    ),

    GetPage(
      name: AppRoutes.searchLocationSearch,
      page: () => SearchLocationScreen(),
      binding: SearchLocationBinding(),
      transitionDuration:  Duration(milliseconds: 50),
      
      transition: Transition.rightToLeftWithFade,
      // transition: Transition.rightToLeftWithFade
    ),
    GetPage(
      name: AppRoutes.editMap,
      page: () => GoogleEditMapScreen(),
      binding: GoogleEditMapBinding(),
      transitionDuration:  Duration(milliseconds: 50),
      
      transition: Transition.rightToLeftWithFade,
      // transition: Transition.rightToLeftWithFade
    ),

    GetPage(
      name: AppRoutes.editSearchMap,
      page: () => SearchEditLocationScreen(),
      binding: SearchEditLocationBinding(),
      transitionDuration:  Duration(milliseconds: 50),
      
      transition: Transition.rightToLeftWithFade,
      // transition: Transition.rightToLeftWithFade
    ),

    GetPage(
      name: AppRoutes.menuPriceList,
      page: () => MenuPriceList(),
      binding: MenuPriceListBinding(),
      transitionDuration:  Duration(milliseconds: 50),

      transition: Transition.rightToLeftWithFade,
      // transition: Transition.rightToLeftWithFade
    ),

    GetPage(
        name: AppRoutes.filterScreen,
        page: () =>  FilterScreen(),
        binding: FilterBinding(),
        transition: Transition.cupertino),



  ];
}
