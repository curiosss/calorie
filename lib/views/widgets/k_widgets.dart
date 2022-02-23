import 'package:cached_network_image/cached_network_image.dart';
import 'package:calorie_calculator/utils/dimens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';




// Widget kCachedImageWithShadow({
//   @required String imageurl,
//   @required double width,
//   @required double height,
// }) {
//   return Container(
//     height: height,
//     width: width,
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(Dimens.GBORDER_R),
//       boxShadow: [CustomColors.backShadow],
//     ),
//     child: ClipRRect(
//       borderRadius: BorderRadius.circular(Dimens.GBORDER_R),
//       child: kCachedNetworkImage(imageUrl: imageurl),
//     ),
//   );
// }

Widget kCachedNetworkImage({String imageUrl = ''}) {
  return CachedNetworkImage(
    width: double.infinity,
    height: double.infinity,
    imageUrl: imageUrl,
    fit: BoxFit.cover,
    placeholder: (context, url) => Center(
      child: Container(
        height: 30,
        width: 30,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            Colors.black12,
          ),
        ),
      ),
    ),
    errorWidget: (context, url, error) {
      return Container();
      // return Center(
      //   // child: new Icon(
      //   //   Icons.refresh,
      //   //   color: Colors.black12,
      //   // ),
      //   child: Padding(
      //     padding: const EdgeInsets.all(8.0),
      //     child: SvgPicture.asset(
      //       IconPath.iconLoginLogo,
      //       color: CustomColors.grey1,
      //     ),
      //   ),
      // );
    },
  );
}

Widget kImageWithTitle({
  @required BuildContext context,
  String title = '',
  double fontSize,
  String imageUrl = '',
}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(Dimens.GBORDER_R),
    child: Stack(
      children: [
        kCachedNetworkImage(imageUrl: imageUrl),
        Positioned(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0x00ffffff),
                  Colors.black12,
                  Colors.black26,
                ],
                begin: (Alignment.topCenter),
                end: Alignment.bottomCenter,
                tileMode: TileMode.clamp,
              ),
              // color: Colors.black26,
            ),
          ),
        ),
        Positioned(
          bottom: Dimens.HGMargin,
          left: Dimens.HGMargin,
          right: Dimens.HGMargin,
          child: Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: fontSize ?? Dimens.FONT_H16,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}
