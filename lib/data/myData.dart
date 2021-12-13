import 'package:cloud_firestore/cloud_firestore.dart';

class myData {
  var time, frequence, temperature, humidity;

  myData(this.time, this.frequence, this.temperature, this.humidity);

  //Mapping the data and convert it to string to send into the realtime database
  myData.fromJson(Map<dynamic, dynamic> json)
      : time = DateTime.parse(json['time'] as String),
        frequence = json['frequence'] as String,
        temperature = json['temperature'] as String,
        humidity = json['humidity'] as String;

  Map<dynamic, dynamic> toJson(String test) => {
        test: [
          {
            'time': time.toString(),
            'frequence': frequence,
            'temperature': temperature,
            'humidity': humidity
          }
        ]
      };
}
