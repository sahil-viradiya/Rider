import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:rider/constant/app_color.dart';
import 'package:rider/constant/style.dart';
import 'package:rider/route/app_route.dart';
import 'package:rider/utils/app_logger.dart';
import 'package:rider/widget/custom_button.dart';

import '../screens/request/request_controller.dart';

class RequestItemWidget extends GetView<RequestController> {
  const RequestItemWidget({super.key, required this.index});

  final index;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              border: Border.all(color: primary),
              borderRadius: BorderRadius.circular(8)),
          margin: const EdgeInsets.only(bottom: 34),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Distance : ${controller.ride[index].totalDistance}",
                style: Styles.boldBlack616,
              ),
              const Gap(12),
              Text(
                "Amount : ${controller.ride[index].totalCharges}",
                style: Styles.boldBlack612,
              ),
              Text(
                "Time : ${controller.ride[index].totalTime}",
                style: Styles.boldBlack612,
              ),
              Text(
                "Landmark : ${controller.ride[index].senderLandmark}",
                style: Styles.boldBlack612,
              ),
              Text(
                "Name : ${controller.ride[index].senderName}",
                style: Styles.boldBlack612,
              ),
              Text(
                "Address : ${controller.ride[index].pickupAddress}",
                style: Styles.boldBlack612,
              ),
              const Gap(14),
              Visibility(
                visible: controller.isAccepted[index] ?? true,
                child: _acceptRejectRow(),
              ),
              Visibility(
                visible: !(controller.isAccepted[index] ?? true),
                child: _acceptBtn(),
              )
            ],
          ),
        ));
  }

  Row _acceptRejectRow() {
    return Row(
      children: [
        Expanded(
          child: Obx(() {
            return CustomButton(
              isLoading: controller.rejectLoading[index] ?? false,
              color: const Color(0xFFFA5E5E),
              height: 35,
              borderCircular: 6,
              text: "Reject",
              fun: () {
                controller
                    .rideReject(id: controller.ride[index].rideId, index: index)
                    .then((value) {
                  controller.ride.removeAt(index);
                  controller.update();
                });
              },
            );
          }),
        ),
        const Gap(16),
        Expanded(
          child: Obx(() {
            return CustomButton(
              isLoading: controller.acceptLoading[index] ?? false,
              borderCircular: 6,
              height: 35,
              text: "Accept",
              fun: () {
                log("RIDE ID +++++++++++++++++++ ${controller.ride[index].rideId}");
                controller
                    .acceptRide(
                        id: controller.ride[index].rideId ?? 0, index: index)
                    .then((value) {
                  Get.toNamed(AppRoutes.ORDER,
                          arguments: controller.ride[index].rideId ?? 0)!
                      .then((value) {
                    controller.isAccepted[index] = false;
                  });
                });

                AppLogger.logger.i(controller.isAccepted[index]);
                // controller.acceptRide(
                //     id: controller.ride[index].rideId ?? 0, index: index);
              },
            );
          }),
        ),
      ],
    );
  }

  _acceptBtn() {
    return Obx(() {
      return CustomButton(
        isLoading: controller.acceptLoading[index] ?? false,
        borderCircular: 6,
        height: 35,
        width: Get.width,
        text: "Panding",
        fun: () {
          log("RIDE ID +++++++++++++++++++ ${controller.ride[index].rideId}");
          controller.isAccepted[index] = false;

          AppLogger.logger.i(controller.isAccepted[index]);
        },
      );
    });
  }
}

final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
