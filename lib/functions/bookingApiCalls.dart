import 'dart:convert';

import 'package:get/get.dart';
import 'package:liveasy/controller/transporterIdController.dart';
import 'package:http/http.dart' as http ;
import 'package:flutter_config/flutter_config.dart';
import 'package:liveasy/models/BookingModel.dart';

class BookingApiCalls{

  //TransporterIdController will be used as postId in Transporter App
  TransporterIdController transporterIdController = Get.find<TransporterIdController>();

  //BookingApiUrl
  final String bookingApiUrl = FlutterConfig.get('bookingApiUrl');

  //to hold list of dataModels retrieved from Api
  List<BookingModel> modelList = [];

  //GET ------------------------------------------------------------------------
  Future<List<BookingModel>> getDataByPostLoadIdOnGoing() async {

    modelList = [];

    for (int i = 0;; i++) {
      http.Response response = await http.get(Uri.parse(
          '$bookingApiUrl?postLoadId=${transporterIdController.transporterId
              .value}&completed=false&cancel=false&pageNo=$i'));

      var jsonData = json.decode(response.body);
      if (jsonData.isEmpty) {
        break;
      }

      for (var json in jsonData) {
        BookingModel bookingModel = BookingModel(truckId: []);

        bookingModel.bookingDate = json['bookingDate'];
        bookingModel.loadId = json['loadId'];
        bookingModel.transporterId = json['transporterId'];
        bookingModel.truckId = json['truckId'];
        bookingModel.cancel = json['cancel'];
        bookingModel.completed = json['completed'];
        bookingModel.completedDate = json['completedDate'];
        modelList.add(bookingModel);
      }
    }
    return modelList;
  }

  //----------------------------------------------------------------------------
  Future<List<BookingModel>> getDataByPostLoadIdDelivered() async {

    modelList = [];
    for (int i = 0;; i++) {
      http.Response response = await http.get(Uri.parse(
          '$bookingApiUrl?postLoadId=${transporterIdController.transporterId
              .value}&completed=true&cancel=false&pageNo=$i'));
      var jsonData = json.decode(response.body);
      if (jsonData.isEmpty) {
        break;
      }
      print(jsonData);
      for (var json in jsonData) {
        BookingModel bookingModel = BookingModel(truckId: []);
        bookingModel.bookingDate = json['bookingDate'];
        bookingModel.loadId = json['loadId'];
        bookingModel.transporterId = json['transporterId'];
        bookingModel.truckId = json['truckId'];
        bookingModel.cancel = json['cancel'];
        bookingModel.completed = json['completed'];
        bookingModel.completedDate = json['completedDate'];
        modelList.add(bookingModel);
      }
    }
    return modelList;
  }

  //----------------------------------------------------------------------------
}