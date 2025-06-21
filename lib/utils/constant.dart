import 'dart:convert';

const double a4Width = 595.28;

const String dummyJsonUrl = 'https://dummyjson.com';

const String gitHubApiUrl = 'https://api.github.com';

const String gitHubUsername = 'YourGitHubUserName';

const String gitHubToken = 'YourGitHubAccessToken';

final String gitHubAccessToken = base64Encode(
  utf8.encode('$gitHubUsername:$gitHubToken'),
);

final gitHubAPIHeaders = {
  'Authorization': 'Basic $gitHubAccessToken',
  'Accept': 'application/vnd.github.v3+json',
  'User-Agent': 'Flutter-App',
};

final Map<String, List<String>> languageCache = {};

class Routes {
  static const String loginPage = '/login';
  static const String homePage = '/';
  static const String listPage = '/list';
  static const String imageVideoPage = '/imageVideo';
  static const String profilePage = '/profile';
  static const String projectPage = '/projects';
  static const String cvPage = '/cv';
  static const String settingsPage = '/setting';
}
