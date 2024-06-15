import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import 'detailsview_view.dart';

class PokiGridView extends GetView {
  PokiGridView({
    Key? key,
    required this.allPokemonDetails,
  }) : super(key: key);
  final List allPokemonDetails;

  final HomeController controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      addAutomaticKeepAlives: true,
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 16, left: 12, right: 12),
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
            Get.to(
              () => DetailsviewView(),
              arguments: [
                pokidetails,
                controller.getTypeColor(list),
                controller.formatNumberWithLeadingZeros(index + 1, 3),
              ],
            );
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
                    color: controller.getTypeColor(list),
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
                        "#" +
                            controller.formatNumberWithLeadingZeros(
                                index + 1, 3),
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        controller.capitalizeFirstLetter(pokidetails.name),
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: List.generate(
                          list.length,
                          (v) => Text(
                            controller.capitalizeFirstLetter(
                                    list[v]['type']['name']) +
                                "${v == 0 && list.length > 1 ? "," : ""}" +
                                ' ',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ),
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
