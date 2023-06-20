import 'package:flutter/material.dart';
import 'package:flutter_application_kobis_api/kobis_api.dart';
import 'package:flutter_application_kobis_api/movie_detail_view.dart';

// ignore: must_be_immutable
class MovieDetail extends StatelessWidget {
  final String movieCd;
  MovieDetail({super.key, required this.movieCd});
  var kobis_api = KobisApi(apiKey: "fb0169d0f5280099ff69a2d5fc5e95be");

  @override
  Widget build(BuildContext context) {
    var movieData = kobis_api.getMovieDetail(movieCd: movieCd);

    return Scaffold(
      body: FutureBuilder(
        future: movieData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var movie = snapshot.data;
            return MovieDetailView(movie: movie);
          } else {
            var msg = '데이터 로드중입니다';
            return Center(child: Text(msg));
          }
        },
      ),
    );
  }
}
