import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:today/presentation/home/home_viewmodel.dart';

class MainCalendar extends StatelessWidget {
  const MainCalendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late final ColorScheme _colorScheme = Theme
        .of(context)
        .colorScheme;
    late final TextTheme _textTheme = Theme
        .of(context)
        .textTheme;
    TextStyle _todayTextStyle =
        _textTheme.bodySmall?.copyWith(color: Colors.white) ??
            const TextStyle(fontSize: 14.0, color: Colors.white);

    TextStyle _weekdayStyle =
        _textTheme.bodySmall?.copyWith(color: Colors.black54) ??
            const TextStyle(fontSize: 14.0, color: Colors.black54);
    TextStyle _weekendStyle =
        _textTheme.bodySmall?.copyWith(color: Colors.blue) ??
            const TextStyle(fontSize: 14.0, color: Colors.blue);
    TextStyle _defaultTextStyle =
        _textTheme.bodySmall ?? const TextStyle(fontSize: 14.0);
    TextStyle _selectTextStyle =
        _textTheme.bodySmall?.copyWith(color: Colors.white) ??
            const TextStyle(fontSize: 14.0, color: Colors.white);
    TextStyle _outsideTextStyle =
        _textTheme.bodySmall?.copyWith(color: Colors.grey) ??
            const TextStyle(fontSize: 14.0, color: Colors.grey);

    DaysOfWeekStyle _daysOfWeekStyle = DaysOfWeekStyle(
      weekdayStyle: _weekdayStyle,
      weekendStyle: _weekendStyle,
    );

    DateTime dateTime = context
        .watch<HomeViewModel>()
        .selectDate;
    return TableCalendar(
      onDaySelected: (selectDate, focusDate) {
        context.read<HomeViewModel>().setDatetime(selectDate);
      },
      focusedDay: dateTime,
      selectedDayPredicate: (date) =>
      date.year == dateTime.year &&
          date.month == dateTime.month &&
          date.day == dateTime.day,
      firstDay: DateTime(1990, 12, 14),
      lastDay: DateTime(2999, 12, 31),
      headerStyle: HeaderStyle(
        titleCentered: true,
        formatButtonVisible: false,
        titleTextStyle:
        _textTheme.titleSmall ?? const TextStyle(fontSize: 17.0),
      ),
      locale: 'ko',
      daysOfWeekStyle: _daysOfWeekStyle,
      calendarStyle: CalendarStyle(
        todayTextStyle: _todayTextStyle,
        defaultTextStyle: _defaultTextStyle,
        weekendTextStyle: _defaultTextStyle,
        outsideTextStyle: _outsideTextStyle,
        selectedTextStyle: _selectTextStyle,
        todayDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          color: _colorScheme.secondary,
        ),
        defaultDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          color: Colors.grey[200],
        ),
        weekendDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          color: Colors.grey[200],
        ),
        selectedDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          color: _colorScheme.primary,
        ),
        weekNumberTextStyle: _defaultTextStyle,
        canMarkersOverflow: true,
        isTodayHighlighted: true,
      ),
    );
  }
}
