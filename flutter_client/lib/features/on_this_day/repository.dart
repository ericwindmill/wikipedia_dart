import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:wikipedia_api/wikipedia_api.dart';

class OnThisDayRepository extends ChangeNotifier {
  Future<void> getTimelineForDay(int month, int day) async {
    await WikipediaApiClient.getTimelineForDate(month: month, day: day);
    notifyListeners();
  }
}

class OnThisDayRepositoryProvider
    extends InheritedNotifier<OnThisDayRepository> {
  const OnThisDayRepositoryProvider({
    super.key,
    required super.child,
    required OnThisDayRepository repository,
  }) : super(notifier: repository);

  static OnThisDayRepository of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<OnThisDayRepositoryProvider>()!
        .notifier!;
  }

  @override
  bool updateShouldNotify(
    covariant InheritedNotifier<OnThisDayRepository> oldWidget,
  ) => notifier != oldWidget.notifier;

  @override
  bool updateShouldNotifyDependent(
    covariant InheritedModel<OnThisDayRepository> oldWidget,
    Set<OnThisDayRepository> dependencies,
  ) {
    // TODO: implement updateShouldNotifyDependent
    throw UnimplementedError();
  }
}
