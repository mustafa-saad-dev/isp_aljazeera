import 'package:flutter/material.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../core/localization/translate_extension.dart';
import '../../core/theme/extensions/context_theme_extension.dart';

class ListRefresh extends StatelessWidget {
  const ListRefresh({
    super.key,
    required this.refreshController,
    required this.onRefresh,
    this.onLoadMore,
    required this.child,
  });

  final RefreshController refreshController;
  final Future<void> Function() onRefresh;
  final Future<void> Function()? onLoadMore;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      physics: const AlwaysScrollableScrollPhysics(
        parent: BouncingScrollPhysics(),
      ),
      controller: refreshController,
      enablePullDown: true,
      enablePullUp: onLoadMore != null,
      header: WaterDropHeader(waterDropColor: context.colorScheme.primary),
      footer: ClassicFooter(
        loadingText: context.tr('loading_more'),
        noDataText: context.tr('no_more_data'),
        failedText: context.tr('faield_loading_swipe_to_try_again'),
      ),
      onRefresh: () async {
        await onRefresh();
        refreshController.refreshCompleted();
      },
      onLoading: onLoadMore == null
          ? null
          : () async {
              await onLoadMore!();
              refreshController.loadComplete();
            },
      child: child,
    );
  }
}
