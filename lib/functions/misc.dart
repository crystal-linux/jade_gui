import 'package:flutter/material.dart';
import 'package:adwaita_icons/adwaita_icons.dart';
import 'package:flutter_svg/svg.dart';

final _formKey = GlobalKey<FormState>();
RegExp hostnameRegex = RegExp(
    r'^(?=.{1,255}$)[0-9A-Za-z](?:(?:[0-9A-Za-z]|-){0,61}[0-9A-Za-z])?(?:\.[0-9A-Za-z](?:(?:[0-9A-Za-z]|-){0,61}[0-9A-Za-z])?)*\.?$');
Widget misc(
    setIpv6,
    setHostname,
    setTimeshift,
    ipv6,
    hostname,
    timeshift,
    setRootUser,
    enableRoot,
    setRootPass,
    setConfirmRootPass,
    rootPass,
    confirmRootPass,
    enableFlatpak,
    setFlatpak,
    setKernel,
    String selectedKernel,
    next) {
  bool flatpak = true;
  List<String> availableKernels = [
    "linux",
    "linux-lts",
    "linux-zen",
    "linux-hardened",
  ];
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
                            ? 'Bad Hostname, may not contain spaces, uppercase, or special characters'
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
                            "Enables the root user, who has access to everything in the system",
                        child: CheckboxListTile(
                          title: const Text('Enable root user',
                              style: TextStyle(color: Colors.white)),
                          value: enableRoot,
                          onChanged: (bool? value) {
                            setRootUser(value!);
                          },
                          secondary: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 13),
                            child: const Text(
                              '#',
                              textAlign: TextAlign.center,
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
                    Visibility(
                        child: const SizedBox(height: 10), visible: enableRoot),
                    Visibility(
                      visible: enableRoot,
                      child: TextFormField(
                        //obscureText: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password for root user',
                          labelStyle: TextStyle(color: Colors.white),
                          hintText: 'Password for the root user',
                          hintStyle: TextStyle(color: Colors.white),
                          iconColor: Colors.white,
                          focusColor: Color.fromARGB(100, 169, 0, 255),
                          hoverColor: Colors.blue,
                          prefixIconColor: Colors.white,
                          suffixIconColor: Colors.white,
                        ),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        obscureText: true,

                        onChanged: (String? value) {
                          setRootPass(value);
                        },
                      ),
                    ),
                    Visibility(
                        child: const SizedBox(height: 10), visible: enableRoot),
                    Visibility(
                      visible: enableRoot,
                      child: TextFormField(
                        //obscureText: true,
                        autovalidateMode: AutovalidateMode.always,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Repeat root password',
                          labelStyle: TextStyle(color: Colors.white),
                          hintText: 'Repeat root password',
                          hintStyle: TextStyle(color: Colors.white),
                          iconColor: Colors.white,
                          focusColor: Color.fromARGB(100, 169, 0, 255),
                          hoverColor: Colors.blue,
                          prefixIconColor: Colors.white,
                          suffixIconColor: Colors.white,
                        ),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        obscureText: true,

                        onChanged: (String? value) {
                          setConfirmRootPass(value);
                        },
                        validator: (String? value) {
                          return (value != rootPass)
                              ? 'Password does not match'
                              : null;
                        },
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
                      child: Tooltip(
                        message: "Enables ipv6",
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
                            "Enables timeshift to automatically make backups",
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
                            child:
                                const Icon(Icons.restore, color: Colors.black),
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
                      child: Tooltip(
                        message: "Installs flatpak and enables flathub",
                        child: CheckboxListTile(
                          title: const Text('Enable flatpak',
                              style: TextStyle(color: Colors.white)),
                          value: enableFlatpak,
                          onChanged: (bool? value) {
                            setFlatpak(value!);
                          },
                          secondary: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 13),
                            child: const AdwaitaIcon(
                              AdwaitaIcons.package_x_generic,
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
                        child: Tooltip(
                            message: "Installs a different kernel",
                            child: Row(
                              children: [
                                const SizedBox(width: 15),
                                Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 13),
                                  child:
                                  SvgPicture.asset(
                                    'assets/tux_monochrome.svg',
                                    color: Colors.black,
                                    height: 25,
                                    width: 25,
                                    ),
                                  ),
                                const SizedBox(width: 15),
                                const Text('Kernel to install',
                                    style: TextStyle(color: Colors.white, fontSize: 17)),
                                const Spacer(),
                                DropdownButton(
                                  icon: const Icon(Icons.arrow_downward),
                                  elevation: 16,
                                  style: const TextStyle(color: Colors.deepPurple),
                                  dropdownColor: const Color.fromARGB(255, 23, 23, 23),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.deepPurpleAccent,
                                  ),
                                  value: selectedKernel,
                                  onChanged: (String? value) {
                                    setKernel(value);
                                  },
                                  items: availableKernels.map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value,
                                          style: const TextStyle(color: Colors.white)),
                                    );
                                  }).toList(),
                          ),
                              ],
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
