import 'dart:async';
import 'dart:io';

import 'package:firedart/firestore/firestore.dart';
import 'package:firedart/firestore/models.dart';

class Database {
  static Map<String, dynamic> data = {};
  static String defaultURL = "xdg-open https://chat.openai.com/";
  static final db = Firestore.initialized;
  static String collection = "Commands";
  static String linkDoc = "ZzRKcoVXPGF8F5Mv8VFv";
  static String projectID = "remote-54b9a";
  static String command = "";
  static bool key = false;
  static bool state = false;
  static String playStr = "playerctl play-pause";
  static int count = 0;
  static String unlockStr =
      "java -jar /home/ssstepbro/Documents/others/Password.jar";
  static String vpnStr =
      "java -jar /home/ssstepbro/Documents/remoteApps/stop.jar";
  static String blackboardStr =
      "java -jar /home/ssstepbro/Documents/remoteApps/blackboard.jar";
  static String chromeStr =
      "java -jar /home/ssstepbro/Documents/remoteApps/chrome.jar";
  static String protonStr =
      "java -jar /home/ssstepbro/Documents/remoteApps/remote.jar";
  static String animeStr =
      "xdg-open https://9animetv.to/watch/solo-leveling-18718?ep=122950";

  static Future<void> link() async {
    bool state = (data == null) ? (false) : data[linkDoc]["key"];
    if (state) {
      try {
        var map = await Firestore.instance
            .collection(collection)
            .document("ZzRKcoVXPGF8F5Mv8VFv");
        var doc = await map.get();
        command = doc['cmd'];
        execute(command);
        await map.update({"key": false});
        await map.update({"cmd": ""});
        print("link opened");
      } catch (e) {
        print("😭😭😭😭😭 $e");
      }
    }
  }

  static Future<void> play() async {
    bool state = data["play"]["key"];
    if (state) {
      try {
        var map =
            await Firestore.instance.collection(collection).document("play");
        var doc = await map.get();

        execute(playStr);
        await map.update({"key": false});
        print("Paused");
        //Firestore.instance.close();
      } catch (e) {
        print("😭😭😭😭😭 $e");
      }
    }
  }

  static Future<void> unlock() async {
    bool state = data["unlock"]["key"];
    if (state) {
      try {
        var map =
            await Firestore.instance.collection(collection).document("unlock");
        var doc = await map.get();
        key = doc['key'];

        execute(unlockStr);

        await map.update({"key": false});
        timeRunner(false);
        print("Unlocked");
        // Firestore.instance.close();
      } catch (e) {
        print("😭😭😭😭😭  $e");
      }
    }
  }

  static Future<void> vpn() async {
    bool state = data["vpn"]["key"];
    if (state) {
      try {
        var map =
            await Firestore.instance.collection(collection).document("vpn");
        var doc = await map.get();
        key = doc['key'];
        state = doc['on'];
        if (key && !state) {
          //if the key is on meaning switch the state && state being false means vpn is off
          execute(vpnStr);
          await map.update({"key": false});
          await map.update({"on": true}); //update that vpn is on
          print("VPN is turned on");
        } else if (key && state) {
          //switch vpn off
          execute(vpnStr);
          await map.update({"key": false});
          await map.update({"on": false}); //update that vpn is off
          print("VPN is turned off");
        } else {
          print("no Command");
        }
      } catch (e) {
        print("$e");
      }
    }
  }

  static Future<void> blackboard() async {
    bool state = data["blackboard"]["key"];
    if (state) {
      try {
        var map = await Firestore.instance
            .collection(collection)
            .document("blackboard");
        var doc = await map.get();
        key = doc['key'];

        execute(defaultURL);
        print("Delay");
        Future.delayed(Duration(seconds: 10), () {
          print('Done');
        });
        execute(blackboardStr);
        await map.update({"key": false});
        print("Blackboard Opened");
      } catch (e) {
        print("😭😭😭😭😭  $e");
      }
    }
  }

  static Future<void> openChrome() async {
    bool state = data["chrome"]["key"];
    if (state) {
      try {
        var map =
            await Firestore.instance.collection(collection).document("chrome");
        var doc = await map.get();
        execute(chromeStr);
        await map.update({"key": false});
        print("opening Chrome done");
      } catch (e) {
        print("😭😭😭😭😭  $e");
      }
    }
  }

  static getData() async {
    try {
      // CollectionReference<Map<String, dynamic>> collectionRef = Firestore.instance.collection("cities");
      List<Document> docs =
          await Firestore.instance.collection(collection).get();
      docs.forEach((Document document) {
        String documentId = document.id;
        Map<String, dynamic> documentData = document.map;
        data[documentId] = documentData;
      });

      //print(data);
      print("Got Data");

      play();
      link();
      unlock();
      vpn();
      anime();
      blackboard();
      openChrome();
    } catch (e) {
      print("Error: $e");
    }
  }

  static Future<void> timeRunner(bool state) async {
    // Create a Completer to control when the function completes
    Completer<void> completer = Completer<void>();

    // Create a Timer that completes the Completer after the specified duration
    Timer(Duration(seconds: 12), () {
      (state) ? execute(animeStr) : (print(""));
      completer.complete();
    });

    // Await for the Completer's future to complete
    await completer.future;
  }

  static Future<void> anime() async {
    bool state = data["anime"]["key"];
    if (state) {
      try {
        var map =
            await Firestore.instance.collection(collection).document("anime");
        var doc = await map.get();
        key = doc['key'];

        execute(protonStr);
        print("Delay");
        timeRunner(true);
        map.update({"key": false});
        print("anime done");
      } catch (e) {
        print("😭😭😭😭😭  $e");
      }
    }
  }

  static Future<void> execute(String command) async {
    try {
      ProcessResult result = await Process.run(
          command.split(' ')[0], command.split(' ').sublist(1));
      print('Exit code: ${result.exitCode}');
      print('stdout: ${result.stdout}');
      print('stderr: ${result.stderr}');
    } catch (e) {
      print('Error executing command: $e');
    }
  }
}
