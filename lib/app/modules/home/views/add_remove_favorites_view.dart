import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../data/app_colors.dart';
import '../../../data/app_fonts.dart';
import '../pokeman_detail_model.dart';

class AddRemoveFavoritesView extends GetView {
  const AddRemoveFavoritesView({Key? key,required this.pokidetails}) : super(key: key);
 final PokemanDetais pokidetails;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
          valueListenable: Hive.box('MyFavorites').listenable(),
          builder: (context, box, widget) {
            return Container(
              height: 50.h,
              width: box.keys.contains(pokidetails.name) ? 201.w : 157.w,
              margin: EdgeInsets.only(
                bottom: 15,
              ).w,
              child: FloatingActionButton.extended(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(36).w),
                  onPressed: () async {
                    if (box.keys.contains(pokidetails.name)) {
                      await box.delete(pokidetails.name);
                    } else {
                      await box.put(pokidetails.name, pokidetails);
                      print(pokidetails);
                    }
                  },
                  isExtended: true,
                  extendedTextStyle: TextStyle(
                    fontFamily: AppFonts.ns700,
                  ),
                  extendedPadding: EdgeInsets.all(16),
                  foregroundColor: box.keys.contains(pokidetails.name)
                      ? AppColors.blue
                      : AppColors.white,
                  backgroundColor: box.keys.contains(pokidetails.name)
                      ? AppColors.blue_light
                      : AppColors.blue,
                  label: Text(box.keys.contains(pokidetails.name)
                      ? "Remove from favourites"
                      : "Mark as favourite")),
            );
          },
        );
  }
}
