import 'package:flutter/widgets.dart';

import '../../core/network/dio_error_handler.dart';
import '../../widgets/status/status_view.dart';

extension FailureViewX on Failure {
  Widget view({VoidCallback? onRetry}) => StatusView(
    status: status,
    message: message,
    onRetry: onRetry,
    child: const SizedBox.shrink(),
  );
}
