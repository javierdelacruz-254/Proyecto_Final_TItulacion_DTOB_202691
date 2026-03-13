import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class Bebe3dViewer extends StatelessWidget {
  final String modelo;

  const Bebe3dViewer({super.key, required this.modelo});

  @override
  Widget build(BuildContext context) {
    return ModelViewer(
      backgroundColor: Colors.transparent,
      src: modelo,
      alt: "Modelo del bebé",
      autoRotate: true,
      cameraControls: false,
      disableZoom: true,
      environmentImage: "neutral",
      shadowIntensity: 0,
    );
  }
}
