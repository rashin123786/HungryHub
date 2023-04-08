class DelivaryAddressModel {
  String? id;
  String? fullname;
  String? number;
  String? street;
  String? landMark;
  String? city;
  String? pincode;
  DelivaryAddressModel({
    this.city,
    this.fullname,
    this.landMark,
    this.number,
    this.pincode,
    this.street,
    this.id,
  });
  factory DelivaryAddressModel.fromjson(Map<String, dynamic> json) {
    return DelivaryAddressModel(
      city: json["city"],
      id: json["id"],
      fullname: json["fullname"],
      landMark: json["landmark"],
      number: json["mobilenumber"],
      pincode: json["pincode"],
      street: json["street"],
    );
  }
}
