import 'package:brewcrewapp/models/brew.dart';
import 'package:brewcrewapp/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DBService {

  final String uid;
  DBService ({ this.uid });

  final CollectionReference brewColl = Firestore.instance.collection('brews');

  Future<void> updateUserData (String name, String sugars, int strength) async {
    return await brewColl.document(uid).setData({
      'name': name,
      'sugars': sugars,
      'strength': strength,
    });
  }

  //brew list from snapshots
  List<Brew> _brewListFromSnaps(QuerySnapshot snap) {
    return snap.documents.map((doc) {
      return Brew(
        name: doc.data['name'] ?? '',
        sugars: doc.data['sugars'] ?? '0',
        strength: doc.data['strength'] ?? 100
      );
    }).toList();
  }

  //user data from snapshot
  UserData _userDataFromSnaps(DocumentSnapshot snap) {
    return UserData(
      uid: uid,
      name: snap.data['name'],
      sugars: snap.data['sugars'],
      strength: snap.data['strength'],
    );
  }

  //get brews stream
    Stream<List<Brew>> get brews {
      return brewColl.snapshots()
          .map(_brewListFromSnaps);
  }


  //get user doc stream
  Stream<UserData> get userData {
    return brewColl.document(uid).snapshots()
        .map(_userDataFromSnaps);
  }

  }