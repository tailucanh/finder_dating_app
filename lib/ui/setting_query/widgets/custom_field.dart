import 'package:flutter/material.dart';
import '../../../generated/l10n.dart';

class CustomField extends StatelessWidget {
  final Function() onTap;
  final Function() onReset;
  final String title;
  final String? select;
  final IconData? iconData;

  const CustomField(
      {super.key,
      required this.onTap,
      required this.onReset,
      required this.title,
      this.iconData,
      this.select});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    iconData,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w400),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  InkWell(
                    onTap: onReset,
                    child: Icon(Icons.restart_alt_rounded, size: 20,),
                  )
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                    (select ?? '').isNotEmpty ? select ?? S().emptyText : S().emptyText,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.chevron_right_rounded,
                    color: Colors.grey[500],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
