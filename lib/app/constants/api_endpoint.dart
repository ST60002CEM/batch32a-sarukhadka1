class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 9000);
  static const Duration receiveTimeout = Duration(seconds: 9000);
  // static const String baseUrl = 'http://192.168.1.133:5000/api/';
  static const String baseUrl = "http://10.0.2.2:5000/api/";

// ===========Auth Routes===========
  static const String loginUser = 'user/login';
  static const String createUser = 'user/create';
  static const String getMe = "user/profile/get";
  static const String getToken = "user/token";
  static const String verifyUser = "user/verifyUser";

// ===========Artist Routes===========
  static const String getAllArtists = 'artist/get_all_artists';
  static const String updateArtist = 'artist/update_Artist';

  static const String paginatonArtist = 'artist/pagination';
  static const int limitPage = 4;

  // static const String imageUrl = 'http://192.168.1.133:5000/products/'
  static const String imageUrl = 'http://10.0.2.2:5000/artists/';
}
