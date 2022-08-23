import 'package:get/get.dart';

import 'package:crm/Bindings/controller_binding.dart';
import 'package:crm/Views/edit_leads.dart';
import 'package:crm/Views/lead_details.dart';
import 'package:crm/Views/leads.dart';
import 'package:crm/Views/panel.dart';

class Routes {
  static String getInitialRoute() => '/Leads';

  static List<GetPage> routes = [
    GetPage(
        name: "/Leads",
        page: () => const Leads(),
        binding: ControllerBinding(),
        transition: Transition.fade),
    GetPage(
        name: "/Panel",
        page: () => const Panel(),
        binding: ControllerBinding(),
        transition: Transition.fade),
    GetPage(
        name: "/LeadDetails",
        page: () => const LeadDetails(),
        arguments: [],
        binding: ControllerBinding(),
        transition: Transition.fade),
    GetPage(
        name: "/EditLeads",
        page: () => const EditLeads(),
        binding: ControllerBinding(),
        transition: Transition.fade)
  ];
}
