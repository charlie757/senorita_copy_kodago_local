import 'dart:ffi';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../ScreenRoutes/routes.dart';
import '../../helper/appbar.dart';
import '../../helper/appimage.dart';
import '../../helper/custombtn.dart';
import '../../helper/custombtn_new.dart';
import '../../helper/getText.dart';
import '../../utils/color_constant.dart';
import '../../utils/stringConstants.dart';
import '../../utils/screensize.dart';
import '../../utils/size_config.dart';
import '../../utils/toast.dart';
import '../../utils/validation.dart';
import '../../widget/checkbox_widget.dart';
import '../../widget/customTextField.dart';
import '../../widget/no_data_found.dart';
import 'controller/expert_registration_controller.dart';
import 'models/category_model.dart';
import 'models/city_model.dart';
import 'models/country_model.dart';

class ExpertRegistrationScreen extends GetView<ExpertRegistrationController> {
  const ExpertRegistrationScreen({key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back();

        return true;
      },
      child: Scaffold(
        appBar: appBar(context, "Create Account of Brand", () {
          Get.back();
        }),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                key: controller.expertRegistration,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 15, right: 15, bottom: 28),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ScreenSize.height(25),

                      const SizedBox(
                        height: 15,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: getText(
                            title: "Upload photos",
                            size: 14,
                            fontFamily: interMedium,
                            color: ColorConstant.offerTextBlack,
                            fontWeight: FontWeight.w600),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4, right: 4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            DottedBorder(
                              borderType: BorderType.RRect,
                              radius: Radius.circular(12),
                              padding: EdgeInsets.all(6),
                              color: ColorConstant.addImageBorder,
                              child: SizedBox(
                                height: 120,
                                width: MediaQuery.of(context).size.width - 4,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Obx(
                                      () => controller.imgUrl.value == ''
                                          ? GestureDetector(
                                              onTap: () {
                                                controller
                                                    .showImagePicker(context);
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 10),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    ClipOval(
                                                      child: Image.asset(
                                                        height: 80,
                                                        width: 100,
                                                        AppImages
                                                            .imgUploadOffer,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    getText(
                                                        title:
                                                            "Upload your offer image or banner here",
                                                        size: 13,
                                                        fontFamily: interMedium,
                                                        color: ColorConstant
                                                            .grayColor,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ],
                                                ),
                                              ),
                                            )
                                          : GestureDetector(
                                              onTap: () {
                                                controller
                                                    .showImagePicker(context);
                                              },
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: Image.file(
                                                  File(controller.imgUrl.value),
                                                  fit: BoxFit.cover,
                                                  height: 120,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                ),
                                              ),
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 10),
                        child: Column(
                          children: [
                            ///Name Data Widget
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: CustomTextField(
                                hintText: "",
                                labelText: 'Business Name',
                                auto: AutovalidateMode.onUserInteraction,
                                textInputType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                                controller: controller.fullNameController,
                                validator: (value) {
                                  if (value == null || value == "") {
                                    return "Please Enter Business Name";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(height: 10),

                            ///Number Data Widget
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: CustomTextField(
                                hintText: "",
                                labelText: registerMobileNumber,
                                auto: AutovalidateMode.onUserInteraction,
                                textInputAction: TextInputAction.next,
                                textInputType: TextInputType.number,
                                inputFormatters: [
                                  new LengthLimitingTextInputFormatter(10),
                                ],
                                controller: controller.numberController,
                                validator: (value) {
                                  if (value == null ||
                                      value.length != 10 ||
                                      (!isValidPhone(value,
                                          isRequired: true))) {
                                    return "Mobile Number must be of 10 digit";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(height: 10),

                            ///Email Data Widget
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: CustomTextField(
                                hintText: "",
                                labelText: registerEmailAddress,
                                auto: AutovalidateMode.onUserInteraction,
                                textInputAction: TextInputAction.next,
                                controller: controller.emailController,
                                // validator: (value) {
                                //   if (value == null ||
                                //       (!isValidEmail(value,
                                //           isRequired: true))) {
                                //     return "Please enter valid email";
                                //   }
                                //   return null;
                                // },
                              ),
                            ),
                            SizedBox(height: 10),

                            ///Current Location Data Widget
                            Obx(
                              () => Padding(
                                padding:
                                    const EdgeInsets.only(left: 2, right: 2),
                                child: GestureDetector(
                                  onTap: () {
                                    controller.getUserLocation();
                                    /*  if (controller.latString.value != "null" || controller.lngString.value != "null") {
                                      Get.toNamed(AppRoutes.googleMap,arguments: [
                                        controller.latDouble,
                                        controller.lngDouble,
                                        controller.addressString.value.toString()]);
                                    } else
                                      Get.toNamed(AppRoutes.googleMap,arguments: [
                                        null,null,null]);
                                    }*/
                                  },
                                  child: Container(
                                    height: 50,
                                    padding: EdgeInsets.only(top: 5, bottom: 5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: ColorConstant.addMoney,
                                      ),
                                    ),
                                    child: /* Row(
                                      children: [
                                        Expanded(
                                          flex: 4,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 15, top: 10, bottom: 10),
                                            child: getText(
                                                title: controller.addressString.value ==
                                                        ""
                                                    ? "Select Location"
                                                    : controller
                                                        .addressString.value,
                                                textAlign: TextAlign.start,
                                                size: 15,
                                                fontFamily: interRegular,
                                                color: ColorConstant.black2,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Expanded(
                                            child: Icon(
                                                size: 20,
                                                color: ColorConstant.blackLight,
                                                Icons.my_location))
                                      ],
                                    ),*/
                                        Padding(
                                      padding: EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          top: 0,
                                          bottom: 3),
                                      child: Row(
                                        children: [
                                          /*Container(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15, top: 10, bottom: 10),
                        child: getText(
                            title: controller.addressString.value == ""
                                  ? "Select Location"
                                  : controller.addressString.value,
                            textAlign: TextAlign.start,
                            size: 15,
                            fontFamily: interRegular,
                            color: ColorConstant.black2,
                            fontWeight: FontWeight.w500),
                      ),
                    ),*/
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.4,
                                            child: Text(
                                              controller.addressString.value ==
                                                      ""
                                                  ? "Select Location"
                                                  : controller
                                                      .addressString.value,
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontFamily: interRegular,
                                                  color:
                                                      ColorConstant.qrViewText,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          Spacer(),
                                          Icon(
                                              size: 20,
                                              color: ColorConstant.blackLight,
                                              Icons.my_location)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),

                            //Category
                            Obx(
                              () => GestureDetector(
                                onTap: () {
                                  //controller.getCategoryApiFunction();
                                  controller.allCategoryList.isNotEmpty
                                      ? categoryDialogBox(context)
                                      : showToast("Data Loading Please Wait");
                                },
                                child: Container(
                                  padding: EdgeInsets.only(top: 5, bottom: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: ColorConstant.addMoney,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 4,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15, top: 10, bottom: 10),
                                          child: getText(
                                              title: controller.categoryString
                                                          .value ==
                                                      ""
                                                  ? registerCategory
                                                  : controller
                                                      .categoryString.value,
                                              textAlign: TextAlign.start,
                                              size: 14,
                                              fontFamily: interRegular,
                                              color: ColorConstant.qrViewText,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Expanded(
                                        child: Image.asset(
                                          height: 8,
                                          width: 8,
                                          AppImages.arrowRegister,
                                        ),
                                        /*Icon(
                                              Icons.arrow_back_ios_rounded)*/
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),

                            ///SubCategory
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                if (controller.categoryString.value.isEmpty) {
                                  showToast("Select Category First");
                                } else {
                                  controller.subCatModel.value.selectedList
                                      .clear();
                                  for (int i = 0;
                                      i <
                                          controller
                                              .subCatModel.value.data!.length;
                                      i++) {
                                    for (int j = 0;
                                        j <
                                            controller
                                                .selectedSubCatList.length;
                                        j++) {
                                      if (controller
                                              .subCatModel.value.data![i].id
                                              .toString() ==
                                          controller.selectedSubCatList[j]['id']
                                              .toString()) {
                                        controller.subCatModel.value.data![i]
                                            .isSelected = true;
                                        controller
                                            .subCatModel.value.selectedList
                                            .add({
                                          'name': controller
                                              .selectedSubCatList[j]['name'],
                                          'id': controller.selectedSubCatList[j]
                                              ['id']
                                        });
                                      }
                                    }
                                  }
                                  subCategory(context);
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: ColorConstant.addMoney,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(
                                            top: 3.5, bottom: 3.5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Expanded(
                                              flex: 4,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 15,
                                                    top: 10,
                                                    bottom: 10),
                                                child: getText(
                                                    title: registerSubCategory,
                                                    textAlign: TextAlign.start,
                                                    size: 14,
                                                    fontFamily: interRegular,
                                                    color: ColorConstant
                                                        .qrViewText,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            Expanded(
                                              child: Image.asset(
                                                height: 8,
                                                width: 8,
                                                AppImages.arrowRegister,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Obx(
                                          () =>
                                              controller.selectedSubCatList
                                                      .isNotEmpty
                                                  ? ListView.builder(
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      shrinkWrap: true,
                                                      itemCount: controller
                                                          .selectedSubCatList
                                                          .length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return GestureDetector(
                                                          onTap: () {},
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 5,
                                                                    right: 20,
                                                                    top: 5),
                                                            child: Row(
                                                              children: [
                                                                getText(
                                                                    title: controller.selectedSubCatList[index]
                                                                            [
                                                                            'name'] ??
                                                                        '',
                                                                    size: 13,
                                                                    fontFamily:
                                                                        interRegular,
                                                                    color: ColorConstant
                                                                        .qrViewText,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                                const Spacer(),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    // controller.subCatModel.value.selectedList.removeAt(index);
                                                                    for (int i =
                                                                            0;
                                                                        i < controller.subCatModel.value.data!.length;
                                                                        i++) {
                                                                      if (controller
                                                                              .subCatModel
                                                                              .value
                                                                              .data![
                                                                                  i]
                                                                              .id
                                                                              .toString() ==
                                                                          controller.selectedSubCatList[index]
                                                                              [
                                                                              'id']) {
                                                                        controller
                                                                            .subCatModel
                                                                            .value
                                                                            .data![i]
                                                                            .isSelected = false;
                                                                      }
                                                                    }
                                                                    for (int j =
                                                                            0;
                                                                        j < controller.subCatModel.value.selectedList.length;
                                                                        j++) {
                                                                      if (controller
                                                                              .subCatModel
                                                                              .value
                                                                              .selectedList[j]['id'] ==
                                                                          controller.selectedSubCatList[index]['id']) {
                                                                        controller
                                                                            .subCatModel
                                                                            .value
                                                                            .selectedList
                                                                            .removeAt(j);
                                                                      }
                                                                    }
                                                                    controller
                                                                        .selectedSubCatList
                                                                        .removeAt(
                                                                            index);
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        const BoxDecoration(
                                                                      color: Colors
                                                                          .red,
                                                                      shape: BoxShape
                                                                          .circle,
                                                                    ),
                                                                    child:
                                                                        const Icon(
                                                                      Icons
                                                                          .highlight_remove_outlined,
                                                                      size: 20,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    )
                                                  : Container(),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            ScreenSize.height(15),

                            ///Exp Data Widget
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: CustomTextField(
                                hintText: "",
                                labelText: registerExperience,
                                auto: AutovalidateMode.onUserInteraction,
                                textInputAction: TextInputAction.next,
                                controller: controller.expController,
                                inputFormatters: [
                                  new LengthLimitingTextInputFormatter(2),
                                ],
                                textInputType: TextInputType.number,
                                validator: (value) {
                                  if (value.toString().isEmpty) {
                                    return "Please enter Experience";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(height: 10),

                            ///Bio Data Widget
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: CustomTextField(
                                hintText: "",
                                labelText:
                                    "Kodago Card(URL:-https://card.kodago.com/username)",
                                auto: AutovalidateMode.onUserInteraction,
                                textInputAction: TextInputAction.next,
                                controller: controller.kodagoCardController,
                                /*validator: (value) {
                                  if (value == null ||
                                      (!kodagoCard(value, isRequired: true))) {
                                    return "Please enter Kodago Card (URL)";
                                  }
                                  return null;
                                },*/
                              ),
                            ),
                            SizedBox(height: 10),

                            ///Bio Data Widget
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: CustomTextField(
                                hintText: "",
                                labelText: registerAboutUs,
                                auto: AutovalidateMode.onUserInteraction,
                                textInputAction: TextInputAction.next,
                                controller: controller.aboutUsController,
                                validator: (value) {
                                  if (value.toString().isEmpty) {
                                    return "Please enter AboutUs";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(height: 0),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Obx(
                            () => Transform.translate(
                              offset: const Offset(-8, 0),
                              child: Transform.scale(
                                scale: 1.1,
                                child: Checkbox(
                                  value: controller.checkBoxValue.value,
                                  checkColor: ColorConstant.whiteColor,
                                  activeColor: ColorConstant.onBoardingBack,
                                  side: BorderSide(
                                    color: ColorConstant
                                        .checkBox, //your desire colour here
                                    width: 1,
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        2,
                                      ),
                                      side:
                                          BorderSide(color: Colors.deepPurple)),
                                  onChanged: (bool? value) {
                                    controller.checkBoxValue.value = value!;
                                    if (value == true) {
                                      controller.termsConditionValue.value = 1;
                                    } else if (value == true) {
                                      controller.termsConditionValue.value = 0;
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                          Transform.translate(
                            offset: const Offset(-13, 0),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 0),
                              child: RichText(
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                text: TextSpan(
                                  text: loginAgree,
                                  style: TextStyle(
                                    color: ColorConstant.grayColor,
                                    fontSize: 12,
                                    fontFamily: interRegular,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: loginTerms,
                                      style: const TextStyle(
                                        color: ColorConstant.onBoardingBack,
                                        fontSize: 12,
                                        fontFamily: interRegular,
                                        decoration: TextDecoration.underline,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Get.toNamed(
                                              AppRoutes.helpSupportScreen,
                                              arguments: [
                                                'termsCondition',
                                                ""
                                              ]);
                                        },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      ScreenSize.height(15),
                      Obx(
                        () => CustomBtnNew(
                          title: createBtn,
                          height: 50,
                          width: double.infinity,
                          color: ColorConstant.onBoardingBack,
                          isLoading: controller.isLoading.value,
                          onTap: () {
                            if (controller.expertRegistration.currentState!
                                .validate()) {
                              if (controller.addressString.value == "") {
                                showToast("Select Address");
                              } else if (controller.checkBoxValue.value) {
                                controller.submitProfileImageApi(context);
                              } else {
                                showToast(signUpCheckBoxValidation);
                              }
                            } else {}

                            /*controller.isLoading.value
                                  ? null
                                  : controller.validation();*/
                          },
                          textColor: ColorConstant.whiteColor,
                          rectangleBorder: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Colors.transparent, width: 1.3),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      ///Category Data Widget

                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const getText(
                                  title: registerAlreadyAccount,
                                  size: 12,
                                  fontFamily: interRegular,
                                  color: ColorConstant.lightGray,
                                  fontWeight: FontWeight.w500),
                              const SizedBox(
                                width: 5,
                              ),
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  Get.offNamed(AppRoutes.loginScreen);
                                  controller.resetValues();
                                  controller.checkBoxValue.value = false;
                                },
                                child: getText(
                                    title: registerLogin,
                                    size: 12,
                                    fontFamily: interRegular,
                                    color: ColorConstant.onBoardingBack,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  categoryDialogBox(BuildContext context) {
    //controller.getCategoryApiFunction();

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            content: StatefulBuilder(builder: (context, state) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 10, bottom: 5, top: 10),
                    child: Row(
                      children: [
                        getText(
                            title: "Category",
                            size: 14,
                            fontFamily: interRegular,
                            color: ColorConstant.blackColor,
                            fontWeight: FontWeight.w500),
                        const Spacer(),
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.close,
                            size: 20,
                            color: ColorConstant.onBoardingBack,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: ColorConstant.dividerColor,
                    height: 1,
                  ),
                  Container(
                    width: double.maxFinite,
                    child: ListView.builder(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(
                            left: 15, right: 10, bottom: 15, top: 4),
                        itemCount: controller.allCategoryList.length,
                        itemBuilder: (context, index) {
                          CategoryModel model = CategoryModel.fromJson(
                              controller.allCategoryList[index]);
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Obx(
                                () => GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    controller.selectedCategoryType.value =
                                        index;
                                    controller.categoryString.value =
                                        model.name.toString();
                                    controller.categoryId.value =
                                        model.id.toString();
                                    controller.getSubCategoryApiFunction(
                                        context, model.id.toString());
                                    // controller.stringList.clear();
                                    // Navigator.pop(context);
                                  },
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      controller.selectedCategoryType.value ==
                                              index
                                          ? Icon(
                                              Icons.radio_button_checked,
                                              size: 20,
                                              color:
                                                  ColorConstant.onBoardingBack,
                                            )
                                          : Icon(
                                              Icons.radio_button_off_outlined,
                                              color: ColorConstant.greyColor,
                                              size: 20,
                                            ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        model.name.toString(),
                                        style: const TextStyle(
                                          color: ColorConstant.greyColor,
                                          fontSize: 14,
                                          fontFamily: interRegular,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, bottom: 15, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: getText(
                              title: "Cancel",
                              size: 14,
                              fontFamily: interRegular,
                              color: ColorConstant.onBoardingBack,
                              fontWeight: FontWeight.w100),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            controller.selectedCategoryType.value == -1
                                ? showToast("Please Select Category")
                                : Navigator.pop(context);
                          },
                          child: getText(
                              title: "Ok",
                              size: 14,
                              fontFamily: interRegular,
                              color: ColorConstant.onBoardingBack,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  )
                ],
              );
            }),
          );
        });
  }

  subCategory(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            content: StatefulBuilder(builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 10, bottom: 5, top: 10),
                    child: Row(
                      children: [
                        getText(
                            title: "Sub Category",
                            size: 14,
                            fontFamily: interRegular,
                            color: ColorConstant.blackColor,
                            fontWeight: FontWeight.w500),
                        const Spacer(),
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.close,
                            size: 20,
                            color: ColorConstant.onBoardingBack,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: ColorConstant.dividerColor,
                    height: 1,
                  ),
                  Obx(
                    () => Container(
                      width: double.maxFinite,
                      height: 300,
                      child: controller.subCatModel.value != null &&
                              controller.subCatModel.value!.data != null
                          ? ListView.separated(
                              separatorBuilder: (context, sp) {
                                return const SizedBox(
                                  height: 12,
                                );
                              },
                              physics: const ScrollPhysics(),
                              shrinkWrap: true,
                              padding: const EdgeInsets.only(
                                  left: 15, right: 10, bottom: 15, top: 4),
                              itemCount:
                                  controller.subCatModel.value.data!.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Obx(
                                      () => GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        onTap: () {
                                          state(() {});
                                          if (controller.subCatModel.value
                                                  .data![index].isSelected ==
                                              false) {
                                            controller.subCatModel.value
                                                .data![index].isSelected = true;
                                            controller
                                                .subCatModel.value.selectedList
                                                .add({
                                              "name": controller.subCatModel
                                                  .value.data![index].name,
                                              "id": controller.subCatModel.value
                                                  .data![index].id
                                                  .toString()
                                            });
                                          } else {
                                            controller
                                                .subCatModel
                                                .value
                                                .data![index]
                                                .isSelected = false;
                                            for (int i = 0;
                                                i <
                                                    controller.subCatModel.value
                                                        .selectedList.length;
                                                i++) {
                                              if (controller.subCatModel.value
                                                      .selectedList[i]['id']
                                                      .toString() ==
                                                  controller.subCatModel.value
                                                      .data![index].id
                                                      .toString()) {
                                                print('object');
                                                controller.subCatModel.value
                                                    .selectedList
                                                    .removeAt(i);
                                              }
                                            }
                                          }
                                        },
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            checkBoxWidget(controller
                                                        .subCatModel
                                                        .value
                                                        .data![index]
                                                        .isSelected ==
                                                    true
                                                ? ColorConstant.onBoardingBack
                                                : ColorConstant.white),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              controller.subCatModel.value
                                                  .data![index].name
                                                  .toString(),
                                              style: const TextStyle(
                                                color: ColorConstant.greyColor,
                                                fontSize: 14,
                                                fontFamily: interRegular,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, right: 10),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        color: ColorConstant.dividerColor,
                                        height: 1,
                                      ),
                                    ),
                                  ],
                                );
                              })
                          : Align(
                              alignment: Alignment.center,
                              child: noDataFound(),
                            ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, bottom: 10, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const getText(
                              title: "Cancel",
                              size: 14,
                              fontFamily: interRegular,
                              color: ColorConstant.onBoardingBack,
                              fontWeight: FontWeight.w100),
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            print(controller
                                .subCatModel.value.selectedList.length);
                            if (controller
                                .subCatModel.value.selectedList.isNotEmpty) {
                              controller.selectedSubCatList.clear();
                              for (int i = 0;
                                  i <
                                      controller.subCatModel.value.selectedList
                                          .length;
                                  i++) {
                                controller.selectedSubCatList.add({
                                  "name": controller.subCatModel.value
                                      .selectedList[i]['name'],
                                  "id": controller
                                      .subCatModel.value.selectedList[i]['id']
                                });
                                state(() {});
                              }
                              Navigator.pop(context);
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Please Select Sub Category");
                            }
                          },
                          child: const getText(
                              title: "Ok",
                              size: 14,
                              fontFamily: interRegular,
                              color: ColorConstant.onBoardingBack,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  )
                ],
              );
            }),
          );
        });
  }

  multiSelectDialogBox(BuildContext context, list, model) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            content: StatefulBuilder(builder: (context, state) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 15, top: 10, bottom: 15),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: model.valueList.isEmpty
                          ? Container()
                          : GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                model.valueList.clear();
                                for (int i = 0; i < list.length; i++) {
                                  list[i]['name'] = false;
                                  state(() {});
                                }
                              },
                              child: const Icon(Icons.close)),
                    ),
                  ),
                  ListView.separated(
                      separatorBuilder: (context, sp) {
                        return const SizedBox(
                          height: 5,
                        );
                      },
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 15),
                      itemCount: controller.allCategoryList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            if (list[index]['isSelected'] == false) {
                              list[index]['isSelected'] = true;
                              model.valueList.add(list[index]['value']);
                            } else {
                              list[index]['isSelected'] = false;
                              for (int i = 0; i < model.valueList.length; i++) {
                                if (list[index]['value']
                                        .toString()
                                        .removeAllWhitespace ==
                                    model.valueList[i]
                                        .toString()
                                        .removeAllWhitespace) {
                                  model.valueList.removeAt(i);
                                }
                              }
                            }
                            state(() {});
                          },
                          child: SizedBox(
                            height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(list[index]['value'].toString()),
                                checkBox(index, list[index]['isSelected'])
                              ],
                            ),
                          ),
                        );
                      })
                ],
              );
            }),
          );
        });
  }

  checkBox(int index, isSelected) {
    return Container(
      height: 20,
      width: 20,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          border: Border.all(
              color: index == isSelected ? Colors.blue : Colors.grey.shade500),
          color: isSelected ? Colors.blue : Colors.white),
      alignment: Alignment.center,
      child: index == isSelected
          ? const Icon(
              Icons.check,
              color: Colors.white,
              size: 14,
            )
          : null,
    );
  }
}
