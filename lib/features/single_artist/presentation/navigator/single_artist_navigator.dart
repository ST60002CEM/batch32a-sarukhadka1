import 'package:final_assignment/app/navigator/navigator.dart';
import 'package:final_assignment/features/single_artist/presentation/view/single_artist_view.dart';

class SingleArtistViewNavigator{}
 
mixin SingleArtistViewRoute{
  void navigateToSingleArtistView(){
    NavigateRoute.pushRoute(const SingleArtistView(artistId: '',));
  }
 
}