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
  static const String getSingleArtist = 'artist/get_single_artist';

  static const String paginatonArtist = 'artist/pagination';
  static const int limitPage = 4;

  // static const String imageUrl = 'http://192.168.1.133:5000/products/'
  static const String imageUrl = 'http://10.0.2.2:5000/artists/';


  // ===========Booking Routes===========
  static const String createBooking = 'booking/bookings';
  static const String getAllBookings = 'booking/all_bookings';
  static const String getUserBookings = 'booking/mybookings';
  static const String updateBookingStatus = 'booking/bookings/status';
  static const String updatePaymentMethod = 'booking/bookings/payment';

  // wishlist
  static const String getUserFavorites = 'wishlist/all';
  static const String addFavorite = 'wishlist/add';
  static const String deleteFavorite = 'wishlist/remove';
}
