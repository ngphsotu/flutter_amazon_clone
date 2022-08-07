import 'package:amazon_clone/resources/cloudfirestore_methods.dart';
import 'package:flutter/material.dart';

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
    List<Widget> temp0 = (await CloudFirestoreClass().getProductsFromDiscount(0)).cast<Widget>();

    List<Widget> temp50 = (await CloudFirestoreClass().getProductsFromDiscount(50)).cast<Widget>();

    List<Widget> temp60 = (await CloudFirestoreClass().getProductsFromDiscount(60)).cast<Widget>();

    List<Widget> temp70 = (await CloudFirestoreClass().getProductsFromDiscount(70)).cast<Widget>();

    print('everything is done');

    setState(() {
      discount0 = temp0;
      discount50 = temp50;
      discount60 = temp60;
      discount70 = temp70;
    });
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
      appBar: ,
    );
  }
}
