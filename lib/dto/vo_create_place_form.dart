import 'package:image_picker/image_picker.dart';

class CreatePlaneForm {
  final String subject;
  final String content;
  final String country;
  final String city;
  final XFile thumbnail;
  List<CreatePlaceForm> createPlaceFormList;

  CreatePlaneForm({
    required this.subject,
    required this.content,
    required this.country,
    required this.city,
    required this.thumbnail,
    required this.createPlaceFormList,
  });
}

class CreatePlaceForm {
  final String subject;
  final String content;
  final String address;
  final String latitude;
  final String longitude;
  final List<XFile> pictureList;

  CreatePlaceForm({
    required this.subject,
    required this.content,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.pictureList,
  });
}