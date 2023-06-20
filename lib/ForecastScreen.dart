//
// import 'package:flutter/material.dart';
// import 'package:weatherpal/ForecastModel.dart';
//
// class ForecastScreen extends StatefulWidget {
//   const ForecastScreen({Key? key}) : super(key: key);
//
//   @override
//   State<ForecastScreen> createState() => _ForecastScreenState();
// }
//
// class _ForecastScreenState extends State<ForecastScreen> {
//
//   String? dateAtIndex3;
//   double? tempAtIndex3 ;
//
//   String? dateAtIndex6;
//   double? tempAtIndex6 ;
//
//   String? dateAtIndex9 ;
//   double? tempAtIndex9 ;
//
//   @override
//   void initState() {
//     retrieveForecastValues();
//     super.initState();
//   }
//
//   void retrieveForecastValues() async {
//     var forecasts = await ForecastModel().getLocationForecast();
//
//     dynamic list = forecasts['list'];
//     List<String> datesList = [];
//     List<double> tempsList = [];
//
//     for (final entry in list) {
//       final tempValue = entry['main']['temp'];
//       final dateValue = entry['dt_txt'];
//
//       datesList.add(dateValue);
//       tempsList.add(tempValue);
//     }
//
//     // Print the resulting lists
//     for (int i = 0; i < datesList.length; i++) {
//       String date = datesList[i];
//       double temp = tempsList[i];
//
//       print('Date: $date, Temp: $temp');
//     }
//
//     if (datesList.length > 10 && tempsList.length > 10) {
//
//       dateAtIndex3 = datesList[3];
//       tempAtIndex3 = tempsList[3];
//
//       dateAtIndex6 = datesList[6];
//       tempAtIndex6 = tempsList[6];
//
//       dateAtIndex9 = datesList[9];
//       tempAtIndex9 = tempsList[9];
//
//     }
//     print("yooy $dateAtIndex3");
//     print("yooy $dateAtIndex6");
//     print("yooy $dateAtIndex9");
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Container(
//             height: 100,
//             color: Colors.teal,
//             child: Row(
//               children: [
//                 Text(dateAtIndex3!),
//                 Text('$tempAtIndex3'),
//               ],
//             ),
//           ),
//           Container(
//             height: 100,
//             color: Colors.amberAccent,
//             child: Row(
//                 children: [
//                   Text('$dateAtIndex6'),
//                   Text('$tempAtIndex6'),
//                 ],
//               ),
//             ),
//
//           Container(
//             height: 100,
//             color: Colors.orange,
//             child:  Row(
//               children: [
//                 Text('$dateAtIndex9'),
//                 Text('$tempAtIndex9'),
//               ],
//             ),
//           ),
//           TextButton(onPressed: () {}, child: const Text('Hello'))
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weatherpal/ForecastModel.dart';
import 'package:intl/intl.dart';
import 'package:weatherpal/utilities/bottom_button.dart';
import 'package:weatherpal/utilities/constants.dart';

class ForecastScreen extends StatefulWidget {
  const ForecastScreen({Key? key}) : super(key: key);

  @override
  State<ForecastScreen> createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {
  late Future<List<String>> _dateListFuture;
  late Future<List<double>> _tempListFuture;

  @override
  void initState() {
    _dateListFuture = _retrieveDatesList();
    _tempListFuture = _retrieveTempsList();
    super.initState();
  }

  String getDayFromDate(DateTime date) {
    DateFormat dateFormat = DateFormat('EEEE');
    return dateFormat.format(date); // Returns the day of the week (e.g., Monday, Tuesday)
  }

  Future<List<String>> _retrieveDatesList() async {
    var forecasts = await ForecastModel().getLocationForecast();
    dynamic list = forecasts['list'];
    List<String> datesList = [];

    for (final entry in list) {
      final dateValue = entry['dt_txt'];
      datesList.add(dateValue);
    }

    return datesList;
  }


  String formatDate(dateValue) {
  //  String dateString = dateValue;
    DateTime dateTime = DateTime.parse(dateValue);

    String day = getDayFromDate(dateTime);

    return day;
  }

  Future<List<double>> _retrieveTempsList() async {
    var forecasts = await ForecastModel().getLocationForecast();
    dynamic list = forecasts['list'];
    List<double> tempsList = [];

    for (final entry in list) {
      final tempValue = entry['main']['temp'];
      if (tempValue is int) {
        tempsList.add(tempValue.toDouble());
      } else if (tempValue is double) {
        tempsList.add(tempValue);
      }
    }

    return tempsList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Forecasts for your Location', style: kMessageTextStyle2, textAlign: TextAlign.center,),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 150,
                  color: Colors.teal,
                  child: FutureBuilder<List<String>>(
                    future: _dateListFuture, //data being monitored
                    builder: (context, dateSnapshot) {
                      if (dateSnapshot.hasData) {
                        final datesList = dateSnapshot.data!;
                        return FutureBuilder<List<double>>(
                          future: _tempListFuture,
                          builder: (context, tempSnapshot) {
                            if (tempSnapshot.hasData) {
                              final tempsList = tempSnapshot.data!;
                              final dateAtIndex4 = datesList[4];
                              final tempAtIndex4 = tempsList[4];
                              final forecastDay = formatDate(dateAtIndex4);
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(forecastDay,
                                    style: kTextStyle2,),
                                  Row(
                                    // success widgets
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(dateAtIndex4 , style: kTextStyle3),
                                      Text('$tempAtIndex4°C' , style: kTextStyle3),
                                    ],
                                  ),
                                ],
                              );
                            } else if (tempSnapshot.hasError) {
                              return Text(
                                  'Error: ${tempSnapshot.error}'); // error widget
                            }

                            return const Center(                    //default widget to return until future returns a value
                              child: SpinKitDoubleBounce(
                                color: Colors.white,
                                size: 60.0,
                              ),
                            );
                          },
                        );
                      } else if (dateSnapshot.hasError) {
                        return Text('Error: ${dateSnapshot.error}');
                      }

                      return const Center(
                        child: SpinKitDoubleBounce(
                          color: Colors.white,
                          size: 60.0,
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  height: 150,
                  color: Colors.amberAccent,
                  child: FutureBuilder<List<String>>(
                    future: _dateListFuture,
                    builder: (context, dateSnapshot) {
                      if (dateSnapshot.hasData) {
                        final datesList = dateSnapshot.data!;
                        return FutureBuilder<List<double>>(
                          future: _tempListFuture,
                          builder: (context, tempSnapshot) {
                            if (tempSnapshot.hasData) {
                              final tempsList = tempSnapshot.data!;
                              final dateAtIndex8 = datesList[8];
                              final tempAtIndex8 = tempsList[8];
                              final forecastDay = formatDate(dateAtIndex8);
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(forecastDay,
                                    style: kTextStyle2,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children:[
                                      Text(dateAtIndex8 , style: kTextStyle3),
                                      Text('$tempAtIndex8°C' , style: kTextStyle3),
                                    ],
                                  ),
                                ],
                              );
                            } else if (tempSnapshot.hasError) {
                              return Text('Error: ${tempSnapshot.error}');
                            }

                            return const Center(
                              child: SpinKitDoubleBounce(
                                color: Colors.white,
                                size: 60.0,
                              ),
                            );
                          },
                        );
                      } else if (dateSnapshot.hasError) {
                        return Text('Error: ${dateSnapshot.error}');
                      }

                      return const Center(
                        child: SpinKitDoubleBounce(
                          color: Colors.white,
                          size: 60.0,
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  height: 150,
                  color: Colors.orange,
                  child: FutureBuilder<List<String>>(
                    future: _dateListFuture,
                    builder: (context, dateSnapshot) {
                      if (dateSnapshot.hasData) {
                        final datesList = dateSnapshot.data!;
                        return FutureBuilder<List<double>>(
                          future: _tempListFuture,
                          builder: (context, tempSnapshot) {
                            if (tempSnapshot.hasData) {
                              final tempsList = tempSnapshot.data!;
                              final dateAtIndex12 = datesList[12];
                              final tempAtIndex12 = tempsList[12];
                              final forecastDay = formatDate(dateAtIndex12);
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(forecastDay,
                                    style: kTextStyle2),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(dateAtIndex12, style: kTextStyle3),
                                      Text('$tempAtIndex12°C' , style: kTextStyle3),
                                    ],
                                  ),
                                ],
                              );
                            } else if (tempSnapshot.hasError) {
                              return Text('Error: ${tempSnapshot.error}');
                            }

                            return const Center(
                              child: SpinKitDoubleBounce(
                                color: Colors.white,
                                size: 60.0,
                              ),
                            );
                          },
                        );
                      } else if (dateSnapshot.hasError) {
                        return Text('Error: ${dateSnapshot.error}');
                      }

                      return const Center(
                        child: SpinKitDoubleBounce(
                          color: Colors.white,
                          size: 60.0,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            child: BottomButton(
                onTap: () {
                  Navigator.pop(context);
                }, buttonTitle: "Back Home"),
          )

        ],
      ),
    );
  }
}
