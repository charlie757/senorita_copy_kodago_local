// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../ExpertApp/BottomMenuScreen/expert_dashboard_screen/controller/dashboard_controller.dart';
// import '../ScreenRoutes/routes.dart';
// import '../helper/appimage.dart';
// import '../helper/getText.dart';
// import '../utils/color_constant.dart';
// import '../utils/stringConstants.dart';
// import '../utils/logoutdialogbox.dart';
// import '../utils/screensize.dart';
//
// expertDrawer(BuildContext context, ExpertDashboardController expertDashboardController,) {
//   return Container(
//     width: MediaQuery.of(context).size.width - 70,
//     height: double.infinity,
//     color: ColorConstant.onBoardingBack.withOpacity(0.99),
//     child: Column(
//       children: [
//         ScreenSize.height(50),
//         Obx(()=>
//             Padding(
//               padding: const EdgeInsets.only(left: 21),
//               child: Row(
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                           height: 70,
//                           width: 70,
//                           alignment: Alignment.center,
//                           decoration: BoxDecoration(
//                               shape: BoxShape.circle, color: ColorConstant.white),
//                           child:
//                           GestureDetector(
//                             onTap: ()
//                             {
//                               //  Get.toNamed(AppRoutes.profileScreen);
//                             },
//                             child:  CircleAvatar(
//                               radius: 48, // Image radius
//                               backgroundImage: NetworkImage("expertDashboardController.expertProfileImage.value.toString()"),
//                             ),
//                           )
//                       ),
//                       SizedBox(height: 10,),
//                       Container(
//                         width: MediaQuery.of(context).size.width/1.5,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisSize: MainAxisSize.max,
//                           children: [
//                             getText(
//                                 title: "expertDashboardController.expertName.value.toString()",
//                                 size: 20,
//                                 fontFamily: celiaMedium ,
//                                 color: ColorConstant.white,
//                                 fontWeight: FontWeight.w400),
//                             SizedBox(height: 5,),
//                             getText(
//                                 title: "expertDashboardController.expertEmail.value.toString()",
//                                 size: 14,
//                                 fontFamily: celiaRegular ,
//                                 color: ColorConstant.white,
//                                 fontWeight: FontWeight.w400),
//                           ],
//                         ),
//                       ),
//
//                     ],
//                   ),
//
//                 ],
//               ),
//             ),
//         ),
//         ScreenSize.height(20),
//         Container(
//           height: 1,
//           color: ColorConstant.c0Color,
//         ),
//         Expanded(
//             child: SingleChildScrollView(
//               physics: const ScrollPhysics(),
//               child: Column(
//                 children: [
//                   ScreenSize.height(20),
//                   drawerItemWidget(drawerHome, AppImages.drawerHome, () {
//                     Get.back();
//                     //expertDashboardController.selectIndex.value=0;
//                   }),
//                   ScreenSize.height(10),
//                   drawerItemWidget(drawerProfile, AppImages.drawerUsers, () {
//                     Get.toNamed(AppRoutes.expertProfileScreen)?.then((value) {
//                       //expertDashboardController.expertProfileApiFunction();
//                       //  Get.back();
//
//                     });
//                   }),
//                   ScreenSize.height(10),
//                   drawerItemWidget(offer, AppImages.offers, () {
//                     Get.toNamed(AppRoutes.addOffers)?.then((value) {
//                       //  expertDashboardController.expertProfileApiFunction();
//                       Get.back();
//
//                     });
//                   }),
//                   ScreenSize.height(10),
//                   drawerItemWidget(menuPrice, AppImages.priceList, () {
//
//                   }),
//                   ScreenSize.height(10),
//                   drawerItemWidget(drawerSupport, AppImages.drawerSupport, () {
//                     Get.back();
//                     Get.toNamed(AppRoutes.helpSupportScreen,arguments: ['helpSupport','']);
//                   }),
//                   ScreenSize.height(10),
//                   drawerItemWidget(drawerTerms, AppImages.drawerTerms, () {
//                     Get.back();
//                     Get.toNamed(AppRoutes.helpSupportScreen,arguments: ["termsCondition",'']);
//
//                   }),
//
//
//                   ScreenSize.height(10),
//                   drawerItemWidget("Log Out", AppImages.logout, () {
//                     Get.back();
//                     logoutDialogBox(context, expertDashboardController);
//                   }),
//                 ],
//               ),
//             ))
//       ],
//     ),
//   );
// }
//
// drawerItemWidget(String title, String img, Function() onTap) {
//   return GestureDetector(
//     behavior: HitTestBehavior.opaque,
//     onTap: onTap,
//     child: Container(
//       alignment: Alignment.center,
//       padding: const EdgeInsets.only(left: 21),
//       height: 50,
//       child: Row(
//         children: [
//           Container(
//             height: 30,
//             width: 30,
//             alignment: Alignment.center,
//             child: Image.asset(
//               img,
//               height: 25,
//               color: Colors.white,
//               width: 25,
//             ),
//           ),
//           ScreenSize.width(25),
//           getText(
//               title: title,
//               size: 14,
//               fontFamily: celiaMedium,
//               color: ColorConstant.white,
//               fontWeight: FontWeight.w400)
//         ],
//       ),
//     ),
//   );
// }
