import 'package:flutter/scheduler.dart';

class AnimatedMockTicker extends TickerProvider {
  @override
  Ticker createTicker(final TickerCallback onTick) => Ticker(onTick);

  @override
  void dispose() {}
}
