import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:senorita/UserApp/BottomMenuScreen/wallet_screen/controller/wallet_controller.dart';
import '../../../helper/appimage.dart';
import '../../../utils/color_constant.dart';
import '../../../utils/stringConstants.dart';
import '../../../utils/user_exit_dialogbox.dart';
import 'controller/dashboard_controller.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        AwesomeDialog(
          context: context,
          animType: AnimType.rightSlide,
          dialogType: DialogType.question,

          title: 'Log out',
          desc: 'Are you sure that want to Log out?',

          body: Container(
            padding:const EdgeInsets.only(top: 5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Are you sure?',
                  style: TextStyle(
                    fontFamily: interRegular,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 15),
                const  Text(
                  'Do you want to exit an App',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: interRegular,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Divider(
                  height: 1,
                  color: Colors.grey,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          AwesomeDialog(context: context).dismiss();
                        },
                        child:const Text(
                          'No',
                          style: TextStyle(
                            fontSize: 16,
                            color: ColorConstant.greyColor,
                            fontFamily: 'Poppins Medium',

                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 30,
                      color: Colors.grey,
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          // Handle "Yes" button press
                          AwesomeDialog(context: context).dismiss();
                          SystemNavigator.pop();
                          //controller.logout(context);
                          //  controller.logoutApiFunction();
                        },
                        child: const Text(
                          'Yes',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontFamily: 'Poppins Medium',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          /*  btnOkOnPress: () {},*/
          //  btnOkText: "LogOut",
        ).show();
        return false;
      },
      child: Scaffold(
        body: Obx(()=>
           IndexedStack(
            index: controller.selectedIndex.value,
            children: controller.screens,
          ),
        ),
        bottomNavigationBar:
        Obx(()=>
           Container(
             padding:const EdgeInsets.only(bottom: 4,left: 5,right: 5,top: 2),
             color:  ColorConstant.homeBackground,
             child: ClipRRect(
               borderRadius: const BorderRadius.only(
                 topRight: Radius.circular(10),
                 topLeft: Radius.circular(10),
                 bottomRight: Radius.circular(10),
                 bottomLeft: Radius.circular(10),
               ),
               child: BottomNavigationBar(

                type: BottomNavigationBarType.fixed,
                backgroundColor: ColorConstant.bottomNavigationBack,
                selectedItemColor: ColorConstant.onBoardingBack,
                unselectedItemColor: Colors.white,
                showSelectedLabels: true,
                showUnselectedLabels: true,

                selectedLabelStyle:const TextStyle(
                    fontSize: 12,
                    fontFamily: interRegular,
                    color: ColorConstant.onBoardingBack,
                    fontWeight: FontWeight.w400
                ),

                unselectedLabelStyle: TextStyle(
                    fontSize: 12,
                    fontFamily: interRegular,
                    color: ColorConstant.white,
                    fontWeight: FontWeight.w400
                ),


                onTap: (index){
                  controller.changeIndex(index);
                 },
                currentIndex: controller.selectedIndex.value,
                items:const [
                  BottomNavigationBarItem(icon: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Icon(Icons.home_filled,),
                  ),
                      label: "Home",
                    activeIcon: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Icon(Icons.home_filled,color: ColorConstant.onBoardingBack,size: 18),
                    ),


                  ),
                  BottomNavigationBarItem(icon: Padding(
                    padding:  EdgeInsets.only(top: 5,bottom: 4),
                    child: Image(image: AssetImage(AppImages.offer),height: 18,width: 18,color: Colors.white,),
                  ),
                      label: "Offers",
                    activeIcon: Padding(
                      padding:  EdgeInsets.only(top: 5,bottom: 4),
                      child: Image(image: AssetImage(AppImages.offer),height: 18,width: 18,color: ColorConstant.onBoardingBack),
                    ),


                  ),
                  BottomNavigationBarItem(icon:Padding(
                    padding:  EdgeInsets.only(top: 5,bottom: 4),
                    child: Image(image: AssetImage(AppImages.walletIcon),height: 18,width: 18,color: Colors.white,),
                  ),
                      label: "Wallet",
                    activeIcon: Padding(
                      padding:  EdgeInsets.only(top: 5,bottom: 4),
                      child: Image(image: AssetImage(AppImages.walletIcon),height: 18,width: 18,color: ColorConstant.onBoardingBack),
                    ),


                  ),
                  BottomNavigationBarItem(icon:Padding(
                    padding:  EdgeInsets.only(top: 5,bottom: 4),
                    child: Image(image: AssetImage(AppImages.profile),height: 18,width: 18,color: Colors.white,),
                  ),
                      label: "Profile",
                      activeIcon:Padding(
                        padding:  EdgeInsets.only(top: 5,bottom: 4),
                        child: Image(image: AssetImage(AppImages.profile),height: 18,width: 18,color: ColorConstant.onBoardingBack),
                      ),
                  ),
                ],
          ),
             ),
           ),
        ),
      ),
    );
  }

}
