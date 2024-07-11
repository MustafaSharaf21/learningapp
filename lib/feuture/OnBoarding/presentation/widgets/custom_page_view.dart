import 'package:flutter/material.dart';

import 'page_view_item.dart';

class CustomPageView extends StatelessWidget {
  const CustomPageView({super.key, @required this.pageController});
  final PageController? pageController;
  @override
  Widget build(BuildContext context) {
    return PageView(controller: pageController,
      children: const [
        SizedBox(height: 100,
          child: PageViewItem(image:'assets/images/on_boarding(1).png',
              title:'First See Learning',
          subtitle:'Forget about a for of paper all knowledge in one learning!'),
        ),
        PageViewItem(image:'assets/images/2.png',
            title:'Connetcted With EveryOne',
            subtitle:'Always keep in  touch with your tutor &friend.lets get connected! '),
        PageViewItem(image:'assets/images/3.png',
            title:'Always Fascinated Learning',
            subtitle:'AnyWhere,anytime.The time is at your discretion so study Whenever you want.'),
      ],

    );

  }
}
