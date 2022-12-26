import 'dart:async';

import 'package:authy/src/blocs/auth_bloc.dart';
import 'package:authy/src/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class AuthyAlert {
  static Future<void> showErrorDialog(
      BuildContext context, String errorMessage) async {
    final authBloc = Provider.of<AuthBloc>(context, listen: false);
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text('Error', style: TextStyle(color: Colors.white)),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text(errorMessage, style: TextStyle(color: Colors.white))
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xff464346),
                  fixedSize: const Size(180, 50),
                ),
                child: const Text('Sign Out'),
                onPressed: () {
                  authBloc.clearErrorMessage();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  static Future<void> showCodeConfirmationDialog(
      BuildContext context, AuthBloc authBloc) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text('Verify Phone Number',
                style: TextStyle(color: Colors.white)),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text(
                    'A confirmation code has been sent to your phone, enter to continue',
                    style: TextStyle(color: Colors.white),
                  ),
                  StreamBuilder<String>(
                      stream: authBloc.confirmationCode,
                      builder: (context, snapshot) {
                        return AuthyTextField(
                          onChanged: authBloc.changeConfirmationCode,
                          textInputType: TextInputType.number,
                          errorText: snapshot.error,
                        );
                      })
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xff464346),
                  fixedSize: const Size(180, 50),
                ),
                child: const Text('Sign Out'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xff464346),
                  fixedSize: const Size(180, 50),
                ),
                child: const Text('Sign Out'),
                onPressed: () => authBloc.submitSMSCode(),
              ),
            ],
          );
        });
  }

  static Future<void> showAutomaticConfirmationDialog(
      BuildContext context, AuthBloc authBloc) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text('Verified', style: TextStyle(color: Colors.white)),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text(
                      'Your phone is equipped with automated verification, you may ignore the verification text',
                      style: TextStyle(color: Colors.white))
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xff464346),
                  fixedSize: const Size(180, 50),
                ),
                child: const Text('Sign Out'),
                onPressed: () {
                  authBloc.changeShowAutomatedConfirmationDialog(false);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  static Future<void> showEmailVerifyNotice(
      BuildContext context, String email) async {
    //Default Value if no email submitted
    if (email == null) email = 'your email address';

    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text('Verified', style: TextStyle(color: Colors.white)),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text(
                      'We\'ve sent a message to $email.  Please open to verify your email address',
                      style: TextStyle(color: Colors.white))
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xff464346),
                  fixedSize: const Size(180, 50),
                ),
                child: const Text('Sign Out'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
