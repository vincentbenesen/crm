import 'package:crm/Views/filtered_leads.dart';
import 'package:crm/Views/searched_leads.dart';
import 'package:crm/Views/signup_page.dart';
import 'package:crm/services/routeAccess.dart';
import 'package:get/get.dart';

import 'package:crm/Bindings/controller_binding.dart';
import 'package:crm/Views/edit_leads.dart';
import 'package:crm/Views/lead_details.dart';
import 'package:crm/Views/leads.dart';
import 'package:crm/Views/panel.dart';
import 'package:crm/Views/login_page.dart';

class Routes {
  static String getInitialRoute() => '/Leads';
  static String loginPage() => '/Login';

  static List<GetPage> routes = [
    GetPage(
      name: "/Leads",
      page: () => Leads(),
      binding: ControllerBinding(),
      transition: Transition.noTransition,
      middlewares: [RouteAccessService()],
    ),
    GetPage(
      name: "/SearchedLeads",
      page: () => SearchedLeads(),
      binding: ControllerBinding(),
      transition: Transition.noTransition,
      middlewares: [RouteAccessService()],
    ),
    GetPage(
      name: "/FilteredLeads",
      page: () => FilteredLeads(),
      binding: ControllerBinding(),
      transition: Transition.noTransition,
      middlewares: [RouteAccessService()],
    ),
    GetPage(
      name: "/Panel",
      page: () => Panel(),
      binding: ControllerBinding(),
      transition: Transition.noTransition,
      middlewares: [RouteAccessService()],
    ),
    GetPage(
      name: "/LeadDetails",
      page: () => LeadDetails(),
      arguments: [],
      binding: ControllerBinding(),
      transition: Transition.noTransition,
      middlewares: [RouteAccessService()],
    ),
    GetPage(
      name: "/EditLeads",
      page: () => EditLeads(),
      binding: ControllerBinding(),
      transition: Transition.noTransition,
      middlewares: [RouteAccessService()],
    ),
    GetPage(
      name: "/Login",
      page: () => LoginPage(),
      transition: Transition.noTransition,
      binding: ControllerBinding(),
    ),
    GetPage(
      name: "/SignUp",
      page: () => SignUpPage(),
      transition: Transition.noTransition,
      binding: ControllerBinding(),
    ),
  ];
}
