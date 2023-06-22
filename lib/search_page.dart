import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var controller = TextEditingController();
  var _searchType = 'movieNm';

  void getMovieList() {
    var site =
        'http://kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieList.json?key=f5eef3421c602c6cb7ea224104795888&$_searchType=${controller.text}';
    print(site);
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
