import 'package:flutter_riverpod/flutter_riverpod.dart';

//pass default value to state notifier
class ItemState extends StateNotifier<bool> {
  ItemState(bool state) : super(state);

  void set(bool value) => state = value;

  void toggle() => state = !state;
}
