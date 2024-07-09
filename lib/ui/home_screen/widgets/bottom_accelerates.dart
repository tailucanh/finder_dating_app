import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';


class BottomAcceleratesModal extends StatefulWidget {
  final  int count;
  final Function onAccelerates;

   const BottomAcceleratesModal({super.key, required this.count, required this.onAccelerates,});



  @override
  State<BottomAcceleratesModal> createState() => _BottomAcceleratesModalState();
}

class _BottomAcceleratesModalState extends State<BottomAcceleratesModal> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2.3,
      decoration:  BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : Colors.black,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
           const Icon(Icons.linear_scale, size: 30,),
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: const Icon(
                  Icons.close,
                  color: Colors.grey,
                  size: 26,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Column(
              children: [
                Text(
                  S().bottomDialogBoostTitle,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  S().bottomDialogBoostContent,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  const Icon(
                    Icons.bolt,
                    color: Colors.purple,
                    size: 38,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S().bottomDialogBoostTitle2,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        '${S().bottomDialogBoostRemainingText} ${widget.count}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () => widget.onAccelerates(),
              style: ElevatedButton.styleFrom(
                shadowColor: Colors.grey,
                fixedSize: const Size(250, 50),
                backgroundColor: Colors.purple[400],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                S().bottomDialogBoostButtonText,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
