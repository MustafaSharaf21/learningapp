import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:learningapp/generated/l10n.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_indecator.dart';
import '../../../../screen/login_screen.dart';
import '../../../../service/service.dart';
import 'custom_page_view.dart';


class OnBoardingViewBody extends StatefulWidget {
  const OnBoardingViewBody({super.key});

  @override
  State<OnBoardingViewBody> createState() => _OnBoardingViewBodyState();
}

class _OnBoardingViewBodyState extends State<OnBoardingViewBody> {
  PageController? pageController;
   @override
  void initState() {
    // TODO: implement initState
     pageController=PageController(
         initialPage: 0
     )..addListener(() {
       setState(() {

       });
     });
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPageView(pageController: pageController,),
        Positioned(
          bottom: 130,
          left: 0,
          right: 0,
          child: CustomIndecator(
              dotIndex: pageController!.hasClients?pageController?.page:0 ),
        ),
        Visibility(
          visible:pageController!.hasClients ? pageController?.page==2?false :true :true,
          child: Positioned(
            top: MediaQuery.sizeOf(context).height* .1,
            right: MediaQuery.sizeOf(context).width*.1,
            child:  Text(S.of(context).Skip,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF898989),
            ),
              textAlign: TextAlign.left,
            ),
          ),
        ),
        Positioned(
        bottom:50,
        left: 50,
        right: 50,
        child: CustomGeneralButton(
          onTap:(){
            if(pageController!.page!<2){
              pageController?.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
            }else{
              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),
              ));
            }
          },
          text:pageController!.hasClients? pageController?.page==2?S.of(context).Get_Started:S.of(context).Next:S.of(context).Next,))
      ],
    );
  }
}
