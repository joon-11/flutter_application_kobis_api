import 'dart:convert';
import 'package:http/http.dart' as http;

class KobisApi {
  final String apiKey;
  final String _site = "http://www.kobis.or.kr/kobisopenapi/webservice/rest";
  KobisApi({required this.apiKey});

  Future<List<dynamic>> getDailyBoxOffice({required String targetDt}) async {
    var uri = "$_site/boxoffice/searchDailyBoxOfficeList.json";
    uri = '$uri?key=$apiKey';
    uri = '$uri&targetDt=$targetDt';

    var response = await http.get(Uri.parse(uri));

    if (response.statusCode == 200) {
      var movies = jsonDecode(response.body)['boxOfficeResult']
          ['dailyBoxOfficeList'] as List<dynamic>;
      return movies;
    } else {
      return [];
    }
  }

  Future<dynamic> getMovieDetail({required String movieCd}) async {
    var uri = '$_site/movie/searchMovieInfo.json';
    uri = '$uri?key=$apiKey';
    uri = '$uri&movieCd=$movieCd';

    var response = await http.get(Uri.parse(uri));
    if (response.statusCode == 200) {
      var movie =
          jsonDecode(response.body)['movieInfoResult']['movieInfo'] as dynamic;
      return movie;
    } else {
      return [];
    }
  }

  Future<dynamic> getCompanyDetail({required String companyCd}) async {
    var uri = '$_site/company/searchCompanyInfo.json';
    uri = '$uri?key=$apiKey';
    uri = '$uri&companyCd=$companyCd';

    var response = await http.get(Uri.parse(uri));
    if (response.statusCode == 200) {
      var movie = jsonDecode(response.body)['company InfoResult']['companyInfo']
          as dynamic;
      return movie;
    } else {
      return [];
    }
  }

  Future<List<dynamic>> getSearchMovieList(
      {required String searchType, required String searchValue}) async {
    var uri = "$_site/movie/searchMovieList.json";
    uri = '$uri?key=$apiKey';
    uri = '$uri&$searchType=$searchValue';

    var response = await http.get(Uri.parse(uri));

    if (response.statusCode == 200) {
      var movies = jsonDecode(response.body)['movieListResult']['movieList']
          as List<dynamic>;
      return movies;
    } else {
      return [];
    }
  }
}
