import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class SensorData {
  final double temp;
  final double humidity;
  final double soil;
  final double light;
  final String name;

  SensorData({
    required this.temp,
    required this.humidity,
    required this.soil,
    required this.light,
    required this.name,
  });
}

class FirebaseService {
  final DatabaseReference _ref = FirebaseDatabase.instance.ref('Sensor');

  void listenToSensors(Function(double, double, double, double) onData) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final uid = user.uid;
    final userRef = _ref.child(uid);
    userRef.onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;

      if (data != null) {
        double temp = (data['temp'] ?? 0).toDouble();
        double humidity = (data['humidity'] ?? 0).toDouble();
        double light = (data['light'] ?? 0).toDouble();
        double soil = (data['soil'] ?? 0).toDouble();

        onData(temp, humidity, soil, light);
      } else {
        print('❗Không có dữ liệu trong Sensor/$uid');
      }
    });
  }

  void listenToAllSensors(Function(List<SensorData>) onDataList) {
    _ref.onValue.listen((event) {
      final allData = event.snapshot.value as Map<dynamic, dynamic>?;

      if (allData != null) {
        final List<SensorData> sensors = [];

        allData.forEach((key, value) {
          final sensor = value as Map<dynamic, dynamic>;
          sensors.add(SensorData(
            temp: (sensor['temp'] ?? 0).toDouble(),
            humidity: (sensor['humidity'] ?? 0).toDouble(),
            soil: (sensor['soil'] ?? 0).toDouble(),
            light: (sensor['light'] ?? 0).toDouble(),
            name: key,
          ));
        });

        onDataList(sensors);
      } else {
        print('❗Không có dữ liệu Sensors');
      }
    });
  }
}
