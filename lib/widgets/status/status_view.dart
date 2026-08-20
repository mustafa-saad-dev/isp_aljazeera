import 'package:flutter/material.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../core/status/request_status.dart';
import '../common/list_refresh.dart';
import 'empty_view.dart';
import 'error_view.dart';
import 'loading_view.dart';
import 'offline_view.dart';

class StatusView extends StatelessWidget {
  final RequestStatus status;
  final Widget child;
  final String? message;
  final VoidCallback? onRetry;
  final bool isEmpty;
  final RefreshController? refreshController;
  final Future<void> Function()? onRefresh;
  final Future<void> Function()? onLoadMore;
  
  const StatusView({
    super.key,
    required this.status,
    required this.child,
    this.message,
    this.onRetry,
    this.isEmpty = false,
    this.refreshController,
    this.onRefresh,
    this.onLoadMore,
  });

  Widget _body(BuildContext context) {
    switch (status) {
      case RequestStatus.initial:
        return const SizedBox.shrink();
      case RequestStatus.loading:
        return LoadingView(message: message);
      case RequestStatus.success:
        return isEmpty ? EmptyView(onRetry: onRetry) : child;
      case RequestStatus.empty:
        return EmptyView(onRetry: onRetry);
      case RequestStatus.error:
        return ErrorView(message: message, onRetry: onRetry);
      case RequestStatus.offline:
        return OfflineView(onRetry: onRetry);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (refreshController == null) return _body(context);

    final isSuccessList = status == RequestStatus.success && !isEmpty;

    return ListRefresh(
      refreshController: refreshController!,
      onRefresh: () async {
        if (onRefresh != null) {
          await onRefresh!();
        } else if (onRetry != null) {
          onRetry!();
        }
      },
      onLoadMore: isSuccessList ? onLoadMore : null,
      child: isSuccessList
          ? child
          : LayoutBuilder(
              builder: (context, constraints) => SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: _body(context),
                ),
              ),
            ),
    );
  }
}
