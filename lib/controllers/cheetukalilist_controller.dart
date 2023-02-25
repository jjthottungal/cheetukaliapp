import 'dart:convert';
import 'package:cheetukaliapp/models/cheetukalidtlsmodel.dart';
import 'package:cheetukaliapp/models/cheetukalifamsummmodel.dart';
import 'package:cheetukaliapp/models/cheetukalisummmodel.dart';
import 'package:cheetukaliapp/models/cheetunkalilistmonthlymodel.dart';
import 'package:cheetukaliapp/models/userlistmodel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
//import 'package:cheetukaliapp/models/cheetukalilistmodel.dart';
import 'package:cheetukaliapp/utils/urls.dart';

class CheetuKaliController extends GetxController {
  //RxList<CheetukaliListModel> myList = <CheetukaliListModel>[].obs;
  //List<CheetukaliListModel> cheetukalilist = <CheetukaliListModel>[].obs;
  List<CheetukaliListMonthlyModel> cheetukalilistmonthly =
      <CheetukaliListMonthlyModel>[].obs;
  List<CheetukaliSummModel> cheetukaliSumm = <CheetukaliSummModel>[].obs;
  List<CheetukaliFamSummModel> cheetukaliFamSumm =
      <CheetukaliFamSummModel>[].obs;
  List<CheetukaliDtlsModel> cheetukalidtlsall = <CheetukaliDtlsModel>[].obs;
  List<CheetukaliDtlsModel> cheetukalidtlsperevent =
      <CheetukaliDtlsModel>[].obs;
  List<UserListModel> userlistwinners = <UserListModel>[].obs;
  List<UserListModel> userlisthosts = <UserListModel>[].obs;

  RxBool isListLoading = false.obs;
  RxInt selectedIndexNotifier = 0.obs;
  RxBool eventChanged = false.obs;
  RxBool winnerChanged = false.obs;
  Rx<DateTime> lastEventDate = DateTime.now().obs;
  RxInt lastEventId = 0.obs;
  RxInt cheetukalilistCount = 0.obs;
  RxInt cheetukaliDtliperEventCount = 0.obs;
  RxBool isInternetAlertSet = false.obs;
  RxBool needRefresh = false.obs;
  RxBool deleteDrawer = false.obs;

  @override
  // ignore: unnecessary_overrides
  void onInit() {
    super.onInit();
    // GetCheetukaliList();
    GetCheetukaliListMonthly();
    GetPlayerChart();
    GetFamilyChart();
    GetCheetukaliDtlsAll();
    GetUserListAll();
  }

  //Push Notification message recieved
  void dataHasChanged() {
    GetCheetukaliListMonthly();
    GetPlayerChart();
    GetFamilyChart();
    GetCheetukaliDtlsAll();
  }

  // ignore: non_constant_identifier_names
  /* void GetCheetukaliList() async {
    String url = Urls.baseUrl + Urls.cheetukalilistUrl;
    //Progress Indicator on
    isListLoading.value = true;

    final response = await http.get(Uri.parse(url));
    //Progress Indicator off
    isListLoading.value = false;

    if (response.statusCode == 200) {
      //var res = json.decode(response.body);
      //var data = res as List;
      var data = json.decode(response.body).cast<Map<String, dynamic>>();
      cheetukalilist = data
          .map<CheetukaliListModel>(
              (json) => CheetukaliListModel.fromJson(json))
          .toList();
      //Stored Last Event Date
      lastEventDate.value = cheetukalilist[0].date;
      //cheetukalilistCount.value = cheetukalilist.length;

      // as List<CheetukaliListModel>;
    } else {
      throw Exception('Failed to load data!');
    }
  }
 */
// ignore: non_constant_identifier_names
  void GetCheetukaliListMonthly() async {
    String url = Urls.baseUrl + Urls.cheetukalilistMonthlyUrl;
    //Progress Indicator on
    isListLoading.value = true;

    final response = await http.get(Uri.parse(url));
    //Progress Indicator off
    isListLoading.value = false;

    if (response.statusCode == 200) {
      //var res = json.decode(response.body);
      //var data = res as List;
      var data = json.decode(response.body).cast<Map<String, dynamic>>();
      cheetukalilistmonthly = data
          .map<CheetukaliListMonthlyModel>(
              (json) => CheetukaliListMonthlyModel.fromJson(json))
          .toList();
      //Stored Last Event Date
      if (cheetukalilistmonthly.isNotEmpty) {
        lastEventDate.value = cheetukalilistmonthly[0].events[0].date;
        lastEventId.value = cheetukalilistmonthly[0].events[0].wgId;
      }

      needRefresh.value = true;
    } else {
      throw Exception('Failed to load data!');
    }
  }

