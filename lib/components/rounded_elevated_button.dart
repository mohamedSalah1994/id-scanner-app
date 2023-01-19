import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:id_scanner/components/show_snack_bar.dart';
import 'package:id_scanner/controllers/internet_connection_controller.dart';

class RoundedElevatedButton extends StatelessWidget {
  const RoundedElevatedButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  final Function() onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InternetConnectionController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.only(right: 10),
          child: ElevatedButton(
            onPressed: controller.online
                ? onPressed
                : () async {
                    showNoInternetConnectionSnackBar();

                    await controller.checkConnection();
                  },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              shape: const StadiumBorder(),
              primary: controller.online ? Colors.black : Colors.grey.shade400,
            ),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}
