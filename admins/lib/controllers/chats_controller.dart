import 'package:admins/const/const.dart';
import 'package:admins/controllers/home_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ChatsController extends GetxController {

  ChatsController(this.chatDocId);
  @override
  void onInit() {
    // getChatId(friendId: friendId, friendName: friendName);
    super.onInit();
  }

  var chats = firestore.collection(chatsCollection);

  var friendName;
  var friendId;

  var senderName = Get.find<HomeController>().username;
  var currentId = currentUser!.uid;

  var msgController = TextEditingController();

  dynamic chatDocId;

  var isLoading = false.obs;

  // getChatId({friendId, friendName}) async {
  //   isLoading(true);

  //   await chats
  //       .where('users', isEqualTo: {friendId: null, currentId: null})
  //       .limit(1)
  //       .get()
  //       .then((QuerySnapshot snapshot) {
  //         if (snapshot.docs.isNotEmpty) {
  //           chatDocId = snapshot.docs.single.id;
  //         } else {
  //           chats.add({
  //             'created_on': null,
  //             'last_msg': '',
  //             'users': {friendId: null, currentId: null},
  //             'toId': '',
  //             'fromId': '',
  //             'friend_name': friendName,
  //             'sender_name': senderName
  //           }).then((value) {
  //             {
  //               chatDocId = value.id;
  //             }
  //           });
  //         }
  //       });
  //       isLoading(false);
  // }

  sendMsg(String msg) async {
    if (msg.trim().isNotEmpty) {
      chats.doc(chatDocId).update({
        'created_on': FieldValue.serverTimestamp(),
        'last_msg': msg,
        // 'toId': friendId,
        // 'fromId': currentId,
      });

      chats.doc(chatDocId).collection(messagesCollection).doc().set({
        'created_on': FieldValue.serverTimestamp(),
        'msg': msg,
        'uid': currentId,
      });
    }
  }
}