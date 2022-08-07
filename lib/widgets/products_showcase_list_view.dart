import 'package:flutter/material.dart';

import '/utils/utils.dart';
import '/utils/color_themes.dart';

class ProductsShowcaseListView extends StatelessWidget {
  //
  final String title;
  final List<Widget> children;

  const ProductsShowcaseListView({
    Key? key,
    required this.title,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    Size screenSize = Utils().getScreenSize as Size;
    double height = screenSize.height / 4;
    double titleHeight = 25;

    return Container(
      color: Colors.white,
      width: screenSize.height,
      height: height,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: titleHeight,
            child: Row(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 14),
                  child: Text(
                    'Show more',
                    style: TextStyle(color: activeCyanColor),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: screenSize.width,
            height: height - (titleHeight + 26),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}
