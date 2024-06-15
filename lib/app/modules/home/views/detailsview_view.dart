import 'package:assignment/app/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../data/app_colors.dart';
import '../../../models/pokeman_detail_model.dart';
import 'pages/detail_widgets/add_remove_favorites_view.dart';
import 'pages/detail_widgets/base_stats_view.dart';
import 'pages/detail_widgets/detailed_appbar_view.dart';
import 'pages/detail_widgets/hwbmi_card_view.dart';

class DetailsviewView extends StatefulWidget {
  const DetailsviewView({super.key});

  @override
  State<DetailsviewView> createState() => _DetailsviewViewState();
}

class _DetailsviewViewState extends State<DetailsviewView> {
  ScrollController? _scrollController;
  bool lastStatus = true;
  double height = 200;

  void _scrollListener() {
    if (_isShrink != lastStatus) {
      setState(() {
        lastStatus = _isShrink;
      });
    }
  }

  bool get _isShrink {
    return _scrollController != null &&
        _scrollController!.hasClients &&
        _scrollController!.offset > (height - kToolbarHeight);
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController?.removeListener(_scrollListener);
    _scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PokemanDetais pokidetails = Get.arguments[0];
    var stats = pokidetails.base_stats;

    return Scaffold(
        backgroundColor: Colors.white,
        body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              DetailedAppbarView(
                pokidetails: pokidetails,
                isShrink: _isShrink,
                bgcolor: Get.arguments[1],
              ),
            ];
          },
          body: CustomScrollView(
            shrinkWrap: true,
            slivers: [
              SliverToBoxAdapter(
                child: HwbmiCardView(
                  height: pokidetails.height.toString(),
                  weight: pokidetails.weight.toString(),
                  bmi: AppUtils.calculatebmi(pokidetails.height.toDouble(),
                          pokidetails.weight.toDouble())
                      .toStringAsFixed(1),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  height: 8.h,
                  width: double.infinity,
                  color: AppColors.backgroung,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, top: 12, bottom: 12).w,
                  child: Text(
                    "Base Stats",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: Divider(),
              ),
              BaseStatsView(stats: stats)
            ],
          ),
        ),
        floatingActionButton: AddRemoveFavoritesView(
          pokidetails: pokidetails,
        ));
  }
}
