import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'login_page_view_model.dart';

class LoginPageView extends ConsumerWidget {
  static const routeName = '/';

  const LoginPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var vm = ref.watch(LoginPageViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("Login page"),
      ),
      body: Center(
        child: Column(
          children: [
            //Gmail Login butto
            ElevatedButton(
              onPressed: () {
                //todo: gogole login
                vm.handleGmailSignIn();
              },
              child: Text("Login with Gmail"),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
            ),
            // FB login button
            ElevatedButton(
              onPressed: () {
                //todo: FB login
                vm.handleFacebookSignIn();
              },
              child: Text("Login with Facebook"),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
            ),

            // biometeric avilable design
            Consumer(
              builder: (cxt, ref, child) {
                return FutureBuilder<bool>(
                  future: vm.showBiomerticOptions,
                  builder: (contex, snapshot) {
                    if (snapshot.hasData && snapshot.data == true)
                      return Container(
                        color: Theme.of(context).primaryColor,
                        child: IconButton(
                          onPressed: vm.onBiometericTapped,
                          icon: Icon(
                            Icons.fingerprint,
                            color: Theme.of(context).secondaryHeaderColor,
                          ),
                        ),
                      );
                    if (snapshot.connectionState == ConnectionState.waiting) return CircularProgressIndicator();
                    return Container();
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
