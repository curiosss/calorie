// import 'package:abat_courier/services/providers/abat_provider.dart';
// import 'package:abat_courier/utils/enums.dart';
// import 'package:abat_courier/views/widgets/show_messengers.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:provider/provider.dart';

// class RejectBottomSheet extends StatefulWidget {
//   final int id;
//   const RejectBottomSheet({
//     Key key,
//     @required this.id,
//   }) : super(key: key);

//   @override
//   _RejectBottomSheetState createState() => _RejectBottomSheetState();
// }

// class _RejectBottomSheetState extends State<RejectBottomSheet> {
//   final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
//   TextEditingController textNotDeliveredController = TextEditingController();
//   String validateString = '5 harpda az bolmaly dal';

//   bool isLoading = false;

//   void changeStatus() async {
//     setState(() {
//       isLoading = true;
//     });
//     ResponseStats result =
//         await Provider.of<AbatProvider>(context, listen: false)
//             .changeOrderStatus(
//       status: 'not_delivered',
//       id: widget.id.toString(),
//       reason: textNotDeliveredController.text,
//     );

//     setState(() {
//       isLoading = false;
//     });

//     if (result == ResponseStats.Success) {
//       Navigator.popUntil(context, (route) => route.isFirst);
//     } else {
//       ShowMessengers.showMessage(context: context, responseStats: result);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     double ratio = MediaQuery.of(context).size.width / 360;
//     double height = MediaQuery.of(context).size.height - 100;
//     return Consumer<AbatProvider>(
//       builder: (context, services, child) {
//         List<String> strings = [
//           services.getTranslation('wrong_phone'),
//           services.getTranslation('not_answering'),
//           services.getTranslation('wrong_address'),
//           services.getTranslation('not_at_home'),
//         ];
//         return Form(
//           key: _formKey,
//           child: Container(
//             height: 370 * ratio,
//             width: MediaQuery.of(context).size.width,
//             child: Padding(
//               padding: EdgeInsets.symmetric(
//                 horizontal: 16 * ratio,
//                 vertical: 2,
//               ),
//               child: Column(
//                 // mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Opacity(
//                         opacity: 0,
//                         child: Icon(Icons.cancel),
//                       ),
//                       Container(
//                         height: 3,
//                         width: 30,
//                         decoration: BoxDecoration(
//                           color: Colors.blueGrey,
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.of(context).pop();
//                         },
//                         child: Padding(
//                           padding: EdgeInsets.all(8),
//                           child: SvgPicture.asset('assets/icons/x.svg'),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Center(
//                     child: Text(
//                       services.getTranslation('cancel'),
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontWeight: FontWeight.w500,
//                         fontSize: 16 * ratio,
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 5),
//                   Center(
//                     child: Text(
//                       services.getTranslation('note_cancel_reason'),
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontWeight: FontWeight.w400,
//                         fontSize: 14 * ratio,
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     services.getTranslation('ready_answers'),
//                     textAlign: TextAlign.start,
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontWeight: FontWeight.w400,
//                       fontSize: 12 * ratio,
//                     ),
//                   ),
//                   SizedBox(height: 15),
//                   Expanded(
//                       child: SingleChildScrollView(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Wrap(
//                           runAlignment: WrapAlignment.start,
//                           alignment: WrapAlignment.start,
//                           spacing: 10,
//                           runSpacing: 10,
//                           children: List.generate(
//                             4,
//                             (index) => GestureDetector(
//                               onTap: () {
//                                 setState(
//                                   () {
//                                     textNotDeliveredController.text =
//                                         strings[index];
//                                   },
//                                 );
//                               },
//                               child: Container(
//                                 padding: EdgeInsets.symmetric(
//                                   horizontal: 10,
//                                   vertical: 6,
//                                 ),
//                                 decoration: BoxDecoration(
//                                   borderRadius:
//                                       BorderRadius.circular(8 * ratio),
//                                   color: Color(0xffE8F0F7),
//                                 ),
//                                 child: Text(
//                                   strings[index],
//                                   // services.getTranslation('wrong_phone'),
//                                   // softWrap: true,

//                                   style: TextStyle(
//                                     color: Color(0xff255BCE),
//                                     fontWeight: FontWeight.w400,
//                                     fontSize: 14 * ratio,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 20 * ratio),
//                         Container(
//                           // height: 120 * ratio,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(8),
//                             color: Color(0xffF2F3F5),
//                           ),
//                           child: Padding(
//                             padding: EdgeInsets.symmetric(
//                               horizontal: 13 * ratio,
//                               vertical: 3 * ratio,
//                             ),
//                             child: TextFormField(
//                               controller: textNotDeliveredController,
//                               decoration: InputDecoration(
//                                 disabledBorder: InputBorder.none,
//                                 hintText:
//                                     services.getTranslation('write_reason'),
//                                 fillColor: Colors.transparent,
//                                 // filled: true,
//                                 border: OutlineInputBorder(
//                                   borderSide: BorderSide.none,
//                                 ),
//                                 contentPadding: EdgeInsets.zero,
//                                 hintStyle: TextStyle(
//                                   color: Color(0xffA0A3BD),
//                                   fontWeight: FontWeight.w400,
//                                   fontSize: 12 * ratio,
//                                 ),
//                               ),
//                               onChanged: (value) {
//                                 if (value.length > 5) {
//                                   _formKey.currentState.validate();
//                                 }
//                               },
//                               minLines: 1,
//                               maxLines: 5,
//                               validator: (value) {
//                                 if (value.length < 5) {
//                                   return validateString;
//                                 } else {
//                                   return null;
//                                 }
//                               },
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 15),
//                         Center(
//                           child: InkWell(
//                             onTap: () {
//                               if (_formKey.currentState.validate()) {
//                                 changeStatus();
//                               } else {
//                                 ShowMessengers.showMessageStandard(
//                                     context: context,
//                                     message: services.getTranslation('more5'),
//                                     color: Colors.red);
//                               }
//                             },
//                             child: Container(
//                               height: 40 * ratio,
//                               width: 120 * ratio,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(4),
//                                 color: Color(0xff255BCE),
//                               ),
//                               child: Center(
//                                 child: isLoading
//                                     ? Container(
//                                         height: 25 * ratio,
//                                         width: 25 * ratio,
//                                         child: CircularProgressIndicator(
//                                           valueColor:
//                                               new AlwaysStoppedAnimation<Color>(
//                                                   Colors.white),
//                                         ),
//                                       )
//                                     : Text(
//                                         services.getTranslation('confirm'),
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                           fontWeight: FontWeight.w500,
//                                           fontSize: 12 * ratio,
//                                         ),
//                                       ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 15),
//                       ],
//                     ),
//                   ))
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
