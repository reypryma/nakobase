 import 'package:flutter/material.dart';

void showSnackBar(ScaffoldMessengerState? state, message) {
  if (state != null) {
  state.showSnackBar(SnackBar(content: Text(message)));
  }
}

 // Tools.showSnackBar(ScaffoldMessenger.of(context),
 // S.of(context).couponHasBeenSavedSuccessfully);