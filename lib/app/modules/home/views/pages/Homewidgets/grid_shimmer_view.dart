import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class GridShimmerView extends GetView {
  const GridShimmerView({super.key});
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
                        addAutomaticKeepAlives: true,
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(top: 16, left: 12, right: 12),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisExtent: 186.w,
                          crossAxisCount: 3,
                          crossAxisSpacing: 10.w,
                          mainAxisSpacing: 12.w,
                        ),
                        itemCount: 9, // Shimmer placeholder count
                        itemBuilder: (context, index) {
                          return Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          );
                        },
                      );
  }
}
