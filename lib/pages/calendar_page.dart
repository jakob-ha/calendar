import 'package:calendar/components/monthly_view.dart';
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
      length: 5,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Calendar Page'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Monthly'),
              Tab(text: 'Events'),
              Tab(text: 'Holidays'),
              Tab(text: 'EventMini'),
              Tab(text: 'Test'),
            ],
          ),
        ),
        body: const Column(
          children: [
            SharedHeader(),
            Expanded(
              child: TabBarView(
                children: [
                  MonthlyView(),
                  EventList(),
                  HolidayList(),
                  EventMini(),
                  FetchingDemo(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}