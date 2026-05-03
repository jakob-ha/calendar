import 'package:calendar/components/holiday_table.dart';
import 'package:flutter/material.dart';
import 'package:calendar/components/shared_header.dart';
import 'package:calendar/components/item_list.dart';
import 'package:calendar/components/event_mini.dart';

import '../components/event_list.dart';
import '../components/holiday_list.dart';
import '../components/test.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Calendar Page'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Monthly'),
              Tab(text: 'Events'),
              Tab(text: 'Holidays'),
            ],
          ),
        ),
        body: const Column(
          children: [
            SharedHeader(),
            Expanded(
              child: TabBarView(
                children: [
                  HolidayTable(),
                  EventList(),
                  HolidayList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}