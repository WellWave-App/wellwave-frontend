      // progressList.isNotEmpty
                      //     ? SingleChildScrollView(
                      //         scrollDirection: Axis.horizontal,
                      //         child: Padding(
                      //           padding: const EdgeInsets.only(
                      //               left: 24.0,
                      //               top: 8.0,
                      //               bottom: 8.0,
                      //               right: 24.0),
                      //           child: Row(
                      //             children: [
                      //               ...progressList.map((progress) {
                      //                 final dates = List.generate(
                      //                   progress.totalDays,
                      //                   (index) => progress.startDate
                      //                       .add(Duration(days: index)),
                      //                 );
                      //                 final hasDateNow = dates.any((date) =>
                      //                     _isSameDay(date, DateTime.now()));

                      //                 if (!hasDateNow) {
                      //                   return const SizedBox.shrink();
                      //                 }

                      //                 return Row(
                      //                   children: [
                      //                     ProgressShowCard(progress: progress),
                      //                     const SizedBox(width: 16),
                      //                   ],
                      //                 );
                      //               }).toList(),
                      //               if (progressList.every((progress) {
                      //                 final dates = List.generate(
                      //                   progress.totalDays,
                      //                   (index) => progress.startDate
                      //                       .add(Duration(days: index)),
                      //                 );
                      //                 return !dates.any((date) =>
                      //                     _isSameDay(date, DateTime.now()));
                      //               }))
                      //                 Container(
                      //                   height: 200,
                      //                   width:
                      //                       MediaQuery.of(context).size.width -
                      //                           48,
                      //                   child: Center(
                      //                     child: Text(
                      //                       'ยังไม่มีความคืบหน้า ไปเริ่มทำกันเลย!',
                      //                       style: Theme.of(context)
                      //                           .textTheme
                      //                           .bodyMedium
                      //                           ?.copyWith(
                      //                             color:
                      //                                 AppColors.darkgrayColor,
                      //                           ),
                      //                     ),
                      //                   ),
                      //                 ),
                      //             ],
                      //           ),
                      //         ),
                      //       )
                      //     : Container(
                      //         height: 200,
                      //         width: MediaQuery.of(context).size.width - 48,
                      //         child: Center(
                      //           child: Text(
                      //             'ยังไม่มีความคืบหน้า ไปเริ่มทำกันเลย!',
                      //             style: Theme.of(context)
                      //                 .textTheme
                      //                 .bodyMedium
                      //                 ?.copyWith(
                      //                   color: AppColors.darkgrayColor,
                      //                 ),
                      //           ),
                      //         ),
                      //       ),