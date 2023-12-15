// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i5;
import 'package:galactic_scales/screens/home_screen.dart' as _i1;
import 'package:galactic_scales/screens/quiz_screen.dart' as _i2;
import 'package:galactic_scales/screens/space_object_info_screen.dart' as _i3;

abstract class $AppRouter extends _i4.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.HomeScreen(),
      );
    },
    QuizRoute.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.QuizScreen(),
      );
    },
    SpaceObjectInfoRoute.name: (routeData) {
      final args = routeData.argsAs<SpaceObjectInfoRouteArgs>();
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.SpaceObjectInfoScreen(
          key: args.key,
          spaceObjectId: args.spaceObjectId,
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.HomeScreen]
class HomeRoute extends _i4.PageRouteInfo<void> {
  const HomeRoute({List<_i4.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}

/// generated route for
/// [_i2.QuizScreen]
class QuizRoute extends _i4.PageRouteInfo<void> {
  const QuizRoute({List<_i4.PageRouteInfo>? children})
      : super(
          QuizRoute.name,
          initialChildren: children,
        );

  static const String name = 'QuizRoute';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}

/// generated route for
/// [_i3.SpaceObjectInfoScreen]
class SpaceObjectInfoRoute extends _i4.PageRouteInfo<SpaceObjectInfoRouteArgs> {
  SpaceObjectInfoRoute({
    _i5.Key? key,
    required int spaceObjectId,
    List<_i4.PageRouteInfo>? children,
  }) : super(
          SpaceObjectInfoRoute.name,
          args: SpaceObjectInfoRouteArgs(
            key: key,
            spaceObjectId: spaceObjectId,
          ),
          initialChildren: children,
        );

  static const String name = 'SpaceObjectInfoRoute';

  static const _i4.PageInfo<SpaceObjectInfoRouteArgs> page =
      _i4.PageInfo<SpaceObjectInfoRouteArgs>(name);
}

class SpaceObjectInfoRouteArgs {
  const SpaceObjectInfoRouteArgs({
    this.key,
    required this.spaceObjectId,
  });

  final _i5.Key? key;

  final int spaceObjectId;

  @override
  String toString() {
    return 'SpaceObjectInfoRouteArgs{key: $key, spaceObjectId: $spaceObjectId}';
  }
}
