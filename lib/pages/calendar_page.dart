import 'package:flutter/material.dart';
import 'package:calendar/components/shared_header.dart';
import 'package:calendar/components/item_list.dart';
import 'package:calendar/components/event_mini.dart';

import '../components/event_list.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Calendar Page'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Words'),
              Tab(text: 'Events'),
              Tab(text: 'EventMini'),
              Tab(text: 'EventMini'),
            ],
          ),
        ),
        body: const Column(
          children: [
            SharedHeader(),
            Expanded(
              child: TabBarView(
                children: [
                  ItemList(fontSize: 24),
                  EventList(),
                  EventMini(),
                  EventMini(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}