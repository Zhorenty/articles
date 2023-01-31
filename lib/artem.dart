// import 'package:flutter/material.dart';

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   List todoList = [];

//   @override
//   void initState() {
//     super.initState();

//     todoList.addAll(['Сходить нахуй', 'Побрить Волтера', "Пнуть Лоха"]);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           backgroundColor: Colors.black,
//           title: const Text('Список дел'),
//           centerTitle: true,
//         ),
//         body: Stack(
//           children: [
//             ListView.builder(
//                 itemCount: todoList.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   return Dismissible(
//                       key: Key(todoList[index]),
//                       child: Card(
//                         child: ListTile(
//                           title: Text(todoList[index]),
//                           trailing: IconButton(
//                             icon: Icon(Icons.abc),
//                             onPressed: () {},
//                           ),
//                         ),
//                       ),
//                       onDismissed: (direction) {
//                         if (direction == DismissDirection.endToStart)
//                           setState(() {
//                             todoList.remove(index);
//                           });
//                       });
//                 }),
//           ],
//         ));
//   }
// }
