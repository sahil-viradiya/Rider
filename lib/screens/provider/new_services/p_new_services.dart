import 'package:flutter/material.dart';
import 'package:rider/constant/app_color.dart';
import 'package:rider/constant/my_size.dart';
import 'package:rider/screens/provider/new_services/widget_new_services.dart';
import 'package:rider/widget/auth_app_bar_widget.dart';

class PAddNewServices extends StatelessWidget {
  const PAddNewServices({super.key});
  @override
  Widget build(BuildContext context) {
    var selectedIndex = 0;

    MySize().init(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: white,
      appBar: appbarSmall1(context, "Post a Project", backgroundColor: white),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: PageController(),
              itemCount: 2, // Adjust this according to the number of pages
              onPageChanged: (index) {
                // postProjectBloc.add(PageCh0ange(page: index));
                selectedIndex = index;

                // BlocProvider.of<PostProjectBloc>(context)
                //     .add(PageChange(page: index));
              },
              itemBuilder: (context, index) {
                return const WidgetAddNewServices();
              },
            ),
          ),
          // if (selectedIndex == 0) // Show button only on the first page
          //   CustomButton(
          //     text: "Next",
          //     fun: () {
          //       postProjectBloc.currentPageIndex++;
          //       // _scrollToPage(postProjectBloc.currentPageIndex,
          //       //     postProjectBloc.pageController);
          //       postProjectBloc.pageController.animateToPage(
          //         postProjectBloc.currentPageIndex,
          //         duration: const Duration(milliseconds: 500),
          //         curve: Curves.ease,
          //       );
          //     },
          //   ),
          // if (selectedIndex == 0) Gap(MySize.size20!)
        ],
      ),
    );
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
      // return _buildFirstPage();
      case 1:
      // return _buildSecondPage();
      default:
        return Container(); // You can return empty container or handle other cases
    }
  }

  // Widget _buildFirstPage() {
  //   // return StepOne();
  // }

  // Widget _buildSecondPage() {
  //   return StepTwo();
  // }
}
