import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // FilteringTextInputFormatter를 import합니다.
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:table_calendar/table_calendar.dart'; // table_calendar 패키지를 import합니다.
import 'dart:convert';

ValueNotifier<bool> isFlag = ValueNotifier<bool>(true);

class DateState {
  final DateTime date;
  final String state;

  DateState({required this.date, required this.state});

  factory DateState.fromJson(Map<String, dynamic> json) {
    return DateState(
      date: DateTime.parse(json['date']),
      state: json['state'],
    );
  }

  static List<DateState> fromJsonList(String jsonString) {
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((json) => DateState.fromJson(json)).toList();
  }
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Usage Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalendarScreen(),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [const Locale('en', 'US')],
    );
  }
}

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _selectedDate = DateTime.now();
  Map<DateTime, String> _events = {};

  @override
  void initState() {
    super.initState();
    _loadData();
  }
  Future<void> _loadData() async {
    final String jsonString = await rootBundle.loadString('data/data.json');
    final List<DateState> dateStates = DateState.fromJsonList(jsonString);

    final Map<DateTime, String> events = {};
    for (var dateState in dateStates) {
      events[dateState.date] = dateState.state;
    }

    setState(() {
      _events = events;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: isFlag,
        builder: (context, value, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Select Date'),
            ),
            body: Column(
              children: [
                TableCalendar(
                  focusedDay: _selectedDate,
                  firstDay: DateTime.utc(2020, 01, 01),
                  lastDay: DateTime.utc(2100, 12, 31),
                  selectedDayPredicate: (day) => isSameDay(day, _selectedDate),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDate = selectedDay;
                    });
                    String weekdayName = _getWeekdayName(selectedDay.weekday);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(
                            selectedDate: _selectedDate,
                            weekday : weekdayName
                        ),
                      ),
                    );
                  },
                  calendarBuilders: CalendarBuilders(
                    defaultBuilder: (context, date, _) {
                      return _buildEventIndicator(date, value);
                    },
                    selectedBuilder: (context, date, _) {
                      return _buildEventIndicator(date ,value);
                    },
                    todayBuilder:  (context, date, _) {
                      return _buildEventIndicator(date, value);
                    },
                  ),
                ),
              ],
            ),
          );
        }
        );
  }
  Widget _buildEventIndicator(DateTime date, bool is_true) {


    var image_src = _getstring(is_true, date);

    return
    Padding(padding:const EdgeInsets.symmetric(vertical: 2.0),
    child: Container(
      width: 50,
      decoration: BoxDecoration(
        color: Color(0xFFE0F7FA),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text("${date.toShortDateString().split("-")[0]}"),
          image_src,
        ],
      ),
    ),)
      ;
  }
  Widget _getstring(bool flag, DateTime date) {
    var image_src = Image.asset("imgs/nothing2.png",width: 26,height: 26,);
    if (flag) {
      if (date.toShortDateString().split("-")[0] == '24') {
        image_src = Image.asset("imgs/image_24.png",width: 26,height: 26,);
      } else if (date.toShortDateString().split("-")[0] == '23') {
        image_src = Image.asset("imgs/image_25.png",width: 26,height: 26,);
      } else if (date.toShortDateString().split("-")[0] == '22') {
        image_src = Image.asset("imgs/image_26.png",width: 26,height: 26,);
      } else if (date.toShortDateString().split("-")[0] == '21') {
        image_src = Image.asset("imgs/image_26.png",width: 26,height: 26,);
      }else if (date.toShortDateString().split("-")[0] == '20') {
        image_src = Image.asset("imgs/image_25.png",width: 26,height: 26,);
      }else if (date.toShortDateString().split("-")[0] == '19') {
        image_src = Image.asset("imgs/image_24.png",width: 26,height: 26,);
      }else if (date.toShortDateString().split("-")[0] == '18') {
        image_src = Image.asset("imgs/image_24.png",width: 26,height: 26,);
      }else if (date.toShortDateString().split("-")[0] == '17') {
        image_src = Image.asset("imgs/image_26.png",width: 26,height: 26,);
      }else if (date.toShortDateString().split("-")[0] == '16') {
        image_src = Image.asset("imgs/image_26.png",width: 26,height: 26,);
      }else if (date.toShortDateString().split("-")[0] == '15') {
        image_src = Image.asset("imgs/image_25.png",width: 26,height: 26,);
      }else if (date.toShortDateString().split("-")[0] == '14') {
        image_src = Image.asset("imgs/image_24.png",width: 26,height: 26,);
      }
    } else {
      if (date.toShortDateString().split("-")[0] == '24') {
        image_src = Image.asset("imgs/image_24.png",width: 26,height: 26,);
      } else if (date.toShortDateString().split("-")[0] == '23') {
        image_src = Image.asset("imgs/image_25.png",width: 26,height: 26,);
      } else if (date.toShortDateString().split("-")[0] == '22') {
        image_src = Image.asset("imgs/image_26.png",width: 26,height: 26,);
      } else if (date.toShortDateString().split("-")[0] == '21') {
        image_src = Image.asset("imgs/image_26.png",width: 26,height: 26,);
      }else if (date.toShortDateString().split("-")[0] == '20') {
        image_src = Image.asset("imgs/image_25.png",width: 26,height: 26,);
      }else if (date.toShortDateString().split("-")[0] == '19') {
        image_src = Image.asset("imgs/image_24.png",width: 26,height: 26,);
      }else if (date.toShortDateString().split("-")[0] == '18') {
        image_src = Image.asset("imgs/image_24.png",width: 26,height: 26,);
      }else if (date.toShortDateString().split("-")[0] == '17') {
        image_src = Image.asset("imgs/image_26.png",width: 26,height: 26,);
      }else if (date.toShortDateString().split("-")[0] == '16') {
        image_src = Image.asset("imgs/image_26.png",width: 26,height: 26,);
      }else if (date.toShortDateString().split("-")[0] == '15') {
        image_src = Image.asset("imgs/image_25.png",width: 26,height: 26,);
      }else if (date.toShortDateString().split("-")[0] == '14') {
        image_src = Image.asset("imgs/image_24.png",width: 26,height: 26,);
      }else if (date.toShortDateString().split("-")[0] == '25') {
        image_src = Image.asset("imgs/image_24.png",width: 26,height: 26,);
      }
    }

    return image_src;
  }
  String _getWeekdayName(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return '(월)';
      case DateTime.tuesday:
        return '(화)';
      case DateTime.wednesday:
        return '(수)';
      case DateTime.thursday:
        return '(목)';
      case DateTime.friday:
        return '(금)';
      case DateTime.saturday:
        return '(토)';
      case DateTime.sunday:
        return '(일)';
      default:
        return '';
    }
  }
}

