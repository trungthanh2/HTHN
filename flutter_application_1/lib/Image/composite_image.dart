import 'package:flutter/material.dart';

class CompositeImage extends StatelessWidget {
  final double temp;
  final double humidity;
  final double light;

  const CompositeImage({
    super.key,
    required this.temp,
    required this.humidity,
    required this.light,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset('assets/images/background.png'), // nền chung

        if (temp > 35)
          Positioned(
            top: 30,
            left: 30,
            child: GestureDetector(
              onTap: () {
                print('Nhiệt độ cao: $temp °C');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Nhiệt độ quá cao!')),
                );
              },
              child: Image.asset('assets/images/hot-icon.png', width: 50),
            ),
          ),

        if (humidity < 40)
          Positioned(
            top: 80,
            left: 80,
            child: GestureDetector(
              onTap: () {
                print('Độ ẩm thấp: $humidity %');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Độ ẩm không khí quá thấp!')),
                );
              },
              child: Image.asset('assets/images/dry-icon.png', width: 50),
            ),
          ),

        if (light > 800)
          Positioned(
            bottom: 20,
            right: 20,
            child: GestureDetector(
              onTap: () {
                print('Ánh sáng cao: $light Lux');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Ánh sáng quá mạnh!')),
                );
              },
              child: Image.asset('assets/images/bright-icon.png', width: 50),
            ),
          ),
      ],
    );
  }
}
