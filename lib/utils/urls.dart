class Urls {
  //static String baseUrl = 'http://192.168.10.153:80/api/';
  //static String baseUrl = 'http://10.220.8.228:80/api/';
  //static String baseUrl = 'https://Webapi.oberon.net.in/api/';
  static String baseUrl = 'https://nodejs.thottungal.co.in/api/';

  static String cheetukalilistUrl = 'CheetukaliList';
  static String cheetukalilistMonthlyUrl = 'CheetukaliListGroupByMonth';
  static String cheetukalisummUrl = 'CheetukaliSummary';
  static String cheetukalifamsummUrl = 'CheetukaliFamilySummary';
  static String cheetukalidtlsallUrl = 'CheetukaliDetailsAll';
  static String userListUrl = 'UserList?type=A';
  static String addEventUrl = 'AddEvent';
  static String delEventUrl = 'DelEvent?wgId=';
  static String addWinnerUrl = 'AddWinner';
  static String delWinnerUrl = 'DelWinner';
  static String loginUrl = 'Login';

  //Firebase Push Notification
  static String firebaseUrl = 'https://fcm.googleapis.com/fcm/send';
  static String fcmKey = '';

  static String notificationImageUrl =
      'https://thottungal.co.in/firebase/wg_notification.jpg';

  //Variables
  static bool isLoggedIn = false;
  static bool isAdminRole = false;
  static String enKey = 'MySecretKeyForEncryptionAndDecry';
  static String enIv = 'helloworldhellow';
  static String jwtToken = '';
}
