import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:marginta/Account/functions/account_functions.dart';
import 'package:marginta/Global/color.dart';
import 'package:marginta/Global/nav.dart';
import 'package:pinput/pinput.dart';


import '../../Controller/shared_preferences.dart';
import '../../Global/utils.dart';
import '../Functions/auth_functions.dart';
import 'new_password.dart';

// ignore: must_be_immutable
class VerifyCode extends StatefulWidget {
  dynamic code, email, password, isforgot, data,firstname,lastname,phone,changepw;
  VerifyCode(
      {Key? key,
      this.code,
      this.email,
      this.password,
      this.isforgot,
      this.data,this.firstname,this.lastname,this.phone,this.changepw})
      : super(key: key);

  @override
  State<VerifyCode> createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }
  @override
  void initState() {

    // ignore: prefer_conditional_assignment
    if(widget.changepw==null){

      widget.changepw = false;
    }

    if(widget.changepw){
      widget.isforgot =false;
    
    }
    // TODO: implement initState
    super.initState();
  }

  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: borderColor),
      ),
    );

    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image: AssetImage('assets/Untitled.png'), fit: BoxFit.fill)),
      child: KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
        return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            body: ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 80, left: 1),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 80,
                          backgroundColor: Colors.white,
                          child: Image.asset(
                            'assets/logo.jpg',
                            width: 100,
                          ),
                          // backgroundImage: AssetImage(
                          //   'assets/logo.jpg',
                          // ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Verify Code',
                          style: TextStyle(
                              color: pc,
                              fontSize: 26,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          'Please enter verification code here',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.normal),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Form(
                          key: formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Directionality(
                                // Specify direction if desired
                                textDirection: TextDirection.ltr,
                                child: Pinput(
                                  controller: pinController,
                                  focusNode: focusNode,
                                  androidSmsAutofillMethod:
                                      AndroidSmsAutofillMethod
                                          .smsUserConsentApi,
                                  listenForMultipleSmsOnAndroid: true,
                                  defaultPinTheme: defaultPinTheme,
                                  validator: (value) {
                                    return value == widget.code
                                        ? null
                                        : 'Pin is incorrect';
                                  },
                                  // onClipboardFound: (value) {
                                  //   debugPrint('onClipboardFound: $value');
                                  //   pinController.setText(value);
                                  // },
                                  hapticFeedbackType:
                                      HapticFeedbackType.lightImpact,
                                  onCompleted: (pin) {
                                    debugPrint('onCompleted: $pin');
                                  },
                                  onChanged: (value) {
                                    debugPrint('onChanged: $value');
                                  },
                                  cursor: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 9),
                                        width: 22,
                                        height: 1,
                                        color: focusedBorderColor,
                                      ),
                                    ],
                                  ),
                                   focusedPinTheme: defaultPinTheme.copyWith(
                                    decoration:
                                        defaultPinTheme.decoration!.copyWith(
                                      borderRadius: BorderRadius.circular(5),
                                      border:
                                          Border.all(color: focusedBorderColor),
                                    ),
                                  ),
                                 
                                  submittedPinTheme: defaultPinTheme.copyWith(
                                    decoration:
                                        defaultPinTheme.decoration!.copyWith(
                                      color: fillColor,
                                      borderRadius: BorderRadius.circular(5),
                                      border:
                                          Border.all(color: focusedBorderColor),
                                    ),
                                  ),
                                  errorPinTheme: defaultPinTheme.copyBorderWith(
                                    border: Border.all(color: Colors.redAccent),
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () async {
                                  focusNode.unfocus();
                                  formKey.currentState!.validate();

                                  await AuthFunctions()
                                      .sendEmail(
                                          'template_3cpr88s',
                                          widget.email,
                                          widget.password,
                                          context,
                                          resend: true,
                                          data: widget.data)
                                      .then((value) => {
                                            widget.code = value,
                                            setState(() {})
                                          });

                                  Fluttertoast.showToast(
                                      msg: 'Email resend successfully');
                                },
                                child: const Text('Resend'),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal:48.0),
                          child: BouncingWidget(
                            duration: const Duration(milliseconds: 100),
                            scaleFactor: 1.5,
                            onPressed: () async {
                              isloading = true;
                              setState(() {});

                              if(widget.firstname==null){

if (widget.isforgot) {
                                navandThen(context,
                                     NewPassword(data: widget.data), false);
                              }else if(widget.changepw){
                                                var userid =     await  PrefManager().get('user','');

                                // ignore: use_build_context_synchronously
                                await AuthFunctions().updatepasswords(context, widget.email, widget.password, userid);



                              } else {
                                await AuthFunctions().signup(
                                    widget.email, widget.password, context);
                              }
                              }else{
                var userid =     await  PrefManager().get('user','');

                                // ignore: use_build_context_synchronously
                                await AuthFunctions().updatepassword(context, widget.email, widget.password, userid);

                                 // ignore: use_build_context_synchronously
                                 await AccountFunctions().updatesettings(context, widget.firstname, widget.lastname, widget.email,widget.phone,userid);
                              }
                              

                              isloading = false;
                              setState(() {});
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: const Color(0xffFF2F68),
                                  borderRadius: BorderRadius.circular(5)),
                              height: 63,
                              width: 250,
                              child: Center(
                                child: isloading
                                    ?     spinkit
                                    : const Text(
                                        'Verify',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    )),
              ],
            ));
      }),
    );
  }
}
