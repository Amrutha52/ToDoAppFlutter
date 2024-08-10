import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide CarouselController;
import  'package:countdown_progress_indicator/countdown_progress_indicator.dart';

class FocusScreen extends StatefulWidget
{
  const FocusScreen({super.key});

  @override
  State<FocusScreen> createState() => _FocusScreenState();
}

class _FocusScreenState extends State<FocusScreen>
{
  bool _isRunning = true;
  final _controller = CountDownController();
  final _controller2 = CountDownController();

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(
          child: Text("Focus Mode", style: TextStyle(color: Colors.white,
              fontWeight: FontWeight.bold
          ),
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 200,
                width: 200,
                child: CountDownProgressIndicator(
                  controller: _controller,
                  valueColor: Colors.red,
                  backgroundColor: Colors.blue,
                  initialPosition: 0,
                  duration: 365,
                  timeFormatter: (seconds) {
                    return Duration(seconds: seconds)
                        .toString()
                        .split('.')[0]
                        .padLeft(8, '0');
                  },
                  text: 'hh:mm:ss',
                  onComplete: () => null,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 200,
                width: 200,
                child: CountDownProgressIndicator(
                  controller: _controller2,
                  valueColor: Colors.red,
                  backgroundColor: Colors.blue,
                  initialPosition: 0,
                  duration: 365,
                  text: 'Seg',
                  onComplete: () => null,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => setState(() {
                  if (_isRunning) {
                    _controller.pause();
                    _controller2.pause();
                  } else {
                    _controller.resume();
                    _controller2.resume();
                  }

                  _isRunning = !_isRunning;
                }),
                child: Text(_isRunning ? 'Pause' : 'Resume'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
