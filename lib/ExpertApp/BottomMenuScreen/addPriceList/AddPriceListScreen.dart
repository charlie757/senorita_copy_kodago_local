import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:senorita/helper/appimage.dart';
import 'package:http/http.dart' as http;
import 'package:senorita/utils/screensize.dart';
import '../../../helper/appbar.dart';
import '../../../helper/custombtn_new.dart';
import '../../../helper/getText.dart';
import '../../../utils/color_constant.dart';
import '../../../utils/size_config.dart';
import '../../../utils/stringConstants.dart';
import '../../../utils/toast.dart';
import '../../../widget/checkbox_widget.dart';
import '../../../widget/customTextField.dart';
import '../../../widget/no_data_found.dart';
import 'controller/priceListcontroller.dart';
import 'model/topic.dart';

class AddPriceListScreen extends GetView<PriceListController> {
  const AddPriceListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: appBar(context, "Menu & Price List", () {
        Get.back();
      }),
      body:
          Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 1,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Obx(
                      () => customDropDown(context, () {
                        // controller.categoryModel!=null?
                 categoryDialogBox(context);
                        // :showToast("Data Loading Please Wait");
                },
                          controller.categoryString.value == ""
                              ? registerCategory
                              : controller.categoryString.value, ColorConstant.black2)
                    ),
                  const  SizedBox(height: 10),
                    Obx(
                      () => controller.categoryString.value.isNotEmpty
                          ? Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 40, right: 65),
                                  child: Row(
                                    children: [
                                      getText(
                                          title: "Tittle",
                                          textAlign: TextAlign.start,
                                          size: 13,
                                          fontFamily: interMedium,
                                          color: ColorConstant.blackColor,
                                          fontWeight: FontWeight.w600),
                                    const  Spacer(),
                                      getText(
                                          title: "Price",
                                          textAlign: TextAlign.center,
                                          size: 13,
                                          fontFamily: interMedium,
                                          color: ColorConstant.blackColor,
                                          fontWeight: FontWeight.w600),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          :const SizedBox(),
                    ),
                  ],
                ),
              ),
            ),
            //Category
            Flexible(
              flex: 3,
              child: Obx(
                () => ListView.builder(
                  // padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: controller.addTopicList.length,
                  itemBuilder: (context, index) {
                    var model = controller.addTopicList[index];
                    return Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        decoration: BoxDecoration(
                            color: ColorConstant.lightColor.withOpacity(0.2),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(child: Obx(() => customDropDown(context, () {
                                subCategoryDialogBox(context,model);
                              }, model.title.value.isEmpty?"title":model.title.value,
                                  model.title.value.isEmpty? ColorConstant.addPriceListText:ColorConstant.redeemTextDark))),
                             // const Spacer(),
                              const SizedBox(
                                width: 10,
                              ),

                              Expanded(
                                child: SizedBox(
                                  width: 100,
                                  height: 45,
                                  child: Row(
                                    children: [
                                      getText(
                                          title: "₹",
                                          textAlign: TextAlign.center,
                                          size: 14,
                                          fontFamily: celiaRegular,
                                          color: ColorConstant.blackColor,
                                          fontWeight: FontWeight.w400),
                                    const  SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: SizedBox(
                                          height: 50,
                                          width: 80,
                                          child: TextFormField(
                                            controller: model.priceController,
                                            keyboardType: TextInputType.number,
                                            // inputFormatters: [
                                            //   LengthLimitingTextInputFormatter(14)
                                            // ],
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.transparent,
                                              // isDense: true,
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0,
                                                      // vertical: 15
                                                  ),
                                              hintText: "Price",
                                              hintStyle: const TextStyle(
                                                  fontSize: 13,

                                                  fontFamily: interRegular,
                                                  color: ColorConstant
                                                      .addPriceListText),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: const BorderSide(
                                                  width: 2.0,
                                                ), // BorderSide
                                              ),
                                              // OutlineInputBorder
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: const BorderSide(
                                                    width: 1.5,
                                                    color: ColorConstant
                                                        .addPriceListText), // BorderSide
                                              ),
                                              // OutlineInputBorder
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: const BorderSide(
                                                    width: 2.0,
                                                    color: ColorConstant
                                                        .addPriceListText), // BorderSide
                                              ), // OutlineInputBorder
                                            ),
                                            style: const TextStyle(
                                                fontSize: 13,
                                                fontFamily: interRegular,
                                                color: ColorConstant
                                                    .redeemTextDark), // InputDecoration
                                          ),
                                        ),
                                      ),
                                    const SizedBox(
                                        width: 10,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          if(index==0){
                                            for(int i=0;i<controller.addTopicList.length;i++){
                                              var model1= controller.addTopicList[i];
                                              if(controller.addTopicList.length==i+1){
                                                if(model1.title.value.isNotEmpty&&model1.priceController.text.isNotEmpty){
                                                  controller.updateItems();
                                                  break;
                                                }else{
                                                  showToast("Enter title and price");
                                                }
                                              }
                                              else{
                                              }
                                            }}
                                          else{
                                            controller.removeItems(index);
                                          }
                                          // if(model.title.value
                                          //     .isNotEmpty &&
                                          //     model.priceController.text
                                          //         .isNotEmpty){
                                          //       controller.sendDataList.add({
                                          //         'item_name': model
                                          //             .title.value,
                                          //         'price':
                                          //             model.priceController.text
                                          //       });
                                          //       controller.updateItems();
                                          // }
                                          // else{
                                          //   showToast(
                                          //       "Enter title and price");
                                          // }}
                                          // else{
                                          //   controller.removeItems(index);
                                          // }
                                          // if (model.status.value) {
                                          //   controller.removeItems(index);
                                          // } else {
                                          //   if (model.title.value
                                          //           .isNotEmpty &&
                                          //       model.priceController.text
                                          //           .isNotEmpty) {
                                          //     model.status.value = true;
                                          //     print(
                                          //         'else${model.status.value}');
                                          //     controller.sendDataList.add({
                                          //       'item_name': model
                                          //           .title.value,
                                          //       'price':
                                          //           model.priceController.text
                                          //     });
                                          //     controller.updateItems();
                                          //   } else {
                                          //     showToast(
                                          //         "Enter title and price");
                                          //   }
                                          // }
                                        },
                                        child: Image.asset(
                                          height: 23,
                                          width: 23,
                                          index==0?
                                          AppImages.addPrice: AppImages.removePrice
                                          // model.status.value
                                          //     ? AppImages.removePrice
                                          //     : AppImages.addPrice
                                          ,

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
                  },
                ),
              ),
            ),
            //AddTopicWidget(context),
          ],
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: 55,
            child: Obx(
              () => Column(
                children: [
                  controller.categoryString.isNotEmpty
                      ? CustomBtnNew(
                          title: loginButton,
                          height: 46,
                          width: double.infinity,
                          rectangleBorder: RoundedRectangleBorder(
                            side:const BorderSide(
                                color: Colors.transparent, width: 1.3),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          color: ColorConstant.onBoardingBack,
                          onTap: () {
                            bool checkValidation = false;
                            print(controller.addTopicList.length);
                            controller.sendDataList.clear();
                            for (int i = 0;
                                i < controller.addTopicList.length;
                                i++) {
                              print(controller.addTopicList[i].subCatId.value);
                              if(controller.addTopicList[controller.addTopicList.length-1].title.value.isNotEmpty&&
                                  controller.addTopicList[controller.addTopicList.length-1].priceController.text.isNotEmpty){
                                checkValidation=true;
                              }
                              else{
                                checkValidation=false;
                              }
                              controller.sendDataList.add({
                                'item_name': controller
                                    .addTopicList[i].title.value,
                                'price': controller
                                    .addTopicList[i].priceController.text,
                                'base_sub_category_id':controller.addTopicList[i].subCatId.value.toString()

                              });
                            }
                            // print(sendDataList);
                            if(checkValidation){
                              controller.submitMultipleItems(
                                  context, controller.sendDataList);
                            }
                            else{
                              showToast('Add Price and title');
                            }

                          },
                          textColor: ColorConstant.whiteColor)
                      : SizedBox(),
                ],
              ),
            )),
      ),
    );
  }

  customDropDown(BuildContext context, Function()onTap,String title, Color color){
    return  GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        width: double.infinity,
        padding:const EdgeInsets.only(left: 15,right: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: ColorConstant.addMoney,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(  title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 13,
                    fontFamily: interRegular,
                    color:color,
                    fontWeight: FontWeight.w500
                ),
              ),
            ),
            ScreenSize.width(3),
            Image.asset(
              height: 12,
              width: 12,
              AppImages.arrowRegister,
            )
          ],
        ),
      ),
    );
    ;
  }

  categoryDialogBox(BuildContext context,) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: ColorConstant.white,
            contentPadding: EdgeInsets.zero,
            content: StatefulBuilder(builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                          child:const Icon(
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
                  Container(
                    constraints:const BoxConstraints(
                        maxHeight: 300,
                        minHeight: 100
                    ),
                    width: MediaQuery.of(context).size.width,
                    // color: Colors.white,
                    child:controller.categoryList.isNotEmpty?
                    ListView.builder(
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        padding: const EdgeInsets.only(
                            left: 15, right: 10, bottom: 15, top: 4),
                        itemCount: controller.categoryList.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Obx(
                                    () => GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    state((){});
                                    controller.selectedCategoryIndex.value=index;
                                    controller.selectedCategory.value=controller.categoryList[index].name;
                                    controller.selectedCategoryId.value = controller.categoryList[index].id.toString();
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        color:controller.selectedCategoryIndex.value==index?
                                        ColorConstant.onBoardingBack: ColorConstant.greyColor,
                                        size: 20,
                                        controller.selectedCategoryIndex.value==index?
                                        Icons.radio_button_checked:
                                        Icons.radio_button_off_outlined,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        controller.categoryList[index].name.toString(),
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
                        }):
                    Align(
                      alignment: Alignment.center,
                      child: noDataFound(),
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
                              size: 17,
                              fontFamily: interRegular,
                              color: ColorConstant.onBoardingBack,
                              fontWeight: FontWeight.w100),
                        ),
                        const  SizedBox(
                          width: 25,
                        ),
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            state((){});
                            controller.addTopicList.clear();
                            if(controller.selectedCategory.value.isNotEmpty){
                              Navigator.pop(context);
                              controller.categoryString.value = controller.selectedCategory.value;
                              controller.getSubCategoryApiFunction(controller.selectedCategoryId.value);
                             controller.updateItems();
                              // controller.selectedDiscountSubCat.clear();
                            }
                            else{
                              Fluttertoast.showToast(msg: "Please Select Category");
                            }
                          },
                          child: const getText(
                              title: "Ok",
                              size: 17,
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


  subCategoryDialogBox(BuildContext context,var model) {
    String value = '';
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: ColorConstant.white,
            contentPadding: EdgeInsets.zero,
            content: StatefulBuilder(builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 10, bottom: 5, top: 10),
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
                          child:const Icon(
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
                  Container(
                    constraints:const BoxConstraints(
                        maxHeight: 300,
                        minHeight: 100
                    ),
                    width: MediaQuery.of(context).size.width,
                    // color: Colors.white,
                    child:controller.subCatModel.value!=null&& controller.subCatModel.value!.data!=null?
                    ListView.builder(
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        padding: const EdgeInsets.only(
                            left: 15, right: 10, bottom: 15, top: 4),
                        itemCount: controller.subCatModel.value!.data!.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Obx(
                                    () => GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    state((){});
                                    model.subCatId.value = controller.subCatModel.value.data![index].id.toString();
                                   value = controller.subCatModel.value.data![index].name.toString();
                                  },
                                  child: Row(
                                    children: [
                                      checkBoxWidget(controller.subCatModel.value.data![index].id.toString()==model.subCatId.value?
                                      ColorConstant.onBoardingBack:ColorConstant.white
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Flexible(
                                        child: Text(
                                          controller.subCatModel.value.data![index].name.toString(),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: ColorConstant.greyColor,
                                            fontSize: 14,
                                            fontFamily: interRegular,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        }):
                    Align(
                      alignment: Alignment.center,
                      child: noDataFound(),
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
                              size: 17,
                              fontFamily: interRegular,
                              color: ColorConstant.onBoardingBack,
                              fontWeight: FontWeight.w100),
                        ),
                        const  SizedBox(
                          width: 25,
                        ),
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            if(value.isNotEmpty){
                              model.title.value=value;
                            state((){});
                              Navigator.pop(context);
                            }
                            else{
                              Fluttertoast.showToast(msg: "Please Select Sub Category");
                            }
                          },
                          child: const getText(
                              title: "Ok",
                              size: 17,
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

}
