import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vector_math/vector_math_64.dart' as vector64;

class ArEarth extends StatefulWidget {
  const ArEarth({super.key});

  @override
  State<ArEarth> createState() => _ArEarthState();
}

class _ArEarthState extends State<ArEarth> {
  ArCoreController? arCoreController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ArCoreView(onArCoreViewCreated: onArCoreViewCreated),
    );
  }

  void onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    displayEarth();
  }

  void displayEarth() async {
    final earthMap = await rootBundle.load("assets/earth_map.jpg");

    final material = ArCoreMaterial(
      color: Colors.white,
      textureBytes: earthMap.buffer.asUint8List(),
    );

    final sphere = ArCoreSphere(
      materials: [material],
      radius: 0.2,
    );

    final node = ArCoreNode(
      shape: sphere,
      position: vector64.Vector3(0, 0, -1.5),
    );

    arCoreController!.addArCoreNode(node);
  }
}
