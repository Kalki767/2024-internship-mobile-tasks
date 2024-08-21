import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc/user_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    return Scaffold(
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          late String email;
          late String password;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                Image.asset('assets/logo.png', width: 144, height: 50),
                const Padding(
                  padding: EdgeInsets.only(top: 45.0, bottom: 45),
                  child: Text(
                    'Sign into your account',
                    style:
                        TextStyle(fontSize: 26.72, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 30),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text(
                    'Email',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                        color: const Color(0xffF3F3F3),
                        borderRadius: BorderRadius.circular(6)),
                    child: Center(
                      child: TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsetsDirectional.only(start: 4),
                          hintStyle: TextStyle(color: Color(0xffC1C1C1)),
                          border: InputBorder.none,
                          isDense: true,
                          hintText: 'ex: jon.smith@email.com',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Password',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                        color: const Color(0xffF3F3F3),
                        borderRadius: BorderRadius.circular(6)),
                    child: Center(
                      child: TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsetsDirectional.only(start: 4),
                          hintStyle: TextStyle(color: Color(0xffC1C1C1)),
                          border: InputBorder.none,
                          isDense: true,
                          hintText: '*******',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff3F51F3),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 120, vertical: 20),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                    ),
                    child: const Text(
                      'SIGN IN',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 100),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      children: [
                        const Text(
                          'Don’t have an account?',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey),
                        ),
                        GestureDetector(
                          child: const Text(
                            'SIGN UP',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.blue),
                          ),
                        )
                      ],
                    ),
                  ),
                ]),
              ],
            ),
          );
        },
      ),
    );
  }
}
