import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final user = FirebaseAuth.instance.currentUser!;

var dashboardAppBar = AppBar(
  title: const Text("Sutra"),
  centerTitle: true,
);

var dashboardDrawer = Drawer(
  backgroundColor: Colors.grey[300],
  child: Column(
    children: [
      DrawerHeader(
        child: Image.asset('asset/Brand/Black_Wire.png'),
      ),
      Text(user.email!),
      const ListTile(
        leading: Icon(Icons.dashboard),
        title: Text("D A S H B O A R D"),
      ),
      const ListTile(
        leading: Icon(Icons.home),
        title: Text("H O M E"),
      ),
      const ListTile(
        leading: Icon(Icons.chat),
        title: Text("C H A T S"),
      ),
      const ListTile(
        leading: Icon(Icons.settings),
        title: Text("S E T T I N G S"),
      ),
      ListTile(
        leading: const Icon(Icons.logout),
        title: const Text("L O G O U T"),
        onTap: () {
          FirebaseAuth.instance.signOut();
        },
      ),
    ],
  ),
);
