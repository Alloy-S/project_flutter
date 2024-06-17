import 'package:admins/const/const.dart';
import 'package:admins/controllers/chats_controller.dart';
import 'package:admins/services/store_services.dart';
import 'package:admins/views/messages_screen/components/chat_bubble.dart';
import 'package:admins/views/widgets/loading_indicator.dart';
import 'package:admins/views/widgets/text_style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ChatsController());

    return Scaffold(
      appBar: AppBar(
        title: boldText(
            text: "${controller.friendName}", size: 16.0, color: fontGrey),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Obx(
              () => controller.isLoading.value
                  ? Center(
                      child: loadingIndicator(),
                    )
                  : Expanded(
                    child: StreamBuilder(
                        stream: StoreServices.getChatMessages(controller.chatDocId.toString()),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: loadingIndicator(),
                            );
                          } else if (snapshot.data!.docs.isEmpty) {
                            return Center(
                              child: "Send a message..."
                                  .text
                                  .color(darkGrey)
                                  .make(),
                            );
                          } else {
                            return ListView(
                              children: snapshot.data!.docs.mapIndexed((currentValue, index) {
                                var data = snapshot.data!.docs[index];

                                return Align(
                                  alignment: 
                                      data['uid'] == currentUser!.uid ? Alignment.centerRight : Alignment.centerLeft,

                                  child: chatBubble(data));
                              }).toList(),
                            );
                          }
                        },
                      ),
                      // child: ListView.builder(
                      //   itemCount: 20,
                      //   itemBuilder: ((context, index) {
                      //     return chatBubble();
                      //   }),
                      // ),
                    ),
            ),
            10.heightBox,
            SizedBox(
              height: 60,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        isDense: true,
                        hintText: "Enter Message",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: purpleColor,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: purpleColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      controller.sendMsg(controller.msgController.text);
                      controller.msgController.clear();
                    },
                    icon: const Icon(Icons.send, color: purpleColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
