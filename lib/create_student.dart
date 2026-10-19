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
    if (isSaving) return;

    setState(() {
      isSaving = true;
    });

    final studentNo = studentNoController.text.trim();
    final name = nameController.text.trim();
    final course = courseController.text.trim();

    try {
      await students.add({
        'student_no': studentNo,
        'name': name,
        'course': course,
        'createdAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;

      studentNoController.clear();
      nameController.clear();
      courseController.clear();

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Student successfully created.')));
    } on FirebaseException catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.message ?? 'Unable to save the student.')),
      );
    } finally {
      if (mounted) {
        setState(() {
          isSaving = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF2196F3);
    const backgroundColor = Color(0xFFF5F7FC);
    const textColor = Color(0xFF1E293B);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Create Student Page',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 600,
                    minHeight: constraints.maxHeight - 48,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Header Icon
                      Center(
                        child: Container(
                          width: 84,
                          height: 84,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE3F0FF),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: const Icon(
                            Icons.person_add_alt_1_rounded,
                            size: 42,
                            color: primaryColor,
                          ),
                        ),
                      ),

                      const SizedBox(height: 22),

                      Text(
                        "Create Student Data!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      SizedBox(height: 8),

                      const Text(
                        'Enter the student information below',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF64748B),
                        ),
                      ),

                      const SizedBox(height: 30),

                      // Form Card
                      Container(
                        padding: EdgeInsets.all(22),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(color: Color(0xFFE5EAF2)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.035),
                              blurRadius: 18,
                              offset: Offset(0, 6),
                            ),
                          ],
                        ),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Student Information',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: textColor,
                              ),
                            ),

                            const SizedBox(height: 5),

                            Text(
                              'Fill in the student details',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF94A3B8),
                              ),
                            ),

                            const SizedBox(height: 24),

                            // Student Number
                            Text(
                              'Student Number',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: textColor,
                              ),
                            ),

                            const SizedBox(height: 8),

                            TextField(
                              controller: studentNoController,
                              decoration: InputDecoration(
                                hintText: 'Enter student number',
                                hintStyle: TextStyle(
                                  color: Color(0xFF94A3B8),
                                  fontSize: 14,
                                ),
                                prefixIcon: Icon(
                                  Icons.badge_outlined,
                                  color: primaryColor,
                                ),
                                filled: true,
                                fillColor: Color(0xFFF8FAFD),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 17,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Color(0xFFE2E8F0),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Color(0xFFE2E8F0),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: primaryColor,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),

                            // Student Name
                            Text(
                              'Student Name',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: textColor,
                              ),
                            ),

                            const SizedBox(height: 8),

                            TextField(
                              controller: nameController,
                              decoration: InputDecoration(
                                hintText: 'Enter student full name',
                                hintStyle: const TextStyle(
                                  color: Color(0xFF94A3B8),
                                  fontSize: 14,
                                ),
                                prefixIcon: const Icon(
                                  Icons.person_outline_rounded,
                                  color: primaryColor,
                                ),
                                filled: true,
                                fillColor: const Color(0xFFF8FAFD),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 17,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: Color(0xFFE2E8F0),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: Color(0xFFE2E8F0),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: primaryColor,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),

                            // Course
                            const Text(
                              'Course',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: textColor,
                              ),
                            ),

                            const SizedBox(height: 8),

                            TextField(
                              controller: courseController,
                              decoration: InputDecoration(
                                hintText: 'Enter student course',
                                hintStyle: const TextStyle(
                                  color: Color(0xFF94A3B8),
                                  fontSize: 14,
                                ),
                                prefixIcon: const Icon(
                                  Icons.school_outlined,
                                  color: primaryColor,
                                ),
                                filled: true,
                                fillColor: const Color(0xFFF8FAFD),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 17,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: Color(0xFFE2E8F0),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: Color(0xFFE2E8F0),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: primaryColor,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 28),

                            // Save Button
                            SizedBox(
                              width: double.infinity,
                              height: 52,
                              child: ElevatedButton(
                                onPressed: isSaving ? null : saveTestData,
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: primaryColor,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: isSaving
                                    ? const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2.5,
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                    Colors.white,
                                                  ),
                                            ),
                                          ),
                                          SizedBox(width: 12),
                                          Text(
                                            'Saving Student...',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      )
                                    : const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.save_outlined, size: 20),
                                          SizedBox(width: 10),
                                          Text(
                                            'Save Student',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // TextField(
                      //   controller: studentNoController,
                      //   decoration: InputDecoration(
                      //     labelText: 'Student No',
                      //     border: OutlineInputBorder(),
                      //     prefixIcon: Icon(Icons.numbers),
                      //   ),
                      // ),

                      // SizedBox(height: 16),

                      // TextField(
                      //   controller: nameController,
                      //   decoration: InputDecoration(
                      //     labelText: 'Student name',
                      //     border: OutlineInputBorder(),
                      //     prefixIcon: Icon(Icons.person),
                      //   ),
                      // ),
                      // SizedBox(height: 12),

                      // TextField(
                      //   controller: courseController,
                      //   decoration: InputDecoration(
                      //     labelText: 'Course',
                      //     border: OutlineInputBorder(),
                      //     prefixIcon: Icon(Icons.school),
                      //   ),
                      // ),

                      // SizedBox(height: 12),
                      // SizedBox(
                      //   width: double.infinity,
                      //   height: 40,
                      //   child: ElevatedButton(
                      //     style: ElevatedButton.styleFrom(
                      //       backgroundColor: Colors.blue,
                      //       foregroundColor: Colors.white,
                      //     ),
                      //     onPressed: saveTestData,
                      //     child: Text('Save Test Student'),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
