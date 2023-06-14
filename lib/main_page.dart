import 'package:flutter/material.dart';
import 'kobis_api.dart';
import 'movie_detail.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
  });

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MainPage> {
  final kobisApi = KobisApi(apiKey: "fb0169d0f5280099ff69a2d5fc5e95be");
  dynamic body = const Center(
    child: Text('영화검색'),
  );
  void showCal() async {
    var dt = await showDatePicker(
        context: context,
        initialDate: DateTime.now().subtract(const Duration(days: 1)),
        firstDate: DateTime(2022),
        lastDate: DateTime.now().subtract(const Duration(days: 1)));
    if (dt != null) {
      var targetDt = dt.toString().split(' ')[0].replaceAll('-', '');
      var movies = kobisApi.getDailyBoxOffice(targetDt: targetDt);
      showList(movies);
    }
  }

  void showList(Future<List<dynamic>> movies) {
    setState(() {
      body = FutureBuilder(
          future: movies,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var movies = snapshot.data;
              return ListView.separated(
                  itemBuilder: (context, index) {
                    var rankColor = Colors.black;
                    if (index == 0) {
                      rankColor = Colors.yellow;
                    } else if (index == 1) {
                      rankColor = Colors.blue;
                    } else if (index == 2) {
                      rankColor = Colors.green;
                    }

                    var movie = movies[index];
                    return ListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: rankColor,
                            borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          movies[index]['rank'],
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                      title: Text(movies[index]["movieNm"]),
                      subtitle: Text('${movies[index]['audiAcc']}'),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MovieDetail(movieCd: movie["movieCd"]),
                          )),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: movies!.length);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: body,
        floatingActionButton: FloatingActionButton(
          onPressed: showCal,
          child: const Icon(Icons.calendar_month),
        ));
  }
}
