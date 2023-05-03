class LocationOfPost {
  double lat = 0;
  double long = 0;

  LocationOfPost({
    required this.lat,
    required this.long,
  });
  LocationOfPost.fromJson(Map<String, dynamic> jsonData) {
    lat = double.parse(jsonData['lat'].toString());
    long = double.parse(jsonData['long'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['long'] = this.long;
    return data;
  }
}
