import 'package:flutter/material.dart';

class ProfileMenuWidget extends StatefulWidget {
  const ProfileMenuWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onpress,
    this.endIcon = true,
    this.textColor,
  });
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onpress;
  final bool endIcon;
  final Color? textColor;

  @override
  State<ProfileMenuWidget> createState() => _ProfileMenuWidgetState();
}

class _ProfileMenuWidgetState extends State<ProfileMenuWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(width: 320,
      height: 57,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),

        color: Color(0xD5E5E4E4),),
      child: ListTile(
        onTap: widget.onpress,
        subtitle: Container(padding:EdgeInsets.only(bottom:5),child: Text(widget.subtitle)),
        leading: Container(margin: EdgeInsets.only(bottom: 15),
          width: 33,
          height: 33,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
           // color: Colors.green.withOpacity(0.1),
            color: Colors.white
          ),
          child: Icon(
            widget.icon,
            size: 18,
            color: Colors.black,
          ),
        ),
        title: Container(
          //margin: EdgeInsets.only(bottom: 2),
          child: Container(padding: EdgeInsets.only(bottom:4),
            child: Text(widget.title,
                style:
                    Theme.of(context).textTheme.bodyText1?.apply(color: widget.textColor)),
          ),
        ),
        // trailing: widget.endIcon
        //     ?  DropdownButton<String>( value:dropdownValu,
        //     icon:Icon(Icons.arrow_drop_down),items: [
        //       DropdownMenuItem( value:'female',child: Text('female')),
        //       DropdownMenuItem( value:'male',child: Text('male')),
        //     ], onChanged: (String?newValue){
        //       setState(() {
        //         dropdownValu=newValue!;
        //       });
        //     })
        //     : null,
      ),
    );
  }
}
