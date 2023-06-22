import 'package:flutter/material.dart';
import 'package:flutter_application_kobis_api/kobis_api.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var controller = TextEditingController();
  var _searchType = 'movieNm';
  final kobisApi = KobisApi(apiKey: "fb0169d0f5280099ff69a2d5fc5e95be");

  void getMovieList() async {
    print(controller.text);
    var movies = await kobisApi.getSearchMovieList(
        searchType: _searchType, searchValue: controller.text);

    for (var movie in movies) {
      print(movie);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          DropdownButton(
            items: const [
              DropdownMenuItem(value: 'movieNm', child: Text('영화제목')),
              DropdownMenuItem(value: 'directorNm', child: Text('감독명')),
            ],
            onChanged: (value) {
              _searchType = value.toString();
            },
          ),
          Expanded(
            child: TextFormField(
              autofocus: true,
              controller: controller,
            ),
          ),
          ElevatedButton(onPressed: getMovieList, child: const Text('검색'))
        ],
      ),
    );
  }
}
