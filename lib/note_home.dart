import 'package:cubit_practice/DB/data_model.dart';
import 'package:cubit_practice/add_note.dart';
import 'package:cubit_practice/counter_cubit.dart';
import 'package:cubit_practice/state_management/db/db_cubit.dart';
import 'package:cubit_practice/state_management/db/db_state_cubit.dart';
import 'package:cubit_practice/state_management/list/list_cubit.dart';
import 'package:cubit_practice/state_management/list/list_cubit.dart';
import 'package:cubit_practice/state_management/list/list_state_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoteHome extends StatefulWidget {
  @override
  State<NoteHome> createState() => _NoteHomeState();
}

class _NoteHomeState extends State<NoteHome> {
  // const NoteHome({super.key});
  // List<Map<String, dynamic>> allData = [];

  @override
  void initState() {
    super.initState();
    context.read<DbCubit>().fetchInitialData();
  }

  @override
  Widget build(BuildContext context) {

    TextEditingController titleController = TextEditingController();
    TextEditingController desController = TextEditingController();
// print('Main context called');
    // allData = context.watch<ListCubit>().state.data;
    // allData = BlocProvider.of<ListCubit>(context).state.data;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: BlocBuilder<DbCubit, DbStateCubit>(builder: (ctx, state){
        var allData = state.dataModel;
        print('inner context called');
        return allData.isNotEmpty ? ListView.builder(
          itemCount: allData.length,
          itemBuilder: (_, index) {
            return ListTile(
              title: Text(allData[index].title, style: TextStyle(fontSize: 25, color: Colors.black),),
              subtitle: Text(allData[index].description, style: TextStyle(fontSize: 20, color: Colors.grey),),
              trailing: SizedBox(
                width: 100,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {    
                        titleController.text = allData[index].title;
                        desController.text = allData[index].description;
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => UpdateNoteScreen(
                        //             dataModel: DataModel(
                        //                 title: titleController.text,
                        //                 description: desController.text,
                        //                 id: mData[index].id),
                        //           )),
                        // );

                        showModalBottomSheet(
                          context: context,
                          builder: (_) {
                            return Container(
                              padding: const EdgeInsets.all(11),
                              width: double.infinity,
                              child: Column(
                                children: [
                                  const Text(
                                    'Add Note',
                                    style: TextStyle(fontSize: 25),
                                  ),
                                  const SizedBox(
                                    height: 11,
                                  ),
                                  TextField(
                                    controller: titleController,
                                    decoration: InputDecoration(
                                      hintText: "Enter title here..",
                                      label: const Text('Title'),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(11),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(11),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 11,
                                  ),
                                  TextField(
                                    controller: desController,
                                    minLines: 4,
                                    maxLines: 6,
                                    decoration: InputDecoration(
                                      hintText: "Enter desc here..",
                                      label: const Text('Desc'),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(11),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(11),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 11,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      OutlinedButton(
                                        onPressed: () {
                                          // using list cubit
                                          // BlocProvider.of<ListCubit>(ctx, listen: false).updateNote(updatedTitle: titleController.text, updatedDescription: desController.text, index: index);
                                          
                                          // using db cubit
                                          BlocProvider.of<DbCubit>(ctx, listen: false).updateData(uData: DataModel(title: titleController.text, description: desController.text, id: allData[index].id));
                                              Navigator.pop(context);
                                        },
                                        child: const Text('Save'),
                                      ),
                                      OutlinedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Cancel'),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () {
                        // Delete note through list Cubit
                        // BlocProvider.of<ListCubit>(ctx, listen: false).removeNote(index: index);

                        // Delete note through db cubit
                        BlocProvider.of<DbCubit>(ctx, listen: false).deleteData(noteId: allData[index].id);
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }) : Center(child: Text('No notes yet!!, please add note'),);
      }),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddNote()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
