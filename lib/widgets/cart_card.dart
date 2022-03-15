import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartCard extends StatelessWidget {
  var image;
  var widget1;
  var widget2;
  var widget3;
  var widget4;
  var widget5;

  CartCard({
    this.image,
    this.widget1,
    this.widget2,
    this.widget3,
    this.widget4,
    this.widget5,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 150,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image(
              image: AssetImage(
                "assets/images/${image}",
              ),
              width: MediaQuery.of(context).size.width / 3,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [widget1, widget2, widget3, widget4],
              ),
            ),
            widget5
          ],
        ),
      ),
    );
  }
}
