import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  //
  final String title, hintText;
  final TextEditingController controller;
  final bool obscureText;

  const TextFieldWidget({
    Key? key,
    required this.title,
    required this.hintText,
    required this.controller,
    required this.obscureText,
  }) : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  //
  bool isInFocus = false;
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          isInFocus = true;
        });
      } else {
        setState(() {
          isInFocus = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Text(
            widget.title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              isInFocus
                  ? BoxShadow(
                      color: Colors.orange.withOpacity(0.4),
                      blurRadius: 8,
                      spreadRadius: 2,
                    )
                  : BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
            ],
          ),
          child: TextField(
            maxLines: 1,
            focusNode: focusNode,
            controller: widget.controller,
            obscureText: widget.obscureText,
            decoration: InputDecoration(
              filled: true,
              hintText: widget.hintText,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(3),
                borderSide: const BorderSide(color: Colors.grey, width: 1),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.orange, width: 1),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
