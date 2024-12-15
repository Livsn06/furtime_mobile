import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/_utils.dart';
import 'build_form.dart';

void showLoadingModal({label, text}) {
  Get.defaultDialog(
    barrierDismissible: false,
    title: "$label",
    content: Column(
      children: [
        const CircularProgressIndicator(
          color: Colors.black,
          strokeWidth: 1,
        ),
        Text('$text'),
        space(height: 20),
      ],
    ),
  );
}

void showSuccessModal({label, text}) {
  Get.defaultDialog(
    barrierDismissible: false,
    contentPadding: const EdgeInsets.all(20),
    title: "$label",
    content: Column(
      children: [
        Text('$text'),
        space(height: 20),

        //
        customButton(
          label: "OK",
          onPress: () => Get.close(1),
        ),
      ],
    ),
  );
}

void showFailedModal({label, text}) {
  Get.defaultDialog(
    barrierDismissible: false,
    contentPadding: const EdgeInsets.all(20),
    title: "$label",
    content: Column(
      children: [
        Text('$text'),
        space(height: 20),

        //
        customButton(
          label: "Retry",
          onPress: () => Get.close(1),
          color: Colors.red,
        ),
      ],
    ),
  );
}
