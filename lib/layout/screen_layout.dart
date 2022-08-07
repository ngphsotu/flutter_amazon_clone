import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/utils/constants.dart';
import '/utils/color_themes.dart';
import '/providers/user_details_provider.dart';
import '/resources/cloudfirestore_methods.dart';

class ScreenLayout extends StatefulWidget {
  const ScreenLayout({Key? key}) : super(key: key);

  @override
  State<ScreenLayout> createState() => _ScreenLayoutState();
}

class _ScreenLayoutState extends State<ScreenLayout> {
  //
  int currentPage = 0;
  PageController pageController = PageController();

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  changPage(int page) {
    pageController.jumpToPage(page);
    setState(() {
      currentPage = page;
    });
  }

  @override
  void initState() {
    super.initState();
    CloudFirestoreClass().getNameAndAddress();
  }

  @override
  Widget build(BuildContext context) {
    //
    Provider.of<UserDetailsProvider>(context).getData();

    return DefaultTabController(
      length: 4,
      child: SafeArea(
        child: Scaffold(
          body: PageView(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: screens,
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
                border: Border(
              top: BorderSide(color: Colors.grey[400]!, width: 1),
            )),
            child: TabBar(
              onTap: changPage,
              indicatorSize: TabBarIndicatorSize.label,
              indicator: const BoxDecoration(
                  border: Border(
                      top: BorderSide(color: activeCyanColor, width: 4))),
              tabs: [
                Tab(
                  child: Icon(
                    Icons.home_outlined,
                    color: currentPage == 0 ? activeCyanColor : Colors.black,
                  ),
                ),

                //
                Tab(
                  child: Icon(
                    Icons.account_circle_outlined,
                    color: currentPage == 1 ? activeCyanColor : Colors.black,
                  ),
                ),

                //
                Tab(
                  child: Icon(
                    Icons.shopping_cart_outlined,
                    color: currentPage == 2 ? activeCyanColor : Colors.black,
                  ),
                ),

                //
                Tab(
                  child: Icon(
                    Icons.menu,
                    color: currentPage == 3 ? activeCyanColor : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
