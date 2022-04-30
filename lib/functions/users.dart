import 'package:flutter/material.dart';

final _formKey = GlobalKey<FormState>();
RegExp userRegex = RegExp(r'^[a-z_]([a-z0-9_-]{0,31}|[a-z0-9_-]{0,30}\$)$');
Widget users(setState, enableSudo, setPass, setConfirmPass, clearPass,
    confirmPassword, setUsername, username, next) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const SizedBox(height: 40),
      const Text(
        'Create a new user',
        style: TextStyle(
            fontSize: 60,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 169, 0, 255)),
      ),
      const SizedBox(height: 20),
      Container(
        height: 125,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey,
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 2,
              offset: Offset(-2, 3),
            ),
          ],
        ),
        child: const Icon(
          Icons.person,
          size: 125,
        ),
      ),
      const SizedBox(width: 10),
      Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.always,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 20),
            SizedBox(
              width: 600,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black),
                  color: const Color.fromARGB(255, 30, 30, 30),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 2,
                      offset: Offset(-2, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.always,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Username',
                        labelStyle: TextStyle(color: Colors.white),
                        hintText: 'Enter your username',
                        hintStyle: TextStyle(color: Colors.white),
                        iconColor: Colors.white,
                        focusColor: Color.fromARGB(100, 169, 0, 255),
                        hoverColor: Colors.blue,
                        prefixIconColor: Colors.white,
                        suffixIconColor: Colors.white,
                      ),
                      style: const TextStyle(color: Colors.white),
                      onChanged: (String? value) {
                        setUsername(value);
                      },
                      validator: (String? value) {
                        return (value != "" &&
                                value != null &&
                                !userRegex.hasMatch(value))
                            ? 'Bad username, may not contain spaces, uppercase, or special characters'
                            : null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      //obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.white),
                        hintText: 'Enter your password',
                        hintStyle: TextStyle(color: Colors.white),
                        iconColor: Colors.white,
                        focusColor: Color.fromARGB(100, 169, 0, 255),
                        hoverColor: Colors.blue,
                        prefixIconColor: Colors.white,
                        suffixIconColor: Colors.white,
                      ),
                      obscureText: true,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      onChanged: (String? value) {
                        setPass(value);
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      //obscureText: true,
                      autovalidateMode: AutovalidateMode.always,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Repeat password',
                        labelStyle: TextStyle(color: Colors.white),
                        hintText: 'Repeat your password',
                        hintStyle: TextStyle(color: Colors.white),
                        iconColor: Colors.white,
                        focusColor: Color.fromARGB(100, 169, 0, 255),
                        hoverColor: Colors.blue,
                        prefixIconColor: Colors.white,
                        suffixIconColor: Colors.white,
                      ),
                      obscureText: true,

                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      onChanged: (String? value) {
                        setConfirmPass(value);
                      },
                      validator: (String? value) {
                        return (value != clearPass)
                            ? 'Password does not match'
                            : null;
                      },
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.black45),
                        color: const Color.fromARGB(100, 30, 30, 30),
                      ),
                      child: Tooltip(
                        message:
                            'Allows the user to gain root access using sudo',
                        child: CheckboxListTile(
                          title: const Text('Enable sudo for user',
                              style: TextStyle(color: Colors.white)),
                          value: enableSudo,
                          onChanged: (bool? value) {
                            setState(value!);
                          },
                          secondary: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 13),
                            child: const Text(
                              '#',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    //const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
      const SizedBox(width: 60),
      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                children: [
                  TextButton(
                    onPressed: () {
                      next();
                    },
                    child: const Text(
                      'Next',
                    ),
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: const Color.fromARGB(255, 169, 0, 255),
                      minimumSize: const Size(100, 50),
                      padding: const EdgeInsets.all(10),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
              const SizedBox(width: 30),
            ],
          ),
          const SizedBox(height: 7)
        ],
      ),
    ],
  );
}
