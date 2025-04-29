import 'package:flutter/material.dart';

class CompositeSensorView extends StatelessWidget {
  final double temp;
  final double humidity;
  final double soil;
  final double light;

  const CompositeSensorView({
    super.key,
    required this.temp,
    required this.humidity,
    required this.soil,
    required this.light,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.maxWidth < constraints.maxHeight
            ? constraints.maxWidth
            : constraints.maxHeight;

        return GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text('Chi tiết thông số'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('🌡️ Nhiệt độ: ${temp.toStringAsFixed(1)} °C'),
                    Text('💧 Độ ẩm: ${humidity.toStringAsFixed(1)} %'),
                    Text('🪨 Độ ẩm đất: ${soil.toStringAsFixed(1)}'),
                    Text('💡 Ánh sáng: ${light.toStringAsFixed(1)} Lux'),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Đóng'),
                  )
                ],
              ),
            );
          },
          child: SizedBox(
            width: size,
            height: size,
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (temp < 25.0 && light < 10000.0 && light >= 5000.0)
                  Image.asset(
                    'assets/images/mat_troi_xanh_nho.png',
                    width: 300,
                    height: 300,
                  ),
                if (temp < 25.0 && light >= 10000.0) 
                  Image.asset(
                    'assets/images/mat_troi_xanh_to.png',
                    width: 300,
                    height: 300,
                  ),
                if (temp >= 25.0 && temp <= 40.0 && light < 10000.0 && light >= 5000.0) 
                  Image.asset(
                    'assets/images/mat_troi_vang_nho.png',
                    width: 300,
                    height: 300,
                  ),
                if (temp >= 25.0 && temp <= 40.0 && light >= 10000.0) 
                  Image.asset(
                    'assets/images/mat_troi_vang_to.png',
                    width: 300,
                    height: 300,
                  ),
                if (temp > 40.0 && light < 10000.0 && light >= 5000.0) 
                  Image.asset(
                    'assets/images/mat_troi_do_nho.png',
                    width: 300,
                    height: 300,
                  ),
                if (temp > 40.0 && light >= 10000.0) 
                  Image.asset(
                    'assets/images/mat_troi_do_to.png',
                    width: 300,
                    height: 300,
                  ),
                if (light < 5000.0) 
                  Image.asset(
                    'assets/images/may.png',
                    width: 300,
                    height: 300,
                  ),

                if (humidity < 40.0 )
                  Image.asset(
                    'assets/images/co_kho.png',
                    width: 300,
                    height: 300,
                    ),
                if (humidity >= 40.0 )
                  Image.asset(
                    'assets/images/co_tuoi.png',
                    width: 300,
                    height: 300,
                    ),

                if (soil < 90.0 && soil >= 30.0)
                  Image.asset(
                    'assets/images/song_thuong.png',
                    width: 300,
                    height: 300,
                    ),
                if (soil >= 90.0 && humidity >= 40.0)
                  Image.asset(
                    'assets/images/ngap_tuoi.png',
                    width: 300,
                    height: 300,
                    ),
                if (soil >= 90.0 && humidity < 40.0)
                  Image.asset(
                    'assets/images/ngap_kho.png',
                    width: 300,
                    height: 300,
                    ),
                if (soil < 30.0)
                  Image.asset(
                    'assets/images/song_kho.png',
                    width: 300,
                    height: 300,
                    ),
                if (humidity >= 90.0)
                  Image.asset(
                    'assets/images/cay_nam.png',
                    width: 300,
                    height: 300,
                    ),
                if (humidity < 90.0)
                  Image.asset(
                    'assets/images/cay_thuong.png',
                    width: 300,
                    height: 300,
                    ),
              ],
            ),
          ),
        );
      },
    );
  }
}
