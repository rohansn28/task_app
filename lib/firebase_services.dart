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

  Future<Map<String, Map<String, dynamic>>> fetchDocuments() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('links').get();

      Map<String, Map<String, dynamic>> tempMap = {};

      querySnapshot.docs.forEach((DocumentSnapshot document) {
        bool disable = document['disable'];
        String url = document['url'];

        Map<String, dynamic> documentMap = {
          'disable': disable,
          'url': url,
          // Add other fields as needed
        };

        tempMap[document.id] = documentMap;
      });
      // print(tempMap);
      return tempMap;
    } catch (e) {
      print('Error fetching documents: $e');
      return {}; // Return an empty map in case of an error
    }
  }

  Future<Map<String, Map<String, dynamic>>> bottomNavLinks() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('bottomnavlinks').get();

      Map<String, Map<String, dynamic>> tempMap = {};

      querySnapshot.docs.forEach((DocumentSnapshot document) {
        String tag = document['tag'];
        String url = document['url'];

        Map<String, dynamic> documentMap = {
          'tag': tag,
          'url': url,
          // Add other fields as needed
        };

        tempMap[document.id] = documentMap;
      });
      // print(tempMap);
      return tempMap;
    } catch (e) {
      print('Error fetching documents: $e');
      return {}; // Return an empty map in case of an error
    }
  }
}
