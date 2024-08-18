import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:senorita/utils/toast.dart';
import '../../../api_config/Api_Url.dart';
import '../../../helper/appbar.dart';
import '../../../helper/appimage.dart';
import '../../../helper/getText.dart';
import '../../../utils/color_constant.dart';
import '../../../utils/size_config.dart';
import '../../../utils/stringConstants.dart';
import 'controller/addPhotosController.dart';

class AddPhotosScreen extends GetView<AddPhotosController> {
  const AddPhotosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstant.white,
        appBar: appBar(context, "Photos", () {
          Get.back();
        }),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 4),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 7),
                    child: getText(
                        title: "My photos",
                        size: 14,
                        fontFamily: interMedium,
                        color: ColorConstant.offerTextBlack,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(
                    () => controller.photosList.isEmpty?
                    Container():
                    GridView.builder(
                      physics: const ClampingScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              crossAxisSpacing: 1,
                              mainAxisSpacing: 1),
                      itemCount: controller.photosList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        // var model = controller.fileNameList[index];
                        return GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 1,
                            ),
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 12, left: 5, right: 5),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        color: ColorConstant.cardBack,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: ClipRRect(
                                      borderRadius:
                                         const BorderRadius.all(Radius.circular(5)),
                                      child: Image.network(
                                        height: 80,
                                        width: 89,
                                        ApiUrls.expertImageBase+ controller.photosList[index]['image'],
                                        fit: BoxFit.cover,
                                      ),
                                       ),
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  top: 4,
                                  child: GestureDetector(
                                    onTap: () {
                                      controller.deleteImageApiFunction(
                                          context,
                                          controller.photosList[index]['id']).then((value) {
                                            if(value!=null){
                                              controller.photosList.removeAt(index);
                                            }
                                      }) ;
                                    },
                                    child: ClipRRect(
                                      child: Image.asset(
                                        height: 20,
                                        width: 20,
                                        AppImages.imgRemoveOffer,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 35,
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
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      if(controller.imgUploaded.value==false){
                        controller.showImagePicker(context);
                      }
                      else{
                        showToast('uploading...');
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
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
                              width: MediaQuery.of(context).size.width - 10,
                              child: Column(
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
                                  getText(
                                      title:
                                          "Upload your image or banner here",
                                      size: 12,
                                      fontFamily: interMedium,
                                      color: ColorConstant.offerTextBlack,
                                      fontWeight: FontWeight.w600),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Obx(()=>
                       controller.imgUploaded.value==true?
                            SizedBox(
                              height: 100,
                              width: MediaQuery.of(context).size.width,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6)),
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.black45.withOpacity(0.1),
                                    )),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Obx(()=>
                                             controller.imgFile.value == null
                                                ? ClipRRect(
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(5)),
                                                    child: Image.asset(
                                                      height: 45,
                                                      width: 45,
                                                      AppImages.photoTwo,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  )
                                                : ClipRRect(
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(5)),
                                                    child: Image.file(
                                                        height: 45,
                                                        width: 45,
                                                        fit: BoxFit.cover,
                                                        controller.imgFile.value!)),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 3,
                                              ),
                                              Obx(()=>
                                                getText(
                                                    title: controller.imgPathString.value,
                                                    size: 15,
                                                    fontFamily: interMedium,
                                                    color: ColorConstant
                                                        .offerTextBlack,
                                                    fontWeight: FontWeight.w600),
                                              ),
                                              SizedBox(
                                                height: 4,
                                              ),
                                              getText(
                                                  title: controller.imgSize.value+"MB",
                                                  size: 12,
                                                  fontFamily: interMedium,
                                                  color: ColorConstant.imgSize,
                                                  fontWeight: FontWeight.w600),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Obx(()=>
                                      Padding(
                                        padding: const EdgeInsets.only(right: 5),
                                        child: LinearPercentIndicator(
                                          width: MediaQuery.of(context).size.width -
                                              95,
                                          lineHeight: 10,
                                          barRadius: Radius.circular(20),
                                          animation: true,
                                          animationDuration: 1200,
                                          trailing: getText(
                                              title: '${(controller.percentage.value * 100).toStringAsFixed(2)}%',
                                              size: 12,
                                              fontFamily: interMedium,
                                              color: ColorConstant.imgSize,
                                              fontWeight: FontWeight.w600),
                                          percent:controller.percentage.value,
                                          progressColor: ColorConstant.progressBar,
                                        ),
                                      ),
                                    ),
                                    getText(
                                        title: "",
                                        size: 10,
                                        fontFamily: interMedium,
                                        color: ColorConstant.offerTextBlack,
                                        fontWeight: FontWeight.w600),
                                  ],
                                ),
                              ),
                            ):SizedBox(),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
