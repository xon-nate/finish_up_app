import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../controllers/date_time_controller.dart';

class PickDateTimeWidget extends StatelessWidget {
  const PickDateTimeWidget({
    Key? key,
    required this.dateTimeController,
    required this.formKey,
  }) : super(key: key);

  final DateTimeController dateTimeController;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    String buttonText = 'Time & Date';
    String? chosenDateTimeText;

    if (dateTimeController.value != null) {
      buttonText = 'Change Date';
      chosenDateTimeText =
          DateFormat('yyyy-MM-dd hh:mm').format(dateTimeController.value!);
    }

    return Column(
      children: [
        Row(
          children: [
            Flexible(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  side: const BorderSide(
                    width: 1,
                    style: BorderStyle.solid,
                  ),
                  elevation: 0,
                ),
                onPressed: () async {
                  final pickedDateTime =
                      await showDateTimePicker(context: context);
                  if (pickedDateTime != null) {
                    dateTimeController.value = pickedDateTime;
                    if (formKey.currentState != null) {
                      formKey.currentState!.validate();
                    }
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        buttonText,
                        style: const TextStyle(fontSize: 16),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Icon(Icons.edit),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Flexible(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  side: const BorderSide(
                    width: 1,
                    style: BorderStyle.solid,
                  ),
                  elevation: 0,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Pick Day'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                dateTimeController.value =
                                    DateTime.now().add(const Duration(days: 1));
                                Navigator.pop(context);
                                if (formKey.currentState != null) {
                                  formKey.currentState!.validate();
                                }
                              },
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Tomorrow'),
                                  Icon(Icons.date_range),
                                ],
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                dateTimeController.value =
                                    DateTime.now().add(const Duration(days: 7));
                                Navigator.pop(context);
                                if (formKey.currentState != null) {
                                  formKey.currentState!.validate();
                                }
                              },
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Next Week'),
                                  Icon(Icons.calendar_today),
                                ],
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                dateTimeController.value = DateTime.now()
                                    .add(const Duration(days: 30));
                                Navigator.pop(context);
                                if (formKey.currentState != null) {
                                  formKey.currentState!.validate();
                                }
                              },
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Next Month'),
                                  Icon(Icons.event),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        'Pick Day',
                        style: TextStyle(fontSize: 16),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Icon(Icons.date_range),
                  ],
                ),
              ),
            ),
          ],
        ),
        if (chosenDateTimeText != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              chosenDateTimeText,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.green,
              ),
            ),
          ),
      ],
    );
  }
}

class DateTimeFormField extends FormField<DateTime> {
  DateTimeFormField({
    Key? key,
    FormFieldSetter<DateTime>? onSaved,
    FormFieldValidator<DateTime>? validator,
    DateTime? initialValue,
  }) : super(
          key: key,
          onSaved: onSaved,
          validator: validator,
          initialValue: initialValue,
          builder: (FormFieldState<DateTime> state) {
            return InkWell(
              onTap: () async {
                final selectedDate = await showDateTimePicker(
                  context: state.context,
                  initialDate: state.value ?? DateTime.now(),
                );
                if (selectedDate != null) {
                  state.didChange(selectedDate);
                }
                debugPrint("Selected Date: $selectedDate");
              },
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Date & Time',
                  errorText: state.errorText,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      state.value != null
                          ? DateFormat('yyyy-MM-dd HH:mm').format(state.value!)
                          : 'Select Date & Time',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal,
                        color: state.value != null ? Colors.black : Colors.grey,
                      ),
                    ),
                    const Icon(Icons.calendar_today),
                  ],
                ),
              ),
            );
          },
        );
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
