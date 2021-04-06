import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: RawScrollbar(
                  isAlwaysShown: true,
                  thumbColor: Colors.blue,
                  child: ListView(
                    children: [
                      Divider(
                        thickness: 2,
                      ),
                      //HandOuts
                      Container(
                        child: Column(
                          children: [
                            Text(
                              "Handouts List",
                              style: TextStyle(
                                  fontSize: 30,
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  "African Studies",
                                  style: TextStyle(fontSize: 18),
                                )),
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Communication Skills",
                                  style: TextStyle(fontSize: 18),
                                )),
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Circuit Theory",
                                  style: TextStyle(fontSize: 18),
                                )),
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Computing",
                                  style: TextStyle(fontSize: 18),
                                )),
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Programming",
                                  style: TextStyle(fontSize: 18),
                                )),
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Statistics",
                                  style: TextStyle(fontSize: 18),
                                )),
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Mathematics",
                                  style: TextStyle(fontSize: 18),
                                )),
                          ],
                        ),
                      ),
                      //Groups
                      Divider(
                        thickness: 2,
                      ),
                      //Groups section
                      Container(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "Groups",
                                  style: TextStyle(
                                      fontSize: 30,
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 40,
                                ),
                                TextButton(
                                    onPressed: () {},
                                    child: Icon(
                                      Icons.add,
                                      size: 30,
                                    ))
                              ],
                            ),
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Group 1",
                                  style: TextStyle(fontSize: 18),
                                )),
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Group 2",
                                  style: TextStyle(fontSize: 18),
                                )),
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Group 3",
                                  style: TextStyle(fontSize: 18),
                                )),
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Group 4",
                                  style: TextStyle(fontSize: 18),
                                )),
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Group 5",
                                  style: TextStyle(fontSize: 18),
                                )),
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Group 6",
                                  style: TextStyle(fontSize: 18),
                                )),
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Group 7",
                                  style: TextStyle(fontSize: 18),
                                )),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Container(
            //   height: 50,
            //   width: 50,
            //   decoration: BoxDecoration(border: Border.all(width: 1)),
            // )
            Container(
              decoration: BoxDecoration(color: Colors.blue),
              height: 50,
              // width: 150,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Attendance",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.app_registration,
                      color: Colors.white,
                      size: 30,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
