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
        listener: (BuildContext context, UserState state) {
          if (state is LoggedState) {
            // Navigate to the home page when login is successful
            Navigator.pushNamed(context, '/home_page');
          } else if (state is ErrorState) {
            // Show an error message when login fails
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          // Show a loading indicator when in LoadingState
          if (state is LoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                const SizedBox(height: 100),
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Email',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      decoration: BoxDecoration(
                        color: const Color(0xffF3F3F3),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                        child: TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            contentPadding:
                                EdgeInsetsDirectional.only(start: 4),
                            hintStyle: TextStyle(color: Color(0xffC1C1C1)),
                            border: InputBorder.none,
                            isDense: true,
                            hintText: 'ex: jon.smith@email.com',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Password',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      decoration: BoxDecoration(
                        color: const Color(0xffF3F3F3),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                        child: TextFormField(
                          controller: _passwordController,
                          decoration: const InputDecoration(
                            contentPadding:
                                EdgeInsetsDirectional.only(start: 4),
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
                      onPressed: () {
                        if (_emailController.text.isEmpty ||
                            _passwordController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Please Provide Required Fields')),
                          );
                        } else if (_passwordController.text.length < 6) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Password length cannot be less than 6')),
                          );
                        } else {
                          // Trigger the login event when the user presses "SIGN IN"
                          context.read<UserBloc>().add(LoginEvent(
                                email: _emailController.text,
                                password: _passwordController.text,
                              ));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff3F51F3),
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
                            onTap: () {
                              Navigator.pushNamed(context, '/signup_page');
                            },
                            child: const Text(
                              'SIGN UP',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
