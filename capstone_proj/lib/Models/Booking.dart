import 'package:cloud_firestore/cloud_firestore.dart';

class Booking {
  String RenterId;
  String LocationId;

  //calendar stuff here

  Booking(this.RenterId, this.LocationId);

  Map<String, dynamic> toJson() => {
        'RenterId': RenterId,
        'LocationId': LocationId,
      };

  Booking.fromSnapshot(DocumentSnapshot snapshot)
      : RenterId = snapshot['RenterId'],
        LocationId = snapshot['LocationId'];
}
