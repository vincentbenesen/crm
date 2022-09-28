import 'package:crm/Views/searched_leads.dart';
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
      page: () => const Leads(),
      binding: ControllerBinding(),
      transition: Transition.noTransition,
      middlewares: [RouteAccessService()],
    ),
    GetPage(
      name: "/SearchedLeads",
      page: () => const SearchedLeads(),
      binding: ControllerBinding(),
      transition: Transition.noTransition,
      middlewares: [RouteAccessService()],
    ),
    GetPage(
      name: "/Panel",
      page: () => const Panel(),
      binding: ControllerBinding(),
      transition: Transition.noTransition,
      middlewares: [RouteAccessService()],
    ),
    GetPage(
      name: "/LeadDetails",
      page: () => const LeadDetails(),
      arguments: [],
      binding: ControllerBinding(),
      transition: Transition.noTransition,
      middlewares: [RouteAccessService()],
    ),
    GetPage(
      name: "/EditLeads",
      page: () => const EditLeads(),
      binding: ControllerBinding(),
      transition: Transition.noTransition,
      middlewares: [RouteAccessService()],
    ),
    GetPage(
      name: "/Login",
      page: () => const LoginPage(),
      binding: ControllerBinding(),
    ),
  ];
}
