import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
// import 'package:flutter_icons/flutter_icons.dart';:

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  WeatherStation weatherStation = new WeatherStation("46b5f9e5a94c87b910c746d3be30721a");
  
  retornarDadosClimaticos() async {
    
    Weather weather = await weatherStation.currentWeather();
    weather.rainLastHour.toString();
    return weather;
  }

  String format(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 2);
  }
  @override
  Widget build(BuildContext context) {

    Widget _buildBodyBack() => Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 69, 124, 31),
            Color.fromARGB(255, 92, 165, 41)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight
        )
      ),
    );

    return Stack(
      children: <Widget>[
        _buildBodyBack(),
        CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text("Dashboard"),
                centerTitle: true,
              ),
            ),
             FutureBuilder<dynamic>(
              future: retornarDadosClimaticos(),
              builder: (context, snapshot){
                if(!snapshot.hasData)
                  return SliverToBoxAdapter(
                    child: Container(
                      height: 200.0,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  );
                else
                  return SliverGrid.count(
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  children: <Widget>[
                    // Card(
                    //   elevation: 6,
                    //   child:Center(
                    //     child: Padding(
                    //       padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
                    //         child: Column(
                    //           children: <Widget>[
                    //             Icon(WeatherIcons.getIconData("wi_strong_wind"),size: 60.0),
                    //             Divider(color: Colors.transparent),
                    //             Row(
                    //               crossAxisAlignment: CrossAxisAlignment.center,
                    //               mainAxisAlignment: MainAxisAlignment.center,
                    //               children: <Widget>[
                    //               Text('Velocidade do vento',
                    //               style: TextStyle(color: Colors.black,fontSize: 16.0)
                    //               ),
                    //             ]),
                    //             Row(
                    //               crossAxisAlignment: CrossAxisAlignment.center,
                    //               mainAxisAlignment: MainAxisAlignment.center,
                    //               children: <Widget>[
                    //               Text(format(snapshot.data.windSpeed * 3.6) + ' km/h',
                    //               style: TextStyle(color: Colors.black,fontSize: 20.0)
                    //               ),
                    //             ])
                                  
                    //           ],
                    //         )     
                    //       )
                    //     )
                    // ),
                    // Card(
                    //   elevation: 6,
                    //   child:Center(
                    //     child: Padding(
                    //       padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
                    //         child: Column(
                    //           children: <Widget>[
                    //             Icon(WeatherIcons.getIconData("wi_thermometer"),size: 60.0),
                    //             Divider(color: Colors.transparent),
                    //             Row(
                    //               crossAxisAlignment: CrossAxisAlignment.center,
                    //               mainAxisAlignment: MainAxisAlignment.center,
                    //               children: <Widget>[
                    //               Text('Temperatura',
                    //               style: TextStyle(color: Colors.black,fontSize: 16.0)
                    //               ),
                    //             ]),
                    //             Row(
                    //               crossAxisAlignment: CrossAxisAlignment.center,
                    //               mainAxisAlignment: MainAxisAlignment.center,
                    //               children: <Widget>[
                    //               Text(format(snapshot.data.temperature.celsius).toString() + ' °C',
                    //               style: TextStyle(color: Colors.black,fontSize: 20.0)
                    //               ),  
                    //             ])
                                  
                    //           ],
                    //         )     
                    //       )
                    //     )
                    // ),
                    // Card(
                    //   elevation: 6,
                    //   child:Center(
                    //     child: Padding(
                    //       padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
                    //         child: Column(
                    //           children: <Widget>[
                    //             Icon(WeatherIcons.getIconData("wi_barometer"),size: 60.0),
                    //             Divider(color: Colors.transparent),
                    //             Row(
                    //               crossAxisAlignment: CrossAxisAlignment.center,
                    //               mainAxisAlignment: MainAxisAlignment.center,
                    //               children: <Widget>[
                    //               Text('Pressão',
                    //               style: TextStyle(color: Colors.black,fontSize: 16.0)
                    //               ),
                    //             ]),
                    //             Row(
                    //               crossAxisAlignment: CrossAxisAlignment.center,
                    //               mainAxisAlignment: MainAxisAlignment.center,
                    //               children: <Widget>[
                    //               Text(format(snapshot.data.pressure).toString() + ' hPa',
                    //               style: TextStyle(color: Colors.black,fontSize: 20.0)
                    //               ),  
                    //             ])
                                  
                    //           ],
                    //         )     
                    //       )
                    //     )
                    // ),
                    //  Card(
                    //   elevation: 6,
                    //   child:Center(
                    //     child: Padding(
                    //       padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
                    //         child: Column(
                    //           children: <Widget>[
                    //             Icon(WeatherIcons.getIconData("wi_humidity"),size: 60.0),
                    //             Divider(color: Colors.transparent),
                    //             Row(
                    //               crossAxisAlignment: CrossAxisAlignment.center,
                    //               mainAxisAlignment: MainAxisAlignment.center,
                    //               children: <Widget>[
                    //               Text('Umidade',
                    //               style: TextStyle(color: Colors.black,fontSize: 16.0)
                    //               ),
                    //             ]),
                    //             Row(
                    //               crossAxisAlignment: CrossAxisAlignment.center,
                    //               mainAxisAlignment: MainAxisAlignment.center,
                    //               children: <Widget>[
                    //               Text(snapshot.data.humidity.toString() +'%',
                    //               style: TextStyle(color: Colors.black,fontSize: 20.0)
                    //               ),  
                    //             ])
                                  
                    //           ],
                    //         )     
                    //       )
                    //     )
                    // ),
                  ]);
              },
            )
          ]
        ),
      ],
    );
  }
}