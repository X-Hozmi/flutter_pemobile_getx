part of '../list_page.dart';

void showPersonForm(
  BuildContext context,
  PersonController personController, {
  person,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder:
        (context) => PersonFormSheet(
          person: person,
          onSaved: () {
            personController.getPerson();
          },
        ),
  );
}
