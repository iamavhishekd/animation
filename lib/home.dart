import 'package:animation/model.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> tasks = [
    Task(
      name: "Buy Eggs",
      description: "Buy Eggs while returning home",
      completed: false,
    ),
    Task(
      name: "Do Laundry",
      description: "Wash and fold clothes",
      completed: false,
    ),
    Task(
      name: "Clean the House",
      description: "Dust, vacuum, and mop the floors",
      completed: false,
    ),
    Task(
      name: "Read a Book",
      description: "Read a chapter of your favorite book",
      completed: false,
    ),
    Task(
      name: "Exercise",
      description: "Go for a run or do some yoga",
      completed: false,
    ),
    Task(
      name: "Write in Journal",
      description: "Reflect on the day's events",
      completed: false,
    ),
  ];

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  void removeTask(int index) {
    setState(
      () {
        tasks.removeAt(index);
        _listKey.currentState!.removeItem(
          index,
          duration: const Duration(milliseconds: 350),
          (context, animation) => _buildItem(context, index, animation),
        );
      },
    );
  }

  Widget _buildItem(
      BuildContext context, int index, Animation<double> animation) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1, 0),
        end: Offset.zero,
      ).animate(animation),
      child: Card(
        child: ListTile(
          leading: const Icon(Icons.abc),
          title: Text(tasks[index].name),
          subtitle: Text(tasks[index].description),
          trailing: IconButton(
            onPressed: () {
              removeTask(index);
            },
            icon: const Icon(Icons.close),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home App'),
      ),
      body: SizedBox(
        child: tasks.isNotEmpty
            ? AnimatedList(
                key: _listKey,
                initialItemCount: tasks.length,
                itemBuilder: ((context, index, animation) {
                  return _buildItem(context, index, animation);
                }),
              )
            : const SizedBox(
                child: Center(
                  child: Text("List is Empty"),
                ),
              ),
      ),
    );
  }
}
