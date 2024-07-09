import 'package:chat_app/generated/l10n.dart';
import 'package:chat_app/model/package_binder_model.dart';
import 'package:flutter/material.dart';


class CustomPackageCard extends StatelessWidget {
  final PackageModel packageModel;
  const CustomPackageCard({
    super.key,
    required this.packageModel,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () => print(packageModel.title),
      child: Container(
        width: double.parse('${size.width / 1.4}'),
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    packageModel.title,
                    style: const TextStyle(fontSize: 16, ),
                  ),

                  // Align(
                  //   alignment: Alignment.topRight,
                  //   child: Icon(Icons.check),
                  // )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                packageModel.name,
                style: const TextStyle( fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    packageModel.price,
                    style:
                    const TextStyle( fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  (packageModel.discount != 0)
                 ? Container(
                    decoration: BoxDecoration(
                        color: packageModel.discount == 0
                            ? Colors.white
                            : Colors.grey[350],
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                            '${S().savingsText} ${packageModel.discount.round().toString()}%',
                        style:  const TextStyle(
                          color: Colors.black,
                            fontSize: 13, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ): const SizedBox(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
