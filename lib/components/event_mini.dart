import 'package:flutter/material.dart';


class EventMini  extends StatelessWidget {
  const EventMini({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      // clipBehavior is necessary because, without it, the InkWell's animation
      // will extend beyond the rounded edges of the [Card] (see https://github.com/flutter/flutter/issues/109776)
      // This comes with a small performance cost, and you should not set [clipBehavior]
      // unless you need it.
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            debugPrint('Card tapped.');
          },
          child: const SizedBox(
            width: null,
            height: null,
            child: Column(
              children: [
                Text('data'),
                Text('data'),
                Text('data')
              ],
            ),
          ),
        ),
    );
  }
}
