import 'package:flutter/material.dart';
import '../../../../../config/constants/app_colors.dart';

class NotiMissionWidget extends StatefulWidget {
  final String time;
  final String day;
  final String description;

  const NotiMissionWidget({
    super.key,
    required this.time,
    required this.day,
    required this.description,
  });

  @override
  State<NotiMissionWidget> createState() => _NotiMissionWidgetState();
}

class _NotiMissionWidgetState extends State<NotiMissionWidget> {
  bool _isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        widget.time,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        widget.day,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: AppColors.darkGrayColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.description,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              Switch(
                value: _isSwitched,
                onChanged: (value) {
                  setState(() {
                    _isSwitched = value;
                  });
                },
                activeColor: Colors.white, // Circle color (active)
                activeTrackColor:
                    const Color(0xFF34C759), // Track color (active)
                inactiveThumbColor:
                    AppColors.whiteColor, // Circle color (inactive)
                inactiveTrackColor:
                    AppColors.darkGrayColor, // Track color (inactive)
              ),
            ],
          ),
        ),
        const SizedBox(height: 12)
      ],
    );
  }
}
