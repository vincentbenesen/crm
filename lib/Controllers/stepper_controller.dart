import 'package:crm/Controllers/record_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Widgets/Text_Field.dart';

class StepperController extends GetxController {
  final currentStep = 0.obs;

  void increment() {
    if (currentStep.value != 3) {
      currentStep.value++;
    }
  }

  void decrement() {
    if (currentStep.value > 0) {
      currentStep.value--;
    }
  }

  List<Step> getSteps(Widget nameContainer, Widget addressContainer,
      Widget contactContainer, Widget additionalInfoContainer) {
    return [
      Step(
        state: currentStep.value > 0 ? StepState.complete : StepState.indexed,
        title: Text(
          'Full Name',
          style: GoogleFonts.rubik(fontSize: 20),
        ),
        content: nameContainer,
        isActive: currentStep.value >= 0,
      ),
      Step(
        state: currentStep.value > 1 ? StepState.complete : StepState.indexed,
        title: Text('Address', style: GoogleFonts.rubik(fontSize: 20)),
        content: addressContainer,
        isActive: currentStep.value >= 1,
      ),
      Step(
        state: currentStep.value > 2 ? StepState.complete : StepState.indexed,
        title:
            Text('Contact Information', style: GoogleFonts.rubik(fontSize: 20)),
        content: contactContainer,
        isActive: currentStep.value >= 2,
      ),
      Step(
        title: Text('Additional Information',
            style: GoogleFonts.rubik(fontSize: 20)),
        content: additionalInfoContainer,
        isActive: currentStep.value >= 3,
      ),
    ];
  }
}
