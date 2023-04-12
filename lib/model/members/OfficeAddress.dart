class OfficeAddress {
  String? street;
  String? municipality;
  String? zip;
  String? phone;

  OfficeAddress({
    required this.street,
    required this.municipality,
    required this.zip,
    required this.phone,
  });

  OfficeAddress.fromJson(final Map<String, dynamic> parsedJson)
      : street = parsedJson['street'],
        municipality = parsedJson['municipality'],
        zip = parsedJson['zip'],
        phone = parsedJson['phone'];
}
