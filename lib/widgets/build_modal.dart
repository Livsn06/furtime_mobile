import 'dart:io';

import 'package:flutter/material.dart';
import 'package:furtime/utils/_constant.dart';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';

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

void showSuccessModal({label, text, Function()? onPress}) {
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
          onPress: onPress,
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

void showConfirmModal(context, {label, text, Function()? onConfirm}) {
  QuickAlert.show(
    context: context,
    type: QuickAlertType.confirm,
    title: label,
    confirmBtnText: 'Confirm',
    cancelBtnText: 'Cancel',
    onConfirmBtnTap: onConfirm,
    onCancelBtnTap: () {
      Navigator.of(context).pop();
    },
  );
}

void showImageModal(image) {
  Get.defaultDialog(
    title: "",
    content: SizedBox(
      height: SCREEN_SIZE.value.width / 1.5,
      width: SCREEN_SIZE.value.width / 1.5,
      child: Image.file(
        File(image!.path),
        fit: BoxFit.cover,
      ),
    ),
  );
}
