part of '../cv_page.dart';

Widget buildEducationSection(BuildContext context, CVController state) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Educations',
        style: Theme.of(
          context,
        ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
      ),
      const Divider(thickness: 1.5),
      // const SizedBox(height: 8),
      ...state.profileEntity!.educations.map((education) {
        final startDate = DateTime.parse(education['start']);
        final endDate =
            education['end'] != null
                ? DateTime.parse(education['end'])
                : DateTime.now();

        final difference = endDate.difference(startDate);
        final years = difference.inDays ~/ 365;
        final months = (difference.inDays % 365) ~/ 30;

        String durationText = '';
        if (years > 0) {
          durationText += '$years Year${years > 1 ? 's' : ''}';
        }
        if (months > 0) {
          durationText += durationText.isNotEmpty ? ' ' : '';
          durationText += '$months Month${months > 1 ? 's' : ''}';
        }

        final formattedStartDate = DateFormat('MMM yyyy').format(startDate);
        final formattedEndDate =
            education['end'] != null
                ? DateFormat('MMM yyyy').format(endDate)
                : 'Present';
        final period = '$formattedStartDate - $formattedEndDate';

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child:
                        education['url'] != null
                            ? GetBuilder<HoverController>(
                              init: HoverController(),
                              global: false,
                              builder: (hoverController) {
                                return Obx(
                                  () => MouseRegion(
                                    onEnter: (_) => hoverController.enter(),
                                    onExit: (_) => hoverController.exit(),
                                    child: InkWell(
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap:
                                          () => urlLauncher(
                                            Uri.parse(education['url']),
                                          ),
                                      child: Text(
                                        education['university'],
                                        style: Theme.of(
                                          context,
                                        ).textTheme.titleLarge?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          decoration:
                                              hoverController.isHovered
                                                  ? TextDecoration.underline
                                                  : TextDecoration.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )
                            : Text(
                              education['university'],
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        period,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        durationText,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Wrap(
                spacing: 4,
                runSpacing: 4,
                children: [
                  Text(
                    '${education['degree']} of',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ...List.generate(education['majors'].length, (index) {
                    final major = education['majors'][index];
                    final isLast = index == education['majors'].length - 1;
                    return _buildMajorTexts(context, major, isLast: isLast);
                  }),
                ],
              ),
            ],
          ),
        );
      }),
    ],
  );
}

Widget _buildMajorTexts(
  BuildContext context,
  String text, {
  bool isLast = false,
}) {
  return Padding(
    padding: const EdgeInsets.only(right: 4),
    child: Text(
      isLast ? text : "$text.",
      style: Theme.of(
        context,
      ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
    ),
  );
}
