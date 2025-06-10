class Model {
  Location? location;
  Current? current;
  Forecast? forecast;

  Model({this.location, this.current, this.forecast});

  Model.fromJson(Map<String, dynamic> json) {
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    current =
        json['current'] != null ? Current.fromJson(json['current']) : null;
    forecast =
        json['forecast'] != null ? Forecast.fromJson(json['forecast']) : null;
  }
}

class Location {
  String? name;
  String? region;
  String? country;
  String? localtime;

  Location({this.name, this.region, this.country, this.localtime});

  Location.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    region = json['region'];
    country = json['country'];
    localtime = json['localtime'];
  }
}

class Current {
  double? tempC;
  Condition? condition;

  Current({
    this.tempC,
    this.condition,
  });

  Current.fromJson(Map<String, dynamic> json) {
    tempC = json['temp_c'];
    condition = json['condition'] != null
        ? Condition.fromJson(json['condition'])
        : null;
  }
}

class Condition {
  String? text;
  String? icon;

  Condition({
    this.text,
    this.icon,
  });

  Condition.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    icon = json['icon'];
  }
}

class Forecast {
  List<Forecastday>? forecastday;

  Forecast({this.forecastday});

  Forecast.fromJson(Map<String, dynamic> json) {
    if (json['forecastday'] != null) {
      forecastday = <Forecastday>[];
      json['forecastday'].forEach((v) {
        forecastday!.add(Forecastday.fromJson(v));
      });
    }
  }
}

class Forecastday {
  Day? day;
  Astro? astro;
  List<Hour>? hour;

  Forecastday({this.day, this.astro, this.hour});

  Forecastday.fromJson(Map<String, dynamic> json) {
    day = json['day'] != null ? Day.fromJson(json['day']) : null;
    astro = json['astro'] != null ? Astro.fromJson(json['astro']) : null;
    if (json['hour'] != null) {
      hour = <Hour>[];
      json['hour'].forEach((v) {
        hour!.add(Hour.fromJson(v));
      });
    }
  }
}

class Day {
  double? avgtemp;
  double? maxwindK;
  int? avghumidity;
  Condition? condition;

  Day({
    this.maxwindK,
    this.avghumidity,
    this.avgtemp,
    this.condition,
  });

  Day.fromJson(Map<String, dynamic> json) {
    maxwindK = json['maxwind_kph'];
    avghumidity = json['avghumidity'];
    avgtemp = json['avgtemp_c'];
    condition = json['condition'] != null
        ? Condition.fromJson(json['condition'])
        : null;
  }
}

class Astro {
  String? sunrise;
  String? sunset;
  String? moonrise;
  String? moonset;
  String? moonPhase;

  Astro({
    this.sunrise,
    this.sunset,
    this.moonrise,
    this.moonset,
    this.moonPhase,
  });

  Astro.fromJson(Map<String, dynamic> json) {
    sunrise = json['sunrise'];
    sunset = json['sunset'];
    moonrise = json['moonrise'];
    moonset = json['moonset'];
    moonPhase = json['moon_phase'];
  }
}

class Hour {
  String? time;
  double? tempC;
  Condition? condition;
  int? humidity;
  double? windKph;

  Hour({
    this.humidity,
    this.windKph,
    this.time,
    this.tempC,
    this.condition,
  });

  Hour.fromJson(Map<String, dynamic> json) {
    humidity = json['humidity'];
    windKph = json['wind_kph'];
    time = json['time'];
    tempC = json['temp_c'];
    condition = json['condition'] != null
        ? Condition.fromJson(json['condition'])
        : null;
  }
}
