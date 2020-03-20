import 'package:flutter/material.dart';
import 'package:international_phone_input/international_phone_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './services/auth.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  String phoneNumber;
  String phoneIsoCode;
  bool visible = false;
  String confirmedNumber = '';
  String verificationId = '';
  bool codeTimeout = false;
  bool _verificationFailed = false;
  String status = '';
  String vcode = '';

  AuthService auth = AuthService();
  FirebaseAuth _auth = AuthService().getAuth();

  void codeSent ( String _verificationId, [int forceResendingToken]) {

    setState(() {
      
      verificationId = _verificationId;

      print('code cent');
      print(verificationId);


    });

  }

  void verificationFailed (AuthException authException) {

    setState(() {

      _verificationFailed = true;

      print('verification failed');
      print(authException.toString());


    //   status = '${authException.message}';

    //   print("Error message: " + status);
    //   if (authException.message.contains('not authorized'))
    //     status = 'Something has gone wrong, please try later';
    //   else if (authException.message.contains('Network'))
    //     status = 'Please check your internet connection and try again';
    //   else
    //     status = 'Something has gone wrong, please try later';
    });
  }

  void codeAutoRetrievalTimeout(String verificationId) {
    
    setState(() {
      
      verificationId = verificationId;

      codeTimeout = true;

      print('retrieval timeout');


    });

  }

  void verificationCompleted (AuthCredential _authCredential) {
    // setState(() {
    //   status = 'Auto retrieving verification code';
    // });

      _auth
        .signInWithCredential(_authCredential)
        .then((AuthResult value) {
          
          if (value.user != null) {
            
            setState(() {
            
              status = 'Authentication successful';
            
            });

            auth.setUser(value.user);
            
            // onAuthenticationSuccessful();

          } else {
            
            setState(() {
            
              status = 'Invalid code/invalid authentication';
            
            });
            
          }

        }).catchError((error) {

          setState(() {
          
            status = 'Something has gone wrong, please try later';
          
          });

        });
  }


  void onPhoneNumberChange(
      String number,
      String internationalizedPhoneNumber,
      String isoCode
  ) {
    print(internationalizedPhoneNumber);
    setState(() {
      phoneNumber = internationalizedPhoneNumber;
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
            Text('Signin to AkokoMarket 2', style: TextStyle(
                color: Colors.black,
                fontSize: 26,
                fontWeight: FontWeight.w900
              ),
            ),
            SizedBox(height: 100),
            (verificationId.isNotEmpty) ? TextField(
              decoration: InputDecoration(
                labelText: "Enter 6 digit verification code"
              ),
              onChanged: (text) {
                
                setState(() {
                  vcode = text;
                });

              },
            ): InternationalPhoneInput(
              onPhoneNumberChange: onPhoneNumberChange,
              initialPhoneNumber: phoneNumber,
              initialSelection: phoneIsoCode,
              enabledCountries: ['+233', '+1'],
              labelText: "Phone Number",
            ),
            SizedBox(height: 30),
            RaisedButton(
              onPressed: () async {

                if (verificationId.isNotEmpty) {

                  final _authCredential = PhoneAuthProvider.getCredential(verificationId: verificationId, smsCode: vcode);

                  await _auth.signInWithCredential(_authCredential);

                  // auth.setUser(user);
// 
                  // print(user);
                  print(vcode);
                  print(verificationId);

                } else {

                  await auth.signInPhone(
                    phoneNumber,
                    this.codeSent,
                    this.codeAutoRetrievalTimeout,
                    this.verificationFailed,
                    this.verificationCompleted
                  );

                }

              },
              child: Text((verificationId.isNotEmpty) ? 'Continue' : 'Sign in / Sign up')
            ),
            SizedBox(height: 30),
            RaisedButton(
              onPressed: () async {

                await auth.signInWithGoogle();

              },
              child: Text('Sign in with Google')
            ),
            SizedBox(height: 30),
            RaisedButton(
              onPressed: () async {

                await auth.signInWithFacebook();

              },
              child: Text('Sign in with Facebook')
            ),
        ],
      ),
    );
  }
}