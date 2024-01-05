import 'package:flutter/material.dart';
import 'package:timer/timer.dart';
import 'package:timer/widgets/button.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int seconds = 0, minutes = 0, hours = 0;

  @override
  void initState() {
    super.initState();
  }

  Future<void> customDialogue(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Add preset timer"),
            content: const TextField(
              decoration: InputDecoration(hintText: "Preset timer name"),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Add")),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancel"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                customDialogue(context);
              },
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              )),
          const IconButton(
              onPressed: null,
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 25,
                  ),
                  Text(
                    "Hours",
                    style: TextStyle(fontSize: 20, color: Colors.grey.shade500),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Text("Minutes",
                      style:
                          TextStyle(fontSize: 20, color: Colors.grey.shade500)),
                  const SizedBox(
                    width: 25,
                  ),
                  Text("Seconds",
                      style:
                          TextStyle(fontSize: 20, color: Colors.grey.shade500)),
                  const SizedBox(
                    width: 10,
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //hours list wheel
                  SizedBox(
                    height: 200,
                    width: 80,
                    child: ListWheelScrollView.useDelegate(
                        physics: const FixedExtentScrollPhysics(),
                        itemExtent: 70,
                        perspective: 0.002,
                        magnification: 1,
                        useMagnifier: true,
                        diameterRatio: 2,
                        overAndUnderCenterOpacity: 0.5,
                        onSelectedItemChanged: (selectedHours) {
                          hours = selectedHours;
                        },
                        childDelegate: ListWheelChildLoopingListDelegate(
                            children: List.generate(100, (index) {
                          return Text(
                            index < 10 ? "0$index" : index.toString(),
                            style: const TextStyle(
                                color: Colors.deepPurpleAccent, fontSize: 70),
                          );
                        }))),
                  ),
                  SizedBox(
                    height: 50,
                    child: Text(
                      ":",
                      style:
                          TextStyle(fontSize: 50, color: Colors.grey.shade500),
                    ),
                  ),
                  //minutes list wheel
                  SizedBox(
                    height: 200,
                    width: 80,
                    child: ListWheelScrollView.useDelegate(
                        physics: const FixedExtentScrollPhysics(),
                        itemExtent: 70,
                        perspective: 0.002,
                        magnification: 1,
                        useMagnifier: true,
                        diameterRatio: 2,
                        overAndUnderCenterOpacity: 0.5,
                        onSelectedItemChanged: (selectedMinutes) {
                          minutes = selectedMinutes;
                        },
                        childDelegate: ListWheelChildLoopingListDelegate(
                            children: List.generate(60, (index) {
                          return Text(
                            index < 10 ? "0$index" : index.toString(),
                            style: const TextStyle(
                                color: Colors.deepPurpleAccent, fontSize: 70),
                          );
                        }))),
                  ),
                  SizedBox(
                    height: 50,
                    child: Text(
                      ":",
                      style:
                          TextStyle(fontSize: 50, color: Colors.grey.shade500),
                    ),
                  ),
                  //seconds list wheel
                  SizedBox(
                    height: 200,
                    width: 80,
                    child: ListWheelScrollView.useDelegate(
                        physics: const FixedExtentScrollPhysics(),
                        itemExtent: 70,
                        perspective: 0.002,
                        magnification: 1,
                        useMagnifier: true,
                        diameterRatio: 2,
                        overAndUnderCenterOpacity: 0.5,
                        onSelectedItemChanged: (selectedSeconds) {
                          seconds = selectedSeconds;
                        },
                        childDelegate: ListWheelChildLoopingListDelegate(
                            children: List.generate(60, (index) {
                          return Text(
                            index < 10 ? "0$index" : index.toString(),
                            style: const TextStyle(
                                color: Colors.deepPurpleAccent, fontSize: 70),
                          );
                        }))),
                  ),
                ],
              ),
              const SizedBox(
                height: 300,
              ),
              Button(
                  height: 50,
                  width: 120,
                  color: Colors.deepPurpleAccent,
                  title: "Start",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TimerScreen(
                                  setHours: hours,
                                  setMinutes: minutes,
                                  setSeconds: seconds,
                                )));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
