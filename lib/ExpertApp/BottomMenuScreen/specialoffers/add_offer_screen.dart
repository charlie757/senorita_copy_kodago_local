import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:senorita/ExpertApp/BottomMenuScreen/expert_profile_screen/controller/expert_profile_controller.dart';
import 'package:senorita/helper/appbar.dart';
import 'package:senorita/helper/custombtn.dart';
import 'package:senorita/helper/getText.dart';
import 'package:senorita/utils/color_constant.dart';
import 'package:senorita/utils/screensize.dart';
import 'package:senorita/utils/stringConstants.dart';
import 'package:senorita/widget/no_data_found.dart';

import '../../../helper/appimage.dart';
import '../../../widget/checkbox_widget.dart';
import '../addPriceList/model/topic.dart';
import 'controller/add_offer_controller.dart';

class AddOfferScreen extends GetView<AddOfferController>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: appBar(context, "Add Offer", () => Get.back()),
      body: Padding(
        padding:const EdgeInsets.only(left: 22,right: 22,top: 15,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getText(title: 'Offer Type',
                size: 18, fontFamily: interSemiBold, color: ColorConstant.blackColor, fontWeight: FontWeight.w500),
            ScreenSize.height(15),
            offerTypeWidget(),
            ScreenSize.height(20),
          Expanded(child: Obx(()=>SingleChildScrollView(
              padding:const EdgeInsets.only(bottom: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  controller.selectedOfferType.value==0?
                  discountWidget(context):buyGetWidget(context),
                  ScreenSize.height(30),
                  CustomBtn(title: 'Continue',
                      height: 48, width: double.infinity, onTap: (){
                    controller.checkValidation();
                      },
                      color: ColorConstant.appColor)
                ],
              ),
            ),
          ))
          ],
        ),
      ),
    );
  }

  
  offerTypeWidget(){
    return Obx(()=>Padding(
      padding: const EdgeInsets.only(right: 40),
      child: Row(
          children: [
            GestureDetector(
              onTap: (){
                controller.selectedOfferType.value=0;
              },
              child:
            checkBoxWidget(
                controller.selectedOfferType.value==0? ColorConstant.onBoardingBack:ColorConstant.white,
         )),
            ScreenSize.width(12),
           const getText(title: '% Discount',
                size: 12, fontFamily: interMedium, color: ColorConstant.blackLight,
                fontWeight: FontWeight.w400),
            const Spacer(),
            GestureDetector(
              onTap: (){
                controller.selectedOfferType.value=1;
              },
              child:
            checkBoxWidget(
                controller.selectedOfferType.value==1? ColorConstant.onBoardingBack:ColorConstant.white,
             )),
            ScreenSize.width(12),
            const getText(title: 'Buy One Get',
                size: 12, fontFamily: interMedium, color: ColorConstant.blackLight,
                fontWeight: FontWeight.w400),

          ],
        ),
    ),
    );
  }

  uploadPhotoWidget(BuildContext context, Function()onTap){
    return   GestureDetector(
      onTap: onTap,
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius:const Radius.circular(12),
        padding:const EdgeInsets.all(6),
        color: ColorConstant.addImageBorder,
        child: SizedBox(
          height: 150,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: ClipOval(
                  child: Image.asset(
                    height: 80,
                    width: 100,
                    AppImages.imgUploadOffer,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
             const getText(
                  title:
                  "Upload your image or banner here",
                  size: 12,
                  fontFamily: interMedium,
                  color: ColorConstant.offerTextBlack,
                  fontWeight: FontWeight.w600),
            ],
          )
        ),
      ),
    );
  }

  discountWidget(BuildContext context){
    return Obx(()=>Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const getText(title: 'Upload Photos', size: 18, fontFamily: interMedium, color: ColorConstant.black3333,
              fontWeight: FontWeight.w500),
          ScreenSize.height(24),
          uploadPhotoWidget(context, (){
            controller.showImagePicker(context);
          }),
          controller.discountImgFile.value==null?
              Container():
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.file(controller.discountImgFile.value!,width: 80,
                height: 80,
                fit: BoxFit.fill,
              ),
            ),
          ),
          ScreenSize.height(14),
          customTextField(hintText: 'category',
            onTap: (){
              discountCategoryDialogBox(context);
            },
            controller: controller.discountCategoryController,
            readOnly: true,
            suffixWidget: Container(
            height: 20,width: 20,
            alignment: Alignment.center,
            child: Image.asset(
              height: 10,
              width: 10,
              AppImages.arrowRegister,
            ),
          ),),
          ScreenSize.height(7),
          customTextField(hintText: 'Sub Category',
            controller: controller.discountSubCategoryController,
            readOnly: true,
            onTap: (){
            if(controller.discountCategoryController.text.isNotEmpty){
              discountSubCategoryDialogBox(context);
            }
            },
            suffixWidget: Container(
              height: 20,width: 20,
              alignment: Alignment.center,
              child: Image.asset(
                height: 10,
                width: 10,
                AppImages.arrowRegister,
              ),
            ),),
          ScreenSize.height(controller.selectedDiscountSubCat.isEmpty?0: 7),
          Obx(() => controller.selectedDiscountSubCat.value.isEmpty?Container():
          selectedSubCatWidget(controller.selectedDiscountSubCat.value),),
          ScreenSize.height(17),
          getText(title: 'Discount %',
              size: 15, fontFamily: interMedium, color: ColorConstant.blackColor, fontWeight: FontWeight.w500),
          ScreenSize.height(6),
          customTextField(hintText: 'Enter discount',
            controller: controller.discountController,
            textInputType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly]
            ),
          ScreenSize.height(17),
          getText(title: 'Description',
              size: 15, fontFamily: interMedium, color: ColorConstant.blackColor, fontWeight: FontWeight.w500),
          ScreenSize.height(6),
          customTextField(hintText: 'Enter description',
            controller: controller.discountDescriptionController,
          ),
          ScreenSize.height(17),
          getText(title: 'Start',
              size: 15, fontFamily: interMedium, color: ColorConstant.blackColor, fontWeight: FontWeight.w500),
          ScreenSize.height(6),
          Row(
            children: [
             Expanded(child:  customTextField(hintText: 'Choose Date...',
               controller: controller.discountStartDateController,
               readOnly: true,
               onTap: (){
                 controller.selectedDate = controller.selectedDiscountStartDate;
                 controller.datePicker().then((value) {
                   if(value!=null){
                     controller.selectedDiscountStartDate = value;
                     var day, month, year;
                     day = value.day < 10 ? '0${value.day}' : value.day;
                     month = value.month < 10
                         ? '0${value.month}'
                         : value.month;
                     year = value.year;
                     controller.discountStartDateController.text="${value.year}-$month-$day";
                   }
                 });
                 },
               suffixWidget: Container(
                 height: 20,width: 20,
                 alignment: Alignment.center,
                 child: Image.asset(
                   height: 20,
                   width: 20,
                   AppImages.dateIcon,
                 ),
               ),),),
              ScreenSize.width(12),
              Expanded(child:  customTextField(hintText: 'Choose Time...',
                controller: controller.discountStartTimeController,
                readOnly: true,
                onTap: ()async{
                  controller.initialTime = controller.discountStartTime;
                  TimeOfDay? pickedTime = await controller.selectTime(context);
                  if (pickedTime != null) {
                    controller.discountStartTime = pickedTime;
                    controller.discountStartTimeController.text = pickedTime.format(context);
                    controller.discountStartTime = TimeOfDay(hour: pickedTime.hour, minute: pickedTime.minute);
                    // Use the picked time
                  }
                }
                ),),
            ],
          ), ScreenSize.height(17),
          getText(title: 'End',
              size: 15, fontFamily: interMedium, color: ColorConstant.blackColor, fontWeight: FontWeight.w500),
          ScreenSize.height(6),
          Row(
            children: [
              Expanded(child:  customTextField(hintText: 'Choose Date...',
                controller: controller.discountEndDateController,
                readOnly: true,
                onTap: (){
                controller.selectedDate = controller.selectedDiscountEndDate;
                  controller.datePicker().then((value) {
                    if(value!=null){
                      controller.selectedDiscountEndDate = value;
                      var day, month, year;
                      day = value.day < 10 ? '0${value.day}' : value.day;
                      month = value.month < 10
                          ? '0${value.month}'
                          : value.month;
                      year = value.year;
                      controller.discountEndDateController.text="${value.year}-$month-$day";
                    }
                  });
                },
                suffixWidget: Container(
                  height: 20,width: 20,
                  alignment: Alignment.center,
                  child: Image.asset(
                    height: 20,
                    width: 20,
                    AppImages.dateIcon,
                  ),
                ),),),
              ScreenSize.width(12),
              Expanded(child:  customTextField(hintText: 'Choose Time...',
                controller: controller.discountEndTimeController,
                readOnly: true,
                onTap: ()async{
                  controller.initialTime = controller.discountEndTime;
                  TimeOfDay? pickedTime = await controller.selectTime(context);
                  if (pickedTime != null) {
                    controller.discountEndTime = pickedTime;
                    controller.discountEndTimeController.text = pickedTime.format(context);
                    controller.discountEndTime = TimeOfDay(hour: pickedTime.hour, minute: pickedTime.minute);
                    // Use the picked time
                  }
                }
              ),),
            ],
          ),
        ],
      ),
    );
  }

  buyGetWidget(BuildContext context){
    return Obx(()=> Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const getText(title: 'Upload Photos', size: 18, fontFamily: interMedium, color: ColorConstant.black3333,
              fontWeight: FontWeight.w500),
          ScreenSize.height(24),
          uploadPhotoWidget(context, (){
            controller.showImagePicker(context);
          }),
          controller.buyImgFile.value==null?
          Container():
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.file(controller.buyImgFile.value!,width: 80,
                height: 80,
                fit: BoxFit.fill,
              ),
            ),
          ),
          ScreenSize.height(14),
          customTextField(hintText: 'category',
            controller: controller.buyCategoryController,
            readOnly: true,
            onTap: (){
              buyCategoryDialogBox(context);
            },
            suffixWidget: Container(
              height: 20,width: 20,
              alignment: Alignment.center,
              child: Image.asset(
                height: 10,
                width: 10,
                AppImages.arrowRegister,
              ),
            ),),
          ScreenSize.height(15),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getText(title: 'Buy',
                        size: 15, fontFamily: interMedium, color: ColorConstant.blackColor, fontWeight: FontWeight.w500),
                    ScreenSize.height(6),
                    customTextField(hintText: 'Sub Category',
                      controller: controller.buySubCategoryController,
                      onTap: (){
                      if(controller.buyCategoryController.text.isNotEmpty){
                        buySubCategoryDialogBox(context);
                      }
                      },
                      readOnly: true,
                      suffixWidget: Container(
                        height: 20,width: 20,
                        alignment: Alignment.center,
                        child: Image.asset(
                          height: 10,
                          width: 10,
                          AppImages.arrowRegister,
                        ),
                      ),
                    ),
                    ScreenSize.height(controller.selectedBuySubCat.isEmpty?0:10),
                    controller.selectedBuySubCat.isEmpty?Container():
                    selectedSubCatWidget(controller.selectedBuySubCat),
                  ],
                ),
              ),
              ScreenSize.width(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getText(title: 'Get',
                        size: 15, fontFamily: interMedium, color: ColorConstant.blackColor, fontWeight: FontWeight.w500),
                    ScreenSize.height(6),
                    customTextField(hintText: 'Sub Category',
                      controller: controller.getSubCategoryController,
                      readOnly: true,
                      onTap: (){
                        if(controller.buyCategoryController.text.isNotEmpty){
                          getSubCategoryDialogBox(context);
                        }
                      },
                      suffixWidget: Container(
                        height: 20,width: 20,
                        alignment: Alignment.center,
                        child: Image.asset(
                          height: 10,
                          width: 10,
                          AppImages.arrowRegister,
                        ),
                      ),),
                    ScreenSize.height(controller.selectedGetSubCat.isEmpty?0:10),
                    controller.selectedGetSubCat.isEmpty?Container():
                    selectedSubCatWidget(controller.selectedGetSubCat),
                  ],
                ),
              ),
            ],
          ),
          ScreenSize.height(17),
          getText(title: 'Description',
              size: 15, fontFamily: interMedium, color: ColorConstant.blackColor, fontWeight: FontWeight.w500),
          ScreenSize.height(6),
          customTextField(hintText: 'Enter description',
            controller: controller.buyDescriptionController,
          ),
          ScreenSize.height(17),
          getText(title: 'Start',
              size: 15, fontFamily: interMedium, color: ColorConstant.blackColor, fontWeight: FontWeight.w500),
          ScreenSize.height(6),
          Row(
            children: [
              Expanded(child:  customTextField(hintText: 'Choose Date...',
                controller: controller.buyStartDateController,
                readOnly: true,
                onTap: (){
                  controller.selectedDate = controller.selectedBuyStartDate;
                  controller.datePicker().then((value) {
                    if(value!=null){
                      controller.selectedBuyStartDate = value;
                      var day, month, year;
                      day = value.day < 10 ? '0${value.day}' : value.day;
                      month = value.month < 10
                          ? '0${value.month}'
                          : value.month;
                      year = value.year;
                      controller.buyStartDateController.text="${value.year}-$month-$day";
                    }
                  });
                },
                suffixWidget: Container(
                  height: 20,width: 20,
                  alignment: Alignment.center,
                  child: Image.asset(
                    height: 20,
                    width: 20,
                    AppImages.dateIcon,
                  ),
                ),),),
              ScreenSize.width(12),
              Expanded(child:  customTextField(hintText: 'Choose Time...',
                controller: controller.buyStartTimeController,
                readOnly: true,
                onTap: ()async{
                  controller.initialTime = controller.buyStartTime;
                  TimeOfDay? pickedTime = await controller.selectTime(context);
                  if (pickedTime != null) {
                    controller.buyStartTime = pickedTime;
                    controller.buyStartTimeController.text = pickedTime.format(context);
                    controller.buyStartTime = TimeOfDay(hour: pickedTime.hour, minute: pickedTime.minute);
                    // Use the picked time
                  }
                }
              ),),
            ],
          ), ScreenSize.height(17),
          getText(title: 'End',
              size: 15, fontFamily: interMedium, color: ColorConstant.blackColor, fontWeight: FontWeight.w500),
          ScreenSize.height(6),
          Row(
            children: [
              Expanded(child:  customTextField(hintText: 'Choose Date...',
                controller: controller.buyEndDateController,
                readOnly: true,
                onTap: (){
                  controller.selectedDate = controller.selectedBuyEndDate;
                  controller.datePicker().then((value) {
                    if(value!=null){
                      controller.selectedBuyEndDate = value;
                      var day, month, year;
                      day = value.day < 10 ? '0${value.day}' : value.day;
                      month = value.month < 10
                          ? '0${value.month}'
                          : value.month;
                      year = value.year;
                      controller.buyEndDateController.text="${value.year}-$month-$day";
                    }
                  });
                },
                suffixWidget: Container(
                  height: 20,width: 20,
                  alignment: Alignment.center,
                  child: Image.asset(
                    height: 20,
                    width: 20,
                    AppImages.dateIcon,
                  ),
                ),),),
              ScreenSize.width(12),
              Expanded(child:  customTextField(hintText: 'Choose Time...',
                controller: controller.buyEndTimeController,
                readOnly: true,
                onTap: ()async{
                controller.initialTime = controller.buyEndTime;
                  TimeOfDay? pickedTime = await controller.selectTime(context);
                  if (pickedTime != null) {
                    controller.buyEndTime = pickedTime;
                    controller.buyEndTimeController.text = pickedTime.format(context);
                    controller.buyEndTime = TimeOfDay(hour: pickedTime.hour, minute: pickedTime.minute);
                    // Use the picked time
                  }
                }
              ),),
            ],
          ),
        ],
      ),
    );
  }
  customTextField({required String hintText,bool readOnly=false,
    TextInputType textInputType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    var suffixWidget,
    TextEditingController? controller,
    Function()?onTap}){
    return TextFormField(
      onTap: onTap,
      controller: controller,
      keyboardType: textInputType,
      inputFormatters: inputFormatters,
      readOnly: readOnly,
      decoration: InputDecoration(
        suffixIcon:suffixWidget,
        isDense: true,
        hintText: hintText,
        hintStyle:const TextStyle(
            fontSize: 13,
            fontFamily: interRegular,
            color: ColorConstant.black2,
            fontWeight: FontWeight.w500
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:const BorderSide(
            color: ColorConstant.addMoney
          )
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:const BorderSide(
                color: ColorConstant.addMoney
            )
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:const BorderSide(
                color: ColorConstant.addMoney
            )
        )
      ),
    );
  }

  selectedSubCatWidget(List list){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: ColorConstant.addMoney,width: 1)
      ),
      padding:const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
      child: ListView.separated(
          separatorBuilder: (context,sp){
            return ScreenSize.height(12);
          },
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: list.length,
          itemBuilder: (context,index){
        return Row(
          children: [
            checkBoxWidget(ColorConstant.onBoardingBack),
            ScreenSize.width(10),
            Flexible(
              child: Text(list[index]['name'],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style:const TextStyle(
                  fontSize: 12, fontFamily: interRegular, color: ColorConstant.blackLight, fontWeight: FontWeight.w400
              ),
              ),
            )
          ],
        );
      }),
    );
  }

  discountCategoryDialogBox(BuildContext context,) {
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
                    child:controller.discountCategoryList.isNotEmpty?
                    ListView.builder(
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        padding: const EdgeInsets.only(
                            left: 15, right: 10, bottom: 15, top: 4),
                        itemCount: controller.discountCategoryList.length,
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
                                    controller.selectedDiscountCategoryIndex.value=index;
                                    controller.selectedDiscountCategory.value=controller.discountCategoryList[index].name;
                                    controller.selectedDiscountCategoryId.value = controller.discountCategoryList[index].id.toString();
                                  },
                                  child: Row(
                                    children: [
                                    Icon(
                                        color:controller.selectedDiscountCategoryIndex.value==index?
                                        ColorConstant.onBoardingBack: ColorConstant.greyColor,
                                        size: 20,
                                     controller.selectedDiscountCategoryIndex.value==index?
                                     Icons.radio_button_checked:
                                        Icons.radio_button_off_outlined,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        controller.discountCategoryList[index].name.toString(),
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
                            if(controller.selectedDiscountCategory.value.isNotEmpty){
                              Navigator.pop(context);
                              controller.discountCategoryController.text = controller.selectedDiscountCategory.value;
                              controller.getSubCategoryApiFunction(controller.selectedDiscountCategoryId.value);
                              controller.selectedDiscountSubCat.clear();
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

  buyCategoryDialogBox(BuildContext context,) {
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
                    child:controller.buyCategoryList.isNotEmpty?
                    ListView.builder(
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        padding: const EdgeInsets.only(
                            left: 15, right: 10, bottom: 15, top: 4),
                        itemCount: controller.buyCategoryList.length,
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
                                    controller.selectedBuyCategoryIndex.value=index;
                                    controller.selectedBuyCategory.value=controller.buyCategoryList[index].name;
                                    controller.selectedBuyCategoryId.value = controller.buyCategoryList[index].id.toString();
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        color:controller.selectedBuyCategoryIndex.value==index?
                                        ColorConstant.onBoardingBack: ColorConstant.greyColor,
                                        size: 20,
                                        controller.selectedBuyCategoryIndex.value==index?
                                        Icons.radio_button_checked:
                                        Icons.radio_button_off_outlined,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        controller.buyCategoryList[index].name.toString(),
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
                            if(controller.selectedBuyCategory.value.isNotEmpty){
                              Navigator.pop(context);
                              controller.buyCategoryController.text = controller.selectedBuyCategory.value;
                              controller.getSubCategoryApiFunction(controller.selectedBuyCategoryId.value);
                              controller.selectedBuySubCat.clear();
                              controller.selectedGetSubCat.clear();
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

  discountSubCategoryDialogBox(BuildContext context,) {
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
                    child:controller.discountSubCatModel.value!=null&& controller.discountSubCatModel.value!.data!=null?
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15, right: 10,top: 5),
                            child: GestureDetector(
                              onTap: (){
                                state((){});
                                if(controller.discountSubCatModel.value.isAllSelected){
                                  controller.discountSubCatModel.value.isAllSelected=false;
                                  for(int i=0;i<controller.discountSubCatModel.value!.data!.length;i++){
                                    controller.discountSubCatModel.value.data![i].isSelected.value=false;
                                    controller.discountSubCatModel.value.selectedList.clear();
                                  }
                                }
                                else{
                                  controller.discountSubCatModel.value.selectedList.clear();
                                  controller.discountSubCatModel.value.isAllSelected=true;
                                  for(int i=0;i<controller.discountSubCatModel.value!.data!.length;i++){
                                    controller.discountSubCatModel.value.data![i].isSelected.value=true;
                                    controller.discountSubCatModel.value.selectedList.add({
                                      "name": controller.discountSubCatModel.value.data![i].name,
                                      "id": controller.discountSubCatModel.value.data![i].id
                                    });
                                  }
                                }
                              },
                              child: Row(
                                children: [
                                  checkBoxWidget(controller.discountSubCatModel.value.isAllSelected==true?
                                  ColorConstant.onBoardingBack:ColorConstant.white
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                const  Text(
                                    "All",
                                    style:  TextStyle(
                                      color: ColorConstant.greyColor,
                                      fontSize: 14,
                                      fontFamily: interRegular,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          ListView.builder(
                              physics: const ScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              padding: const EdgeInsets.only(
                                  left: 15, right: 10, bottom: 15, top: 4),
                              itemCount: controller.discountSubCatModel.value!.data!.length,
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
                                          if(controller.discountSubCatModel.value.data![index].isSelected.value==false){
                                            controller.discountSubCatModel.value.data![index].isSelected.value=true;
                                            controller.discountSubCatModel.value.selectedList.add({
                                              "name": controller.discountSubCatModel.value.data![index].name,
                                              "id": controller.discountSubCatModel.value.data![index].id
                                            }
                                            );
                                            if(controller.discountSubCatModel.value.selectedList.length==controller.discountSubCatModel.value!.data!.length){
                                              controller.discountSubCatModel.value.isAllSelected=true; /// in case the user select all subCat
                                            }
                                          }
                                          else{
                                            controller.discountSubCatModel.value.data![index].isSelected.value=false;
                                            controller.discountSubCatModel.value.isAllSelected=false; /// in case the user unselect any subCat
                                            for(int i=0;i<controller.discountSubCatModel.value.selectedList.length;i++){
                                              if(controller.discountSubCatModel.value.selectedList[i]['id']==controller.discountSubCatModel.value.data![index].id){
                                                controller.discountSubCatModel.value.selectedList.removeAt(i);
                                              }
                                            }

                                          }
                                        },
                                        child: Row(
                                          children: [
                                            checkBoxWidget(controller.discountSubCatModel.value.data![index].isSelected.value==true?
                                            ColorConstant.onBoardingBack:ColorConstant.white
                                                ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Flexible(
                                              child: Text(
                                                controller.discountSubCatModel.value.data![index].name.toString(),
                                                maxLines:1,
                                                overflow:TextOverflow.ellipsis,
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
                              }),
                        ],
                      ),
                    ):
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
                            if(controller.discountSubCatModel.value.selectedList.isNotEmpty) {
                              controller.selectedDiscountSubCat.clear();
                              for (int i = 0; i <
                                  controller.discountSubCatModel.value
                                      .selectedList.length; i++) {
                                controller.selectedDiscountSubCat.add(
                                    {
                                      "name": controller.discountSubCatModel.value.selectedList[i]['name'],
                                      "id": controller.discountSubCatModel.value.selectedList[i]['id']
                                    }
                                );
                                state(() {});
                              }
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

  buySubCategoryDialogBox(BuildContext context,) {
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
                    child:controller.buySubCatModel.value!=null&& controller.buySubCatModel.value!.data!=null?
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15, right: 10,top: 5),
                            child: GestureDetector(
                              onTap: (){
                                state((){});
                                if(controller.buySubCatModel.value.isAllSelected){
                                  controller.buySubCatModel.value.isAllSelected=false;
                                  for(int i=0;i<controller.buySubCatModel.value!.data!.length;i++){
                                    controller.buySubCatModel.value.data![i].isSelected.value=false;
                                    controller.buySubCatModel.value.selectedList.clear();
                                  }
                                }
                                else{
                                  controller.buySubCatModel.value.selectedList.clear();
                                  controller.buySubCatModel.value.isAllSelected=true;
                                  for(int i=0;i<controller.buySubCatModel.value!.data!.length;i++){
                                    controller.buySubCatModel.value.data![i].isSelected.value=true;
                                    controller.buySubCatModel.value.selectedList.add({
                                      "name": controller.buySubCatModel.value.data![i].name,
                                      "id": controller.buySubCatModel.value.data![i].id
                                    });
                                  }
                                }
                              },
                              child: Row(
                                children: [
                                  checkBoxWidget(controller.buySubCatModel.value.isAllSelected==true?
                                  ColorConstant.onBoardingBack:ColorConstant.white
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const  Text(
                                    "All",
                                    style:  TextStyle(
                                      color: ColorConstant.greyColor,
                                      fontSize: 14,
                                      fontFamily: interRegular,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          ListView.builder(
                              physics: const ScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              padding: const EdgeInsets.only(
                                  left: 15, right: 10, bottom: 15, top: 4),
                              itemCount: controller.buySubCatModel.value!.data!.length,
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
                                          if(controller.buySubCatModel.value.data![index].isSelected.value==false){
                                            controller.buySubCatModel.value.data![index].isSelected.value=true;
                                            controller.buySubCatModel.value.selectedList.add(
                                                {
                                                  "name": controller.buySubCatModel.value.data![index].name,
                                                  "id": controller.buySubCatModel.value.data![index].id
                                                }
                                            );
                                            if(controller.buySubCatModel.value.selectedList.length==controller.buySubCatModel.value!.data!.length){
                                              controller.buySubCatModel.value.isAllSelected=true; /// in case the user select all subCat
                                            }
                                          }
                                          else{
                                            controller.buySubCatModel.value.data![index].isSelected.value=false;
                                            controller.buySubCatModel.value.isAllSelected=false; /// in case the user unselect any subCat
                                            for(int i=0;i<controller.buySubCatModel.value.selectedList.length;i++){
                                              if(controller.buySubCatModel.value.selectedList[i]['id']==controller.buySubCatModel.value.data![index].id){
                                                controller.buySubCatModel.value.selectedList.removeAt(i);
                                              }
                                            }
                                          }
                                        },
                                        child: Row(
                                          children: [
                                            checkBoxWidget(controller.buySubCatModel.value.data![index].isSelected.value==true?
                                            ColorConstant.onBoardingBack:ColorConstant.white
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Flexible(
                                              child: Text(
                                                controller.buySubCatModel.value.data![index].name.toString(),
                                                maxLines:1,
                                                overflow:TextOverflow.ellipsis,
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
                              }),
                        ],
                      ),
                    ):
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
                            if(controller.buySubCatModel.value.selectedList.isNotEmpty) {
                              controller.selectedBuySubCat.clear();
                              for (int i = 0; i <
                                  controller.buySubCatModel.value
                                      .selectedList.length; i++) {
                                controller.selectedBuySubCat.add(
                                    {
                                      "name": controller.buySubCatModel.value.selectedList[i]['name'],
                                      "id": controller.buySubCatModel.value.selectedList[i]['id']
                                    });
                                state(() {});
                              }
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
  getSubCategoryDialogBox(BuildContext context,) {
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
                    child:controller.getSubCatModel.value!=null&& controller.getSubCatModel.value!.data!=null?
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15, right: 10,top: 5),
                            child: GestureDetector(
                              onTap: (){
                                state((){});
                                if(controller.getSubCatModel.value.isAllSelected){
                                  controller.getSubCatModel.value.isAllSelected=false;
                                  for(int i=0;i<controller.getSubCatModel.value!.data!.length;i++){
                                    controller.getSubCatModel.value.data![i].isSelected.value=false;
                                    controller.getSubCatModel.value.selectedList.clear();
                                  }
                                }
                                else{
                                  controller.getSubCatModel.value.selectedList.clear();
                                  controller.getSubCatModel.value.isAllSelected=true;
                                  for(int i=0;i<controller.getSubCatModel.value!.data!.length;i++){
                                    controller.getSubCatModel.value.data![i].isSelected.value=true;
                                    controller.getSubCatModel.value.selectedList.add({
                                      "name": controller.getSubCatModel.value.data![i].name,
                                      "id": controller.getSubCatModel.value.data![i].id
                                    });
                                  }
                                }
                              },
                              child: Row(
                                children: [
                                  checkBoxWidget(controller.getSubCatModel.value.isAllSelected==true?
                                  ColorConstant.onBoardingBack:ColorConstant.white
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const  Text(
                                    "All",
                                    style:  TextStyle(
                                      color: ColorConstant.greyColor,
                                      fontSize: 14,
                                      fontFamily: interRegular,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          ListView.builder(
                              physics: const ScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              padding: const EdgeInsets.only(
                                  left: 15, right: 10, bottom: 15, top: 4),
                              itemCount: controller.getSubCatModel.value!.data!.length,
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
                                          if(controller.getSubCatModel.value.data![index].isSelected.value==false){
                                            controller.getSubCatModel.value.data![index].isSelected.value=true;
                                            controller.getSubCatModel.value.selectedList.add({
                                              "name": controller.getSubCatModel.value.data![index].name,
                                              "id": controller.getSubCatModel.value.data![index].id
                                            }
                                            );
                                            if(controller.getSubCatModel.value.selectedList.length==controller.getSubCatModel.value!.data!.length){
                                              controller.getSubCatModel.value.isAllSelected=true; /// in case the user select all subCat
                                            }
                                          }
                                          else{
                                            controller.getSubCatModel.value.data![index].isSelected.value=false;
                                            controller.getSubCatModel.value.isAllSelected=false; /// in case the user unselect any subCat
                                            for(int i=0;i<controller.getSubCatModel.value.selectedList.length;i++){
                                              if(controller.getSubCatModel.value.selectedList[i]['id']==controller.getSubCatModel.value.data![index].id){
                                                controller.getSubCatModel.value.selectedList.removeAt(i);
                                              }
                                            }
                                          }
                      
                                        },
                                        child: Row(
                                          children: [
                                            checkBoxWidget(controller.getSubCatModel.value.data![index].isSelected.value==true?
                                            ColorConstant.onBoardingBack:ColorConstant.white
                                               ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Flexible(
                                              child: Text(
                                                controller.getSubCatModel.value.data![index].name.toString(),
                                                maxLines:1,
                                                overflow:TextOverflow.ellipsis, style: const TextStyle(
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
                              }),
                        ],
                      ),
                    ):
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
                            if(controller.getSubCatModel.value.selectedList.isNotEmpty) {
                              controller.selectedGetSubCat.clear();
                              for (int i = 0; i <
                                  controller.getSubCatModel.value
                                      .selectedList.length; i++) {
                                controller.selectedGetSubCat.add(
                                    {
                                      "name": controller.getSubCatModel.value.selectedList[i]['name'],
                                      "id": controller.getSubCatModel.value.selectedList[i]['id']
                                    }
                                  );
                                state(() {});
                              }
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