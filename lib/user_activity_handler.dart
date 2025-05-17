import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_pemobile_getx/presentation/controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

/// A widget that monitors user activity and triggers a timeout action if the user is inactive for a specified duration.
///
/// This widget listens to user interactions and resets an inactivity timer
/// every time an interaction occurs. If the timer exceeds the specified `timeout`
/// duration, the `onTimeout` callback is triggered, and additional logic such as logout
/// or navigation can be executed.
///
/// This is useful for session management in applications requiring automatic logout
/// after a period of inactivity, especially for security purposes.
class UserActivityHandler extends StatefulWidget {
  /// The duration of inactivity after which the `onTimeout` callback is triggered.
  ///
  /// Defaults to 5 minutes if not specified.
  final Duration timeout;

  /// A callback function to execute when the user timeout occurs.
  final VoidCallback? onTimeout;

  /// The child widget that this handler wraps and monitors for user activity.
  final Widget child;

  /// Creates an instance of [UserActivityHandler].
  ///
  /// [timeout] specifies the inactivity duration,
  /// [onTimeout] is the callback function triggered on timeout,
  /// and [child] is the widget being monitored.
  const UserActivityHandler({
    super.key,
    this.timeout = const Duration(minutes: 5),
    this.onTimeout,
    required this.child,
  });

  @override
  State<UserActivityHandler> createState() => _UserActivityHandlerState();
}

/// The state class for [UserActivityHandler].
///
/// This manages the inactivity timer and listens to app lifecycle changes
/// and user interactions.
class _UserActivityHandlerState extends State<UserActivityHandler>
    with WidgetsBindingObserver {
  final AuthController controller = Get.find<AuthController>();

  /// Timer to periodically check for user inactivity.
  Timer? _timer;

  /// Tracks the timestamp of the last user interaction.
  DateTime? _lastInteraction;

  @override
  void initState() {
    super.initState();

    /// Initializes the inactivity timer and adds an observer for app lifecycle changes.
    _resetTimer();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    /// Cancels the timer and removes the app lifecycle observer.
    _timer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// Handles app lifecycle changes, specifically when the app is resumed.
  ///
  /// Resets the inactivity timer and checks if the user session should still be active.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkInactivity();
    }
  }

  /// Resets the inactivity timer and updates the last interaction timestamp.
  ///
  /// The timer periodically checks for inactivity every 30 seconds.
  void _resetTimer() {
    _timer?.cancel();
    _lastInteraction = DateTime.now();
    _timer = Timer.periodic(
      const Duration(seconds: 30),
      (_) => _checkInactivity(),
    );
  }

  /// Checks for user inactivity and triggers the `onTimeout` callback if timeout occurs.
  ///
  /// If the user is inactive for longer than the specified `timeout`, this method:
  /// - Cancels the timer.
  /// - Logs out the user by triggering a `LogoutEvent` in the `AuthenticationBloc`.
  /// - Redirects the user to the login page using `GoRouter`.
  void _checkInactivity() {
    final now = DateTime.now();
    final difference = now.difference(_lastInteraction!);

    if (difference >= widget.timeout) {
      _timer?.cancel();
      widget.onTimeout?.call();

      final context =
          GoRouter.of(this.context).routerDelegate.navigatorKey.currentContext;

      if (context != null) {
        controller.logout();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    /// Wraps the child widget with a [Listener] that resets the inactivity timer
    /// whenever user interactions like pointer down, move, or up occur.
    return Listener(
      onPointerDown: (_) => _resetTimer(),
      onPointerMove: (_) => _resetTimer(),
      onPointerUp: (_) => _resetTimer(),
      child: widget.child,
    );
  }
}
