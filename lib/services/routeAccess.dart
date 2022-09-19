import 'package:crm/routes/routes.dart';
import 'package:crm/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// This class is used to check if the user has the access to other screens.
class RouteAccessService extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    return AuthService.instance.user.value.isNull
        ? RouteSettings(name: Routes.loginPage())
        : null;
  }
}
