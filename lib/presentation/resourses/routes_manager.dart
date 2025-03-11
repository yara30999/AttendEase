import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../app/di.dart';
import '../../app/extensions.dart';
import '../01_auth_screens/view/forgot_password_view.dart';
import '../01_auth_screens/view/login_view.dart';
import '../01_auth_screens/view/register_view.dart';
import '../02_home_screens/view/admin_home_view.dart';
import '../02_home_screens/view/check_in_view.dart';
import '../02_home_screens/view/user_home_view.dart';
import '../../app/app_prefs.dart';
import '../03_create_group_screen/view/create_group_view.dart';
import '../03_create_group_screen/view_model/bloc/create_group_bloc.dart';
import '../04_group_details_screen/view/group_details_view.dart';
import '../05_user_history_screen/view/user_history_view.dart';
import '../06_pick_location_screen/view/pick_location_view.dart';

class Routes {
  static const String loginRoute = "/";
  static const String registerRoute = "/register_route";
  static const String forgotPasswordRoute = "/forgot_password_route";
  static const String userHomeRoute = "/user_home_route";
  static const String adminHomeRoute = "/admin_home_route";
  static const String createGroupRoute = "/create_group_route";
  static const String groupDetailsRoute = "/group_details_route";
  static const String userHistoryRoute = "/user_history_route";
  static const String CheckInRoute = "/check_in_route";
  static const String pickLocationRoute = "/pick_location_route";
}

class RouteGenerator {
  static AppPreferences appPreferences = instance();

  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.registerRoute:
        return MaterialPageRoute(builder: (context) => const RegisterView());
      case Routes.forgotPasswordRoute:
        return MaterialPageRoute(
          builder: (context) => const ForgotPasswordView(),
        );
      case Routes.userHomeRoute:
        return MaterialPageRoute(builder: (_) => const UserHomeView());
      case Routes.adminHomeRoute:
        return MaterialPageRoute(builder: (_) => const AdminHomeView());
      case Routes.createGroupRoute:
        return MaterialPageRoute(builder: (_) => const CreateGroupView());
      case Routes.groupDetailsRoute:
        return MaterialPageRoute(builder: (_) => const GroupDetailsView());
      case Routes.userHistoryRoute:
        return MaterialPageRoute(builder: (_) => const UserHistoryView());
      case Routes.CheckInRoute:
        return MaterialPageRoute(builder: (_) => const CheckInView());
      case Routes.pickLocationRoute:
        CreateGroupBloc createGroupBloc = settings.arguments as CreateGroupBloc;
        return MaterialPageRoute(
          builder: (_) => PickLocationView(createGroupBloc),
        );
      default:
        return unDefinedRoute();
    }
  }

  static List<Route<dynamic>> generateInitialRoutes(String initialRouteName) {
    if (!appPreferences.isUserLoggedIn()) {
      //not logged in go to login screen
      return [MaterialPageRoute(builder: (_) => const LoginView())];
    } else {
      //already logged in, then check for the role
      if (appPreferences.getUserRole() == Role.admin.name) {
        return [MaterialPageRoute(builder: (_) => const AdminHomeView())];
      } else {
        return [MaterialPageRoute(builder: (_) => const UserHomeView())];
      }
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder:
          (_) => Scaffold(
            appBar: AppBar(title: Text(tr("noRouteFound"))),
            body: Center(child: Text(tr("noRouteFound"))),
          ),
    );
  }
}
