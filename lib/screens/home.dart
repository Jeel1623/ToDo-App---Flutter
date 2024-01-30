import 'package:flutter/material.dart';
import 'package:todolist/constants/colors.dart';
import 'package:todolist/model/todo.dart';
import 'package:todolist/widgets/todo_item.dart';

class Home extends StatefulWidget {
   Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todoslist= ToDo.todolist();
  List<ToDo> _foundToDo = [];
  final _todoController =TextEditingController();


  @override
  void initState() {
    _foundToDo=todoslist;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: 
      
      Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 0,vertical: 10),
            child: 
            Column(
              children: [
                searchbox(),
                Expanded(
                  
                  child: ListView(
                    
                    children: [ 
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 0),
                        margin: EdgeInsets.only(top: 50,bottom: 10),
                        child: Text("All ToDos",style: TextStyle(fontSize: 30,fontWeight:FontWeight.w500) ,),
                      ),
          
          
                      for(ToDo todo in _foundToDo) 
                      ToDoItem(todo: todo,
                      onToDoChanged: _handleToDoChange,
                      onDeleteItem: _deleteToDoItem,
                      ),
                      
                    ],
                  ),
                )
              ]
              
              )
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(children: [
                 Expanded(child:  Container(margin: EdgeInsets.only(bottom: 20,right: 20,left: 20 ),
                 padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                 decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const[BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 0.0),
                    blurRadius: 10.0,
                    spreadRadius: 0.0,
                    )],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: _todoController,
                    decoration: InputDecoration(
                      hintText: 'Add a new todo item',
                      border: InputBorder.none
                    ),
                   ),
                  ),),
                  Container(
                    
                    
                    height: 60,
                    width: 80,
                    
                    margin:  EdgeInsets.only(bottom: 20,right: 20),
                    child: ElevatedButton(
                      
                      style:  ElevatedButton.styleFrom(
                        primary: Colors.deepPurple,
                        minimumSize: Size(60,60),
                        elevation: 10
                      ),
                      onPressed: () {
                        _addToDoItem(_todoController.text);
                      },
                      child: Text('+',style: TextStyle(fontSize: 40,color: Colors.black),)),
                  )
              ]),
            )
        ],
      )
    );
  }



  void _handleToDoChange(ToDo todo){
  setState((){

  });
  todo.isDone=!todo.isDone;
}

void _deleteToDoItem(String id){
  setState(() {
    
  });
  todoslist.removeWhere((item)=> item.id == id);
} 


void _addToDoItem(String toDo){
  setState(() {
    todoslist.add(ToDo(id: DateTime.now().millisecondsSinceEpoch.toString(),todoText: toDo));
    
  });
  _todoController.clear();
}









void runFilter(String enteredKeyword){
   List<ToDo> results = [];
   if( enteredKeyword.isEmpty){
    results = todoslist; 
   }
   else{ 
    results = todoslist.where((item) => item.todoText!.toLowerCase().contains(enteredKeyword.toLowerCase())).toList();
   }

   setState(() {
     _foundToDo = results;
   });
}


Widget searchbox(){
  return  Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
    child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: 
                BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: TextField(
                  onChanged: (value) => runFilter(value),
                  decoration: InputDecoration(
                    
                    contentPadding: EdgeInsets.all(0),
                    prefixIcon: Icon( 
                      Icons.search,
                      color: Colors.black,
                      size: 25,
                    ),
                    prefixIconConstraints: BoxConstraints(maxHeight: 30,minHeight: 20),
                    border: InputBorder.none,
                    hintText: 'Search',
                    hintStyle: TextStyle(color:  Colors.grey,fontSize: 16)
                  ),
                  
                ),
              ),
  );
}

AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.deepPurple,
      title:
       Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Icon(
          Icons.menu,
          color: Colors.black,
          size: 30,
          ),
        Container(
            height: 50,
            width: 50,
            child: ClipRRect(
              child: Image.asset('assets/images/avatar3.png')
              ),
          )
      ]), 
      );
  }
}