// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:rider/constant/app_color.dart';
import 'package:rider/constant/app_image.dart';
import 'package:rider/constant/my_size.dart';
import 'package:rider/constant/style.dart';

class Appbar extends StatelessWidget implements PreferredSizeWidget {
  Appbar({super.key});
  double? appBarHeight;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    appBarHeight = screenHeight * 0.1;
    MySize().init(
      context,
    );
    return Container(
      height: MySize.size200,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            AppImage.AUTHAPPIMAGE,
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(MySize.size200 ?? 200);
}

class ProfileAppbar extends StatelessWidget implements PreferredSizeWidget {
  ProfileAppbar({super.key});
  double? appBarHeight;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    appBarHeight = screenHeight * 0.1;
    MySize().init(
      context,
    );
    return Column(
      children: [
        Container(
          height: MySize.size266,
          width: double.infinity,
          decoration: const BoxDecoration(
            // image: DecorationImage(
            //   image: AssetImage(
            //     AppImage.authAppImage,
            //   ),
            //   fit: BoxFit.cover,
            // ),
          ),
        ),
        Container(
          height: MySize.size95,
          width: double.infinity,
          decoration: const BoxDecoration(
            //color: Colors.amber,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(MySize.size200 ?? 200);
}

appbarSmall1(BuildContext context, String title,
    {PreferredSizeWidget? bottom,Color? backgroundColor}) {
  return AppBar(
    backgroundColor:backgroundColor?? scaffoldColor,
    bottom: bottom,
    forceMaterialTransparency: true,
    automaticallyImplyLeading: false,
    leading: Padding(
      padding: const EdgeInsets.only(bottom: 2.0),
      child: IconButton(
        visualDensity: const VisualDensity(horizontal: -4),
        constraints: BoxConstraints.loose(Size.zero),
        icon: Icon(Icons.arrow_back_ios,
            color: Colors.black, size: MySize.size20),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ),
    title: Text(
      title,
      style: Styles.boldBlack716,
    ),
    centerTitle: true,
  );


}
bottomAppbarSmall(BuildContext context, String title,
    {PreferredSizeWidget? bottom,Color? backgroundColor}) {
  return AppBar(
    backgroundColor:backgroundColor?? scaffoldColor,
    bottom: bottom,
    automaticallyImplyLeading: false,
    leading: Align(
      alignment: Alignment.topLeft,
      child: IconButton(
        icon: const Icon(Icons.menu,color: primary,),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
    ),
    title: Text(
      title,
      style: Styles.boldBlue716,
    ),
    centerTitle: true,
  );
}