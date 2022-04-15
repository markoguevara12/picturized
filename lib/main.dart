
// ignore_for_file: avoid_print, must_be_immutable

// ignore: unnecessary_import
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'src.dart';
// ignore: import_of_legacy_library_into_null_safe, unused_import

// ignore: unused_import
import 'dart:async';
// ignore: unused_import
import 'dart:convert';
// ignore: unused_import
import 'package:http/http.dart' as http;


void main(){
  // ignore: unnecessary_new
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home:Login(),
  ));
}



class FirsPage extends StatelessWidget {
 // ignore: prefer_final_fields, unnecessary_new
 var _categoryNameController = new TextEditingController();
 int selectedIndex = 0;

  FirsPage({Key? key}) : super(key: key);
 @override

 @override
 Widget build(BuildContext context) {
   return Scaffold(
     // ignore: avoid_unnecessary_containers
     body: Center(
       child: Container(
         decoration:const BoxDecoration(
    image: DecorationImage(image: NetworkImage('https://img.freepik.com/foto-gratis/papel-arrugado-sobre-fondo-blanco_63176-62.jpg'),
    fit: BoxFit.cover)
  ),
         child: Center(
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget> [
               const Padding(
                 padding:  EdgeInsets.all(30.0)
                 ),
                 Center(child: picturized()),
                  const SizedBox(height: 10,),
                   ListTile(
                     title:  TextFormField(
                      controller:_categoryNameController,
                       decoration: InputDecoration(
                        labelText: 'Enter a Category',
                         hintText: 'eg: Dogs, Bikes, Cats...',
                         border: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(10.0)),
                           contentPadding: 
                           const EdgeInsets.fromLTRB(10.0, 15.0,10.0, 15.0),
                      ),
                     ),
                   ),
                  const Padding(
                     padding:  EdgeInsets.all(5.0)
                     ),
                     ListTile(
                       title:  Material(
                         color:  Colors.lightBlue,
                         elevation: 5.0,
                         borderRadius: BorderRadius.circular(25.0),
                         child: MaterialButton(
                           height: 47.5,
                           onPressed: (){
                             Navigator.of(context).push(
                               MaterialPageRoute(
                                 builder: (context){
                                   return SecondPage(category: _categoryNameController.text,);
                                 })
                             );
                           },
                           child:const Text('Search',
                           style: TextStyle(
                             fontSize: 22.0,fontWeight: FontWeight.bold,
                             color: Colors.white),
                           ),                         
                      ),

                    ),
                  ),
             ],
           ),
         ),
       ),
     ),
   );
 }
}


class SecondPage extends StatefulWidget {
  String category;
  // ignore: use_key_in_widget_constructors
  SecondPage({required this.category});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[350],
        title:const Text('Picturized',
        style: TextStyle(color: Colors.red,
        fontFamily: 'Schyler',
        fontSize: 20,
        fontWeight: FontWeight.bold),
        ) ,
        centerTitle:true ,
      ),
  
      body: FutureBuilder(
        future: getPics(widget.category),
        builder: (context, snapShot){
          // ignore: unused_local_variable
          Map? data = snapShot.data as Map?;
          if(snapShot.hasError){
            print(snapShot.error);
            return const Text('Fail to get response from the serer',
            style: TextStyle(
              color: Colors.red,fontSize: 22.0
            ),);
          }else if(snapShot.hasData){
            return  Center(
              child:  ListView.builder( 
                itemCount: data?.length,
                itemBuilder: (context,index){
                  return Column(
                     children: [
                       
                       // ignore: avoid_unnecessary_containers
                       Container(
                        child:  InkWell(
                          onTap: (){},
                          child:  Image.network(
                            '${data!['hits'][index]['largeImageURL']}'
                          ) ,
                        ),
                       ),
                      const  Padding(padding:  EdgeInsets.all(5.0))
                     ],
                  );
                      
                })
            );
          }else if(!snapShot.hasData){
            return const Center(child: CircularProgressIndicator(),);
          }
         
           return build(context);
        }),
    );
  }
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final user = TextEditingController();
  final password = TextEditingController();
  String us ='';
  String pass = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
    padding:const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
  decoration:const BoxDecoration(
    image: DecorationImage(image: NetworkImage('https://storage.googleapis.com/pod_public/1300/86858.jpg'),
    fit: BoxFit.cover)
  ),
  child: Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        
        picturized(),
        const SizedBox(height: 10),
        Container(
    padding:const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
    child: TextField(
      controller: user,
    decoration: const InputDecoration(
      hintText: 'User',
      fillColor: Colors.white,
      filled: true,
      
    ),
  )),
        Container(
    padding:const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
    child: TextField(
      controller: password,
      obscureText: true,
    decoration:const InputDecoration(
      
      hintText: 'Password',
      fillColor: Colors.white,
      filled: true,
      
    ),
  )),
       Container(
    padding:const EdgeInsets.symmetric(
      horizontal: 0,
      vertical: 4),
    child:  ElevatedButton(
    
    onPressed: (){
       us = user.text;
       pass = password.text;
       if(us == 'user' && pass == 'user'){
       
           Navigator.of(context).push(MaterialPageRoute(
             builder: (context){
               return FirsPage();
             }));

       }else{
         showDialog(
           context: context,
            builder: (BuildContext context){
              return  AlertDialog(
              title: const Text('OOPS!',
              style: TextStyle(
              color: Colors.red,)                
                ),
                content: SingleChildScrollView(
                  child: ListBody(
                       children:const [
                           Text('Los Datos son incorrectos, verifique e intente de nuevo',)
                       ],
                  ),
                ),
              );
            });
       }
    }, 
    child: const Text(
      'Enter'),
      )
  )
      ],
    ),
  ),
  ),
    );
  }
}
Widget picturized(){
  return const Text('Picturized',
  style: TextStyle(color: Colors.red,
  fontSize: 50.0,fontWeight: FontWeight.bold,
  fontFamily: 'Schyler'),
  );
}


Future<Map> getPics(String category) async{
  String url = 'https://pixabay.com/api/?key=$apiKey&q=$category&image_type=photo';
  http.Response response = await http.get(Uri.parse(url));
  return json.decode(response.body);
}
