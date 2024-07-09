import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../update_profile_cubit.dart';

class UpdateImage extends StatefulWidget {
  const UpdateImage({
    super.key,
    required this.itemWidth,
    required this.itemHeight,
  });

  final double itemWidth;
  final double itemHeight;

  @override
  State<UpdateImage> createState() => _UpdateImageState();
}

class _UpdateImageState extends State<UpdateImage> {
  late UpdateProfileCubit _cubit;
  bool isEditImage = false;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<UpdateProfileCubit>(context);
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
      bloc: _cubit,
      builder: (context, state) {
        if((state.photoList ?? []).isNotEmpty){
          isEditImage = (state.photoList ?? []).length > 1;
        }
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  childAspectRatio: widget.itemWidth /widget.itemHeight,
                ),
                itemCount: 9,
                itemBuilder: (BuildContext context, int index) {
                  if (index < state.photoList!.length) {
                    return Stack(children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: CachedNetworkImage(
                              imageUrl: state.photoList![index],
                              key: UniqueKey(),
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(color: Colors.grey,),
                              errorWidget: (context, url, error) => Container(
                                color:Colors.grey,
                                child: const Icon(Icons.error, color: Colors.red, size: 30,),
                              )
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 5,
                        right: 5,
                        child: InkWell(
                          onTap: () => isEditImage ? _cubit.removeImageFromList(index: index) : _cubit.pickImages(context: context),
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: Border.all(
                                  color: Colors.grey, width: 1),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child:  Icon(
                              isEditImage
                                  ? Icons.close_rounded
                                  : Icons.edit,
                              color: Colors.grey,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ]);
                  } else {
                    return InkWell(
                      onTap: () => _cubit.pickImages(context: context),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: DottedBorder(
                          strokeWidth: 3,
                          borderType: BorderType.RRect,
                          color: Colors.grey.shade500,
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Theme.of(context).brightness == Brightness.light ? Colors.grey.shade200 : Colors.black,
                            ),
                            child: const Icon(
                              Icons.add,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
              const SizedBox(
                height: 24,
              ),
            ],
          ),
        );
      },
    );
  }
}