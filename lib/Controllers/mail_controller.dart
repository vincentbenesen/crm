import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:crm/Models/mail.dart';
import 'package:crm/constant.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MailController extends GetxController {
  final message = Mail().obs;
  GlobalKey<FormState> mailFormKey = GlobalKey<FormState>();

  Future sendMail() async {
    final url = Uri.parse(kPostUrl);
    final response = await http.post(
      url,
      headers: {'Content-Type': kContentType},
      body: json.encode({
        'service_id': kServiceId,
        'template_id': kTemplateId,
        'user_id': kUserId,
        'template_params': {
          'user_email': message.value.email,
          'user_subject': message.value.subject,
          'user_firstName': message.value.firstName,
          'user_lastName': message.value.lastName,
          'user_message': message.value.message
        }
      }),
    );

    print(response.body);
  }
}
