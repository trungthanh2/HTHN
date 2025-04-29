import 'package:flutter/material.dart';
import '../widgets/composite_sensor_view.dart'; // 👈 Import composite sensor

class MonitorScreen extends StatefulWidget {
  const MonitorScreen({super.key});

  @override
  State<MonitorScreen> createState() => _MonitorScreenState();
}

class _MonitorScreenState extends State<MonitorScreen> {
  List<Widget> sensors = [];

  void addSensor() {
    setState(() {
      sensors.add(_buildSensor());
    });
  }

  Widget _buildSensor() {
    // Tùy bạn có thể random dữ liệu để test
    double temp = 30 + sensors.length * 2;
    double humidity = 50 + sensors.length * 5;
    double soil = 300 + sensors.length * 10;
    double light = 500 + sensors.length * 20;

    return GestureDetector(
      onTap: () {
        // TODO: Xử lý khi bấm vào sensor: mở chi tiết
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Chi tiết Sensor'),
            content: Text(
              '🌡 Nhiệt độ: ${temp.toStringAsFixed(1)} °C\n'
              '💧 Độ ẩm: ${humidity.toStringAsFixed(1)} %\n'
              '🌱 Độ ẩm đất: ${soil.toStringAsFixed(1)}\n'
              '💡 Ánh sáng: ${light.toStringAsFixed(1)} Lux',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Đóng'),
              ),
            ],
          ),
        );
      },
      child: Container(
        width: 150,
        height: 150,
        margin: const EdgeInsets.all(8),
        child: CompositeSensorView(
          temp: temp,
          humidity: humidity,
          soil: soil,
          light: light,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giám sát cây trồng - Web'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Wrap(
                alignment: WrapAlignment.center,
                children: sensors,
              ),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: addSensor,
            icon: const Icon(Icons.add),
            label: const Text('Thêm sensor'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
