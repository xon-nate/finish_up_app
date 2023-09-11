import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../controllers/date_time_controller.dart';

class PickDateTimeWidget extends StatelessWidget {
  const PickDateTimeWidget({
    super.key,
    required this.dateTimeController,
  });

  final DateTimeController dateTimeController;

  @override
  Widget build(BuildContext context) {
    String buttonText = 'Pick Date';
    if (dateTimeController.value != null) {
      //show date time in yyyy-MM-dd hh:mm format
      buttonText =
          DateFormat('yyyy-MM-dd hh:mm').format(dateTimeController.value!);
    }
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        side: const BorderSide(
          width: 1,
          style: BorderStyle.solid,
        ),
        elevation: 0,
      ),
      onPressed: () async {
        final pickedDateTime = await showDateTimePicker(context: context);
        if (pickedDateTime != null) {
          dateTimeController.value =
              pickedDateTime; // Set the selected date and time
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            buttonText,
            style: const TextStyle(fontSize: 16),
          ),
          const Icon(Icons.date_range),
        ],
      ),
    );
  }
}

Future<DateTime?> showDateTimePicker({
  required BuildContext context,
  DateTime? initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
}) async {
  initialDate ??= DateTime.now();
  firstDate ??= initialDate.subtract(const Duration(days: 365 * 100));
  lastDate ??= firstDate.add(const Duration(days: 365 * 200));

  final DateTime? selectedDate = await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: firstDate,
    lastDate: lastDate,
  );

  if (selectedDate == null) return null;

  if (!context.mounted) return selectedDate;

  final TimeOfDay? selectedTime = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.fromDateTime(selectedDate),
  );
  debugPrint("$selectedDate $selectedTime");
  return selectedTime == null
      ? selectedDate
      : DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );
}
