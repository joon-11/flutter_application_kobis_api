import 'package:flutter/material.dart';
import 'package:flutter_application_kobis_api/kobis_api.dart';

// ignore: must_be_immutable
class MovieDetailView extends StatefulWidget {
  Map<String, dynamic> movie;
  MovieDetailView({super.key, required this.movie});

  @override
  State<MovieDetailView> createState() => _MovieDetailViewState();
}

class _MovieDetailViewState extends State<MovieDetailView> {
  void showPopup() async {
    var kobisApi = KobisApi(apiKey: "fb0169d0f5280099ff69a2d5fc5e95be");
    var company = await kobisApi.getCompanyDetail(
        companyCd: widget.movie['companys'][0]['companyCd']);
    // ignore: use_build_context_synchronously
    var msg = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('${company['companyNm']}'),
              content: const Text('company info'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('닫기')),
              ],
            ));
    print(msg);
  }

  @override
  Widget build(BuildContext context) {
    print(widget.movie);

    var grade = widget.movie['audits'][0]['watchGradeNm'].toString();
    Map<String, dynamic> gradeStyle = {};
    if (grade == '15세이상관람가') {
      // var gradeColor = Colors.blue;
      // var gradeText = '15';
      gradeStyle['color'] = Colors.blue;
      gradeStyle['text'] = '15';
    }

    return Column(
      children: [
        Text('${widget.movie['movieNm']}(${widget.movie['prdtYear']})'),
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                  color: gradeStyle['color'], shape: BoxShape.circle),
            ),
            Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                  color: Colors.white, shape: BoxShape.circle),
              child: Center(child: Text(gradeStyle['text'])),
            )
          ],
        ),
        GestureDetector(
            onTap: () {
              showPopup();
            },
            child: Text('${widget.movie['companys'][0]['companyCd']}'))
      ],
    );
  }
}
