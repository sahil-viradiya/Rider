// ignore_for_file: deprecated_member_use


import 'package:dotted_border/dotted_border.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:rider/constant/app_color.dart';
import 'package:rider/constant/app_image.dart';
import 'package:rider/constant/my_size.dart';
import 'package:rider/constant/style.dart';
import 'package:rider/widget/app_text_field.dart';
import 'package:rider/widget/custom_button.dart';


class WidgetAddNewServices extends StatefulWidget {
  const WidgetAddNewServices({super.key});

  @override
  State<WidgetAddNewServices> createState() => _WidgetAddNewServicesState();
}

class _WidgetAddNewServicesState extends State<WidgetAddNewServices> {
  TextEditingController userC = TextEditingController();
  String searchUserQuery = '';
  List<Map<String, dynamic>> uList = <Map<String, dynamic>>[
    {'fullName': "sahil", 'customerId': "1"},
    {'fullName': "john", 'customerId': "2"},
    {'fullName': "alex", 'customerId': "3"},
    {'fullName': "jane", 'customerId': "4"},
    {'fullName': "emma", 'customerId': "5"},
  ];

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MySize.getScaledSizeWidth(16),
        vertical: MySize.getScaledSizeWidth(8),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Gap(MySize.size12!),
            // Text(
            //   "AppString.step1",
            //   style: Styles.boldBlack616,
            // ),
            Gap(MySize.size24!),

            //--------------------------enter service-----------------------------
            const CustomTextFormFieldWidget(
              lblTxt: '',
            ),

            //--------------------------enter Location-----------------------------
            const CustomTextFormFieldWidget(
              lblTxt: "AppString.location",
            ),
            //--------------------------enter fix prices-----------------------------
            const CustomTextFormFieldWidget(
              lblTxt: "AppString.enterFixPrice",
            ),
            //--------------------------enter description-----------------------------
            const CustomTextFormFieldWidget(
              lblTxt: "AppString.description",
            ),

