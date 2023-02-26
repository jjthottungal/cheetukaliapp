class Urls {
  //static String baseUrl = 'http://192.168.10.153:80/api/';
  //static String baseUrl = 'http://10.220.8.228:80/api/';
  //static String baseUrl = 'https://Webapi.oberon.net.in/api/';
  static String baseUrl = 'https://nodejs.thottungal.net.in/api/';

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
  static String firebaseServerKey =
      'key=AAAArztpzbw:APA91bED7qsrN-ST__LFQvUgSbFvzIwAGFLyMPs63sY2CvY0A_jKDyOczPodAmp92m-fFGLx3bGUFeqlr8VEAKqYgqDYdJi2cLAKogBlJhAqyh4llamhAwKSZ7NghOtvgZ3nRKh6dRis';
  static String notificationImageUrl =
      'https://nodejs.thottungal.net.in/firebase/wg_notification.png';

  //Variables
  static bool isLoggedIn = false;
  static bool isAdminRole = true;
}
