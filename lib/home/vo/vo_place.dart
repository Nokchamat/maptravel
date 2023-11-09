import 'dart:ffi';

class Place {
  final String title;
  final String explains;
  final String imageUrl;
  final double locationX;
  final double locationY;

  Place(
      this.title, this.explains, this.imageUrl, this.locationX, this.locationY);
}