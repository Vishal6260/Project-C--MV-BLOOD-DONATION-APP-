import 'package:mvblooddonationapp/services/database.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'models/request.dart';

class RequestList extends StatefulWidget {
  const RequestList({super.key});

  @override
  State<RequestList> createState() => _RequestListState();
}

class _RequestListState extends State<RequestList> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Request>?>.value(
      value: Database().requestlist(),
      initialData: null,
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Available Request"),
          ),
          body: LayoutBuilder(builder: (context, dimens) {
            final donors = Provider.of<List<Request>?>(context);
            List<Widget> childItems = [];
            if (donors != null) {
              for (var td in donors) {
                childItems.add(
                  RequestCard(
                    user: td,
                  ),
                );
              }
            }
            return ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: childItems,
            );
          })),
    );
  }
}

class RequestCard extends StatefulWidget {
  const RequestCard({
    super.key,
    required this.user,
  });

  final Request user;

  @override
  State<RequestCard> createState() => _RequestCardState();
}

class _RequestCardState extends State<RequestCard> {
  Future<void> _launchDialer(String contact) async {
    Uri url = Uri.parse("tel:$contact");
    if (!await launchUrl(url)) {
      throw Exception('Could not launch "tel:$contact"');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: 85,
                height: 85,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/image/Red.png'),
                    fit: BoxFit.fill,
                  ),
                  shape: BoxShape.rectangle,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        widget.user.name ?? "err",
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        widget.user.location ?? "err",
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        widget.user.bloodgroup ?? "err",
                        style: const TextStyle(
                          fontSize: 19,
                          color: Colors.red,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.phone_enabled),
                color: Colors.green,
                onPressed: () {
                  _launchDialer(widget.user.phone!);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
