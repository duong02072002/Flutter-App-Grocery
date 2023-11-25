import 'package:card_swiper/card_swiper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_grocery/consts/contss.dart';
import 'package:flutter_app_grocery/consts/firebase_consts.dart';
import 'package:flutter_app_grocery/screens/auth/login.dart';
import 'package:flutter_app_grocery/screens/loading_manager.dart';
import 'package:flutter_app_grocery/services/global_methods.dart';
import 'package:flutter_app_grocery/widgets/auth_button.dart';
import 'package:flutter_app_grocery/services/utils.dart';
import 'package:flutter_app_grocery/widgets/back_widget.dart';
import 'package:flutter_app_grocery/widgets/text_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static const routeName = '/ForgetPasswordScreen';
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _emailTextController = TextEditingController();
  @override
  void dispose() {
    _emailTextController.dispose();

    super.dispose();
  }

  bool _isLoading = false;

  void _forgetPassFCT() async {
    if (_emailTextController.text.isEmpty ||
        !_emailTextController.text.contains("@")) {
      GlobalMethods.errorDialog(
          subtitle: 'Please enter a correct email address', context: context);
    } else {
      setState(() {
        _isLoading = true;
      });
      try {
        await authInstance.sendPasswordResetEmail(
            email: _emailTextController.text.toLowerCase());
        // Display success message if the password reset email is sent successfully
        GlobalMethods.errorDialog(
            subtitle: 'Vui Lòng Check Email Để Thay Đổi Mật Khẩu.',
            context: context);
      } on FirebaseException {
        GlobalMethods.errorDialog(
            subtitle: 'Email Không Tồn Tại!!!', context: context);
      } catch (error) {
        // Handle other types of errors, such as non-existent email
        GlobalMethods.errorDialog(subtitle: '$error', context: context);
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // bool _isLoading = false;
  // void _forgetPassFCT() async {
  //   if (_emailTextController.text.isEmpty ||
  //       !_emailTextController.text.contains("@")) {
  //     GlobalMethods.errorDialog(
  //         subtitle: 'Please enter a correct email address', context: context);
  //   } else {
  //     setState(() {
  //       _isLoading = true;
  //     });
  //     try {
  //       await authInstance.sendPasswordResetEmail(
  //           email: _emailTextController.text.toLowerCase());
  //       // Fluttertoast.showToast(
  //       //   msg: "An email has been sent to your email address",
  //       //   toastLength: Toast.LENGTH_LONG,
  //       //   gravity: ToastGravity.CENTER,
  //       //   timeInSecForIosWeb: 1,
  //       //   backgroundColor: Colors.grey.shade600,
  //       //   textColor: Colors.white,
  //       //   fontSize: 16.0,
  //       // );
  //     } on FirebaseException catch (error) {
  //       GlobalMethods.errorDialog(
  //           subtitle: '${error.message}', context: context);
  //       setState(() {
  //         _isLoading = false;
  //       });
  //     } catch (error) {
  //       GlobalMethods.errorDialog(subtitle: '$error', context: context);
  //       setState(() {
  //         _isLoading = false;
  //       });
  //     } finally {
  //       setState(() {
  //         GlobalMethods.errorDialog(
  //             subtitle: 'Vui Lòng Check Email Để Thay Đổi Mật Khẩu.', context: context);
  //         _isLoading = false;
  //       });
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    return Scaffold(
      // backgroundColor: Colors.blue,
      body: LoadingManager(
        isLoading: _isLoading,
        child: Stack(
          children: [
            Swiper(
              itemBuilder: (BuildContext context, int index) {
                return Image.asset(
                  Constss.authImagesPaths[index],
                  fit: BoxFit.cover,
                );
              },
              autoplay: true,
              itemCount: Constss.authImagesPaths.length,

              // control: const SwiperControl(),
            ),
            Container(
              color: Colors.black.withOpacity(0.7),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  const BackWidget(),
                  const SizedBox(
                    height: 20,
                  ),
                  TextWidget(
                    text: 'Forget password',
                    color: Colors.white,
                    textSize: 30,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: _emailTextController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: 'Email address',
                      hintStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  AuthButton(
                    buttonText: 'Reset now',
                    fct: () {
                      _forgetPassFCT();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
