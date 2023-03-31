class CardData {
  String?
      // id,
      nationalId,
      // expirationDate,

      name,
      address,
      job,
      gender,
      religion,
      maritalStatus,
      // releaseDate,
      // info,
      hus,
      birthdate,
      birthPlace,
      croppedPersonalImage,
      croppedBackImage,
      croppedFrontImage;

  CardData();

  CardData.fromMap(Map<String, dynamic> jsonCardData) {
    // id = jsonCardData['id'];
    nationalId = jsonCardData['national_id'];

    // expirationDate = jsonCardData['expiration_date'];
    name = jsonCardData['name'];
    address = jsonCardData['address'];
    job = jsonCardData['job'];
    gender = jsonCardData['gender'];
    religion = jsonCardData['religion'];
    maritalStatus = jsonCardData['marital_status'];
    hus = jsonCardData['hus'];
    // releaseDate = jsonCardData['release_date'];
    // info = jsonCardData['info'];
    birthdate = jsonCardData['birthdate'];
    birthPlace = jsonCardData['birth_place'];
    croppedPersonalImage = jsonCardData['cropped_personal_image'];
    croppedBackImage = jsonCardData['cropped_back_image'];
    croppedFrontImage = jsonCardData['cropped_front_image'];
  }

  Map<String, dynamic> toMap() => {
        // 'id': id,
        'national_id': nationalId,
        // 'expiration_date': expirationDate,
        'name': name,
        'address': address,
        'job': job,
        'gender': gender,
        'religion': religion,
        'marital_status': maritalStatus,
        // 'release_date': releaseDate,
        // 'info': info,
        'hus': hus,
        'birthdate': birthdate,
        'birth_place': birthPlace,
        'cropped_personal_image': croppedPersonalImage,
        'cropped_front_image': croppedFrontImage,
        'Cropped_back_image': croppedBackImage,
      };
}
