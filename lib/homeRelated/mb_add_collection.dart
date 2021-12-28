import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customcharts/services/database_related.dart';
import 'package:customcharts/shared/shared_values.dart';
import 'package:flutter/material.dart';


class ModalBottomAddCollection extends StatefulWidget {
  @override
  _ModalBottomAddCollectionState createState() => _ModalBottomAddCollectionState();
}

class _ModalBottomAddCollectionState extends State<ModalBottomAddCollection> {
  bool isAddPressed = false;
  TextEditingController _textEditingController;

  Widget colExtras() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  void save() async {
    bool alreadyExists = await DatabaseService()
        .userData
        .doc(user.uid)
        .collection('My Collections')
        .doc(_textEditingController.text)
        .get()
        .then((value) => value.exists);

    if (alreadyExists) return;

    DateTime currentPhoneDate = DateTime.now(); //DateTime
    Timestamp myTimeStamp = Timestamp.fromDate(currentPhoneDate); //To TimeStamp

    await DatabaseService()
        .userData
        .doc(user.uid)
        .collection('My Collections')
        .doc(_textEditingController.text)
        .set({
      'title': _textEditingController.text,
      'timeStamp': myTimeStamp,
    });
  }

  @override
  void initState() {
    _textEditingController = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: TextFormField(
            controller: _textEditingController,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.greenAccent, width: 5.0),
                )),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.red,
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      child: Text(
                        'Abort',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: TextButton(
                onPressed: isAddPressed
                    ? null
                    : () async {
                  setState(() {
                    isAddPressed = true;
                  });
                  await save();

                  Navigator.pop(context);
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.blue,
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      child: Text(
                        'Add Collection',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}



