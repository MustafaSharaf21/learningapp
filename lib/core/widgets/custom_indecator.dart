import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class CustomIndecator extends StatelessWidget {
   CustomIndecator({super.key, required this.dotIndex});
 double? dotIndex,i;
  @override
  Widget build(BuildContext context) {
     return 
    DotsIndicator(decorator:DotsDecorator(
        activeColor: Color(0xFF399679),color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: Color(0xFF2554255) )
        )
    )
      ,dotsCount: 3,
       // position  : dotIndex!
    );

  }
}