            Gap(MySize.size10!),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "AppString.selectDateTime",
                style: Styles.boldBlack614,
              ),
            ),
            EasyDateTimeLine(
              timeLineProps: const EasyTimeLineProps(),
              headerProps: EasyHeaderProps(
                selectedDateStyle: Styles.boldBlue515,
                centerHeader: true,
                showMonthPicker: true,
                selectedDateFormat: SelectedDateFormat.fullDateMonthAsStrDY,
                showHeader: true,
                showSelectedDate: true,
              ),
              dayProps: EasyDayProps(
                activeDayNumStyle: Styles.boldWhite615,
                activeDayStrStyle: Styles.boldWhite615,
                activeMothStrStyle: Styles.boldWhite615,
                inactiveDayNumStyle: Styles.boldBlue614,
                inactiveDayStrStyle: Styles.boldBlue614,
                inactiveMothStrStyle: Styles.boldBlue614,
                inactiveDayDecoration: BoxDecoration(
                    border: Border.all(color: Colors.transparent),
                    color: primaryShade,
                    borderRadius: BorderRadius.circular(10)),
                height: MySize.size80!,
                width: MySize.scaleFactorWidth*70,
                activeDayDecoration: const BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
              initialDate: DateTime.now(),
              onDateChange: (selectedDate) {
                //`selectedDate` the new date selected.
              },
            ),
            Gap(MySize.size24!),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "AppString.uploadDocuments",
                style: Styles.boldBlack614,
              ),
            ),
            Gap(MySize.size15!),
            Container(
              // height: 500,
              // width: 325,
              margin: EdgeInsets.symmetric(
                  horizontal: MySize.getScaledSizeWidth(4)),
              padding: EdgeInsets.symmetric(
                  horizontal: MySize.getScaledSizeWidth(12),
                  vertical: MySize.getScaledSizeHeight(12)),
              decoration: BoxDecoration(
                color: white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                  )
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "AppString.addnewfiles",
                        style: Styles.lable618,
                      ),
                      SvgPicture.asset(AppImage.MOBIKWIK)
                    ],
                  ),
                  Gap(MySize.size20!),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: DottedBorder(
                      dashPattern: const [6, 6],
                      color: primary,
                      strokeWidth: 2,
                      child: Container(
                        height: 160,
                        // width: 300,
                        decoration: BoxDecoration(
                          color: primaryShade,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: primaryShade, // Border color
                            width: 1, // Border width
                            style: BorderStyle.none, // Border style
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(AppImage.PAYTM),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "AppString.choose",
                                  style: Styles.boldBlue614UnderLine,
                                ),
                                const Gap(8),
                                Text(
                                  "AppString.filetoupload",
                                  style: Styles.boldBlack616,
                                )
                              ],
                            ),
                            Text(
                              "AppString.selectzipimagejpgpdf",
                              style: Styles.lable411,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Gap(MySize.size25!),
                  Container(
                    height: 70,
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 2,
                        )
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                          child: Image.asset(
                            AppImage.PAYTM,
                            fit: BoxFit.cover,
                            height: MySize.safeHeight,
                            width: 70,
                          ),
                        ),
                        Gap(MySize.size16!),
                        Padding(
                          padding: EdgeInsets.only(
                              top: MySize.getScaledSizeHeight(8)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Sos.jpeg",
                                style: Styles.boldBlack614,
                              ),
                              Text(
                                "92 kb - 4 second left",
                                style: Styles.lable411,
                              ),
                              SizedBox(
                                width: MySize.safeWidth! / 2,
                                child: const LinearProgressIndicator(
                                  value: .5,
                                  backgroundColor: Color(0xFFBABABA),
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Color(0xFF687BFF)),
                                ),
                              )
                            ],
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: EdgeInsets.only(
                              top: MySize.getScaledSizeHeight(8),
                              right: MySize.getScaledSizeWidth(8)),
                          child: const Icon(Icons.close),
                        )
                      ],
                    ),
                  ),
                  Gap(MySize.size25!),
                  Text(
                    "AppString.importfromURL",
                    style: Styles.boldBlack614,
                  ),
                  Gap(MySize.size15!),
                  CustomTextFormFieldWidget(
                    // hintBpadding: 8,
                    hintText: "www.loremipsum20.com",
                    hintStyle: Styles.lable614,
                    sufixIconWidget: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MySize.getScaledSizeHeight(18),
                          vertical: MySize.getScaledSizeHeight(16)),
                      child: Text(
                        "AppString.select",
                        style: Styles.boldWithOPBlue614,
                      ),
                    ),
                  ),
                  // Row(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Checkbox(
                  //       visualDensity: const VisualDensity(horizontal: -4),
                  //       materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  //       side: const BorderSide(color: primary),
                  //       value: false,
                  //       activeColor: primary,
                  //       checkColor: white,
                  //       onChanged: (bool? value) {
                  //         // loginBloc.add(IsCheckbox(
                  //         //     isCheck: value!)); // Pass the value to the method
                  //       },
                  //     ),
                  //     Gap(MySize.size4!),
                  //     Padding(
                  //       padding: EdgeInsets.symmetric(
                  //           vertical: MySize.getScaledSizeHeight(12)),
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Text(
                  //             "AppString.markasFeatured",
                  //             style: Styles.hint614,
                  //           ),
                  //           Align(
                  //             alignment: Alignment.topLeft,
                  //             child: SizedBox(
                  //               width: MySize.safeWidth! / 1.5,
                  //               child: Text(
                  //                 "AppString.demoText1",
                  //                 style: Styles.lable411,
                  //               ),
                  //             ),
                  //           )
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  Gap(MySize.size15!),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButton(

                        borderSide: const BorderSide(color: primary),
                        color: Colors.white,
                        text: "AppString.cancel",
                        style: Styles.boldBlue712,
                        fun: () {},
                        borderCircular: 6,
                        height: 28,
                      ),
                      CustomButton(
                        borderSide: const BorderSide(color: primary),

                        text: "AppString.upload",
                        style: Styles.boldwhite712,
                        fun: () {},
                        borderCircular: 6,
                        height: 28,
                      ),
                    ],
                  )
                ],
              ),
            ),
            Gap(MySize.size20!),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomButton(
                  borderSide: const BorderSide(color: red),
                  color: Colors.white,
                  text: "AppString.cancel",
                 style: Styles.boldRed712,
                  fun: () {},
                  borderCircular: 12,
                ),
                CustomButton(
                  borderSide: const BorderSide(color: primary),

                  text: "AppString.update",
                  // style: Styles.boldBlue712,
                  fun: () {},
                  borderCircular: 12,
                ),
              ],
            ),
            Gap(MySize.size20!),
          ],
        ),
      ),
    );
  }

  _dropdown(
      {required List<DropdownMenuItem<String>>? items,
      required String labelText}) {
    return Padding(
      padding: EdgeInsets.only(bottom: MySize.getScaledSizeHeight(24)),
      child: DropdownButtonFormField(
        iconDisabledColor: primary,
        iconEnabledColor: primary,
        isDense: true,
        isExpanded: true,
        icon: const Icon(Icons.arrow_drop_down),
        onChanged: (v) {},
        decoration: InputDecoration(
          isDense: true,
          isCollapsed: true,
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            borderSide: BorderSide(color: primary, width: 1),
          ),
          contentPadding: EdgeInsets.only(
            left: MySize.getScaledSizeWidth(22),
            right: MySize.getScaledSizeWidth(8),
            bottom: MySize.getScaledSizeHeight(12),
            top: MySize.getScaledSizeHeight(12),
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            borderSide: BorderSide(color: primary, width: 1),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            borderSide: BorderSide(color: primary, width: 1),
          ),
          labelText: labelText,
          labelStyle: Styles.lable,
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
        items: items,
      ),
    );
  }

  List<Map<String, dynamic>> get filteredUserList {
    final query = searchUserQuery.toLowerCase();
    return uList
        .where((user) =>
            user['fullName'].toLowerCase().contains(query) ||
            user['customerId'].toString().contains(query))
        .toList();
  }

  void updateUserQuery(String? query) {
    setState(() {
      searchUserQuery = query ?? "";
    });
  }
}
