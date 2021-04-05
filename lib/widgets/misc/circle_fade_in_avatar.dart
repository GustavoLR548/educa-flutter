import 'package:flutter/material.dart';

class CircleFadeInAvatar extends StatelessWidget {
  final String profilePicture;
  final int widthVariation;
  final String placeholderPath;

  CircleFadeInAvatar(
    this.profilePicture, [
    this.widthVariation = 0,
    this.placeholderPath = 'assets/images/icon.jpg',
  ]);
  @override
  Widget build(BuildContext context) {
    return ClipOval(
        clipper: CircleRevealClipper(this.widthVariation),
        child: FadeInImage(
          width: 125,
          height: 125,
          fit: BoxFit.fitWidth,
          placeholder: AssetImage(this.placeholderPath),
          image: NetworkImage(this.profilePicture),
        ));
  }
}

class CircleRevealClipper extends CustomClipper<Rect> {
  final int widthVariation;
  CircleRevealClipper(this.widthVariation);
  @override
  Rect getClip(Size size) {
    final epicenter = new Offset(size.width, size.height);

    // Calculate distance from epicenter to the top left corner to make sure clip the image into circle.

    final distanceToCorner = epicenter.dy;

    final radius = distanceToCorner;
    final diameter = radius;

    return new Rect.fromLTWH(epicenter.dx - radius - this.widthVariation,
        epicenter.dy - radius, diameter, diameter);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}
