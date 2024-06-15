import 'package:assignment/app/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../detailsview_view.dart';

class PokiGridView extends GetView {
  const PokiGridView({
    super.key,
    required this.allPokemonDetails,
  });
  final List allPokemonDetails;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      addAutomaticKeepAlives: true,
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 16, left: 12, right: 12, bottom: 20).w,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisExtent: 186.w,
        crossAxisCount: 3,
        crossAxisSpacing: 10.w,
        mainAxisSpacing: 12.w,
      ),
      itemCount: allPokemonDetails.length,
      itemBuilder: (context, index) {
        final pokidetails = allPokemonDetails[index];
        var list = pokidetails.types;

        return GestureDetector(
          onTap: () {
            Get.to(() => const DetailsviewView(),
                arguments: [
                  pokidetails,
                  AppUtils.getTypeColor(list),
                  AppUtils.formatNumberWithLeadingZeros(index + 1, 3),
                ],
                transition: Transition.circularReveal,
                duration: const Duration(seconds: 1));
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    color: AppUtils.getTypeColor(list),
                    height: 104,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: Image.network(
                        fit: BoxFit.cover,
                        pokidetails.image,
                        alignment: Alignment.center,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 9.0, top: 8, bottom: 9).w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "#${AppUtils.formatNumberWithLeadingZeros(
                                pokidetails.id, 3)}",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        AppUtils.capitalizeFirstLetter(pokidetails.name),
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      SizedBox(height: 10.h),
                      Row(
                          children:
                              AppUtils.generateTypeTextListCard(context, list)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