class HomeScreen extends StatefulWidget {
  final DateTime selectedDate;
  final String weekday;

  HomeScreen({required this.selectedDate, required this.weekday});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controllers = {
    'YouTube': TextEditingController(),
    'TikTok': TextEditingController(),
    'Instagram': TextEditingController(),
    'Netfilx': TextEditingController(),
    'X': TextEditingController(),
    'tmap': TextEditingController(),
    'kakaotalk': TextEditingController(),
  };
  final image = {
    'YouTube': "imgs/youtube.png",
    'TikTok': "imgs/tiktok.png",
    'Instagram': "imgs/instagram.png",
    'Netfilx': "imgs/netflix.png",
    'X': "imgs/x.png",
    'tmap': "imgs/tmap.png",
    'kakaotalk': "imgs/kakaotalk.png",
    'etc' : "imgs/nothing1.png"
  };
  @override
  Widget build(BuildContext context) {
    var date = widget.selectedDate.toLocal().toShortDateString();
    var date_list = date.split('-');
    List<List<int>> array = [[20,5,10,0,0,0,10],[10,58,10,10,13,12,10],
      [550,11,100,11,13,12,131],[10,58,100,150,13,12,131],[10,58,10,10,13,12,0],[10,18,10,10,13,12,0],
      [10,58,100,10,13,12,0],[121,110,100,11,13,12,131],[121,110,100,11,13,12,300],[121,11,100,11,13,12,131],
    [10,58,10,10,13,12,0],[20,5,10,0,0,0,10]];
    int idx3 = 0;

    return ValueListenableBuilder<bool>(
          valueListenable: isFlag,
          builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('${date_list[2]}년 ${date_list[1]}월 ${date_list[0]}일 ${widget.weekday}'),
          ),
          body: Column(
            children: [
              Text("서비스별 사용시간을 입력해주세요", style: TextStyle(fontSize: 20 ,fontWeight: FontWeight.bold),),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: _controllers.entries.map((entry) {
                    idx3 = idx3 + 1;
                    entry.value.text = entry.value.text.isEmpty & !value ? array[int.parse(date_list[0])-14][idx3-1].toString() : entry.value.text;
                    return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                            children: [
                              Image.asset(image[entry.key]!,width: 35,height: 35,),
                              Container(
                                width: 15,
                              ),
                              Expanded(
                                child: TextField(
                                  controller: entry.value,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    labelText: '${entry.key} 사용시간 (분)',
                                    border: OutlineInputBorder(),
                                  ),
                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                ),
                              ),
                              Container(
                                width: 40,
                              ),
                            ]
                        )
                    );
                  }).toList(),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  isFlag.value = false;
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TabScreen(
                        times: _controllers.map((key, controller) => MapEntry(key, double.tryParse(controller.text) ?? 0)),
                        date : '${date_list[2]}년 ${date_list[1]}월 ${date_list[0]}일 ${widget.weekday}'
                    )),
                  );
                },
                child: Text('디지털 탄소 발자국 확인하기'),
              ),
            ],
          ),
        );
      },
    );
  }
}

