import 'package:assignment/app/models/pokeman_detail_model.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../../utils/app_utils.dart';
import 'appbarflex_card_view.dart';

class DetailedAppbarView extends GetView {
  const DetailedAppbarView({super.key,required this.pokidetails,required this.isShrink,required this.bgcolor});
  final PokemanDetais pokidetails;
  final bool isShrink;
  final Color bgcolor;
  @override
  Widget build(BuildContext context) {
    return  SliverAppBar(
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      backgroundColor: bgcolor,
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: const Icon(Icons.arrow_back_ios),
      ),
      pinned: true,
      expandedHeight: 248,
      flexibleSpace: AppbarflexCardView(name: pokidetails.name, types: pokidetails.types, id: pokidetails.id, bgimage: pokidetails.types[0]['type']['name'], image: pokidetails.image,),
      actions: isShrink
          ? [
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 12),
          child: Row(
            children: [
              Padding(
                padding:
                const EdgeInsets.only(left: 8, right: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      AppUtils.capitalizeFirstLetter(
                          pokidetails.name),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                        children: AppUtils.generateTypeTextList(
                            context, pokidetails.types)),
                  ],
                ),
              ),
              Image.network(
                pokidetails.image,
                fit: BoxFit.cover,
                // height: 30,
                // width: 30,
              ),
            ],
          ),
        ),
      ]
          : null,
    );
  }
}
