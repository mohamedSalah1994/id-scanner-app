class CardModel {
  String? id, event, frontImagePath, backImagePath, userAddress, deviceSerialNumber;
  double? lat, long;

  CardModel();

  CardModel.fromMap(Map<String, dynamic> card) {
    id = card['id'];
    event = card['event'];
    frontImagePath = card['front_image_path'];
    backImagePath = card['back_image_path'];
    userAddress = card['user_address'];
    lat = card['lat'];
    long = card['long'];
    deviceSerialNumber = card['device_serial_number'];
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'event': event,
        'front_image_path': frontImagePath,
        'back_image_path': backImagePath,
        'user_address': userAddress,
        'lat': lat,
        'long': long,
        'device_serial_number': deviceSerialNumber,
      };
}
