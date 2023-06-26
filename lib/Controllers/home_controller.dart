import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final todos = <QueryDocumentSnapshot>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchTodos();
  }

  void fetchTodos() async {
    try {
      var result = await FirebaseFirestore.instance.collection('todos').get();
      todos.addAll(result.docs);
    } catch (e) {
      Get.snackbar("Error fetching todos", e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }
}
