import 'package:flutter/material.dart';

import '../../widgets/common/app_loading.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key, this.message});

  final String? message;

  @override
  Widget build(BuildContext context) =>
      AppLoadingBody(tagline: message, footer: const SizedBox.shrink());
}
