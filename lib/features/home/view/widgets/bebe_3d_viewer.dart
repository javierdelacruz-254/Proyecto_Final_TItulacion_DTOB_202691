import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class Bebe3dViewer extends StatelessWidget {
  final String modelo;

  const Bebe3dViewer({super.key, required this.modelo});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: RepaintBoundary(
        child: ModelViewer(
          backgroundColor: Colors.transparent,
          src: modelo,
          alt: "Modelo del bebé",
          autoRotate: false,
          cameraControls: true,
          disableZoom: false,
          minCameraOrbit: "auto auto auto",
          maxCameraOrbit: "auto auto auto",
          environmentImage: "neutral",
          shadowIntensity: 1,
        ),
      ),
    );
  }
}
