import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_banners/super_banners.dart';
import '../../../../core/constants/color_constants.dart';
import '../../../cart/presentation/bloc/cart_bloc.dart';
import '../../../cart/presentation/bloc/cart_event.dart';
import '../../data/model/product_model.dart';

class ProductItem extends StatelessWidget {
  final ProductModel product;
  final AudioPlayer audioPlayer ;

 const  ProductItem({super.key, required this.product, required this.audioPlayer});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () async{
           if(product.type == "package"){
             showDialog(
               context: context,
               builder: (BuildContext context) {
                 return AlertDialog(
                   title: const Text("Select Variation"),
                   content: SingleChildScrollView(
                     child: ListBody(
                       children: product.variations
                           .map((variation) {
                         return ListTile(
                           title: Text(
                               "Person: ${variation
                                   .personCount}"),
                           subtitle: Text(
                               "Price: Tk ${variation.price}"),
                           onTap: () {
                             context
                                 .read<CartBloc>()
                                 .add(AddToCart(
                                 product: product,
                                 variation:
                                 variation));
                             Navigator.of(context).pop();
                           },
                         );
                       }).toList(),
                     ),
                   ),
                   actions: <Widget>[
                     TextButton(
                       child: const Text('Cancel',
                           style: TextStyle(
                               color: Colors.red)),
                       onPressed: () {
                         Navigator.of(context).pop();
                       },
                     ),
                   ],
                 );
               },
             );
           }else{
             context.read<CartBloc>().add(AddToCart(product: product));
             await audioPlayer.play(AssetSource("audio/beep.mp3"));
           }

          },
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(8)),
                    child:  CachedNetworkImage(
                      height: 60,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      imageUrl: product.image,
                      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    )
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Tk ${product.price}",
                            style: const TextStyle(
                                fontSize: 14, color: Colors.white),
                          ),
                          // product.type == "package"
                          //     ? ElevatedButton(
                          //   onPressed: () {
                          //     showDialog(
                          //       context: context,
                          //       builder: (BuildContext context) {
                          //         return AlertDialog(
                          //           title: const Text("Select Variation"),
                          //           content: SingleChildScrollView(
                          //             child: ListBody(
                          //               children: product.variations
                          //                   .map((variation) {
                          //                 return ListTile(
                          //                   title: Text(
                          //                       "Person: ${variation
                          //                           .personCount}"),
                          //                   subtitle: Text(
                          //                       "Price: Tk ${variation.price}"),
                          //                   onTap: () {
                          //                     context
                          //                         .read<CartBloc>()
                          //                         .add(AddToCart(
                          //                         product: product,
                          //                         variation:
                          //                         variation));
                          //                     Navigator.of(context).pop();
                          //                   },
                          //                 );
                          //               }).toList(),
                          //             ),
                          //           ),
                          //           actions: <Widget>[
                          //             TextButton(
                          //               child: const Text('Cancel',
                          //                   style: TextStyle(
                          //                       color: Colors.red)),
                          //               onPressed: () {
                          //                 Navigator.of(context).pop();
                          //               },
                          //             ),
                          //           ],
                          //         );
                          //       },
                          //     );
                          //   },
                          //   style: ElevatedButton.styleFrom(
                          //     fixedSize: const Size(70, 10),
                          //     padding: const EdgeInsets.all(0),
                          //     backgroundColor:
                          //     ColorConstants.primaryColor,
                          //   ),
                          //   child: Text(
                          //     "Person",
                          //     style:
                          //     Theme
                          //         .of(context)
                          //         .textTheme
                          //         .bodyMedium,
                          //   ),
                          // )
                          //     : const SizedBox.shrink(),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        product.type == "package"
            ? const CornerBanner(
          bannerPosition: CornerBannerPosition.topLeft,
          bannerColor: ColorConstants.primaryColor,
          child: Text("Package"),
        )
            : const SizedBox.shrink(),
      ],
    );
  }
}