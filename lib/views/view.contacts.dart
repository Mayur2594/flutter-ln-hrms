import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ln_hrms/controllers/controller.contacts.dart';
import 'package:ln_hrms/customwidgets/widget.applayout.dart';
import 'package:ln_hrms/customwidgets/widget.shimmers.dart';
import 'package:shimmer/shimmer.dart';

class ContactsView extends StatelessWidget {
  const ContactsView({super.key});

  @override
  Widget build(BuildContext context) {
    final ContactsController contactsCtrl = Get.find();
    return Scaffold(
      appBar: AppBarView(),
      drawer: const DrawerView(),
      body: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: Container(
              child: Padding(
                padding: const EdgeInsets.all(7.0),
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: 'Search',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    contactsCtrl.filterContacts(value);
                  },
                ),
              ),
            ),
          ),
          body: Obx(() {
            // ignore: invalid_use_of_protected_member
            if (contactsCtrl.loadingContacts.value == true) {
              return const ListShimmerLoader();
            } else {
              if (contactsCtrl.filteredContactsList.value.isEmpty) {
                return const Column(
                  children: [Text("No Records Found")],
                );
              } else {
                return ListView.separated(
                    // ignore: invalid_use_of_protected_member
                    itemCount: contactsCtrl.filteredContactsList.value.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      // ignore: invalid_use_of_protected_member
                      final item =
                          contactsCtrl.filteredContactsList.value[index];
                      return ListTile(
                        leading: CircleAvatar(
                            backgroundImage: NetworkImage(item['profile_pic'])),
                        title: Text(item['name']),
                        subtitle:
                            Text(item['designation_name'] ?? "Not Available"),
                      );
                    });
              }
            }
          })),
    );
  }
}
