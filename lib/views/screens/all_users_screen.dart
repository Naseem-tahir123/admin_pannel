import 'package:admin_pannel/models/user_model.dart';
import 'package:admin_pannel/utils/app_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllUsersScreen extends StatelessWidget {
  const AllUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Users"),
        centerTitle: true,
        backgroundColor: AppConstants.appMainColor,
      ),
      body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection("users")
              .orderBy("createdOn", descending: true)
              .get(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Center(
                  child: Text("Error occured while fetching users"));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.data!.docs.isEmpty) {
              return const Center(child: Text("No Users found"));
            }
            if (snapshot.data != null) {
              return ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final data = snapshot.data!.docs[index];
                    UserModel userModel = UserModel(
                        uId: data["uId"],
                        username: data["username"],
                        email: data["email"],
                        phone: data["phone"],
                        userImg: data["userImg"],
                        userDeviceToken: data["userDeviceToken"],
                        country: data["country"],
                        userAddress: data["userAddress"],
                        street: data["street"],
                        isAdmin: data["isAdmin"],
                        isActive: data["isActive"],
                        createdOn: data["createdOn"],
                        city: data["city"]);
                    return Card(
                      elevation: 5,
                      child: ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: AppConstants.appMainColor,
                        ),
                        title: Text(userModel.username),
                        subtitle: Text(userModel.email),
                      ),
                    );
                  });
            }
            return Container();
          }),
    );
  }
}
