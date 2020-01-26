import 'package:carrot_club_app/configs/routes/routes.dart';
import 'package:carrot_club_app/providers/global_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalProvider globalProvider = Provider.of<GlobalProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification')
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: globalProvider.receivedMessages.length == 0 ? Center(child: Text('No new Messages')) : ListView.separated(
            itemCount: globalProvider.receivedMessages.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  contentPadding: EdgeInsets.all(0),
                  leading: Icon(
                    globalProvider.receivedMessages[index]["title"] == 'Error' ? Icons.error : Icons.check_circle,
                    size: 50,
                    color: globalProvider.receivedMessages[index]["title"] == 'Error' ? Colors.red[800]: Colors.green,
                  ),
                  title: Text(
                    globalProvider.receivedMessages[index]["title"],
                    style: Theme.of(context).textTheme.title,
                  ),
                  subtitle: Text(globalProvider.receivedMessages[index]["body"]),
                  onTap: () {
                    print(globalProvider.receivedMessages[index]["orderId"]);
                    if(globalProvider.receivedMessages[index]["orderId"]?.isNotEmpty ?? false){
                      Navigator.pushNamed(context, Routes.REWARD_POINT + '?order_id=${globalProvider.receivedMessages[index]["orderId"]}');
                    }
                  },
                );
              },
              separatorBuilder: (context, index) {
                return Divider(thickness: 2,);
              },
          ),
        ),
      ),
    );
  }
}
