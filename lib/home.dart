import 'package:cubit_practice/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // when we can't see the updated value then we can use BlocBuilder like this ->
        // child: BlocBuilder<CounterCubit, int>(
          // builder: (context, state) {
            // child: Text('Your count is ${BlocProvider.of<CounterCubit>(context).state}', style: TextStyle(color: Colors.black, fontSize: 20),) // This is not working
            child: Text('Your count is ${context.watch<CounterCubit>().state}', style: TextStyle(color: Colors.black, fontSize: 20),)
            // return Text('$state');
          // }
        // ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        BlocProvider.of<CounterCubit>(context, listen: false).increamentCount();
      }, child: Icon(Icons.add),),
    );
  }
}
