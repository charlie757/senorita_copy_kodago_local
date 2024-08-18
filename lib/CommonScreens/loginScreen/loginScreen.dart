 import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../ScreenRoutes/routes.dart';
import '../../helper/appimage.dart';
import '../../helper/custombtn_new.dart';
import '../../helper/getText.dart';
import '../../utils/color_constant.dart';
import '../../utils/stringConstants.dart';
import '../../utils/screensize.dart';
import '../../utils/toast.dart';
import '../../utils/validation.dart';
import '../../widget/customTextField.dart';
import 'controller/loginController.dart';


class LoginScreen extends GetWidget<LoginController> {
  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async
      {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(

       /* appBar: appBar(context, "", () {
          SystemNavigator.pop();
        }),*/
        body: SingleChildScrollView(
          child: Form(
           // key: controller.loginFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    height: MediaQuery.of(context).size.height/2.2,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      fit: BoxFit.fitWidth,
                      AppImages.loginBack,
                    )),
                ScreenSize.height(35),
                getText(
                    title: userLoginTitle,
                    textAlign: TextAlign.start,
                    size: 25,
                    letterSpacing: 1,
                    fontFamily: interBold,
                    color: ColorConstant.blackColor,
                    fontWeight: FontWeight.w500),
                ScreenSize.height(10),
                getText(
                    title: expertLoginSubTitle,
                    textAlign: TextAlign.start,
                    size: 11,
                    fontFamily: interMedium,
                    color: ColorConstant.loginSubTitle,
                    fontWeight: FontWeight.w500),
                ScreenSize.height(25),

                Padding(
                  padding: const EdgeInsets.only(left: 15,right: 15),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: CustomTextField(
                          hintText: "",
                          labelText: loginMobile,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            new LengthLimitingTextInputFormatter(10),
                          ],
                          textInputType: TextInputType.phone,
                          textInputAction: TextInputAction.done,

                          auto: AutovalidateMode.onUserInteraction,
                          controller: controller.mobileController,
                          validator: (value) {
                            if (value == null ||
                                value.length != 10 ||
                                (!isValidPhone(value,
                                    isRequired: true))) {
                              return loginMobileValidation;
                            }
                            return null;
                          },
                        ),

                      ),
                      ScreenSize.height(10),

                      Obx(
                            () => CustomBtnNew(
                            title: loginButton,
                            height: 50,
                            width: double.infinity,
                            rectangleBorder: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.transparent,width: 1.3),
                              borderRadius: BorderRadius.circular(10),),
                            color: ColorConstant.onBoardingBack,
                            isLoading: controller.isLoading.value,
                            onTap: () {
                              controller.selectButton1();
                              if(controller.mobileController.text.isEmpty || controller.mobileController.text=="")
                              {
                                showToast(loginMobileToast);
                              }
                              else {
                                controller.loginApiFunction(context);
                              }
                            },textColor: ColorConstant.whiteColor),
                      ),
                      ScreenSize.height(10),
                      Center(
                        child: Padding(
                          padding:  const EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const getText(
                                  title: createAccount,
                                  size: 12,
                                  fontFamily: interRegular,
                                  color: ColorConstant.lightGray,
                                  fontWeight: FontWeight.w500),
                              const SizedBox(width: 5,),
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: ()
                                {
                                  controller.selectButton2();
                                  controller.resetValues();
                                  Get.toNamed(AppRoutes.selectCreateAccount);
                                },
                                child: getText(
                                    title: signUp,
                                    size: 12,
                                    fontFamily: interRegular,
                                    color: ColorConstant.onBoardingBack,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // ScreenSize.height(15),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Container(
                      //       width: 140,
                      //       color: ColorConstant.dividerColor,
                      //       height: 1,
                      //     ),
                      //     const SizedBox(width: 10,),
                      //    const getText(
                      //         title: or,
                      //         textAlign: TextAlign.start,
                      //         size: 13,
                      //         fontFamily: interMedium,
                      //         color: ColorConstant.lightGray,
                      //         fontWeight: FontWeight.w400),
                      //     SizedBox(width: 10,),
                      //     Container(
                      //       width: 150,
                      //       color: ColorConstant.dividerColor,
                      //       height: 1,
                      //     ),
                      //   ],
                      // ),
                      // ScreenSize.height(6),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     GestureDetector(
                      //       onTap: ()
                      //       {
                      //        // controller.signup(context);
                      //       },
                      //       child: Container(
                      //         width: 45,
                      //         height: 45,
                      //         decoration: BoxDecoration(
                      //             border: Border.all(
                      //               width: 1,
                      //               color: ColorConstant.cardBack,),
                      //             borderRadius: BorderRadius.all(Radius.circular(100))),
                      //         child: Padding(
                      //           padding: const EdgeInsets.all(10.0),
                      //           child: Image.asset(AppImages.google,),
                      //         ),
                      //       ),
                      //     ),
                      //     ScreenSize.width(30),
                      //     Container(
                      //       width: 45,
                      //       height: 45,
                      //       decoration: BoxDecoration(
                      //           border: Border.all(
                      //             width: 1,
                      //             color: ColorConstant.cardBack,),
                      //           borderRadius: BorderRadius.all(Radius.circular(100))),
                      //       child: Padding(
                      //         padding: const EdgeInsets.all(10.0),
                      //         child: Image.asset(AppImages.facebook,),
                      //       ),
                      //     ),
                      //   ],
                      // )
                    ],
                  ),
                ),
                ScreenSize.height(15),
                const getText(
                    title: termsText1,
                    textAlign: TextAlign.center,
                    size: 12,
                    fontFamily: interRegular,
                    color: ColorConstant.lightGray,
                    fontWeight: FontWeight.w400),
                ScreenSize.height(5),

                /*Center(
                  child: Transform.translate(
                    offset: const Offset(-13, 0),
                    child:   Padding(
                      padding:  const EdgeInsets.only(top: 0),
                      child: RichText(
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          text: "",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: celiaRegular,
                          ),
                          children: [
                            TextSpan(
                              text: loginTerms,

                              style: const TextStyle(
                                color:  ColorConstant.lightGray,
                                fontSize: 12,

                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Get.toNamed(AppRoutes.helpSupportScreen,arguments: ['termsCondition',""]);

                                },

                            ),

                          ],
                        ),
                      ),
                    ),),
                ),*/
              /*  getText(
                    title: loginTerms,
                    textAlign: TextAlign.center,
                    size: 12,
                    fontFamily: interRegular,
                    color: ColorConstant.lightGray,
                    fontWeight: FontWeight.w400),*/

                Text(loginTerms,
                style: TextStyle(
                  decoration: TextDecoration.underline,
                    fontFamily: interRegular,
                    fontSize: 12,
                    color: ColorConstant.lightGray,
                    fontWeight: FontWeight.w400
                ),)

              ],
            ),
          ),
        ),
      ),
    );
  }
}
