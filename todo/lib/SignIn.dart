import 'package:flutter/material.dart';
import 'package:international_phone_input/international_phone_input.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  String phoneNumber;
  String phoneIsoCode;
  bool visible = false;
  String confirmedNumber = '';

  void onPhoneNumberChange(
      String number,
      String internationalizedPhoneNumber,
      String isoCode
  ) {
    print(number);
    setState(() {
      phoneNumber = number;
      phoneIsoCode = isoCode;
    });
  }

  onValidPhoneNumber(
      String number,
      String internationalizedPhoneNumber,
      String isoCode
  ) {
    setState(() {
      visible = true;
      confirmedNumber = internationalizedPhoneNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 0.0, bottom: 0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
            Text('Signin to AkokoMarket', style: TextStyle(
                color: Colors.black,
                fontSize: 26,
                fontWeight: FontWeight.w900
              ),
            ),
            SizedBox(height: 100),
            InternationalPhoneInput(
              onPhoneNumberChange: onPhoneNumberChange,
              initialPhoneNumber: phoneNumber,
              initialSelection: phoneIsoCode,
              enabledCountries: ['+233', '+1'],
              labelText: "Phone Number",
            ),
            SizedBox(height: 30),
            RaisedButton(
              onPressed: () {},
              child: Text('Sign in / Sign up')
            )
        ],
      ),
    );
  }
}