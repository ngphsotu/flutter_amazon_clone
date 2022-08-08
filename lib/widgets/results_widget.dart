import 'package:flutter/material.dart';

import '/utils/utils.dart';
import '/utils/color_themes.dart';
import '/model/product_model.dart';
import '/widgets/cost_widget.dart';
import '/widgets/rating_star_widget.dart';

class ResultsWidget extends StatelessWidget {
  //
  final ProductModel product;

  const ResultsWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    Size screenSize = Utils().getScreenSize();

    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: screenSize.width / 3,
              child: Image.network(product.url),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                product.productName,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Row(
                children: [
                  SizedBox(
                    width: screenSize.width / 5,
                    child: FittedBox(
                      child: RatingStarWidget(rating: product.rating),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      product.noOfRating.toString(),
                      style: const TextStyle(
                        color: activeCyanColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
              child: FittedBox(
                child: CostWidget(
                  cost: product.cost,
                  color: const Color.fromARGB(255, 92, 9, 3),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
