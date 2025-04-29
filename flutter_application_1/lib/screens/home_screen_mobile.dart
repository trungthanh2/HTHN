import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/firebase_service.dart';
import '../widgets/sensor_tile.dart';
import '../widgets/composite_sensor_view.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double temp = 0, humidity = 0, light = 0, soil = 0;

  @override
  void initState() {
    super.initState();
    FirebaseService().listenToSensors((t, h, l, s) {
      setState(() {
        temp = t;
        humidity = h;
        light = l;
        soil = s;
      });
      checkWarnings();
    });
  }
  void checkWarnings() {
    if (temp > 35.0) {
      showWarning('Cảnh báo: Nhiệt độ quá cao!');
    }
    if (humidity < 40.0) {
      showWarning('Cảnh báo: Độ ẩm quá thấp!');
    }
    if (light > 800) {
      showWarning('Cảnh báo: Ánh sáng quá mạnh!');
    }
  }

  void showWarning(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Giám sát cây trồng - Mobile"),
        backgroundColor: Colors.green,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          SensorTile(label: "🌡️ Nhiệt độ", value: "${temp.toStringAsFixed(1)}°C"),
          SensorTile(label: "💧 Độ ẩm không khí", value: "${humidity.toStringAsFixed(1)}%"),
          SensorTile(label: "💡 Ánh sáng", value: "${light.toStringAsFixed(1)} Lux"),
          SensorTile(label: "💡 độ ẩm đất", value: "${soil.toStringAsFixed(1)} %"),
          CompositeSensorView(
            temp: temp,
            humidity: humidity,
            soil: soil,
            light: light,
          ),
        ]
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => FirebaseService().sendTestData(),
        child: const Icon(Icons.cloud_upload),
      ),
    );
  }
}
