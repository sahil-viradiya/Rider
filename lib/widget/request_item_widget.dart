import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:rider/constant/style.dart';
import 'package:rider/route/app_route.dart';
import 'package:rider/screens/request/request_controller.dart';
import 'package:rider/widget/custom_button.dart';

class RequestItemWidget extends StatelessWidget {
  const RequestItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
   var _con = Get.put(RequestController());
    return   Container(
      margin: EdgeInsets.only(bottom: 34),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Delivery Parcel...",
            style: Styles.boldBlack616,
          ),
          Gap(12),
          Text(
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer",
            style: Styles.boldBlack612,),
          Gap(14),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  color: Color(0xFFFA5E5E),
                  height: 35,
                  borderCircular: 6,
                  text: "Reject",
                  fun: () {},
                ),
              ),
              Gap(16),
              Expanded(
                child: CustomButton(
                  borderCircular: 6,
                  height: 35,
                  text: "Accept",
                  fun: () {
                    Get.toNamed(AppRoutes.ORDER);
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
