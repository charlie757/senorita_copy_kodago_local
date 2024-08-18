import 'package:flutter/material.dart';
import 'package:senorita/utils/utils.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../utils/color_constant.dart';
import '../../../../utils/size_config.dart';

allExpertShimmer() {
  return ListView.separated(
      separatorBuilder: (context,sp){
    return const SizedBox(height: 23,);
  },
      itemCount: 10,
      shrinkWrap: true,
      padding:const EdgeInsets.only(left: 15,right: 14,top: 15),
      physics: const ScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
            decoration: BoxDecoration(
                color: ColorConstant.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      offset:const Offset(0, -2),
                      color: ColorConstant.blackColor.withOpacity(.2),
                      blurRadius: 10
                  )
                ]
            ),
            child: Shimmer.fromColors(
              direction: ShimmerDirection.ltr,
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                      borderRadius: BorderRadius.only(topRight: Radius.circular(10),
                      topLeft: Radius.circular(10))
                    ),
                    height: 200,
                    width: MediaQuery.of(context).size.width,

                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 7,right: 7,bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 15,
                              width: MediaQuery.of(context).size.width/2,
                              color: Colors.grey.shade200,
                            ),
                            Container(
                              height: 20,
                              width: 55,
                              color: Colors.grey.shade200,
                            ),

                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 15,
                          width: MediaQuery.of(context).size.width/2.3,
                          color: Colors.grey.shade200,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 15,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.grey.shade200,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          height: 2,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.grey.shade200,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 20,
                              width: 50,
                              color: Colors.grey.shade200,
                            ),
                            Container(
                              height: 20,
                              width: 50,
                              color: Colors.grey.shade200,
                            ),

                          ],
                        ),
                      ],
                    ),
                  )

                ],
              ),
            ));
      });
}

allHomeExpertShimmer() {
  return ListView.builder(
      itemCount: 10,
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      padding: EdgeInsets.only(
          left: SizeConfig.screenHeightConstant * 0.7,
          top: SizeConfig.screenHeightConstant * 1,
          right: SizeConfig.screenHeightConstant * 0.5,
          bottom: SizeConfig.screenHeightConstant * 5
      ),
      itemBuilder: (context, index) {
        return Card(
            elevation: 1,
            shadowColor: const Color(0xff6A6A6A),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Shimmer.fromColors(
              direction: ShimmerDirection.ltr,
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.only(topRight: Radius.circular(10),
                            topLeft: Radius.circular(10))
                    ),
                    height: 200,
                    width: MediaQuery.of(context).size.width,

                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 7,right: 7,bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 15,
                              width: MediaQuery.of(context).size.width/2,
                              color: Colors.grey.shade200,
                            ),
                            Container(
                              height: 20,
                              width: 55,
                              color: Colors.grey.shade200,
                            ),

                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 15,
                          width: MediaQuery.of(context).size.width/2.3,
                          color: Colors.grey.shade200,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 15,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.grey.shade200,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          height: 2,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.grey.shade200,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 20,
                              width: 50,
                              color: Colors.grey.shade200,
                            ),
                            Container(
                              height: 20,
                              width: 50,
                              color: Colors.grey.shade200,
                            ),

                          ],
                        ),
                      ],
                    ),
                  )

                ],
              ),
            ));
      });
}

homeScreenShimmer() {
  return Container(
    height: 150,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12)
      ),
      margin: EdgeInsets.only(
          left: SizeConfig.screenHeightConstant * 1,
          top: SizeConfig.screenHeightConstant * 1,
          right: SizeConfig.screenHeightConstant * 1,
      ),
      child: Shimmer.fromColors(
        direction: ShimmerDirection.ltr,
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade50,
        child:  Container(
          decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius:const BorderRadius.all(Radius.circular(10))
          ),
          height: 150,
          width: MediaQuery.of(navigatorKey.currentContext!).size.width,
        ),

      ));
}

allCategoryShimmer() {
  return GridView.builder(
      itemCount: 4,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
      shrinkWrap: true,
      padding: EdgeInsets.only(
          left: SizeConfig.screenHeightConstant * 0.2,
          top: SizeConfig.screenHeightConstant * 1,
          right: SizeConfig.screenHeightConstant * 0.2,
          bottom: SizeConfig.screenHeightConstant * 5
      ),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          direction: ShimmerDirection.ltr,
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade50,
          child:  Container(
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
              borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            height: 150,
            width: MediaQuery.of(context).size.width,

          ),
        );
      });
}



