import 'dart:convert';

import 'package:pegawai/detailpegawai_screen.dart';
import 'package:pegawai/editpegawai_screen.dart';
import 'package:pegawai/insertpegawai_screen.dart';
import 'package:pegawai/login_screen.dart';
import 'package:pegawai/logout_screen.dart';
import 'package:pegawai/utils/cek_session.dart';
import 'package:pegawai/utils/ip.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class PegawaiScreen extends StatefulWidget {
  const PegawaiScreen({Key? key}) : super(key: key);

  @override
  State<PegawaiScreen> createState() => _PegawaiScreenState();
}

class _PegawaiScreenState extends State<PegawaiScreen> {
  List alluser = [];
  List filteredUsers = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getAllUser();
  }

  Future<void> getAllUser() async {
    String urlAllUser = "$ip/getPegawai.php";
    try {
      var response = await http.get(Uri.parse(urlAllUser));
      setState(() {
        alluser = jsonDecode(response.body);
        filteredUsers = alluser;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteUser(String id) async {
    String urlDeleteUser = "$ip/deletePegawai.php";
    try {
      var responseDel = await http.post(Uri.parse(urlDeleteUser), body: {
        "id": id,
      });
      var delUser = jsonDecode(responseDel.body);
      if (delUser["success"] == "true") {
        print("hapus data Pegawai berhasil");
        getAllUser();
      } else {
        print("hapus data Pegawai berhasil");
      }
    } catch (e) {
      print(e);
    }
  }

  void searchUser(String query) {
    List searchResult = alluser
        .where(
            (user) => user["nama"].toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() {
      filteredUsers = searchResult;
    });
  }

  Future<void> refreshData() async {
    await getAllUser();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pegawai'),
        backgroundColor: Colors.green,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LogoutScreen()),
                );
              });
            },
            icon: Icon(Icons.exit_to_app),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: searchController,
              onChanged: searchUser,
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredUsers.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailPegawai(pegawai: filteredUsers[index]),
                        ),
                      );
                    },
                    title: Text(
                      filteredUsers[index]["nama"],
                      style: const TextStyle(
                        color: Colors.green,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      filteredUsers[index]["email"],
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditPegawai(
                                      pegawai: filteredUsers[index]),
                                ));
                            refreshData();
                          },
                          icon: const Icon(
                            Icons.edit_rounded,
                            size: 24,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            deleteUser(filteredUsers[index]["id"]);
                            getAllUser();
                          },
                          icon: const Icon(
                            Icons.delete,
                            size: 24,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => InsertPegawai()));
        },
        splashColor: Colors.green,
        backgroundColor: Colors.green,
        mini: true,
        child: const Icon(
          Icons.add,
          size: 24,
        ),
      ),
    );
  }
}
