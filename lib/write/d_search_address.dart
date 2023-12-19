import 'package:flutter/material.dart';
import 'package:maptravel/dto/vo_google_place.dart';

searchAddressDialog(BuildContext context,
    List<GooglePlace> places,
    TextEditingController addressController,
    TextEditingController countryController,
    TextEditingController cityController) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('주소 선택'),
        content: SingleChildScrollView(
          child: ListBody(
            children: places.map((place) {
              return ListTile(
                title: Text(place.displayName),
                subtitle: Text(place.formattedAddress),
                onTap: () {
                  addressController.text = place.formattedAddress;

                  if(countryController.text.isEmpty || cityController.text.isEmpty) {
                    for (AddressComponents item in place.addressComponents) {
                      if (item.types[0] == 'country') {
                        countryController.text = item.longText;
                      }
                      if (item.types[0] == 'locality' ||
                          item.types[0] == "administrative_area_level_1") {
                        cityController.text = item.longText;
                      }
                    }
                    print('나라 : ${countryController.text}');
                    print('도시 : ${cityController.text}');
                  }

                  Navigator.of(context).pop(); // AlertDialog를 닫습니다.
                },
              );
            }).toList(),
          ),
        ),
      );
    },
  );
}
