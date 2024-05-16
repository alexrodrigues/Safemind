import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SfDetailsTopWidget extends StatelessWidget {
  final String urlImage;
  final String title;
  SfDetailsTopWidget(this.urlImage, this.title);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 120,
          height: 200,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              urlImage,
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                title.replaceAll(" ", "\n"),
                maxLines: 3,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 40.0,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
