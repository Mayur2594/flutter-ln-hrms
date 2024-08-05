import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ln_hrms/controllers/controller.common.dart';
import 'package:ln_hrms/helpers/helper.config.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';

class commonService {
  final CommonController CommonCtrl = Get.put(CommonController());

  late FlutterLocalNotificationsPlugin flutterLocalNotification =
      FlutterLocalNotificationsPlugin();
  static AndroidNotificationDetails androidSettings =
      const AndroidNotificationDetails("channelId", "channelName",
          playSound: true,
          enableVibration: true,
          importance: Importance.max,
          priority: Priority.max);

  LocalNotificationinitializer() {
    androidSettings; //for logo
    var initializationSettings = new InitializationSettings();
    flutterLocalNotification.initialize(initializationSettings);
  }

  showNotification(var title, var body) async {
    var notifDetails = NotificationDetails(android: androidSettings);
    flutterLocalNotification.show(1, '$title', '$body', notifDetails);
  }

  initializeService() async {
    print("Inside Service-------");
    final service = FlutterBackgroundService();

    /// OPTIONAL, using custom notification channel id
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'my_foreground', // id
      'MY FOREGROUND SERVICE', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.low, // importance must be at low or higher level
    );

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    if (Platform.isIOS || Platform.isAndroid) {
      await flutterLocalNotificationsPlugin.initialize(
        const InitializationSettings(
          iOS: DarwinInitializationSettings(),
          android: AndroidInitializationSettings('ic_bg_service_small'),
        ),
      );
    }

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await service.configure(
      androidConfiguration: AndroidConfiguration(
        // this will be executed when app is in foreground or background in separated isolate
        onStart: onStart,
        autoStartOnBoot: false,
        // auto start service
        autoStart: true,
        isForegroundMode: true,
        notificationChannelId: 'bg-notification',
        initialNotificationTitle: 'Ln-HRMS',
        initialNotificationContent: 'Initializing Service',
        foregroundServiceNotificationId: 2,
      ),
      iosConfiguration: IosConfiguration(
        // auto start service
        autoStart: true,
        // this will be executed when app is in foreground in separated isolate
        onForeground: onStart,
      ),
    );
  }

  @pragma('vm:entry-point')
  static onStart(ServiceInstance service) async {
    // Only available for flutter 3.0.0 and later
    DartPluginRegistrant.ensureInitialized();

    if (service is AndroidServiceInstance) {
      service.on('setAsForeground').listen((event) {
        service.setAsForegroundService();
      });

      service.on('setAsBackground').listen((event) {
        service.setAsBackgroundService();
      });
    }

    service.on('stopService').listen((event) {
      service.stopSelf();
    });

    commonService().LocalNotificationinitializer();
    commonService().showNotification("Ln-hrms", "Welcome");

    // bring to foreground
    print('before periodic');
    Timer.periodic(const Duration(minutes: 5), (timer) async {
      if (service is AndroidServiceInstance) {
        if (await service.isForegroundService()) {
          commonService().getCurrentPosition();
        }
      }
    });
  }

  late bool serviceEnabled;
  late LocationPermission permission;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }

  var currentPosition = {};
  Future<void> getCurrentPosition() async {
    var token = await CommonCtrl.getDetailsFromSharedPref("token");

    currentPosition.clear();
    final hasPermission = await _handleLocationPermission();
    if (hasPermission == false) {
      currentPosition = {
        'latitude': null,
        'longitude': null,
        'message': 'Location service permissions denied.'
      };
      final response = await http.post(
          Uri.parse('${Config.baseUrl}/api/saveCurrrentLocationDetails'),
          headers: {
            'Authorization': 'Bearer $token',
          },
          body: currentPosition);
    } else {
      await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high)
          .then((Position position) async {
        currentPosition = {
          'latitude': position.latitude,
          'longitude': position.longitude,
          'message': ''
        };
        final response = await http.post(
            Uri.parse('${Config.baseUrl}/api/saveCurrrentLocationDetails'),
            headers: {
              'Authorization': 'Bearer $token',
            },
            body: currentPosition);
      }).catchError((e) async {
        print("Error while getting Current Location: \n $e");
        currentPosition = {
          'latitude': null,
          'longitude': null,
          'message': 'Location service disabled.'
        };

        final response = await http.post(
            Uri.parse('${Config.baseUrl}/api/saveCurrrentLocationDetails'),
            headers: {
              'Authorization': 'Bearer $token',
            },
            body: currentPosition);
      });
    }
  }

  stopBackgroundService() {
    final service = FlutterBackgroundService();
    service.invoke('stopService');
  }
}
