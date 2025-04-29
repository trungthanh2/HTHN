import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/firebase_service.dart';
import '../widgets/composite_sensor_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<SensorData> sensors = [];
  int? selectedSensorIndex;

  @override
  void initState() {
    super.initState();
    FirebaseService().listenToAllSensors((dataList) {
      setState(() {
        sensors = dataList;
        if (selectedSensorIndex == null && sensors.isNotEmpty) {
          selectedSensorIndex = 0;
        }
      });
    });
  }

  Widget buildSensorBar(BuildContext context, String label, double value, double maxValue, IconData icon) {
    double percent = (value / maxValue).clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.green),
            const SizedBox(width: 8),
            Text('$label: ${value.toStringAsFixed(1)}'),
          ],
        ),
        const SizedBox(height: 4),
        Stack(
          children: [
            Container(
              height: 14,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Container(
              height: 14,
              width: MediaQuery.of(context).size.width * percent,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Giám sát cây trồng - Web'),
        actions: [
          IconButton(
            icon: const Icon(Icons.cloud_upload),
            tooltip: 'Gửi dữ liệu mẫu',
            onPressed: () async {
              if (user != null) {
                await FirebaseService().sendSensorData("sensor_demo", {
                  "temp": 28,
                  "humidity": 65,
                  "soil": 400,
                  "light": 600,
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Đã gửi dữ liệu mẫu!')),
                );
              }
            },
          ),
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: sensors.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: List.generate(sensors.length, (index) {
                    final sensor = sensors[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedSensorIndex = index;
                        });
                      },
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: selectedSensorIndex == index ? Colors.green : Colors.transparent,
                                width: 3,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: CompositeSensorView(
                              temp: sensor.temp,
                              humidity: sensor.humidity,
                              soil: sensor.soil,
                              light: sensor.light,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(sensor.name, style: const TextStyle(fontSize: 14)),
                        ],
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 20),
                if (selectedSensorIndex != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildSensorBar(
                          context,
                          '🌡 Nhiệt độ',
                          sensors[selectedSensorIndex!].temp,
                          60,
                          Icons.thermostat,
                        ),
                        buildSensorBar(
                          context,
                          '💧 Độ ẩm không khí',
                          sensors[selectedSensorIndex!].humidity,
                          100,
                          Icons.water_drop,
                        ),
                        buildSensorBar(
                          context,
                          '🌱 Độ ẩm đất',
                          sensors[selectedSensorIndex!].soil,
                          1000,
                          Icons.grass,
                        ),
                        buildSensorBar(
                          context,
                          '💡 Ánh sáng',
                          sensors[selectedSensorIndex!].light,
                          1000,
                          Icons.light_mode,
                        ),
                      ],
                    ),
                  )
              ],
            ),
    );
  }
}
