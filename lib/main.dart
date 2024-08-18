import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musicplayer/screen/view_screen.dart';

void main()=> runApp( 
   ProviderScope(child: MyApp())
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(  
      
       debugShowCheckedModeBanner: false,
       home: ViewScreen(),
    );
  }
}