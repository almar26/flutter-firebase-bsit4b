import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CreateStudent extends StatefulWidget {
  const new({super.key});

  @override
  State<CreateStudent> createState() => _CreateStudentState();
}

class _CreateStudentState extends State<CreateStudent> {
  final studentNoController = TextEditingController();
  final nameController = TextEditingController();
  final courseController = TextEditingController();
  bool isSaving = false;

  final CollectionReference<Map<String, dynamic>> students = FirebaseFirestore
      .instance
      .collection('students');

  // Add student in the Firestore database
  Future<void> saveTestData() async {
    final student_no = studentNoController.text.trim();
    final name = nameController.text.trim();
    final course = courseController.text.trim();

    try {
      await students.add({
        'student_no': student_no,
        'name': name,
        'course': course,
        'createdAt': FieldValue.serverTimestamp(),
      });

      studentNoController.clear();
      nameController.clear();
      courseController.clear();

      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Student successfully created.')));
    } on FirebaseException catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.message ?? 'Unable to save the student.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Student Page"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Create Student Data!",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),

                TextField(
                  controller: studentNoController,
                  decoration: InputDecoration(
                    labelText: 'Student No',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.numbers),
                  ),
                ),

                SizedBox(height: 16),

                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Student name',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                SizedBox(height: 12),

                TextField(
                  controller: courseController,
                  decoration: InputDecoration(
                    labelText: 'Course',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.school),
                  ),
                ),

                SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: saveTestData,
                    child: Text('Save Test Student'),
                  ),
                ),

                // SizedBox(height: 16),

                // const Divider(height: 1),

                // Expanded(
                //   child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                //     stream: students.snapshots(),
                //     builder: (context, snapshot) {
                //       if (snapshot.connectionState == ConnectionState.waiting) {
                //         return Center(child: const CircularProgressIndicator());
                //       }

                //       if (snapshot.hasError) {
                //         return Text('Error: ${snapshot.error}');
                //       }

                //       final documents = snapshot.data?.docs ?? [];

                //       if (documents.isEmpty) {
                //         return Center(child: Text('No student records yet.'));
                //       }

                //       return ListView.builder(
                //         itemCount: documents.length,
                //         itemBuilder: (context, index) {
                //           final document = documents[index];
                //           final data = document.data();

                //           final studentno = data["student_no"] ?? '';
                //           final name = data["name"] ?? '';
                //           final course = data['course'] ?? '';

                //           return Card(
                //             child: ListTile(
                //               isThreeLine: true,
                //               leading: Icon(Icons.person),
                //               title: Text(name),
                //               subtitle: Column(
                //                 crossAxisAlignment: CrossAxisAlignment.start,
                //                 children: [Text(studentno), Text(course)],
                //               ),
                //             ),
                //           );
                //         },
                //       );
                //     },
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
