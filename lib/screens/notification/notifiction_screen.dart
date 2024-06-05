import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../constant/app_color.dart';
import '../../constant/app_image.dart';
import '../../constant/my_size.dart';
import '../../constant/style.dart';
import '../../widget/auth_app_bar_widget.dart';
import '../../widget/custom_button.dart';
import 'notifiction_controller.dart';

class NotificationScreen extends GetView<NotificationController> {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: appbarSmall1(context, "Notifications"),
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: MySize.getScaledSizeWidth(25)),
        child: Column(
          children: [
            const Divider(),
            Gap(14),
            CustomButton(
                height: MySize.size44,
                width: double.infinity,
                borderCircular: 8,
                text: "Mark as Read All",
                fun: () {}),
            Gap(MySize.size8!),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: 26,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      /* Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return ChatingScreen();
                                },
                              ));*/
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: MySize.size80,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 0.8, color: Colors.black12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              ClipOval(
                                child: Image.asset(
                                  AppImage.USERDUMMY,
                                  width: MySize.size60,
                                  height: MySize.size60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Gap(MySize.size14!),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Mahima Chrisht",
                                    style: Styles.boldBlack716,
                                  ),
                                  Text(
                                    "Lorem Ipsum has been the...",
                                    style: Styles.boldBlue614,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: MySize.getScaledSizeHeight(20)),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                "09:11 AM",
                                style: Styles.hint610,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
