import "package:flutter/material.dart";
import 'package:weight_tracker/src/UI/add_weight.dart';
import 'package:weight_tracker/src/UI/auth/auth_page.dart';
import 'package:weight_tracker/src/UI/home.dart';
import 'package:weight_tracker/src/UI/weight_detail.dart';

class RouteGenerator {
  static const String landing = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String addWeight = '/add/weight';
  static const String weightDetail = '/weight/detail';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case login:
        return MaterialPageRoute(
          builder: (_) => AuthPage(),
          settings: settings,
        );
      case home:
        return MaterialPageRoute(
          builder: (BuildContext context) => HomePage(),
          settings: settings,
        );
      case addWeight:
        return MaterialPageRoute(
          builder: (_) => AddWeightPage(
            weightDetailBloC: settings.arguments,
          ),
          settings: settings,
        );
      case weightDetail:
        WeightDetailPageArgs weightDetailArgs = args;
        return MaterialPageRoute(
            builder: (_) => WeightDetailPage(
                  capturedWeightDetails: weightDetailArgs.capturedWeightDetails,
                  initialWeightDetails: weightDetailArgs.initialWeightDetails,
                  weightDetailBloC: weightDetailArgs.weightBloC,
                ));
      default:
        return MaterialPageRoute(
          builder: (_) => AuthPage(),
          settings: settings,
        );
    }
  }
}

class WeightDetailPageArgs {
  final capturedWeightDetails;
  final initialWeightDetails;
  final weightBloC;
  WeightDetailPageArgs(
      this.capturedWeightDetails, this.initialWeightDetails, this.weightBloC);
}