class TabScreen extends StatelessWidget {
  final Map<String, double> times;

  final String date;
  TabScreen({required this.times, required this.date});




  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Usage Summary'),
        ),
        body: TabBarView(
          children: [
            StatusTab(times: times, date : date),
            HowTab(times: times),
          ],
        ),
        bottomNavigationBar: TabBar(
          tabs: [
            Tab(text: 'Status'),
            Tab(text: 'How'),
          ],
        ),
      ),
    );
  }
}

class StatusTab extends StatelessWidget {
  final Map<String, double> times;
  final String date;

  StatusTab({required this.times, required this.date});

  @override
  Widget build(BuildContext context) {

    final totalTime = times.values.reduce((a, b) => a + b);

    // Sort the apps by usage time in descending order
    final sortedTimes = times.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    // Separate the top 3 and the rest
    final topThree = sortedTimes.take(3).toList();
    final rest = sortedTimes.skip(3).toList();

    final footprint = {
      'YouTube': 0.46,
      'TikTok': 2.63,
      'Instagram': 1.05,
      'Netfilx': 0.92,
      'X': 0.6,
      'tmap': 0.95,
      'kakaotalk': 2.3,
    };

    final double etcTime = rest.fold(0.0, (sum, entry) => sum + entry.value);
    final double etcfootprint = rest.fold(0.0, (sum, entry) => sum + entry.value * footprint[entry.key]!);
    final double total_footprint = sortedTimes.fold(0.0, (sum, entry) => sum + entry.value * footprint[entry.key]!);
    var amount = "쪽문";

    if (total_footprint < 160) {
       amount = "쪽문";
    } else  if (total_footprint < 208) {
      amount = "달빛포차";
    } else  if (total_footprint < 240) {
      amount = "한빛탑";
    } else  if (total_footprint < 296) {
      amount = "갤러리라 백화점";
    }  else if (total_footprint < 693) {
      amount = "대전 복합터미널";
    }  else if (total_footprint < 720) {
      amount = "대전역";
    } else   if (total_footprint < 776) {
      amount = "성심당 본점";
    } else  if (total_footprint < 800) {
      amount = "한화생명 이글스파크";
    } else  if (total_footprint < 1280) {
      amount = "동학사";
    }

    final categories = [
      ...topThree,
      MapEntry('etc', etcTime),
    ];

    footprint['etc'] = etcfootprint;
    int idx = 0;
    int idx2 = 0;
    double screenWidth = MediaQuery.of(context).size.width;
    final List<Color> colors = [
      Colors.blue,
      Colors.lightBlue,
      Colors.lightBlueAccent,
      Colors.grey
    ];
    final length = [
      categories[0].value / categories[0].value,
      categories[1].value / categories[0].value,
      categories[2].value / categories[0].value,
      categories[3].value / categories[0].value,
    ];
    final image = {
      'YouTube': "imgs/youtube.png",
      'TikTok': "imgs/tiktok.png",
      'Instagram': "imgs/instagram.png",
      'Netfilx': "imgs/netflix.png",
      'X': "imgs/x.png",
      'tmap': "imgs/tmap.png",
      'kakaotalk': "imgs/kakaotalk.png",
      'etc' : "imgs/nothing1.png"
    };
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(date ,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
              const Text("나의 디지털 탄소 발자국",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))
            ],
          ),
        ),
        Container(
          height: 15,
        ),
        Container(
          child: Row(
            children: categories.map((entry) {
              idx2 = idx2 + 1;
              var border_radius = const BorderRadius.only(
                bottomRight: Radius.circular(0), bottomLeft: Radius.circular(0),
              );
              var padding_constant = const EdgeInsets.fromLTRB(2, 2, 2, 2);
              if (idx2 == 1) {
                border_radius = const BorderRadius.only(
                  topLeft: Radius.circular(10), bottomLeft: Radius.circular(10),
                );
                padding_constant = const EdgeInsets.fromLTRB(15, 2, 2, 2); // 왼쪽 15, 나머지 2
              } else if (idx2 == 4) {
                border_radius = const BorderRadius.only(
                  topRight: Radius.circular(10), bottomRight: Radius.circular(10),
                );
                padding_constant = const EdgeInsets.fromLTRB(2, 2, 15, 2); // 오른쪽 15, 나머지 2
              }
              return Padding(
                padding: padding_constant,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: colors[idx2-1],
                        borderRadius: border_radius,
                      ),
                      alignment: Alignment.centerLeft,
                      height: 16,
                      width : length[idx2-1] * categories[0].value / totalTime * (screenWidth - 45),
                    ),
                    Container(
                      height: 5,
                    ),
                    Image.asset(
                        image[entry.key]!,
                        width: 30,
                        height:30),
                  ],
                ),
              );
            }).toList()
          ),
        ),
        Container(
          height: 15,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.all(8.0),
            child: Padding(
              padding:EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Image.asset(
                    "imgs/image_28.png", // 애셋 경로
                    width: 80, // 이미지의 너비
                    height: 80, // 이미지의 높이
                  ),
                  Container(
                    width: 20,
                  ),
                  Expanded(
                    child: Container(
                    alignment: Alignment.center,
                      child: Center(
                        child: Text("오늘 나의 탄소 발자국은 \n카이스트 N1에서 ${amount} 까지의 \n버스가 배출하는 양과 같아요",style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                  ),
                  Container(
                    width: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          height: 20,
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: categories.map((entry) {
              idx = idx + 1;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                            image[entry.key]!,
                          width: 30,
                          height:30),
                        Container(
                          width: 15,
                        ),
                        Text(
                          entry.key,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    Container(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      height: 16,
                      width : length[idx-1] * screenWidth,
                      decoration: BoxDecoration(
                        color: colors[idx-1],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Text(
                      '탄소 발자국 : ${(footprint[entry.key]! * (entry.key == 'etc' ? 1 : entry.value)).roundToDouble()}g, 사용시간 : ${entry.value}min',
                      style: const TextStyle(fontSize: 16),
                    )
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class HowTab extends StatelessWidget {
  final Map<String, double> times;

  HowTab({required this.times});

  @override
  Widget build(BuildContext context) {
    final totalTime = times.values.reduce((a, b) => a + b);

    final sortedTimes = times.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    final topThree = sortedTimes.take(3).toList();
    final footprint = {
      'YouTube': 0.46,
      'TikTok': 2.63,
      'Instagram': 1.05,
      'Netfilx': 0.92,
      'X': 0.6,
      'tmap': 0.95,
      'kakaotalk': 2.3,
    };
    final double total_footprint = sortedTimes.fold(0.0, (sum, entry) => sum + entry.value * footprint[entry.key]!);


    final ment = {
      'YouTube': ["화질을 낮춰주세요!","스트리밍 서비스에서 시청하는 영상의 화질을 낮추면 탄소 발자국을 줄일 수 있어요."],
      'TikTok': ["화면 밝기를 낮춰주세요!","스마트폰 화면의 밝기를 낮추면 에너지 사용량을 줄여 탄소 발자국을 줄일 수 있어요."],
      'Instagram': ["지루함을 만끽하세요!","별다른 알림이 없을 때에는 스마트폰을 만지기보다는 잠시 디지털 세상으로부터 벗어나 지루함을 만끽하면 탄소 발자국을 줄일 수 있어요."],
      'Netfilx': ["스트리밍보다는 다운로드!","음악/비디오를 감상할 때는 스트리밍보다는 다운로드 후 감상하면 탄소 발자국을 줄일 수 있어요."],
      'X': ["영상 자동재생을 멈춰주세요!","소셜미디어에서 영상 자동재생을 차단하면 불필요한 영상 재생에 의한 탄소 발자국을 줄일 수 있어요."],
      'tmap': ["지도는 미리 오프라인 저장!", "경로 안내를 시작하기 전에 지도를 미리 오프라인으로 저장하면 탄소 발자국을 줄일 수 있어요."],
      'kakaotalk': ["한 번 보낸 사진/영상은 전달하기!", "채팅 앱에서 이미 누군가에게 보낸 사진/영상을 다른 사람에게 다시 보낼 땐 전달하기 기능을 사용하면 탄소 발자국을 줄일 수 있어요."],
      'etc' : ["스마트폰 사용 시간을 줄여보세요!", "스마트폰을 충전하는 동안에도 탄소 발자국이 생기고 있어요."]
    };
    return Scrollbar(
        child: ListView(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              height: 100,
              alignment: Alignment.center,
              child: Text("내가 줄일 수 있는 탄소발자국은?", style: TextStyle(fontSize: 25),),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Container(
                child: Image.asset("imgs/${(total_footprint / 5) > 9 ? 9 : (total_footprint / 5).round()}.png"),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              height: 100,
              alignment: Alignment.center,
              child: Text("플라스틱 컵 ${(total_footprint / 5).round()} 개를 절약한 효과와 같아요! ", style: TextStyle(fontSize: 25),),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Container(
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(ment[topThree[0].key]![0],style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                    Container(
                      height: 10,
                    ),
                    Text(ment[topThree[0].key]![1],style: const TextStyle(fontSize: 15)),
                  ],
                ),
              ),
            ),
            Container(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Container(
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(ment[topThree[1].key]![0],style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                    Container(
                      height: 10,
                    ),
                    Text(ment[topThree[1].key]![1],style: const TextStyle(fontSize: 15)),
                  ],
                ),
              ),
            ),
            Container(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Container(
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(ment[topThree[2].key]![0],style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                    Container(
                      height: 10,
                    ),
                    Text(ment[topThree[2].key]![1],style: const TextStyle(fontSize: 15)),
                  ],
                ),
              ),
            ),
          ],
      )
    );
      Center(
      child: Text('Total Time: ${totalTime} hours', style: TextStyle(fontSize: 20)),
    );
  }
}

extension DateUtils on DateTime {
  String toShortDateString() {
    return '${this.day}-${this.month}-${this.year}';
  }
}
