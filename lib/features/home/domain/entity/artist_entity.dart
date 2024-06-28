import 'package:equatable/equatable.dart';

class ArtistEntity extends Equatable{
  final String ?  id;
  final String  artistName;
  final  int artistRate;
  final String  artistImage;
  final String  artistDescription;
  final String  artistGenre;

  const ArtistEntity({
    required this.id,
    required this.artistName,
    required this.artistRate,
    required this.artistImage,
    required this.artistDescription,
    required this.artistGenre,
  });

  @override
  List<Object?> get props => [ id, artistName, artistRate, artistImage, artistDescription, artistGenre, ];
}