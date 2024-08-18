import 'dart:async';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

import '../../api_config/Api_Url.dart';
import '../../helper/appimage.dart';
import '../../utils/color_constant.dart';
import 'indication.dart';

class ImgView extends StatefulWidget {
  final List imgList;
  final int index;
  const ImgView(this.imgList, this.index, {super.key});
  @override
  State<ImgView> createState() => _ImgViewState();
}
class _ImgViewState extends State<ImgView> {
  int index = 0;

  @override
  void initState() {
    index= widget.index;

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.blackColor,
        elevation: 0,
        leadingWidth: 30,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Container(
              height: 28,
              width: 28,
              alignment: Alignment.centerRight,
              child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Image.asset(
                    AppImages.backIcon,
                    height: 28,
                    color: Colors.white,
                    width: 28,
                  ))),
        ),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child:    PhotoViewGallery.builder(
                scrollPhysics: const BouncingScrollPhysics(),
                builder: (BuildContext context, int index) {
                  return PhotoViewGalleryPageOptions(
                    imageProvider: NetworkImage(ApiUrls.expertImageBase + widget.imgList[index].toString()),
                    initialScale: PhotoViewComputedScale.contained * .97,
                    minScale: PhotoViewComputedScale.contained*.9,
                  );
                },
                itemCount: widget.imgList.length,
                backgroundDecoration:const BoxDecoration(color: Colors.transparent),
                pageController:  PageController(initialPage: widget.index,viewportFraction: 1),
                onPageChanged: (val){
                  index = val;
                  setState(() {
                  });
                },
              )
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List<Widget>.generate(widget.imgList.length, (i) => Indicator(index == i ? true : false))),
          ],
        ),
      ),
    );
  }

}
