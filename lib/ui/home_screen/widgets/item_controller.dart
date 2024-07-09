import 'package:chat_app/config/extentions/String_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemController extends StatefulWidget {
  const ItemController(
      {super.key,
      this.state = false,
      required this.onTap,
      required this.iconSvg,
      this.size,
     required this.colors});

  final Function() onTap;
  final bool state;
  final String iconSvg;
  final double? size;
  final List<Color> colors;

  @override
  State<ItemController> createState() => _ItemControllerState();
}

class _ItemControllerState extends State<ItemController> {
  bool isClick = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
       widget.onTap();
       setState(() {
         isClick = true;
       });
       Future.delayed(const Duration(milliseconds: 500), (){
         setState(() {
           isClick = false;
         });
       });
      },
      child: Container(
        height:  widget.size ?? 65,
        width:  widget.size ?? 65,
        alignment: Alignment.center,
        padding:  const EdgeInsets.all(15),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors:  (widget.state || isClick) ?  widget.colors ?? [] : [
              Theme.of(context).brightness == Brightness.light
                  ? Colors.white
                  : const Color(0xFF23262F),
              Theme.of(context).brightness == Brightness.light
                  ? Colors.white
                  : const Color(0xFF23262F),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              blurRadius: 2,
              offset: const Offset(0.3, -0.5),
            ),
          ],
        ),

        child: (widget.state || isClick) ? SvgPicture.asset(widget.iconSvg.withIcon(),
            width: 35,
            fit: BoxFit.contain,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn))
            : SvgPicture.asset(widget.iconSvg.withIcon(),
            width: 35,
            fit: BoxFit.contain,) ,
      ),
    );
  }
}
