import 'package:flutter/material.dart';
import 'package:calendar/components/shared_header.dart';
import 'package:calendar/components/item_list.dart';
import 'package:calendar/components/event_mini.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Second Page'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Big'),
              Tab(text: 'Medium'),
              Tab(text: 'Small'),
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
                  ItemList(fontSize: 16),
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