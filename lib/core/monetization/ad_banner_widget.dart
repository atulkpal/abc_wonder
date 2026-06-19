import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'monetization_provider.dart';

class AdBannerWidget extends ConsumerWidget {
  final String placementKey;

  const AdBannerWidget({super.key, required this.placementKey});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final service = ref.watch(monetizationProvider);
    if (service.isPremium || !service.areAdsEnabled) {
      return const SizedBox.shrink();
    }
    // TODO: Return real BannerAd (AdWidget) when google_mobile_ads is added
    return const SizedBox.shrink();
  }
}
