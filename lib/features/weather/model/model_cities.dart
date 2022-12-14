class ModelCities {
  int? id;
  String? name;
  String? state;
  String? country;
  Coord? coord;

  ModelCities({this.id, this.name, this.state, this.country, this.coord});

  ModelCities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    state = json['state'];
    country = json['country'];
    coord = json['coord'] != null ? Coord.fromJson(json['coord']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['state'] = state;
    data['country'] = country;
    if (coord != null) {
      data['coord'] = coord!.toJson();
    }
    return data;
  }
}

class Coord {
  double? lon;
  double? lat;

  Coord({this.lon, this.lat});

  Coord.fromJson(Map<String, dynamic> json) {
    lon = json['lon'];
    lat = json['lat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lon'] = lon;
    data['lat'] = lat;
    return data;
  }
}
