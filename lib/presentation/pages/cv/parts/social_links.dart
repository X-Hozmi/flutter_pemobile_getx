part of '../cv_page.dart';

Widget buildSocialLinks(List<Map<String, dynamic>> socials) {
  return Wrap(
    spacing: 8,
    runSpacing: 8,
    children:
        socials.map((social) {
          IconData getIcon() {
            switch (social['icon']) {
              case 'envelope':
                return FontAwesomeIcons.envelope;
              case 'phone':
                return FontAwesomeIcons.phone;
              case 'github':
                return FontAwesomeIcons.github;
              case 'linkedin':
                return FontAwesomeIcons.linkedin;
              case 'instagram':
                return FontAwesomeIcons.instagram;
              default:
                return FontAwesomeIcons.link;
            }
          }

          return SocialLink(
            icon: getIcon(),
            url: social['url'],
            hoverController: HoverController(),
          );
        }).toList(),
  );
}

class SocialLink extends StatelessWidget {
  final IconData icon;
  final String url;
  final HoverController hoverController;

  const SocialLink({
    super.key,
    required this.icon,
    required this.url,
    required this.hoverController,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HoverController>(
      init: HoverController(),
      global: false,
      builder: (hoverController) {
        final hoveredTransform = Matrix4.identity()..scale(1.1);
        final transform =
            hoverController.isHovered ? hoveredTransform : Matrix4.identity();

        return Obx(
          () => MouseRegion(
            onEnter: (_) => hoverController.enter(),
            onExit: (_) => hoverController.exit(),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              transform: transform,
              child: InkWell(
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () => urlLauncher(Uri.parse(url)),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(4),
                    color:
                        hoverController.isHovered
                            ? Colors.grey[100]
                            : Colors.transparent,
                  ),
                  child: FaIcon(icon, size: 20),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
