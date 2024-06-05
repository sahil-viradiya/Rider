import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:rider/constant/app_color.dart';
import 'package:rider/constant/app_image.dart';
import 'package:rider/constant/my_size.dart';
import 'package:rider/constant/style.dart';
import 'package:rider/route/app_route.dart';
import 'home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    StringTitle myTitle = StringTitle(
      img1: AppImage.REQUEST,
      img2: AppImage.COURIER,
      count1: '06',
      count2: '03',
      count3: '\$ 999',
      count4: '4.4',
      img3: AppImage.MONEY,
      img4: AppImage.RATING,
      title1: "No of requests received" ?? "",
      title2: "No of rides accepted" ?? "",
      title3: "Revenue earned" ?? "",
      title4: "Star rating" ?? "",
    );
    return Scaffold(
      backgroundColor: white,

      drawer: drawer(context),
      appBar: AppBar(
        backgroundColor: white,
        forceMaterialTransparency: true,
        title: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //=========================Current Location==============

                Text(
                  "Current Location",
                  style: Styles.lable414,
                ),
                Row(
                  children: [
                    SvgPicture.asset(AppImage.LOCATION),
                    const Gap(6),
                    Text(
                      "Kalupur, Ahmedabad",
                      style: Styles.boldDarkGrey60012,
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white, // Set the border color
                  width: 3.0, // Set the border width
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    // Set the shadow color
                    blurRadius: 10.0,
                    // Set the shadow blur radius
                    offset: const Offset(0, 5), // Set the shadow offset
                  ),
                ],
              ),
              child: const CircleAvatar(
                radius: 20.0,
                backgroundImage: NetworkImage(
                  'https://picsum.photos/id/237/300/300',
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 0.96),
              itemCount: 4,
              itemBuilder: (context, index) {
                String title;
                String img;
                String cnt;
                switch (index) {
                  case 0:
                    title = myTitle.title1;
                    cnt = myTitle.count1;
                    img = myTitle.img1;
                    break;
                  case 1:
                    title = myTitle.title2;
                    cnt = myTitle.count2;

                    img = myTitle.img2;

                    break;
                  case 2:
                    title = myTitle.title3;
                    cnt = myTitle.count3;

                    img = myTitle.img3;

                    break;
                  case 3:
                    title = myTitle.title4;
                    cnt = myTitle.count4;
                    img = myTitle.img4;

                    break;
                  default:
                    img = AppImage.VISA;
                    cnt = "0";
                    title = ''; // Handle the case for unexpected indices
                }
                return GestureDetector(
                  onTap: () {
                    if(index==0){
                      Get.toNamed(AppRoutes.REQUEST);
                    }
                  },
                  child: _projectContainer(
                      myTitle: title, imges: img, count: cnt, index: index),
                );
              },
            ),
            const Gap(24),
            Row(
              children: [
                Text(
                  "Recent orders",
                  style: Styles.boldBlack616,
                ),
                const Spacer(),
                Text(
                  "View All",
                  style: Styles.boldBlue612,
                ),
              ],
            ),
            //============================RECENT ORDER===============================
            Expanded(
              child: AnimatedList(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                initialItemCount: 15,
                itemBuilder: (context, index, animation) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: primary)),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Order ID",
                                style: Styles.boldBlack612,
                              ),
                            ),
                            Text(
                              "30 May 2024",
                              style: Styles.lable411,
                            )
                          ],
                        ),
                        const Gap(8),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "9872589963188985",
                                style: Styles.lable414,
                              ),
                            ),
                            Text(
                              "Rejected",
                              style: Styles.boldRed712,
                            )
                          ],
                        )
                      ],
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

  Widget drawer(
    BuildContext context,
  ) {
    return Drawer(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topRight: Radius.circular(16)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: MySize.getScaledSizeHeight(22),
                right: MySize.getScaledSizeHeight(34),
                top: MySize.getScaledSizeHeight(44),
                bottom: MySize.getScaledSizeHeight(14),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 250,
                    child: Row(
                      children: [
                        ClipOval(
                          child: Image.asset(
                            AppImage.USERDUMMY,
                            width: MySize.size48,
                            height: MySize.size48,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Gap(MySize.size14!),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hello',
                              style: Styles.boldBlack716,
                            ),
                            Text(
                              "Adiwara Bestari",
                              style: Styles.lable414,
                            ),
                          ],
                        ),
                        const Spacer(),
                        GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: const Icon(
                              Icons.arrow_back_ios,
                              size: 16,
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 1,
              color: Colors.black12,
            ),
            _commonListtile(
                context: context,
                icon: AppImage.NOTIFICTION,
                title: 'Notification',
                fun: () async {
                  Get.toNamed(AppRoutes.NOTIFICATION);
                }),
            _commonListtile(
                context: context,
                icon: AppImage.Document,
                title: 'Order History',
                fun: () async {
                  Get.toNamed(AppRoutes.ORDERHISTORY);
                }),
            _commonListtile(
                context: context,
                icon: AppImage.WELLET,
                title: 'Wallet',
                fun: () async {
                  Get.toNamed(AppRoutes.WALLET);

                  // showErrorMessage(
                  //   context: context,
                  //   message: 'Your account has been deleted.',
                  //   backgroundColor: green,
                  // );
                  // resate(context);
                  // delet(context);
                }),
            _commonListtile(
                context: context,
                icon: AppImage.LOGOUT,
                title: 'LogOut',
                fun: () async {
                  Navigator.pop(context);
                  // showErrorMessage(
                  //   context: context,
                  //   message: 'Your account has been deleted.',
                  //   backgroundColor: green,
                  // );
                  // resate(context);
                  // delet(context);
                }),
          ],
        ),
      ),
    );
  }

  ListTile _commonListtile(
      {required BuildContext context,
      required String title,
      required String icon,
      required VoidCallback fun}) {
    return ListTile(
      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
      leading: SvgPicture.asset(
        icon.toString(),
        height: MySize.size18,
        width: MySize.size18,
        color: Colors.black,
      ),
      title: Text(
        title,
        style: Styles.boldBlack614,
      ),
      onTap: fun,
    );
  }

  Container _projectContainer(
      {required String myTitle,
      required String imges,
      required String count,
      required int index}) {
    return Container(
      padding: const EdgeInsets.all(12),
      width: MySize.size168,
      // height: MySize.size140,
      decoration: BoxDecoration(
          // color: black,
          gradient: const LinearGradient(
            colors: [
              Color(0xFFEAB73B), // Start color
              Color(0xFFA78430), // End color
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              index == 3 ? SvgPicture.asset(AppImage.STAR) : const SizedBox(),
              index == 3 ? const Gap(6) : const SizedBox(),
              Expanded(
                child: Text(
                  count,
                  style: index == 0 || index == 1
                      ? Styles.white740
                      : Styles.white720,
                ),
              ),
              Align(
                  alignment: Alignment.bottomRight,
                  child: SvgPicture.asset(
                    imges,
                    color: white,
                  ))
            ],
          ),
          Gap(MySize.size10!),
          Expanded(
            child: Text(
              myTitle,
              style: Styles.white715,
            ),
          ),
          Gap(MySize.size35!),
        ],
      ),
    );
  }
}
