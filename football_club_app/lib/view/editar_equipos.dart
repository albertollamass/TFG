import 'package:flutter/material.dart';
// import 'package:drag_and_drop_lists/drag_and_drop_item.dart';
// import 'package:drag_and_drop_lists/drag_and_drop_list.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/services.dart';
import 'package:football_club_app/view/info_partido.dart';

class EditarEquipos extends StatefulWidget {
  @override
  _EditarEquipos createState() => _EditarEquipos();
}

class _EditarEquipos extends State<EditarEquipos> {
  late List<DragAndDropList> lists;

  @override
  void initState() {
    super.initState();

    lists = allLists.map(buildList).toList();
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = const Color.fromARGB(255, 243, 242, 248);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text("EDITAR EQUIPOS", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
        centerTitle: true,
        actions: [
              IconButton(
                icon: const Icon(Icons.save, size: 29),
                onPressed: () {
                  AlertDialog alert = AlertDialog(
                  title: const Text("Guardar cambios"),
                  content:
                      const Text("¿Quieres guardar los cambios?"),
                  actions: [
                    TextButton(
                      child: const Text(
                        "Guardar",
                        style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                      onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>  EditarEquipos()),
                        )
                      },
                    ),
                    TextButton(
                      child: const Text("Cancelar"),
                      onPressed: () => {Navigator.pop(context)},
                    )
                  ],
                );
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return alert;
                    });
                },
              ),
            ],
      ),
      body: DragAndDropLists(
        // lastItemTargetHeight: 50,
        // addLastItemTargetHeightToTop: true,
        // lastListTargetSize: 30,
        listPadding: const EdgeInsets.all(16),
        listInnerDecoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.circular(10),
        ),
        children: lists,
        itemDivider: Divider(thickness: 2, height: 2, color: backgroundColor),
        itemDecorationWhileDragging: const BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        //listDragHandle: buildDragHandle(isList: true),
        itemDragHandle: buildDragHandle(),
        onItemReorder: onReorderListItem,
        onListReorder: onReorderList,
      ),
    );
  }

  DragHandle buildDragHandle({bool isList = false}) {
    final verticalAlignment = isList
        ? DragHandleVerticalAlignment.top
        : DragHandleVerticalAlignment.center;
    final color = isList ? Colors.blueGrey : Colors.black26;

    return DragHandle(
      verticalAlignment: verticalAlignment,
      child: Container(
        padding: const EdgeInsets.only(right: 10),
        child: Icon(Icons.menu, color: color),
      ),
    );
  }

  DragAndDropList buildList(DraggableList list) => DragAndDropList(
        header: Container(
          padding: const EdgeInsets.all(8),
          child: Text(
            list.header,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        children: list.items
            .map((item) => DragAndDropItem(
                  child: ListTile(
                    leading: Image.network(
                      item.urlImage,
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                    title: Text(item.title),
                  ),
                ))
            .toList(),
      );

  void onReorderListItem(
    int oldItemIndex,
    int oldListIndex,
    int newItemIndex,
    int newListIndex,
  ) {
    setState(() {
      final oldListItems = lists[oldListIndex].children;
      final newListItems = lists[newListIndex].children;

      final movedItem = oldListItems.removeAt(oldItemIndex);
      newListItems.insert(newItemIndex, movedItem);
    });
  }

  void onReorderList(
    int oldListIndex,
    int newListIndex,
  ) {
    setState(() {
      final movedList = lists.removeAt(oldListIndex);
      lists.insert(newListIndex, movedList);
    });
  }
}

class DraggableList {
  final String header;
  final List<DraggableListItem> items;

  const DraggableList({required this.header, required this.items});
}

class DraggableListItem {
  final String title;
  final String urlImage;

  const DraggableListItem({
    required this.title,
    required this.urlImage,
  });
}
List<DraggableList> allLists = buildList();
List<DraggableList> buildList() {
  Map<String, List<String>> equipos = {
    "negro": ["Antonio", "Joaquin", "M.Pardo", "Sergio", "Francis", "Victor"],
    "blanco": [
      "Rafa",
      "Jose",
      "Juanjo",
      "Nene",
      "Sam",
      "Joseles",
    ]
  };
//Listas oara draggable
  List<DraggableListItem> equipoNegro = [];
  List<DraggableListItem> equipoBlanco = [];

  for (int i = 0; i < equipos.length; i++) {
    for (int j = 0; j < equipos.values.elementAt(i).length; j++) {
      if (i % 2 == 0) {
        equipoNegro.add(
          DraggableListItem(
            title: equipos.values.elementAt(i).elementAt(j).toString(),
            urlImage:
                'https://images.unsplash.com/photo-1617112848923-cc2234396a8d?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1567&q=80',
          ),
        );
      } else {
        equipoBlanco.add(
          DraggableListItem(
            title: equipos.values.elementAt(i).elementAt(j).toString(),
            urlImage:
                'https://images.unsplash.com/photo-1590502593747-42a996133562?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=975&q=80',
          ),
        );
      }
    }
  }
  List<DraggableList> allLists = [
    DraggableList(header: 'Negro', items: equipoNegro),
    DraggableList(header: 'Blanco', items: equipoBlanco),
  ];
  return allLists;
}
