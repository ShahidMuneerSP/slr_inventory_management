// ignore_for_file: no_leading_underscores_for_local_identifiers

class Profile {
  Profile({
    required this.rawViewData,
    required this.status,
  });
  late final RawViewData rawViewData;
  late final int status;
  
  Profile.fromJson(Map<String, dynamic> json){
    rawViewData = RawViewData.fromJson(json['rawViewData']);
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['rawViewData'] = rawViewData.toJson();
    _data['status'] = status;
    return _data;
  }
}

class RawViewData {
  RawViewData({
    required this.id,
    required this.personId,
    required this.firstName,
    required this.lastName,
     this.image,
     this.gender,
    required this.mobileNumber,
    required this.email,
    required this.address,
    required this.district,
    required this.state,
    required this.country,
    required this.pincode,
    required this.dob,
    required this.legislativeAssembly,
    required this.panchayath,
    required this.ward,
    required this.licenceImage,
    required this.shopName,
    required this.gstNo,
    required this.sqft,
    required this.username,
    required this.password,
  });
   late final String? id;
   late final String? personId;
   late final String? firstName;
   late final String? lastName;
   late final String? image;
   late final String? gender;
   late final String? mobileNumber;
   late final String? email;
   late final String? address;
   late final String? district;
   late final String? state;
   late final String? country;
   late final String? pincode;
   late final String? dob;
   late final String? legislativeAssembly;
   late final String? panchayath;
   late final String? ward;
   late final String? licenceImage;
   late final String? shopName;
   late final String? gstNo;
   late final String? sqft;
   late final String? username;
   late final String? password;
  
  RawViewData.fromJson(Map<String, dynamic> json){
    id = json['id'];
    personId = json['person_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    image = null;
    gender = null;
    mobileNumber = json['mobile_number'];
    email = json['email'];
    address = json['address'];
    district = json['district'];
    state = json['state'];
    country = json['country'];
    pincode = json['pincode'];
    dob = json['dob'];
    legislativeAssembly = json['legislative_assembly'];
    panchayath = json['panchayath'];
    ward = json['ward'];
    licenceImage = json['licence_image'];
    shopName = json['shop_name'];
    gstNo = json['gst_no'];
    sqft = json['sqft'];
    username = json['username'];
    // password = json['password'];
  }
  //  {
  //"rawViewData":
  //{"id":"1",
  //"person_id":"376",
  //"first_name":"Raouf P",
  //"last_name":"Said Muhammed",
  //"image":null,
  //"gender":"Male",
  //"mobile_number":"+919554642562",
  //"email":"raoufpsaidmuhammed@gmail.com",
  //"address":"Peruntharayil (H)",
  //"district":"Thrissur",
  //"state":"KERALA",
  //"country":"India",
  //"pincode":"680688",
  //"dob":"1974-04-04",
  //"legislative_assembly":"69",
  //"panchayath":"43",
  //"ward":"8",
  //"licence_image":"image.png",
  //"shop_name":"Raouf Stores",
  //"shop_image":"image.png",
  //"gst_no":"32SDHHJ32211121",
  //"sqft":"60000",
  //"username":"Raouf@123",
  //"aadhar_nmbr":"254224666565",
  //"aadhar_image":"image.png",
  //"pan_nmbr":"3232252656",
  //"pan_image":"image.png",
  //"type":"thirdparty",
  //"shop_pin":"680686",
  //"sell_type":"Retail",
  //"status":"Open",
  //"is_wallet_pswd":"Yes"
  //},
  //"status":200
  //}

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['person_id'] = personId;
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    _data['image'] = image;
    _data['gender'] = gender;
    _data['mobile_number'] = mobileNumber;
    _data['email'] = email;
    _data['address'] = address;
    _data['district'] = district;
    _data['state'] = state;
    _data['country'] = country;
    _data['pincode'] = pincode;
    _data['dob'] = dob;
    _data['legislative_assembly'] = legislativeAssembly;
    _data['panchayath'] = panchayath;
    _data['ward'] = ward;
    _data['licence_image'] = licenceImage;
    _data['shop_name'] = shopName;
    _data['gst_no'] = gstNo;
    _data['sqft'] = sqft;
    _data['username'] = username;
    // _data['password'] = password;
    return _data;
  }
}