part of '../project_page.dart';

Widget buildProjectCard(BuildContext context, Project project) {
  final isDesktop = ResponsiveBreakpoints.of(context).isDesktop;
  final isMobile = ResponsiveBreakpoints.of(context).isMobile;

  return InkWell(
    focusColor: Colors.transparent,
    hoverColor: Colors.transparent,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    onTap: () => urlLauncher(Uri.parse(project.htmlUrl)),
    child: Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color:
              Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xFF30363D)
                  : Colors.grey.shade300,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Project Image Placeholder with Language-based Color
          Expanded(
            flex: isMobile ? 1 : 2,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color:
                    Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey.withValues(alpha: 0.1)
                        : Colors.grey.withValues(alpha: 0.05),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Icon(
                      Icons.web,
                      size: isMobile ? 32 : 48,
                      // color: Colors.white38,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.4),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Project Info
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(isDesktop ? 16 : 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Project Title
                  Text(
                    project.name.replaceAll('-', ' ').toUpperCase(),
                    style: TextStyle(
                      // color: Colors.white,
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: isDesktop ? 18 : 16,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  // Project Description
                  Expanded(
                    child: Text(
                      project.description.isNotEmpty
                          ? project.description
                          : 'No description available for this repository.',
                      style: TextStyle(
                        // color: Colors.white70,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.7),
                        fontSize: isDesktop ? 14 : 12,
                        height: 1.4,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: isDesktop ? 3 : 2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Language Tags
                  FutureBuilder<List<String>>(
                    future: fetchLanguages(
                      project.languagesUrl,
                      topThreeOnly: true,
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return SizedBox(
                          height: isDesktop ? 20 : 16,
                          width: isDesktop ? 20 : 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            // color: Color(0xFF58A6FF),
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        );
                      }

                      final languages = snapshot.data ?? [];

                      if (languages.isEmpty) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: isDesktop ? 8 : 6,
                            vertical: isDesktop ? 4 : 3,
                          ),
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.grey.withValues(alpha: 0.1)
                                    : Colors.grey.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color:
                                  Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.grey.withValues(alpha: 0.3)
                                      : Colors.grey.withValues(alpha: 0.2),
                            ),
                          ),
                          child: Text(
                            'No languages detected',
                            style: TextStyle(
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurface.withValues(alpha: 0.5),
                              fontSize: isDesktop ? 12 : 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }

                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children:
                              languages
                                  .take(isDesktop ? 3 : 2) // Limit on mobile
                                  .map(
                                    (language) => Container(
                                      margin: const EdgeInsets.only(right: 6),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: isDesktop ? 8 : 6,
                                        vertical: isDesktop ? 4 : 3,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary
                                            .withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary
                                              .withValues(alpha: 0.3),
                                        ),
                                      ),
                                      child: Text(
                                        language.toUpperCase(),
                                        style: TextStyle(
                                          color:
                                              Theme.of(
                                                context,
                                              ).colorScheme.primary,
                                          fontSize: isDesktop ? 12 : 10,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
