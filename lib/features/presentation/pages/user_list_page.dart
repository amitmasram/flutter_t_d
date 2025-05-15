import 'package:cv_d_project/features/data/repositories/api_serverce.dart';
import 'package:flutter/material.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  bool isSelected = false;
  bool isSelectedAll = false;
  bool isReset = false;
  bool isSubmit = false;

  List<bool> isonlyselected = List.generate(20, (index) => false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff9ebb7b), Colors.lightBlue],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
        title: const Text(
          'Available Users',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: ApiServerce().getUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(
              color: Colors.lightBlue,
            ));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No users found'));
          }

          final users = snapshot.data!;

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Transform.scale(
                          scale: 1.2,
                          child: Checkbox(
                            activeColor: Colors.green,
                            checkColor: Colors.white,
                            side: const BorderSide(color: Colors.green, width: 2.0),
                            value: isSelected,
                            onChanged: (value) {
                              setState(() {
                                isSelected = value!;
                                isSelectedAll = value;
                                for (int i = 0; i < isonlyselected.length; i++) {
                                  isonlyselected[i] = value;
                                }
                              });
                            },
                          ),
                        ),
                        const Text(
                          'Select all',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isonlyselected = List.generate(20, (index) => false);
                          isSelected = false;
                          isSelectedAll = false;
                        });
                      },
                      child: Icon(Icons.delete, color: Colors.red, size: 30),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            isonlyselected[index] = !isonlyselected[index];
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                          height: 60,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color:
                                isonlyselected[index]
                                    ? Colors.green.withOpacity(0.2)
                                    : Color(0xfff2f2f2),
                            borderRadius: BorderRadius.circular(3),
                            shape: BoxShape.rectangle,
                            border:
                                isonlyselected[index]
                                    ? Border.all(
                                      color: Colors.green.shade300,
                                      width: 2.0,
                                      style: BorderStyle.solid,
                                      strokeAlign: BorderSide.strokeAlignInside,
                                    )
                                    : null,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                isonlyselected[index] ? Icons.check_sharp : null,
                                size: 27,
                                color:
                                    isonlyselected[index]
                                        ? Colors.green.shade400
                                        : Colors.grey,
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                   Text(
                                    users[index].name.toString(),
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                   Text(
                                    users[index].email.toString(),
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isonlyselected = List.generate(20, (index) => false);
                          });
                        },
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),

                            border: Border.all(
                              color: Colors.lightBlue,
                              width: 2.0,
                              style: BorderStyle.solid,
                              strokeAlign: BorderSide.strokeAlignInside,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Reset",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.lightBlue,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.lightBlue,
                          ),
                          child: Center(
                            child: Text(
                              "Submit Users",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}
