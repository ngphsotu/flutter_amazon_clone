import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/model/product_model.dart';
import '/widgets/loading_widget.dart';
import '/widgets/results_widget.dart';
import '/widgets/search_bar_widget.dart';

class ResultsScreen extends StatelessWidget {
  //
  final String query;

  const ResultsScreen({Key? key, required this.query}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBarWidget(isReadOnly: false, hasBackButton: true),
      body: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Showing results for ',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    TextSpan(
                      text: query,
                      style: const TextStyle(
                        fontSize: 17,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('products')
                  .where('productName', isEqualTo: query)
                  .get(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingWidget();
                } else {
                  return GridView.builder(
                    itemCount: snapshot.data!.docs.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, childAspectRatio: 2 / 3.5),
                    itemBuilder: (context, index) {
                      ProductModel product = ProductModel.getModelFromJson(
                          json: snapshot.data!.docs[index].data());
                      return ResultsWidget(product: product);
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
