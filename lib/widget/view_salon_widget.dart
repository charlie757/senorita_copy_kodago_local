import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:senorita/api_config/Api_Url.dart';
import 'package:senorita/helper/network_image_helper.dart';
import 'package:senorita/model/home_user_screen_model.dart';
import 'package:senorita/utils/extension.dart';

import '../helper/appimage.dart';
import '../helper/getText.dart';
import '../utils/color_constant.dart';
import '../utils/my_sperator.dart';
import '../utils/stringConstants.dart';

salonWidget(BuildContext context, model, String route, Function() onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
          color: ColorConstant.white,
          border: Border.all(color: ColorConstant.borderColor),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, -2),
                color: ColorConstant.blackColor.withOpacity(.2),
                blurRadius: 15)
          ]),
      padding: const EdgeInsets.only(bottom: 13),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(18),
                    topLeft: Radius.circular(18)),
                child: model.user != null
                    ? NetworkImageHelper(
                        img: route == 'offer'
                            ? model.imageUrl
                            : ApiUrls.imgBaseUrl +
                                model.user!.profilePicture.toString(),
                        height: 200.0,
                        width: double.infinity,
                      )
                    : Container(),
              ),
              route == 'offer'
                  ? Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 32,
                        width: 35,
                        decoration: BoxDecoration(
                            color: ColorConstant.blackColor,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4),
                              bottomLeft: Radius.circular(4),
                            )),
                        alignment: Alignment.center,
                        child: getText(
                            title: "+${model.offerCount.toString()}",
                            size: 15,
                            fontFamily: interMedium,
                            color: ColorConstant.whiteColor,
                            fontWeight: FontWeight.w400),
                      ),
                    )
                  : Container()
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 11, right: 12, top: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            softWrap: true,
                            model.user != null
                                ? model.user!.name.toString().toTitleCase()
                                : "",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 17,
                              fontFamily: interSemiBold,
                              color: ColorConstant.blackColorDark,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          model.expertSubcats != null
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 3),
                                  child: getText(
                                      title: model.expertSubcats!
                                              .map((subcat) => subcat.name)
                                              .join(', ') ??
                                          '',
                                      size: 12.5,
                                      fontFamily: interMedium,
                                      color: ColorConstant.blackLight,
                                      fontWeight: FontWeight.w500),
                                )
                              : SizedBox(),
                        ],
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: ColorConstant.greenStar,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      padding: const EdgeInsets.only(
                          left: 5, right: 5, top: 4, bottom: 4),
                      child: Row(
                        children: [
                          getText(
                              title: model.avgRating == null
                                  ? '0.0'
                                  : model.avgRating.toString().contains('.')
                                      ? model.avgRating.toString()
                                      : "${model.avgRating.toString()}.0",
                              size: 11,
                              fontFamily: interMedium,
                              color: ColorConstant.white,
                              fontWeight: FontWeight.w500),
                          const SizedBox(
                            width: 2,
                          ),
                          Image.asset(
                            width: 7,
                            height: 7,
                            color: ColorConstant.white,
                            AppImages.rating,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                model.user != null && model.user!.address != null
                    ? Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              width: 16,
                              height: 16,
                              AppImages.location,
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            Flexible(
                              child: Text(
                                model.user != null
                                    ? model.user!.address.toString()
                                    : '',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: const TextStyle(
                                  fontSize: 12.5,
                                  fontFamily: interMedium,
                                  color: ColorConstant.blackLight,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    : const SizedBox(),
                model.user != null && model.user!.lat != null
                    ? Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              width: 13,
                              color: ColorConstant.blackLight,
                              height: 13,
                              AppImages.distance,
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            Flexible(
                              child: Text(
                                "${model.user!.distance.toString()} km",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: const TextStyle(
                                  fontSize: 13.0,
                                  fontFamily: interMedium,
                                  color: ColorConstant.blackLight,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    : const SizedBox(),
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: MySeparator(color: Color(0xffD6D5D5)),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 11,
                  ),
                  child: Row(
                    children: [
                      const Text(
                        "Exp. ",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13.0,
                          fontFamily: interMedium,
                          color: ColorConstant.pointBg,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "${model.experience.toString()} year",
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13.0,
                          fontFamily: interMedium,
                          color: ColorConstant.blackLight,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      model.offers != null && model.offers.isNotEmpty
                          ? Text(
                              model.offers![0].type == 'buyget'
                                  ? "BUY 1 GET 1 FREE"
                                  : "Flat ${model.offers![0].discountPecent}% Discount",
                              style: const TextStyle(
                                fontSize: 12.0,
                                fontFamily: interBold,
                                color: ColorConstant.darkBlueColor,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
