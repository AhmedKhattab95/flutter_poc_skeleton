// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookLoginPage extends StatefulWidget {
  @override
  State createState() => FacebookLoginPageState();
}

class FacebookLoginPageState extends State<FacebookLoginPage> {

  String _contactText = '';

  @override
  void initState() {
    super.initState();
  }

  LoginResult? result;
  Map<String,dynamic>? userData;
  Future<void> _handlefacebookSignIn() async {
    try {
      result = await FacebookAuth.instance.login(    permissions: ['public_profile', 'email'],
      ); // by default we request the email and the public profile
      if (result == null) return;
// or FacebookAuth.i.login()
      if (result!.status == LoginStatus.success) {
        // you are logged
        final AccessToken accessToken = result!.accessToken!;
        userData = await FacebookAuth.instance.getUserData();
        _contactText = userData.toString();
        setState(() {

        });
      } else {
        print(result!.status);
        print(result!.message);
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> _handleSignOut() => FacebookAuth.instance.logOut();

  Widget _buildBody() {
    if (userData != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage:  NetworkImage(userData!['picture']['data']['url']),
            ),
            title: Text(userData!['name']),
            subtitle: Text(userData!['email']),
          ),
          const Text("Signed in successfully."),
          Text(_contactText),
          ElevatedButton(
            child: const Text('SIGN OUT'),
            onPressed: _handleSignOut,
          ),

        ],
      );
    } else
      {
        return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(_contactText),
          const Text("You are not currently signed in."),
          ElevatedButton(
            child: const Text('SIGN IN'),
            onPressed: _handlefacebookSignIn,
          ),
        ],
      );
  }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Google Sign In'),
        ),
        body: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: _buildBody(),
        ));
  }
}