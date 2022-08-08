// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '/utils/utils.dart';
import '/utils/constants.dart';
import '/utils/color_themes.dart';
import '/screens/search_screen.dart';
import '/screens/results_screen.dart';

class SearchBarWidget extends StatelessWidget with PreferredSizeWidget {
  //
  final bool isReadOnly, hasBackButton;

  SearchBarWidget({
    Key? key,
    required this.isReadOnly,
    required this.hasBackButton,
  })  : preferredSize = const Size.fromHeight(kAppBarHeight),
        super(key: key);

  @override
  final Size preferredSize;

  //
  OutlineInputBorder border = OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.grey, width: 1),
    borderRadius: BorderRadius.circular(7),
  );

  @override
  Widget build(BuildContext context) {
    //
    Size screenSize = Utils().getScreenSize();

    return Container(
      height: kAppBarHeight,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          end: Alignment.centerRight,
          begin: Alignment.centerLeft,
          colors: backgroundGradient,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          hasBackButton
              ? IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back))
              : Container(),
          SizedBox(
            width: screenSize.width * 0.7,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: const Offset(0, 5),
                    blurRadius: 8,
                    spreadRadius: 1,
                  )
                ],
              ),
              child: TextField(
                readOnly: isReadOnly,
                onSubmitted: (String query) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResultsScreen(query: query),
                    ),
                  );
                },
                decoration: InputDecoration(
                  filled: true,
                  border: border,
                  hintText: 'Search for something in amazon',
                  fillColor: Colors.white,
                  focusedBorder: border,
                ),
                onTap: () {
                  if (isReadOnly) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SearchScreen(),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.mic_none_outlined),
          ),
        ],
      ),
    );
  }
}
