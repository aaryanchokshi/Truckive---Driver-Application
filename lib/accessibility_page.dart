import 'package:flutter/material.dart';

class AccessibilityPage extends StatefulWidget {
  @override
  _AccessibilityPageState createState() => _AccessibilityPageState();
}

class _AccessibilityPageState extends State<AccessibilityPage> {
  double _textSize = 16.0;

  @override
  Widget build(BuildContext context) {
    // Define your color theme here
    Color primaryColor = Color(0xFF0d2136); // Dark blue color
    Color secondaryColor = Color(0xFF031525); // Even darker blue color
    Color textColor = Colors.white; // For better readability on dark background

    return Scaffold(
      appBar: AppBar(
        title: Text('Accessibility'),
        backgroundColor: primaryColor,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            color: secondaryColor, // Background color for ListTile container
            child: ListTile(
              title: Text('Text Size', style: TextStyle(color: textColor)),
              subtitle: SliderTheme(
                data: SliderThemeData(
                  thumbColor: Colors.white,
                  activeTrackColor: Colors.lightBlueAccent,
                  inactiveTrackColor: Colors.lightBlueAccent.withOpacity(0.5),
                  trackHeight: 4.0,
                ),
                child: Slider(
                  min: 10.0,
                  max: 24.0,
                  divisions: 7,
                  label: '${_textSize.round()}',
                  value: _textSize,
                  onChanged: (double value) {
                    setState(() {
                      _textSize = value;
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
