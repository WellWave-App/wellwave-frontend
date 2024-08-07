import 'package:flutter/material.dart';
import 'package:flutter_health_connect/flutter_health_connect.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // List<HealthConnectDataType> types = [
  //   HealthConnectDataType.ActiveCaloriesBurned,
  //   HealthConnectDataType.BasalBodyTemperature,
  //   HealthConnectDataType.BasalMetabolicRate,
  //   HealthConnectDataType.BloodGlucose,
  //   HealthConnectDataType.BloodPressure,
  //   HealthConnectDataType.BodyFat,
  //   HealthConnectDataType.BodyTemperature,
  //   HealthConnectDataType.BoneMass,
  //   HealthConnectDataType.CervicalMucus,
  //   HealthConnectDataType.CyclingPedalingCadence,
  //   HealthConnectDataType.Distance,
  //   HealthConnectDataType.ElevationGained,
  //   HealthConnectDataType.ExerciseEvent,
  //   HealthConnectDataType.ExerciseLap,
  //   HealthConnectDataType.ExerciseRepetitions,
  //   HealthConnectDataType.ExerciseSession,
  //   HealthConnectDataType.FloorsClimbed,
  //   HealthConnectDataType.HeartRate,
  //   HealthConnectDataType.Height,
  //   HealthConnectDataType.HipCircumference,
  //   HealthConnectDataType.Hydration,
  //   HealthConnectDataType.LeanBodyMass,
  //   HealthConnectDataType.MenstruationFlow,
  //   HealthConnectDataType.Nutrition,
  //   HealthConnectDataType.OvulationTest,
  //   HealthConnectDataType.OxygenSaturation,
  //   HealthConnectDataType.Power,
  //   HealthConnectDataType.RespiratoryRate,
  //   HealthConnectDataType.RestingHeartRate,
  //   HealthConnectDataType.SexualActivity,
  //   HealthConnectDataType.SleepSession,
  //   HealthConnectDataType.SleepStage,
  //   HealthConnectDataType.Speed,
  //   HealthConnectDataType.StepsCadence,
  //   HealthConnectDataType.Steps,
  //   HealthConnectDataType.SwimmingStrokes,
  //   HealthConnectDataType.TotalCaloriesBurned,
  //   HealthConnectDataType.Vo2Max,
  //   HealthConnectDataType.WaistCircumference,
  //   HealthConnectDataType.Weight,
  //   HealthConnectDataType.WheelchairPushes,
  // ];

  List<HealthConnectDataType> types = [
    HealthConnectDataType.Steps,
    HealthConnectDataType.HeartRate,
    HealthConnectDataType.SleepSession,
    HealthConnectDataType.OxygenSaturation,
    HealthConnectDataType.RespiratoryRate,
  ];

  bool readOnly = false;
  String resultText = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Health Connect'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            ElevatedButton(
              onPressed: () async {
                var result = await HealthConnectFactory.isApiSupported();
                resultText = 'isApiSupported: $result';
                _updateResultText();
              },
              child: const Text('isApiSupported'),
            ),
            ElevatedButton(
              onPressed: () async {
                var result = await HealthConnectFactory.isAvailable();
                resultText = 'isAvailable: $result';
                _updateResultText();
              },
              child: const Text('Check installed'),
            ),
            ElevatedButton(
              onPressed: () async {
                await HealthConnectFactory.installHealthConnect();
              },
              child: const Text('Install Health Connect'),
            ),
            ElevatedButton(
              onPressed: () async {
                await HealthConnectFactory.openHealthConnectSettings();
              },
              child: const Text('Open Health Connect Settings'),
            ),
            ElevatedButton(
              onPressed: () async {
                var result = await HealthConnectFactory.hasPermissions(
                  types,
                  readOnly: readOnly,
                );
                resultText = 'hasPermissions: $result';
                _updateResultText();
              },
              child: const Text('Has Permissions'),
            ),
            ElevatedButton(
              onPressed: () async {
                var result = await HealthConnectFactory.requestPermissions(
                  types,
                  readOnly: readOnly,
                );
                resultText = 'requestPermissions: $result';
                _updateResultText();
              },
              child: const Text('Request Permissions'),
            ),
            ElevatedButton(
              onPressed: () async {
                var startTime = DateTime.now().subtract(const Duration(days: 4));
                var endTime = DateTime.now();

                // Iterate over the types and fetch records for each type
                for (var type in types) {
                  var results = await HealthConnectFactory.getRecord(
                    type: type, // Change this from 'types' to 'type'
                    startTime: startTime,
                    endTime: endTime,
                  );

                  // Process the results as needed
                  resultText += '\ntype: $type\n\n$results';
                  _updateResultText();
                }
              },
              child: const Text('Get Record'),
            ),
            Text(resultText),
          ],
        ),
      ),
    );
  }

  void _updateResultText() {
    setState(() {});
  }
}