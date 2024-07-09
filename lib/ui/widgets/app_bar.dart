import 'package:chat_app/config/extentions/String_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryAppBar extends AppBar {
  PrimaryAppBar(
      {super.key,
      this.text,
      this.sizeText,
      required this.context,
      this.center = true,
      this.isElevation,
      this.actionsWidget});

  final BuildContext context;
  final String? text;
  final double? sizeText;
  final double? isElevation;
  final bool center;
  final List<Widget>? actionsWidget;

  @override
  bool? get centerTitle => center;

  @override
  Color? get backgroundColor =>  Theme.of(context).brightness == Brightness.light
      ? Colors.white
      : Colors.black;

  @override
  double? get elevation => isElevation;
  @override
  // TODO: implement toolbarOpacity
  double get toolbarOpacity => 1;

  @override
  List<Widget>? get actions => actionsWidget;




  @override
  Widget? get title => text == null
      ? Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'ic_tinder_logo'.withImage(),
              width: 30.w,
            ),
            const SizedBox(
              width: 5,
            ),
            ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(colors: [
                      Color(0xFFd73730),
                      Color(0xFFee0979),
                    ]).createShader(bounds),
                child: Text(
                  'Finder',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 26.sp,
                      fontFamily: "Kanit",
                      fontWeight: FontWeight.w600),
                )),
          ],
        )
      : Text(text ?? "",
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.w600, fontSize: sizeText ?? 22));
}
