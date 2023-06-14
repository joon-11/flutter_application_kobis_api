import 'package:flutter/material.dart';
import 'package:flutter_application_kobis_api/kobis_api.dart';

class MovieDetail extends StatelessWidget {
  final String movieCd;
  MovieDetail({super.key, required this.movieCd});
  var kobis_api = KobisApi(apiKey: "fb0169d0f5280099ff69a2d5fc5e95be");

  @override
  Widget build(BuildContext context) {
    kobis_api.getMovieDetail(movieCd: movieCd);
    return Scaffold(
      body: Text(movieCd),
    );
  }
}
