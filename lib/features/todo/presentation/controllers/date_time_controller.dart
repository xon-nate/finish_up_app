class DateTimeController {
  DateTime? _dateTime;

  DateTime? get value => _dateTime;

  set value(DateTime? newValue) {
    _dateTime = newValue;
  }

  void clear() {
    _dateTime = null;
  }
}
