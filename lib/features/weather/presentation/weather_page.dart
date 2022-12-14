import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/features/weather/presentation/components/item.dart';
import 'package:weather_app/features/weather/presentation/provider/prov_get_weather.dart';
import 'package:weather_app/features/weather/presentation/search_cities.dart';

class WeatherPage extends ConsumerStatefulWidget {
  const WeatherPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WeatherPageState();
}

class _WeatherPageState extends ConsumerState<WeatherPage> {

 late String bgImage;
 late String icon;

  @override
  void initState() {
    super.initState();
    ref.read(weatherProvider.notifier).call('Jakarta');
  }

  @override
  Widget build(BuildContext context) {
    // final provider = ref.watch(dataProvider('Jakarta'));
    final provider = ref.watch(weatherProvider);

    return Scaffold(
      // body: ,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 200,
        title: SizedBox(
          width: double.maxFinite,
          // color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: InkWell(
              enableFeedback: false,
              onTap: () async {
                final selectedCities = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SearchCities(),
                  ),
                );
                if (selectedCities != null) {
                  ref.read(weatherProvider.notifier).call(selectedCities);
                }
              },
              child: Row(
              children: [
                const Icon(Icons.search),
                const SizedBox(width: 10),
                Text(
                  // locationList[index].weatherType,
                  'Search Cities..',
                  style: GoogleFonts.lato(
                    // fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            ),
          ),
        ),
      ),
      body: provider.when(
        data: (data) {
          setState(() {
            if(data?.weather?[0].main == 'Clouds') {
              bgImage = 'assets/sunny.jpg';
              icon = 'assets/icons/sun.svg';
            } else if (data?.weather?[0].main == 'Mist') {
              bgImage = 'assets/mist.jpg';
              icon = 'assets/icons/mist.svg';
            } else if (data?.weather?[0].main == 'Rain') {
              bgImage = 'assets/rainy.jpg';
              icon = 'assets/icons/rain.svg';
            } else if (data?.weather?[0].main == 'Wind') {
              bgImage = 'assets/cloudy.jpeg';
              icon = 'assets/icons/cloudy.svg';
            } else if (data?.weather?[0].main == 'Clear') {
              bgImage = 'assets/clear.jpeg';
              icon = 'assets/icons/cloudy.svg';
            }
          });
          return Stack(
            children: [
              Image.asset(
                bgImage,
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
              ),
              Container(
                decoration: const BoxDecoration(color: Colors.black38),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Column(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                              
                          //     const SizedBox(height: 5),
                              
                          //   ],
                          // ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 150),
                              Text(
                                data?.name ?? '-',
                                style: GoogleFonts.lato(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                '${data?.main?.temp!.round()} \u2109',
                                // 'temp',
                                style: GoogleFonts.lato(
                                  fontSize: 85,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    // 'assets/sun.svg',
                                    icon,
                                    width: 34,
                                    height: 34,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    '${data?.weather?[0].main ?? '-'} - ${data?.weather?[0].description ?? '-'}',
                                    style: GoogleFonts.lato(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const Text(' | '),
                                  // Text(
                                  //   '${ DateFormat("yyyy-MM-dd").parse(data!.dt.toString(), true).toLocal() }',
                                  //   style: GoogleFonts.lato(
                                  //     fontSize: 14,
                                  //     fontWeight: FontWeight.bold,
                                  //     color: Colors.white,
                                  //   ),
                                  // )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 40),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white30,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            // color: Colors.grey,
                            decoration: const BoxDecoration(
                              color: Colors.black38,
                              borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ItemComponents(
                                  title: 'Wind',
                                  value: data?.wind?.speed.toString() ?? '-',
                                  metric: 'm/s',
                                ),
                                ItemComponents(
                                  title: 'Rain',
                                  value: data?.rain?.d1h.toString() ?? '-',
                                  metric: 'volume',
                                ),
                                ItemComponents(
                                  title: 'Cloud',
                                  value: data?.clouds?.all?.toString() ?? '-',
                                  metric: '%',
                                ),
                                ItemComponents(
                                  title: 'Visibility',
                                  value: data?.visibility.toString() ?? '-',
                                  metric: 'meters',
                                ),
                                ItemComponents(
                                  title: 'Humidity',
                                  value: data?.main?.humidity.toString() ?? '-',
                                  metric: '%',
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          );
        },
        error: (error, stackTrace) {
          return const Center(child: Text('Unexpected Error..'),);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

