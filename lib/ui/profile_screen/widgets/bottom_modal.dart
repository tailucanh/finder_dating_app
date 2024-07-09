import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';


class BottomModal extends StatefulWidget {
  const BottomModal({super.key});

  @override
  State<BottomModal> createState() => _BottomModalState();
}

class _BottomModalState extends State<BottomModal> {
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
                        '${S().bottomDialogBoostRemainingText} 0',
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
              onPressed: () {},
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
