import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/wave/BasePainter.dart';
import 'package:flutter_app/widgets/wave/WavePainter.dart';

abstract class BasePainterFactory {
    BasePainter getPainter();
}

class WavePainterFactory extends BasePainterFactory {
    BasePainter getPainter() {
        return WavePainter(
            waveCount: 1,
            waveColors: [
                Colors.lightBlueAccent[200],
            ],
            textStyle:
            TextStyle(
                fontSize: 60.0,
                foreground: Paint()
                    ..color = Colors.lightBlue
                    ..style = PaintingStyle.fill
                    ..strokeWidth = 2.0
                    ..blendMode = BlendMode.difference
                    ..colorFilter = ColorFilter.mode(Colors.white, BlendMode.exclusion)
                    ..maskFilter = MaskFilter.blur(BlurStyle.solid, 1.0),
                fontWeight: FontWeight.bold,
            ),
        );
    }
}