  // ignore: non_constant_identifier_names
  void GetPlayerChart() async {
    String url = Urls.baseUrl + Urls.cheetukalisummUrl;

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      //var res = json.decode(response.body);
      //var data = res as List;
      var data = json.decode(response.body).cast<Map<String, dynamic>>();
      cheetukaliSumm = data
          .map<CheetukaliSummModel>(
              (json) => CheetukaliSummModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load data!');
    }
  }

  // ignore: non_constant_identifier_names
  void GetFamilyChart() async {
    String url = Urls.baseUrl + Urls.cheetukalifamsummUrl;

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      //var res = json.decode(response.body);
      //var data = res as List;
      var data = json.decode(response.body).cast<Map<String, dynamic>>();
      cheetukaliFamSumm = data
          .map<CheetukaliFamSummModel>(
              (json) => CheetukaliFamSummModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load data!');
    }
  }

  // ignore: non_constant_identifier_names
  Future<int> GetCheetukaliDtlsAll() async {
    String url = Urls.baseUrl + Urls.cheetukalidtlsallUrl;

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      cheetukalidtlsall = cheetukaliDtlsModelFromJson(response.body);
    } else {
      throw Exception('Failed to load data!');
    }
    return response.statusCode;
  }

  // ignore: non_constant_identifier_names
  void GetCheetukaliDtlsPerEvent(int wgid) {
    cheetukalidtlsperevent.clear();
    cheetukalidtlsperevent =
        cheetukalidtlsall.where((i) => i.wgId == wgid).toList();
    cheetukaliDtliperEventCount.value = cheetukalidtlsperevent.length;
  }

  // ignore: non_constant_identifier_names
  void GetUserListAll() async {
    String url = Urls.baseUrl + Urls.userListUrl;

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      userlistwinners = userListModelFromJson(response.body);
      userlisthosts = userlistwinners.where((i) => i.type == 'H').toList();
    } else {
      throw Exception('Failed to load data!');
    }
  }

  /*  // ignore: non_constant_identifier_names
  void GetCheetukaliListUpdated(int index) {
    cheetukalilist.removeAt(index);

    //cheetukalilistCount.value = cheetukalilist.length;
    lastEventDate.value = cheetukalilist[0].date;
    needRefresh.value = true;
  } */

  // ignore: non_constant_identifier_names
  void GetCheetukaliListMonthlyUpdated(int wgid, String title) {
    //cheetukalilistmonthly.any((a) => a.events.removeWhere((e) => e.wgId == index));
    var filteredList =
        cheetukalilistmonthly.where((e) => e.monthly.contains(title)).toList();
    final outerIndex =
        cheetukalilistmonthly.indexWhere((e) => e.monthly.contains(title));
    var innerList = filteredList[0].events;

    if (innerList.length == 1) {
      cheetukalilistmonthly.removeWhere((e) => e.monthly.contains(title));
    } else {
      cheetukalilistmonthly[outerIndex]
          .events
          .removeWhere((e) => e.wgId == wgid);
    }

    //cheetukalilistCount.value = cheetukalilist.length;
    lastEventDate.value = cheetukalilistmonthly[0].events[0].date;
    lastEventId.value = cheetukalilistmonthly[0].events[0].wgId;
    needRefresh.value = true;
  }
}
