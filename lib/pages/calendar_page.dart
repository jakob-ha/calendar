import 'package:calendar/components/holiday_table.dart';
import 'package:flutter/material.dart';
import 'package:calendar/components/shared_header.dart';



import '../components/country_list.dart';
import '../components/event_table.dart';
import '../components/holiday_list.dart';


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
              Tab(text: 'Holidays'),
              Tab(text: 'Events'),
              Tab(text: 'Browse'),
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
                  EventTable(),
                  CountryList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}