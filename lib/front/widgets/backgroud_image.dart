import 'package:flutter/material.dart';

class BacgroundImage extends StatelessWidget {
  const BacgroundImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
      colors: [
        Colors.black,
        Colors.black12,
      ],
      begin: Alignment.bottomCenter,
      end: Alignment.center,
      ).createShader(bounds), 
      blendMode: BlendMode.darken,
      child: Container(
          decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/login.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
          ),
        )
      ),
    );
  }
}