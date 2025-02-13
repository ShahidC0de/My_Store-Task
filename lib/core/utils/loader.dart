import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingWrapper extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const LoadingWrapper(
      {super.key, required this.isLoading, required this.child});

  @override
  Widget build(BuildContext context) {
    if (!isLoading) return child; // Show actual UI if not loading

    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: IgnorePointer(
        // Prevent interactions when loading
        child: AbsorbPointer(child: child), // Block clicks while loading
      ),
    );
  }
}
