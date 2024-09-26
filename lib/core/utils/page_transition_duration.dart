enum PageTransitionDuration {
  short,
  medium,
  long,
}

extension PageTransitionDurationExtension on PageTransitionDuration {
  Duration get duration {
    switch (this) {
      case PageTransitionDuration.short:
        return const Duration(milliseconds: 300);
      case PageTransitionDuration.medium:
        return const Duration(milliseconds: 600);
      case PageTransitionDuration.long:
        return const Duration(seconds: 3);
    }
  }
}
