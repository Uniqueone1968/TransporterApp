import 'package:flutter/material.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/widgets/whatsappShare.dart';

// ignore: must_be_immutable
class DynamicLinkService extends StatefulWidget {
  int deviceId;
  String? truckId;
  String? truckNo;
  DynamicLinkService({
    required this.deviceId,
    required this.truckId,
    required this.truckNo,
  });

  @override
  DynamicLink createState() => DynamicLink();
}

class DynamicLink extends State<DynamicLinkService> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: bidBackground, width: 4),
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: FloatingActionButton(
          heroTag: "button2",
          backgroundColor: Colors.white,
          foregroundColor: bidBackground,
          child: Image.asset(
            'assets/icons/share.png',
            scale: 2.5,
          ),
          onPressed: () async {
            showDialog(
                context: context,
                builder: (context) => WhatsappShare(
                      deviceId: widget.deviceId,
                      truckId: widget.truckId,
                      truckNo: widget.truckNo,
                    ));
            print(MediaQuery.of(context).size.width);
          },
        ),
      ),
    );
  }
}
