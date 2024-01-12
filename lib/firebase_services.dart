import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference linksCollection =
      FirebaseFirestore.instance.collection('links');

  Future<List<String>> getLinks() async {
    try {
      QuerySnapshot querySnapshot = await linksCollection.get();
      List<String> links = [];

      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        String url = data['url'] ?? '';
        links.add(url);
      }

      return links;
    } catch (e) {
      print('Error retrieving links: $e');
      return [];
    }
  }
}
