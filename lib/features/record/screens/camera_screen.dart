import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:log/log.dart';
import 'package:vocabualize/features/record/services/camera_screen_arguments.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  static const routeName = "/cameraScreen";

  @override
  CameraScreenState createState() => CameraScreenState();
}

class CameraScreenState extends State<CameraScreen> {
  late CameraScreenArguments args;
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  _initCamera() {
    _controller = CameraController(args.camera, ResolutionPreset.medium);
    _initializeControllerFuture = _controller.initialize();
  }

  _takePicutre() async {
    try {
      await _initializeControllerFuture;

      final image = await _controller.takePicture();

      if (!mounted) return;
      Navigator.pop(context, File(image.path));
    } catch (error) {
      Log.error(error);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)!.settings.arguments as CameraScreenArguments;
    _initCamera();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text("Take a picture", textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineMedium),
                    const SizedBox(height: 24),
                    Flexible(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: CameraPreview(
                          _controller,
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.background.withOpacity(0.2),
                                  ),
                                ),
                              ),
                              AspectRatio(
                                aspectRatio: 1,
                                child: Container(),
                              ),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.background.withOpacity(0.2),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(onPressed: () => _takePicutre(), child: const Text("Looks good")),
                  ],
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
