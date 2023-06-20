import 'package:flutter/material.dart';
import 'package:weatherpal/color_constants.dart';
import 'package:weatherpal/utilities/constants.dart';


class BottomButton extends StatelessWidget {
  const BottomButton({super.key, required this.onTap, required this.buttonTitle});

  final Function onTap;
  final String buttonTitle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){onTap();},
      child: Container(
        decoration: BoxDecoration(
          color:AppColors.orangeWeb,
          borderRadius: BorderRadius.circular(100.0),
        ),
        margin: const EdgeInsets.all(20),
        width: 323,
        height: 64,
        child: Center(
          child: Text(
            buttonTitle,
            style: kTextStyle2,
          ),
        ),
      ),
    );
  }
}
