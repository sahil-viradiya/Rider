import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:rider/animation/fade_in.dart';
import 'package:rider/constant/app_color.dart';
import 'package:rider/constant/my_size.dart';
import 'package:rider/constant/style.dart';
import 'package:rider/widget/app_text_field.dart';
import 'package:rider/widget/auth_app_bar_widget.dart';
import 'package:rider/widget/request_item_widget.dart';
import 'request_controller.dart';

class RequestScreen extends GetView<RequestController> {
  const RequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: appbarSmall1(context, "Requests"),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: GetBuilder<RequestController>(
            init: RequestController(),
            initState: (_) {},
            builder: (_) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(),
                  const Gap(14),
                  Row(
                    children: [
                      Text(
                        "Total Services :",
                        style: Styles.lable414,
                      ),
                      Obx(() => Text(
                            "${controller.ride.length}",
                            style: Styles.boldBlue12,
                          )),
                      const Spacer(),
                      SizedBox(
                        width: MySize.size200!,
                        child: const CustomTextFormFieldWidget(
                          hintRpadding: 12,
                          hintTpadding: 12,
                          maxLine: 1,
                          sufixIconWidget: Icon(
                            Icons.search,
                            color: primary,
                          ),
                          hintText: 'Search',
                          border: primary,
                          borderRadius: 5,
                        ),
                      ),
                    ],
                  ),
                  Obx(() {
                    if (controller.isLoading.value == true) {
                      return Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Gap(Get.height / 3),
                            const CircularProgressIndicator(
                              color: primary,
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Expanded(
                        child: FadeInAnimation(
                          delay: .5,
                          child: AnimatedList(
                            initialItemCount: controller.ride.length,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index, animation) {
                              return RequestItemWidget(
                                index: index,
                              );
                            },
                          ),
                        ),
                      );
                    }
                  })
                ],
              );
            },
          )),
    );
  }
}
