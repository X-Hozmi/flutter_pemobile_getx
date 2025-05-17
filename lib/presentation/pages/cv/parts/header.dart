part of '../cv_page.dart';

Widget buildHeader(BuildContext context, CVController state) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        flex: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              state.profileEntity!.profile['name'],
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              state.profileEntity!.profile['role'],
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            GetBuilder<HoverController>(
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
                      onTap: () {
                        final encodedLocation = Uri.encodeComponent(
                          state.profileEntity!.profile['location'],
                        );
                        final mapsUrl =
                            'https://www.google.com/maps/search/?api=1&query=$encodedLocation';
                        urlLauncher(Uri.parse(mapsUrl));
                      },
                      child: buildInfoRow(
                        icon: Icons.location_on,
                        text: state.profileEntity!.profile['location'],
                        isHovered: hoverController.isHovered,
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            buildSocialLinks(state.socials),
          ],
        ),
      ),
    ],
  );
}
