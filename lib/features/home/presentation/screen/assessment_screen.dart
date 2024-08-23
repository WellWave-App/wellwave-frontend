import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class AssessmentScreen extends StatefulWidget {
  @override
  AssessmentScreenState createState() => AssessmentScreenState();
}

class AssessmentScreenState extends State<AssessmentScreen> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _currentStep > 0
            ? IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: cancel,
              )
            : SizedBox.shrink(), // icon invisible
        title: Text('Flutter Step Progress Indicator Demo'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                StepProgressIndicator(
                  totalSteps: 8,
                  currentStep: _currentStep + 1,
                  size: 4,
                  selectedColor: Colors.green,
                  unselectedColor: Color.fromARGB(255, 121, 121, 121),
                ),
              ],
            ),
            Expanded(
              child: StepContent(currentStep: _currentStep),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: _currentStep < 2 ? continued : null,
                  child: Text('Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    _currentStep < 2 ? setState(() => _currentStep += 1) : null;
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }
}

class StepContent extends StatelessWidget {
  final int currentStep;

  StepContent({required this.currentStep});

  @override
  Widget build(BuildContext context) {
    switch (currentStep) {
      case 0:
        return Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Email Address'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Password'),
            ),
          ],
        );
      case 1:
        return Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Home Address'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Postcode'),
            ),
          ],
        );
      case 2:
        return Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Mobile Number'),
            ),
          ],
        );
      default:
        return Container();
    }
  }
}
