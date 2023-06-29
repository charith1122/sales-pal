import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pros_bot/services/localStorage/UserAuthenticationService.dart';

class SendUser {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  saveDeviceToken() async {
    var profileData = await getUserAuthPref(key: "userAuth");

    String userId = profileData["body"]["id"];
    String fcmToken = await _fcm.getToken();
    // Save it to Firestore
    if (userId != "") {
      if (fcmToken != null) {
        var tokens = _db
            .collection('players')
            .doc(userId)
            .collection('tokens')
            .doc(fcmToken);

        await tokens.set({
          'token': fcmToken,
          'createdAt': FieldValue.serverTimestamp(), // optional
          'platform': Platform.operatingSystem // optional
        });
        updateUserAuthPref(key: 'token', data: {'tokn': fcmToken});
      }
    } else {
      saveDeviceToken();
    }
  }

  deleteDeviceToken() async {
    var profileData = await getUserAuthPref(key: "userAuth");
    var token = await getUserAuthPref(key: "token");

    String userId = profileData["body"]["id"];
    String fcmToken = token["tokn"];
    if (fcmToken != null) {
      await _db
          .collection('players')
          .doc(userId)
          .collection('tokens')
          .doc(fcmToken)
          .delete();
      removeUserAuthPref(key: "token");
    }
  }
}
