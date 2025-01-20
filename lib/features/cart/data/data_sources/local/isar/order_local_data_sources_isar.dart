import 'package:dartz/dartz.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../../../model/order_model.dart';
import '../order_local_data_sources.dart';
import 'orders.dart';



class OrdersLocalDataSourceIsar extends OrdersLocalDataSource{

  late Isar isar;

  @override
  Future<bool> initDb() async{
    try {
      final dir = await getApplicationDocumentsDirectory();
       isar = await Isar.open(
        [OrdersSchema],
        directory: dir.path,
      );
      return true;
    } catch (e) {
      return false;
    }
  }


  @override
  Future<Unit> addOrder(Orders orders) async{

    try{
      //
      // final order = Orders(
      //   cartItems: orderModel.items.map((e) => Cart(
      //     productName: e.productName,
      //     unitPrice: e.unitPrice,
      //     productID: e.productID,
      //     quantity: e.quantity,
      //     price: e.price,
      //   )).toList(),
      //   subtotalAmount: orderModel.subtotalAmount,
      //   paidAmount: orderModel.paidAmount,
      //   netPayableAmount: orderModel.netPayableAmount,
      //   changeAmount: orderModel.changeAmount,
      //   orderDate: orderModel.orderDate,
      //   tableNumber: orderModel.tableNumber,
      //   discountAmount: orderModel.discountAmount,
      //   customerPhoneNumber: orderModel.customerPhoneNumber,
      //   orderType: orderModel.orderType,
      //   branchId: orderModel.branchId,
      //   branchName: orderModel.branchName,
      //   managerId: orderModel.managerId,
      //   managerName: orderModel.managerName,
      //   branchPhoneNumber: orderModel.branchPhoneNumber,
      //   branchAddress: orderModel.branchAddress,
      //   paymentMode: orderModel.paymentMode,
      //   paymentStatus: orderModel.paymentStatus,
      //   syncStatus: orderModel.syncStatus,
      //   orderId: orderModel.orderId
      // );
      //



      await isar.writeTxn(() async {
        isar.orders.put(orders);
      });

      return Future.value(unit);

    }catch(e){
      rethrow;
    }

  }






}