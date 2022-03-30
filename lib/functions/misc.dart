import 'package:flutter/material.dart';

final _formKey = GlobalKey<FormState>();
RegExp hostnameRegex = RegExp(
    r'^(?=.{1,255}$)[0-9A-Za-z](?:(?:[0-9A-Za-z]|-){0,61}[0-9A-Za-z])?(?:\.[0-9A-Za-z](?:(?:[0-9A-Za-z]|-){0,61}[0-9A-Za-z])?)*\.?$');
Widget misc(
    setIpv6, setHostname, setTimeshift, ipv6, hostname, timeshift, next) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      //const SizedBox(height: 2),
      const Text(
        'Misc Settings',
        style: TextStyle(
            fontSize: 60,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 169, 0, 255)),
      ),
      const SizedBox(height: 90),
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
                        labelText: 'Hostname',
                        labelStyle: TextStyle(color: Colors.white),
                        hintText: 'Enter your hostname',
                        hintStyle: TextStyle(color: Colors.white),
                        iconColor: Colors.white,
                        focusColor: Color.fromARGB(100, 169, 0, 255),
                        hoverColor: Colors.blue,
                        prefixIconColor: Colors.white,
                        suffixIconColor: Colors.white,
                      ),
                      style: const TextStyle(color: Colors.white),
                      onChanged: (String? value) {
                        setHostname(value);
                      },
                      validator: (String? value) {
                        return (value != "" &&
                                value != null &&
                                !hostnameRegex.hasMatch(value))
                            ? 'Bad username, may not contain spaces, uppercase, or special characters'
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
                      child: CheckboxListTile(
                        title: const Text('Enable ipv6',
                            style: TextStyle(color: Colors.white)),
                        value: ipv6,
                        onChanged: (bool? value) {
                          setIpv6(value!);
                        },
                        secondary: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 13),
                          child: const Text(
                            'v6',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.black45),
                        color: const Color.fromARGB(100, 30, 30, 30),
                      ),
                      child: CheckboxListTile(
                        title: const Text('Enable timeshift',
                            style: TextStyle(color: Colors.white)),
                        value: timeshift,
                        onChanged: (bool? value) {
                          setTimeshift(value!);
                        },
                        secondary: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 13),
                          child: const Icon(Icons.restore, color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
      const SizedBox(height: 90),
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
