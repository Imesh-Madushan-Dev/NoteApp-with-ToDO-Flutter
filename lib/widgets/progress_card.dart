import 'package:flutter/material.dart';
import 'package:notes_sphere/utils/colors.dart';
import 'package:notes_sphere/utils/constants.dart';
import 'package:notes_sphere/utils/text_styles.dart';

class ProgressCard extends StatefulWidget {
  final int completedTask;
  final int totalTask;

  const ProgressCard({
    super.key,
    required this.completedTask,
    required this.totalTask,
  });

  @override
  State<ProgressCard> createState() => _ProgressCardState();
}

class _ProgressCardState extends State<ProgressCard> {
  @override
  Widget build(BuildContext context) {
// calculaton for the completion percentage

    double completionPercentage = widget.totalTask != 0
        ? (widget.completedTask / widget.totalTask) * 100
        : 0;

    return Container(
      decoration: BoxDecoration(
          color: AppColors.kCardColor, borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.kDefaultPadiing),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Your Progress 👻",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.appSubTitle,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "You have completed ${widget.completedTask} out of ${widget.totalTask} tasks ! 🔥",
                    style: TextStyles.appDescriptionSmall.copyWith(
                        color: AppColors.kWhiteColor.withOpacity(0.5)),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.23,
              width: MediaQuery.of(context).size.width * 0.23,
              child: Center(
                child: Text(
                  "$completionPercentage% ",
                  style: TextStyles.appSubTitle.copyWith(
                      color: AppColors.kFloatingButton,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
