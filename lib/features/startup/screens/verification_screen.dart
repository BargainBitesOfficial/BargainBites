import 'dart:async';
import 'package:bargainbites/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerificationScreen extends StatefulWidget {
  //const VerificationScreen({super.key});

  final String email; // Email address to be displayed
  const VerificationScreen({super.key, required this.email});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  TextEditingController textEditingController = TextEditingController();
  bool hasError = false;
  String currentText = "";

  int remainingSeconds = 60; // Initial countdown time in seconds
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        setState(() {
          remainingSeconds--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            //Navigator.of(context).pop();
          },
        ),
        title: const Text('Create Your Account'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: TColors.bBlack,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 30),
            const Text(
              'Enter code',
              style: TextStyle(fontSize: 22, fontFamily: 'Poppins', fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            // Text(
            //   'We’ve sent an email with an activation code to ${widget.email}',
            //   style: TextStyle(fontSize: 14, fontFamily: 'Poppins'),
            // ),
            RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  color: TColors.bBlack,
                ),
                children: [
                  const TextSpan(text: 'We’ve sent an email with an activation code to '),
                  TextSpan(
                    text: widget.email,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            PinCodeTextField(
              appContext: context,
              length: 5,
              obscureText: false,
              keyboardType: TextInputType.number,
              textStyle: const TextStyle(fontSize: 22, fontFamily: 'Poppins'),
              animationType: AnimationType.fade,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(15),
                fieldHeight: 55,
                fieldWidth: 55,
                activeFillColor: hasError ? Colors.red.shade100 : TColors.bWhite,
                inactiveFillColor: TColors.bWhite,
                selectedFillColor: TColors.bWhite,
                activeColor: hasError ? TColors.primaryErr : TColors.bGrey,
                inactiveColor: TColors.bGrey,
                selectedColor: TColors.bGrey,
                borderWidth: 1,
                errorBorderColor: TColors.bRed,
              ),
              animationDuration: const Duration(milliseconds:200),
              backgroundColor: Colors.transparent,
              enableActiveFill: true,
              controller: textEditingController,
              onCompleted: (v) {
                // Check if the entered code is correct
                if (v != "12345") {
                  setState(() {
                    hasError = true;
                  });
                } else {
                  setState(() {
                    hasError = false;
                  });
                  // Navigate to the next screen or perform your action
                }
              },
              onChanged: (value) {
                setState(() {
                  currentText = value;
                  hasError = false;
                });
              },
              beforeTextPaste: (text) {
                return true;
              },
            ),
            const SizedBox(height: 10),
            if (hasError)
              const Text(
                'Wrong code, please try again',
                style: TextStyle(color: TColors.primaryErr, fontSize: 14),
              ),
            const SizedBox(height: 80),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Send code again',
                  style: TextStyle(fontSize: 16, color: TColors.greyText),
                ),
                const SizedBox(width: 5),
                Text(
                  '00:${remainingSeconds.toString().padLeft(2, '0')}',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
