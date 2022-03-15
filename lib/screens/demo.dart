import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Demo extends StatelessWidget {
  const Demo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("widget.title"),
        ),
        body: ListView.builder(
            // Widget which creates [ItemWidget] in scrollable list.
            itemCount: 3, // Number of widget to be created.
            itemBuilder: (context,
                    itemIndex) => // Builder function for every item with index.
                Center(child: Text("hiiiii"))));
    ;
  }
}
