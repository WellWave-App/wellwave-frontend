import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellwave_frontend/config/constants/app_strings.dart';
import 'package:wellwave_frontend/features/logs/presentation/bloc/logs_bloc.dart';
import 'package:wellwave_frontend/features/logs/presentation/widget/chart.dart';
import 'package:wellwave_frontend/features/logs/presentation/widget/input_button.dart';
import 'package:wellwave_frontend/features/logs/presentation/widget/weekly_logs_card.dart';

import '../../../../config/constants/app_images.dart';

class WeeklyLogs extends StatefulWidget {
  const WeeklyLogs({super.key});

  @override
  State<WeeklyLogs> createState() => _WeeklyLogsState();
}

class _WeeklyLogsState extends State<WeeklyLogs> {
  @override
  void initState() {
    super.initState();
    final today = DateTime.now();

    context.read<LogsBloc>().add(LogsFetchedGraph(today));
    // debugPrint('Dispatched LogsFetchedGraph event');
  }

  @override
  Widget build(BuildContext context) {
    // debugPrint('WeeklyLogs build called');

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<LogsBloc, LogsState>(
            builder: (context, state) {
              bool logsRecorded = false;
              double weight = 0.0;
              double lastWeekWeight = 0.0;
              double waistLine = 0.0;
              double lastWeekWaistLine = 0.0;

              if (state is LogsLoadGraphInProgress) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is LogsLoadGraphSuccess) {
                if (state.logsWeightlist.isNotEmpty) {
                  weight = state.logsWeightlist.last?.value ?? 0.0;
                  lastWeekWeight = state.logsWeightlist.length > 1
                      ? state.logsWeightlist[state.logsWeightlist.length - 2]
                              ?.value ??
                          0.0
                      : 0.0;
                }

                if (state.logsWaistLinelist.isNotEmpty) {
                  waistLine = state.logsWaistLinelist.last?.value ?? 0.0;
                  lastWeekWaistLine = state.logsWaistLinelist.length > 1
                      ? state
                              .logsWaistLinelist[
                                  state.logsWaistLinelist.length - 2]
                              ?.value ??
                          0.0
                      : 0.0;
                }

                logsRecorded = state.logsWaistLinelist.length >= 4 ||
                    state.logsWeightlist.length >= 4;

                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              AppStrings.weeklyLogsText,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        logsRecorded
                            ? Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 16.0),
                                decoration: BoxDecoration(
                                  color: Colors.grey[400],
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                child: Text(
                                  AppStrings.dataRecordingCompletedText,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(color: Colors.white),
                                ),
                              )
                            : const InputButton(
                                buttonText: AppStrings.dataRecordingText,
                              ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            WeeklyLogsCard(
                              title: AppStrings.weightText,
                              value: weight,
                              unit: AppStrings.kgText,
                              lastWeekValue: lastWeekWeight,
                              chart: LineChartSample2(
                                logType: AppStrings.weightLogText,
                                logs: state.logsWeightlist,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            WeeklyLogsCard(
                              title: AppStrings.waistLineText,
                              value: waistLine,
                              unit: AppStrings.cmText,
                              lastWeekValue: lastWeekWaistLine,
                              chart: LineChartSample2(
                                logType: AppStrings.waistLineLogText,
                                logs: state.logsWaistLinelist,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                );
              } else if (state is LogsError) {
                return Center(
                    child: Column(
                  children: [
                    Image.asset(AppImages.catNoItemimage, height: 128),
                    const SizedBox(height: 32),
                    const Text(AppStrings.errorLoadingLogsText),
                  ],
                ));
              }

              return Center(
                  child: Column(
                children: [
                  Image.asset(AppImages.catNoItemimage, height: 128),
                  const SizedBox(height: 32),
                  const Text(AppStrings.noLogsAvailableText),
                ],
              ));
            },
          ),
        ],
      ),
    );
  }
}
