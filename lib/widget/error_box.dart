import 'package:flutter/material.dart';
import '../helper/appimage.dart';
import '../helper/getText.dart';
import '../utils/stringConstants.dart';

showErrorMessageDialog(BuildContext context, String message,) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.zero,
        content: Container(
          padding: const EdgeInsets.only(left: 1,right: 1,top: 10,bottom: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              SizedBox(
                  height: 70,
                  width: 71,
                  child: Image.asset(
                    height: 55,
                    width: 55,
                      AppImages.errorImg,
                  )),
              const SizedBox(height: 15),

               getText(
                  title: "Oh Snap!",
                  textAlign: TextAlign.center,
                  size: 14,
                  fontFamily: celiaRegular,
                  color: Color(0xff183B65),
                  fontWeight: FontWeight.w600),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 5,right: 5),
                child: getText(
                    title: message,
                    textAlign: TextAlign.center,
                    size: 14,
                    fontFamily: celiaRegular,
                    color: Color(0xff696B6E),
                    fontWeight: FontWeight.w500),
              ),

              const SizedBox(height: 16),
              const Divider(
                color: Colors.grey,
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: ()
                {
                  Navigator.of(context).pop();
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child:  getText(
                        title: "Try Again",
                        textAlign: TextAlign.center,
                        size: 13,
                        fontFamily: celiaRegular,
                        color: Color(0xff183B65),
                        fontWeight: FontWeight.w600),),
                  ),
                ),

            ],
          ),
        ),
      );
    },
  );
}
