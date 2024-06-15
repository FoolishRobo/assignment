import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import '../controllers/home_controller.dart';
import '../pokeman_detail_model.dart';
import 'detailsview_view.dart';

class FavoritesView extends GetView {
  FavoritesView({Key? key}) : super(key: key);
  final controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: Hive.box('MyFavorites').listenable(),
        builder: (context, box, widget) {
          return GridView.builder(
            padding: EdgeInsets.only(top: 16, left: 12, right: 12),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 186,
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 12),
            itemBuilder: (context, index) {
              final pokemon = box.keyAt(index);
              PokemanDetais pokemanDetaisDetails = box.get(pokemon);

              PokemanDetais pokidetails = pokemanDetaisDetails;
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
                            const EdgeInsets.only(left: 9.0, top: 8, bottom: 9)
                                .w,
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
                              controller
                                  .capitalizeFirstLetter(pokidetails.name),
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
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
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
            itemCount: box.length,
          );
        },
      ),
    );
  }
}
