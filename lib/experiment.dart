import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FetchDataFromFirebase extends StatefulWidget {
  const FetchDataFromFirebase({super.key});

  @override
  State<FetchDataFromFirebase> createState() => _FetchDataFromFirebaseState();
}

class _FetchDataFromFirebaseState extends State<FetchDataFromFirebase> {
  final CollectionReference fetchData =
      FirebaseFirestore.instance.collection("user");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: fetchData.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasError) {
              return Center(child: Text("Something went wrong!"));
            }

            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return Material(
                  child: ListTile(
                    title: Text(documentSnapshot['name']),
                  ),
                );
              },
            );
          }),
    );
  }
}
