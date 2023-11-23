// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;
import 'package:galactic_scales/screens/home_screen.dart' as _i1;
import 'package:galactic_scales/screens/space_object_info_screen.dart' as _i2;

abstract class $AppRouter extends _i3.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.HomeScreen(),
      );
    },
    SpaceObjectInfoRoute.name: (routeData) {
      final args = routeData.argsAs<SpaceObjectInfoRouteArgs>();
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.SpaceObjectInfoScreen(
          key: args.key,
          spaceObjectId: args.spaceObjectId,
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.HomeScreen]
class HomeRoute extends _i3.PageRouteInfo<void> {
  const HomeRoute({List<_i3.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i3.PageInfo<void> page = _i3.PageInfo<void>(name);
}

/// generated route for
/// [_i2.SpaceObjectInfoScreen]
class SpaceObjectInfoRoute extends _i3.PageRouteInfo<SpaceObjectInfoRouteArgs> {
  SpaceObjectInfoRoute({
    _i4.Key? key,
    required int spaceObjectId,
    List<_i3.PageRouteInfo>? children,
  }) : super(
          SpaceObjectInfoRoute.name,
          args: SpaceObjectInfoRouteArgs(
            key: key,
            spaceObjectId: spaceObjectId,
          ),
          initialChildren: children,
        );

  static const String name = 'SpaceObjectInfoRoute';

  static const _i3.PageInfo<SpaceObjectInfoRouteArgs> page =
      _i3.PageInfo<SpaceObjectInfoRouteArgs>(name);
}

class SpaceObjectInfoRouteArgs {
  const SpaceObjectInfoRouteArgs({
    this.key,
    required this.spaceObjectId,
  });

  final _i4.Key? key;

  final int spaceObjectId;

  @override
  String toString() {
    return 'SpaceObjectInfoRouteArgs{key: $key, spaceObjectId: $spaceObjectId}';
  }
}
