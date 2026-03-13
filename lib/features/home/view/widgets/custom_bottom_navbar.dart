import 'package:flutter/material.dart';

class AnimatedBottomNavExample extends StatefulWidget {
  const AnimatedBottomNavExample({super.key});

  @override
  State<AnimatedBottomNavExample> createState() =>
      _AnimatedBottomNavExampleState();
}

class _AnimatedBottomNavExampleState extends State<AnimatedBottomNavExample> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    Center(child: Text("Hoy")),
    Center(child: Text("Seguimiento")),
    Center(child: Text("ChatBot")),
    Center(child: Text("Vacunas")),
    Center(child: Text("Contenido")),
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    int itemCount = 5;

    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(16),
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8)],
        ),
        child: Stack(
          children: [
            // Indicador animado
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              left:
                  (_currentIndex * (width - 32) / itemCount) +
                  ((width - 32) / itemCount - 50) / 2,
              top: 5,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.pinkAccent,
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(itemCount, (index) {
                IconData icon;
                String label;
                switch (index) {
                  case 0:
                    icon = Icons.home;
                    label = "Hoy";
                    break;
                  case 1:
                    icon = Icons.calendar_month;
                    label = "Seguimiento";
                    break;
                  case 2:
                    icon = Icons.wechat;
                    label = "ChatBot";
                    break;
                  case 3:
                    icon = Icons.medical_information;
                    label = "Vacunas";
                    break;
                  default:
                    icon = Icons.book;
                    label = "Contenido";
                }

                return Expanded(
                  child: InkWell(
                    onTap: () => setState(() => _currentIndex = index),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          icon,
                          color: _currentIndex == index
                              ? Colors.white
                              : Colors.grey,
                        ),
                        Text(
                          label,
                          style: TextStyle(
                            color: _currentIndex == index
                                ? Colors.white
                                : Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
