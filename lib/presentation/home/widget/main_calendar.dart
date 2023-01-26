import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:today/presentation/home/home_viewmodel.dart';

class MainCalendar extends StatelessWidget {
  const MainCalendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = context.watch<HomeViewModel>().selectDate;
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
      headerStyle: const HeaderStyle(
        titleCentered: true,
        formatButtonVisible: false,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 16.0,
        ),
      ),
      calendarStyle: CalendarStyle(
        todayTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 14.0,
        ),
        todayDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          color: Colors.grey[400],
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
          color: Colors.pinkAccent,
        ),
      ),
    );
  }
}
