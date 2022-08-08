// ignore_for_file: avoid_print

import 'package:amazon_clone/widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';

import '/utils/constants.dart';
import '/widgets/loading_widget.dart';
import '/widgets/user_details_bar.dart';
import '/resources/cloudfirestore_methods.dart';
import '/widgets/products_showcase_list_view.dart';
import '/widgets/categories_horizontal_list_view_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //
  double offset = 0;
  List<Widget>? discount0;
  List<Widget>? discount50;
  List<Widget>? discount60;
  List<Widget>? discount70;
  ScrollController controller = ScrollController();

  void getData() async {
    List<Widget> temp0 =
        (await CloudFirestoreClass().getProductsFromDiscount(0)).cast<Widget>();

    List<Widget> temp50 =
        (await CloudFirestoreClass().getProductsFromDiscount(50))
            .cast<Widget>();

    List<Widget> temp60 =
        (await CloudFirestoreClass().getProductsFromDiscount(60))
            .cast<Widget>();

    List<Widget> temp70 =
        (await CloudFirestoreClass().getProductsFromDiscount(70))
            .cast<Widget>();

    print('everything is done');

    setState(() {
      discount0 = temp0;
      discount50 = temp50;
      discount60 = temp60;
      discount70 = temp70;
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    getData();
    controller.addListener(() {
      setState(() {
        offset = controller.position.pixels;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBarWidget(
        isReadOnly: true,
        hasBackButton: false,
      ),
      body: discount70 != null &&
              discount60 != null &&
              discount50 != null &&
              discount0 != null
          ? Stack(
              children: [
                SingleChildScrollView(
                  controller: controller,
                  child: Column(
                    children: [
                      const SizedBox(height: kAppBarHeight / 2),

                      // CategoriesHorizontalListViewBar
                      const CategoriesHorizontalListViewBar(),

                      // ProductsShowcaseListView
                      ProductsShowcaseListView(
                          title: 'Upto 70% Off', children: discount70!),
                      ProductsShowcaseListView(
                          title: 'Upto 60% Off', children: discount60!),
                      ProductsShowcaseListView(
                          title: 'Upto 50% Off', children: discount50!),
                      ProductsShowcaseListView(
                          title: 'Upto 0% Off', children: discount0!),
                    ],
                  ),
                ),

                // UserDetailsBar
                UserDetailsBar(offset: offset),
              ],
            )
          : const LoadingWidget(),
    );
  }
}
