import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc/user_bloc.dart';
import '../widgets/reusable_button.dart';
import '../widgets/reusable_text_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.navigate_before)),
              Image.asset(
                "assets/logo.png",
                width: 78,
                height: 25,
              )
            ],
          ),
        ),
      ),
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          print(state);
          if (state is RegisteredState) {
            Navigator.pushNamed(context, '/login_page');
          } else if (state is ErrorState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: reusableText(
                          "Create your account", FontWeight.w600, 26)),
                  reusableText("Name", FontWeight.w400, 16),
                  ReusableTextField(
                    hint: "ex: jon smith",
                    textEditingController: nameEditingController,
                    textInputType: TextInputType.name,
                  ),
                  reusableText("Email", FontWeight.w400, 16),
                  ReusableTextField(
                    hint: "ex: jon.smith@email.com",
                    textEditingController: emailEditingController,
                    textInputType: TextInputType.emailAddress,
                  ),
                  reusableText("Password", FontWeight.w400, 16),
                  ReusableTextField(
                    hint: "**********",
                    textEditingController: passwordEditingController,
                    textInputType: TextInputType.visiblePassword,
                  ),
                  reusableText("Confirm password", FontWeight.w400, 16),
                  ReusableTextField(
                    hint: "**********",
                    textEditingController: confirmPasswordController,
                    textInputType: TextInputType.visiblePassword,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: true,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        onChanged: (value) {},
                      ),
                      RichText(
                        text: const TextSpan(
                            text: "I understood the ",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Colors.grey),
                            children: [
                              TextSpan(
                                  text: "terms & policy.",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff3F51F3)))
                            ]),
                      ),
                    ],
                  ),
                  GestureDetector(
                      onTap: () {
                        if (nameEditingController.text.isEmpty ||
                            emailEditingController.text.isEmpty ||
                            passwordEditingController.text.isEmpty ||
                            confirmPasswordController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Please provide all required fields')));
                        } else if (nameEditingController.text.length <= 3) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Name must be longer than 3 characters')));
                        } else if (passwordEditingController.text.length < 6) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text(
                                  'Password must be at least 6 characters long')));
                        } else if (passwordEditingController.text !=
                            confirmPasswordController.text) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Passwords do not match')));
                        } else {
                          final userBloc = BlocProvider.of<UserBloc>(context);

                          print("Name: ${nameEditingController.text}");
                          print("Email: ${emailEditingController.text}");
                          print("Password: ${passwordEditingController.text}");

                          userBloc.add(SignupEvent(
                              name: nameEditingController.text,
                              email: emailEditingController.text,
                              password: passwordEditingController.text));
                        }
                      },
                      child: const ReusableButton(lable: "SIGN UP")),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: RichText(
                        text: TextSpan(
                            text: "Have an account? ",
                            style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Colors.grey),
                            children: [
                              TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => Navigator.pushNamed(
                                        context, "/login_page"),
                                  text: "SIGN IN",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff3F51F3)))
                            ]),
                      ),
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

Text reusableText(String text, FontWeight wight, double size,
    [Color color = Colors.black]) {
  return Text(
    text,
    overflow: TextOverflow.clip,
    style: TextStyle(fontWeight: wight, fontSize: size, color: color),
  );
}
