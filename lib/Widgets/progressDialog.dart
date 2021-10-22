import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProgressDialog extends StatelessWidget {
  String mensaje;
  ProgressDialog({required this.mensaje});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        margin: EdgeInsets.all(10.0),
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.white),
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: [
              SizedBox(
                width: 6.0,
              ),
              CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(Colors.amber.shade700),
              ),
              SizedBox(
                width: 26.0,
              ),
              Text(
                mensaje,
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
