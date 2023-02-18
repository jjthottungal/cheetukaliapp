import 'package:cheetukaliapp/models/addeventmodel.dart';
import 'package:cheetukaliapp/models/addwinnermodel.dart';
import 'package:cheetukaliapp/models/delwinnermodel.dart';
import 'package:cheetukaliapp/models/loginmodel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:cheetukaliapp/utils/urls.dart';
import 'dart:convert';
import 'package:cheetukaliapp/utils/dialog_helper.dart';

class ApiManagerController extends GetxController {
  //For tracking internet connction dialogbox
  RxBool isInternetAlertSet = false.obs;

  Future<String> addEvent(AddEventModel requestModel) async {
    String url = Urls.baseUrl + Urls.addEventUrl;

    //Progress Indicator  on
    DialogHelper.showLoading('Updating...');

    final response = await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestModel.toJson()));
    //Progress Indicator  off
    DialogHelper.hideLoading();

    if (response.statusCode == 201) {
      return 'Created';
    } else if (response.statusCode == 400) {
      return 'Invalid Api request';
    } else {
      return 'Invalid Api request';
      //throw Exception('Failed to update!');
    }
  }

  Future<String> delEvent(int wgid) async {
    String url = Urls.baseUrl + Urls.delEventUrl + wgid.toString();

    //Progress Indicator  on
    DialogHelper.showLoading('Updating...');

    final response = await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'}, body: []);
    //Progress Indicator  off
    DialogHelper.hideLoading();

    if (response.statusCode == 200) {
      return 'Deleted';
    } else if (response.statusCode == 400) {
      return 'Invalid Api request';
    } else {
      return 'Invalid Api request';
      //throw Exception('Failed to update!');
    }
  }

  Future<String> addWinner(AddWinnerModel requestModel) async {
    String url = Urls.baseUrl + Urls.addWinnerUrl;

    //Progress Indicator  on
    DialogHelper.showLoading('Updating...');

    final response = await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestModel.toJson()));
    //Progress Indicator  off
    DialogHelper.hideLoading();

    if (response.statusCode == 201) {
      return 'Created';
    } else if (response.statusCode == 400) {
      return 'Invalid Api request';
    } else {
      return 'Invalid Api request';
      //throw Exception('Failed to update!');
    }
  }

  Future<String> delWinner(DelWinnerModel requestModel) async {
    String url = Urls.baseUrl + Urls.delWinnerUrl;

    //Progress Indicator  on
    DialogHelper.showLoading('Updating...');

    final response = await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestModel.toJson()));
    //Progress Indicator  off
    DialogHelper.hideLoading();

    if (response.statusCode == 200) {
      return 'Deleted';
    } else if (response.statusCode == 400) {
      return 'Invalid Api request';
    } else {
      return 'Invalid Api request';
      //throw Exception('Failed to update!');
    }
  }

  Future<String> login(LoginModel requestModel) async {
    String url = Urls.baseUrl + Urls.loginUrl;

    //Progress Indicator  on
    DialogHelper.showLoading('Sign-in...');

    final response = await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestModel.toJson()));
    //Progress Indicator  off
    DialogHelper.hideLoading();

    if (response.statusCode == 200) {
      return 'Logged';
    } else if (response.statusCode == 404) {
      return 'Invalid pin';
    } else {
      return 'Invalid Api request';
      //throw Exception('Failed to update!');
    }
  }
}
