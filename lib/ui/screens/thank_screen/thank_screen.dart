import 'package:flutter/material.dart';

class ThankScreen extends StatelessWidget {
  const ThankScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.topCenter,
          children: [
            Image.asset(
              'assets/images/backgroundImage.png',
              fit: BoxFit.cover,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    height: MediaQuery.of(context).size.height / 6,
                    child: false ? Image.asset(
                      'assets/images/logo.png',
                    ) : Image.asset(
                      'assets/images/logo2.png',
                    )),
                SizedBox(
                  height: 50,
                ),
                Center(
                  child: false
                      ? ShaderMask(
                          blendMode: BlendMode.srcIn,
                          shaderCallback: (bounds) => LinearGradient(colors: [
                                Color(0xFFCFAF4F),
                                Color(0xFFF5D872),
                                Color(0xFFCFAF4F),
                              ]).createShader(
                                Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                              ),
                          child: Text(
                            'Спасибо, что выбираете нас',
                            style:
                                TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                          ))
                      : Text(
                          'Спасибо, что выбираете нас',
                          style: TextStyle(color: Colors.amberAccent, fontWeight: FontWeight.w500),
                        ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
