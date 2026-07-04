import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../features/home/presentation/pages/home_page.dart';
import '../features/activity/presentation/pages/activity_page.dart';
import '../features/games/presentation/pages/games_page.dart';
import '../features/messages/presentation/pages/messages_page.dart';
import '../features/profile/presentation/pages/profile_page.dart';
import '../features/auth/presentation/pages/login_page.dart';
import '../features/room/presentation/pages/room_page.dart';

final appRouterProvider = Provider<GoRouter>(
  (ref) {
    return GoRouter(
      initialLocation: '/login',
      routes: [
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: '/',
          builder: (context, state) => const HomePage(),
          routes: [
            GoRoute(
              path: 'activity',
              builder: (context, state) => const ActivityPage(),
            ),
            GoRoute(
              path: 'games',
              builder: (context, state) => const GamesPage(),
            ),
            GoRoute(
              path: 'messages',
              builder: (context, state) => const MessagesPage(),
            ),
            GoRoute(
              path: 'profile',
              builder: (context, state) => const ProfilePage(),
            ),
            GoRoute(
              path: 'room/:roomId',
              builder: (context, state) {
                final roomId = state.pathParameters['roomId']!;
                return RoomPage(roomId: roomId);
              },
            ),
          ],
        ),
      ],
    );
  },
);
