import 'package:dotted_border/dotted_border.dart';
import 'package:firebase/firestore.dart';
import 'package:flutter/material.dart';
import 'package:godartadmin/const/colors.dart';
import 'package:godartadmin/const/styles.dart';

import 'package:godartadmin/services/fb_services.dart';
import 'package:godartadmin/services/order_services.dart';
import 'package:godartadmin/widgets/buttons/login_btn.dart';
import 'package:godartadmin/widgets/cards/doc_cards.dart';
import 'package:godartadmin/widgets/cards/photo_card.dart';
import 'package:godartadmin/widgets/texts/custom_text.dart';
import 'package:iconsax/iconsax.dart';

class DriverDialog extends StatelessWidget {
  final String id;
  DriverDialog({Key? key, required this.id}) : super(key: key);

  final FirebaseServices _services = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _services.drivers.doc(id).get(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('Something went wrong'),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Dialog(
            child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * .25,
            height: 550,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(children: [
                    FutureBuilder(
                        future: _services.working.doc(id).get(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return const Center(
                              child: Text('Something went wrong'),
                            );
                          } else if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          return CustomButton(
                              btnColor:
                                  OrderServices.dbkgStatusColor(snapshot.data),
                              child: CustomText(
                                text: OrderServices.driverStatusDesc(
                                    snapshot.data),
                                color: OrderServices.driverStatusColor(
                                    snapshot.data),
                              ),
                              onPressed: () {});
                        }),
                    // Container(
                    //     decoration: BoxDecoration(
                    //       color: Colors.green.withAlpha(55),
                    //       borderRadius: BorderRadius.circular(4),
                    //     ),
                    //     child: const Padding(
                    //       padding: EdgeInsets.all(6.0),
                    //       child: Text('Active'),
                    //     )),
                    const Spacer(),
                    const Icon(Iconsax.candle),
                  ]),
                  Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: Image.network(
                            snapshot.data['profilePhoto'],
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.high,
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                        snapshot.data['firstname'] +
                            ' ' +
                            snapshot.data['lastname'],
                        style: photoTitle),
                  ),
                  DottedBorder(
                    color: Colors.black45,
                    radius: const Radius.circular(10),
                    strokeWidth: 1.0,
                    borderType: BorderType.RRect,
                    padding: const EdgeInsets.all(0),
                    dashPattern: const [6, 3],
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        height: 200,
                        width: 400,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            color: Colors.grey.withAlpha(25),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  const Icon(Iconsax.sms_edit),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(snapshot.data['email'].toString()),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(Iconsax.call),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(snapshot.data['mobile'].toString()),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(Iconsax.location),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(snapshot.data['address'].toString()),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('Vehicle: ',
                                      style: photoTitle.copyWith(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                      )),
                                  const SizedBox(
                                    width: 5.0,
                                  ),
                                  Text(
                                      snapshot.data['vehicleColor'].toString() +
                                          ' ' +
                                          snapshot.data['vehicleBrand']
                                              .toString() +
                                          ' ' +
                                          snapshot.data['vehicleType']
                                              .toString(),
                                      style: photoTitle.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      )),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('DOB: ',
                                      style: photoTitle.copyWith(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                      )),
                                  const SizedBox(
                                    width: 5.0,
                                  ),
                                  Text(snapshot.data['dob'].toString(),
                                      style: photoTitle.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      )),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('Plate Number: ',
                                      style: photoTitle.copyWith(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                      )),
                                  Text(snapshot.data['plateNumber'].toString(),
                                      style: photoTitle.copyWith(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  PhotoCard(
                    url: snapshot.data['profilePhoto'],
                    title: 'Selfie',
                  ),
                  PhotoCard(
                    url: snapshot.data['licensePhoto'],
                    title: 'License',
                  ),
                  PhotoCard(
                    url: snapshot.data['ridersCard'],
                    title: 'Riders Card',
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Wrap(
                      spacing: 35,
                      runSpacing: 20,
                      children: [
                        DocCards(
                          title: snapshot.data['totalEarnings'].toString(),
                          desc: 'Total Revenue',
                        ),
                        DocCards(
                          title:
                              snapshot.data['totalRidesCompleted'].toString(),
                          desc: 'Deliveries',
                        ),
                        DocCards(
                            title: snapshot.data['totalViolation'].toString(),
                            desc: 'Violations'),
                        DocCards(
                            title: snapshot.data['totalRatingCount'].toString(),
                            desc: 'Rated'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
      },
    );
  }
}
