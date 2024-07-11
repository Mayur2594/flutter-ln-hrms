import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:ln_hrms/controllers/controller.authentication.dart';
import 'package:ln_hrms/controllers/controller.common.dart';

class ForgotPasssowrdView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(AuthenticationController());
    // ignore: non_constant_identifier_names
    final AuthCtrl = AuthenticationController();
    final CommonCtrl = CommonController();

    return Scaffold(body: Container());
  }
}
