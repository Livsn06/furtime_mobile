import 'package:flutter/material.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  final int currentIndex;
  final void Function(int) onTap;

  const BottomNavigationBarWidget({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  _BottomNavigationBarWidgetState createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: widget.currentIndex,
          onTap: widget.onTap,
          showUnselectedLabels: false,
          enableFeedback: true,
          elevation: 5,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          backgroundColor: Colors.amber[400],
          selectedItemColor: Colors.red[700],
          items: [
            
            BottomNavigationBarItem(
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) {
                  return ScaleTransition(scale: animation, child: child);
                },
                child: widget.currentIndex == 0
                    ? const Icon(Icons.checklist_rounded, key: ValueKey('checklist-selected'))
                    : const Icon(Icons.checklist_rounded, key: ValueKey('checklist')),
              ),
              label: 'Checklist',
            ),
            BottomNavigationBarItem(
              
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) {
                  return ScaleTransition(scale: animation, child: child);
                }, 
                child: widget.currentIndex == 1
                    ? const Icon(Icons.calendar_month_rounded, key: ValueKey('calendar-selected'))
                    : const Icon(Icons.calendar_month, key: ValueKey('calendar')),
              ),
              
              label: 'Calendar',
            ),
            BottomNavigationBarItem(
              icon: GestureDetector(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) {
                    return ScaleTransition(scale: animation, child: child);
                  },
                  child: widget.currentIndex == 2
                      ? const Icon(Icons.home, key: ValueKey('home-selected'))
                      : const Icon(Icons.home_rounded, key: ValueKey('home')),
                ),
                // onTap:  () {
                //     // Navigate to the user guide here
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => ToDoScreen(),
                //       ),
                //     );
                //   },
  
              ),
              label: 'Home',
            ),
             BottomNavigationBarItem(
              icon: GestureDetector(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) {
                    return ScaleTransition(scale: animation, child: child);
                  },
                  child: widget.currentIndex == 3
                      ? const Icon(Icons.pets_rounded, key: ValueKey('pets-selected'))
                      : const Icon(Icons.pets_outlined, key: ValueKey('pets')),
                ),
            
              ),
              label: 'Pets',
            ),
            BottomNavigationBarItem(
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) {
                  return ScaleTransition(scale: animation, child: child);
                },
                child: widget.currentIndex == 4
                    ? const Icon(Icons.person_outline, key: ValueKey('todo-selected'))
                    : const Icon(Icons.person_outline_outlined, key: ValueKey('todo')),
              ),
              label: 'Profile',
            ),
             BottomNavigationBarItem(
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) {
                  return ScaleTransition(scale: animation, child: child);
                },
                child: widget.currentIndex == 5
                    ? const Icon(Icons.key, key: ValueKey('log-selected'))
                    : const Icon(Icons.key_outlined, key: ValueKey('log')),
              ),
              label: 'Log-in',
            ),
          ],
        ),
        // Underline effect
        Positioned(
          bottom: 2,
          left: (MediaQuery.of(context).size.width / 5) * widget.currentIndex,
          child: Container(
            height: 2,
            width: MediaQuery.of(context).size.width / 5,
            color: Colors.red[700], // Color of the underline
          ),
        ),
      ],
    );
  }
}