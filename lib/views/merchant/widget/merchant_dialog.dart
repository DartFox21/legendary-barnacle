import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:godartadmin/const/styles.dart';
import 'package:godartadmin/services/fb_services.dart';
import 'package:godartadmin/widgets/cards/doc_cards.dart';
import 'package:godartadmin/widgets/cards/photo_card.dart';
import 'package:iconsax/iconsax.dart';

class MerchantDialog extends StatelessWidget {
  final String id;
  MerchantDialog({Key? key, required this.id}) : super(key: key);
  final FirebaseServices _services = FirebaseServices();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _services.vendors.doc(id).get(),
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
                    Container(
                        decoration: BoxDecoration(
                          color: Colors.green.withAlpha(55),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(6.0),
                          child: Text('Active'),
                        )),
                    const Spacer(),
                    const Icon(Iconsax.candle),
                  ]),
                  PhotoCard(
                    url: snapshot.data['imageUrl'],
                    title: 'Store Front',
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(snapshot.data['shopName'], style: photoTitle),
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
                                  Text('Prep Time: ',
                                      style: photoTitle.copyWith(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                      )),
                                  const SizedBox(
                                    width: 5.0,
                                  ),
                                  Text(
                                      snapshot.data['prepTime'].toString() +
                                          ' ' +
                                          'minutes',
                                      style: photoTitle.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      )),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('Open Hours: ',
                                      style: photoTitle.copyWith(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                      )),
                                  const SizedBox(
                                    width: 5.0,
                                  ),
                                  Text(snapshot.data['openHours'].toString(),
                                      style: photoTitle.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      )),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('Closing Hours: ',
                                      style: photoTitle.copyWith(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                      )),
                                  Text(snapshot.data['closingHours'].toString(),
                                      style: photoTitle.copyWith(
                                        fontSize: 14,
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
                              snapshot.data['totalOrdersCompleted'].toString(),
                          desc: 'Sales',
                        ),
                        DocCards(
                            title: snapshot.data['totalProducts'].toString(),
                            desc: 'Products'),
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
    ;
  }
}
