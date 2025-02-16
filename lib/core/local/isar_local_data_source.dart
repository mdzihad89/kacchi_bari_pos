import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:isar/isar.dart';
import 'package:kachi_bari_pos/core/local/local_data_source.dart';
import 'package:kachi_bari_pos/core/local/model/branch_model_isar.dart';
import 'package:kachi_bari_pos/core/local/model/category_model_isar.dart';
import 'package:kachi_bari_pos/core/local/model/order_model_isar.dart';
import 'package:kachi_bari_pos/core/local/model/product_model_isar.dart';
import 'package:kachi_bari_pos/core/local/model/user_model_isar.dart';
import 'package:kachi_bari_pos/features/auth/data/model/user_model.dart';
import 'package:kachi_bari_pos/features/cart/data/model/order_model.dart';
import 'package:kachi_bari_pos/features/home/data/model/branch_model.dart';
import 'package:kachi_bari_pos/features/home/data/model/category_model.dart';
import 'package:kachi_bari_pos/features/home/data/model/dine_in_payment_model.dart';
import 'package:kachi_bari_pos/features/home/data/model/product_model.dart';
import 'package:path_provider/path_provider.dart';
import '../../features/cart/data/model/cart_model.dart';
import '../../features/order/data/model/order_filter_model.dart';

class IsarLocalDataSource extends LocalDataSource {
  late Isar isar;

  @override
  Future<bool> initDb() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      isar = await Isar.open(
        [
          UserModelIsarSchema,
          CategoryModelIsarSchema,
          ProductModelIsarSchema,
          BranchModelIsarSchema,
          OrderModelIsarSchema,
        ],
        directory: dir.path,
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Unit> saveUserModel(User user) async {
    try {
      await isar.writeTxn(
        () async {
          await isar.userModelIsars.clear();
          await isar.userModelIsars.put(
            UserModelIsar(
              userId: user.id,
              name: user.name,
              email: user.email,
              image: user.image,
              branchId: user.branchId,
              branchName: user.branchName,
              role: user.role,
              isBlocked: user.isBlocked,
              mobile: user.mobile,
              token: user.token ?? "",
            ),
          );
        },
      );
      return Future.value(unit);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<User> getUserModel() async {
    try {
      final userModelIsar = await isar.userModelIsars.where().findFirst();
      if (userModelIsar != null) {
        return User(
          id: userModelIsar.userId,
          name: userModelIsar.name,
          email: userModelIsar.email,
          image: userModelIsar.image,
          mobile: userModelIsar.mobile,
          role: userModelIsar.role,
          isBlocked: userModelIsar.isBlocked,
          branchId: userModelIsar.branchId,
          branchName: userModelIsar.branchName,
          token: userModelIsar.token,
        );
      } else {
        throw Exception("No user found");
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Unit> deleteUserModel() async {
    try {
      await isar.writeTxn(() async {
        await isar.userModelIsars.clear();
      });
      return Future.value(unit);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Unit> saveAllCategories(List<CategoryModel> categories) async {
    try {
      await isar.writeTxn(() async {
        await isar.categoryModelIsars.clear();
        for (var category in categories) {
          await isar.categoryModelIsars.put(
            CategoryModelIsar(
              categoryId: category.id,
              name: category.name,
              image: category.image,
              slug: category.slug,
              status: category.status,
            ),
          );
        }
      });
      return Future.value(unit);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final categoryModelIsar = isar.categoryModelIsars.where().findAllSync();
      return categoryModelIsar
          .map((e) => CategoryModel(
                id: e.categoryId,
                name: e.name,
                image: e.image,
                slug: e.slug,
                status: e.status,
              ))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Unit> saveAllProducts(List<ProductModel> products) async {
    try {
      await isar.writeTxn(
        () async {
          await isar.productModelIsars.clear();
          for (var product in products) {
            await isar.productModelIsars.put(
              ProductModelIsar(
                productId: product.id,
                name: product.name,
                image: product.image,
                status: product.status,
                slug: product.slug,
                price: product.price,
                categoryId: product.categoryId,
                categoryName: product.categoryName,
                type: product.type,
                variations: product.variations
                    .map((e) => VariationIsar(
                          personCount: e.personCount,
                          price: e.price,
                          variationId: e.id,
                        ))
                    .toList(),
              ),
            );
          }
        },
      );

      return Future.value(unit);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ProductModel>> getAllProducts() async {
    try {
      final productModelIsar = isar.productModelIsars.where().findAllSync();
      return productModelIsar
          .map((e) => ProductModel(
                id: e.productId,
                name: e.name,
                image: e.image,
                status: e.status,
                slug: e.slug,
                price: e.price,
                categoryId: e.categoryId,
                categoryName: e.categoryName,
                type: e.type,
                variations: e.variations
                    .map((e) => Variation(
                          personCount: e.personCount ?? 0,
                          price: e.price ?? 0,
                          id: e.variationId ?? "",
                        ))
                    .toList(),
              ))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<BranchModel> getBranch() async {
    try {
      final branchModelIsar = isar.branchModelIsars.where().findAllSync();

      if (branchModelIsar.isNotEmpty) {
        final branch = branchModelIsar.first;
        return BranchModel(
          id: branch.branchId,
          name: branch.name,
          address: branch.address,
          image: branch.image,
          status: branch.status,
          branchPhoneNumber: branch.branchPhoneNumber,
          branchBinNumber: branch.branchBinNumber,
          managerId: branch.managerId,
          managerName: branch.managerName,
          table: branch.table,
        );
      } else {
        throw Exception("No branch found");
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Unit> saveBranch(BranchModel branches) async {
    try {
      await isar.writeTxn(() async {
        await isar.branchModelIsars.clear();
        await isar.branchModelIsars.put(
          BranchModelIsar(
            branchId: branches.id,
            name: branches.name,
            address: branches.address,
            image: branches.image,
            status: branches.status,
            branchPhoneNumber: branches.branchPhoneNumber,
            branchBinNumber: branches.branchBinNumber,
            managerId: branches.managerId,
            managerName: branches.managerName,
            table: branches.table,
          ),
        );
      });
      return Future.value(unit);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Unit> addOfflineOrder(OrderModel orderModel) async {
    try {
      await isar.writeTxn(() async {
        await isar.orderModelIsars.put(
          OrderModelIsar(
            cartItems: orderModel.cartItems
                .map((e) => CartModelIsar(
                      productName: e.productName,
                      price: e.price,
                      quantity: e.quantity,
                      productID: e.productID,
                      unitPrice: e.unitPrice,
                    ))
                .toList(),
            branchPhoneNumber: orderModel.branchPhoneNumber,
            branchAddress: orderModel.branchAddress,
            branchBinNumber: orderModel.branchBinNumber,
            branchId: orderModel.branchId,
            branchName: orderModel.branchName,
            changeAmount: orderModel.changeAmount,
            customerPhoneNumber: orderModel.customerPhoneNumber,
            discountAmount: orderModel.discountAmount,
            managerId: orderModel.managerId,
            managerName: orderModel.managerName,
            netPayableAmount: orderModel.netPayableAmount,
            orderDate: DateTime.parse(orderModel.orderDate),
            orderType: orderModel.orderType,
            paidAmount: orderModel.paidAmount,
            invoiceNumber: orderModel.invoiceNumber,
            paymentMode: orderModel.paymentMode,
            paymentStatus: orderModel.paymentStatus,
            serialNumber: orderModel.serialNumber,
            subtotalAmount: orderModel.subtotalAmount,
            tableNumber: orderModel.tableNumber,
            deliveryAddress: orderModel.deliveryAddress,
            customerName: orderModel.customerName,
            deliveryDateAndTime: orderModel.deliveryDateAndTime,
            note: orderModel.note,
            orderStatus: orderModel.orderStatus,
            deliveryBoyName: orderModel.deliveryBoyName,
            deliveryFee: orderModel.deliveryFee,
          ),
        );
      });
      return Future.value(unit);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<OfflineOrderResponse> getOfflineAllOrder(OrderFilter orderFilter) async {
    try {
      final query = isar.orderModelIsars.where();
      late List<OrderModelIsar> orders;
      if (orderFilter.invoiceNumber != null && orderFilter.paymentStatus != null && orderFilter.pageToken != null) {
        orders = await query
            .filter()
            .invoiceNumberEqualTo(orderFilter.invoiceNumber!)
            .and()
            .paymentStatusEqualTo(orderFilter.paymentStatus!)
            .and()
            .orderDateLessThan(DateTime.parse(orderFilter.pageToken!))
            .sortByOrderDateDesc()
            .limit(int.tryParse(orderFilter.pageLimit)!)
            .findAll();
      } else if (orderFilter.invoiceNumber != null && orderFilter.paymentStatus != null) {
        orders = await query
            .filter()
            .invoiceNumberEqualTo(orderFilter.invoiceNumber!)
            .and()
            .paymentStatusEqualTo(orderFilter.paymentStatus!)
            .sortByOrderDateDesc()
            .limit(int.tryParse(orderFilter.pageLimit)!)
            .findAll();
      } else if (orderFilter.invoiceNumber != null && orderFilter.pageToken != null) {
        orders = await query
            .filter()
            .invoiceNumberEqualTo(orderFilter.invoiceNumber!)
            .and()
            .orderDateLessThan(DateTime.parse(orderFilter.pageToken!))
            .sortByOrderDateDesc()
            .limit(int.tryParse(orderFilter.pageLimit)!)
            .findAll();
      } else if (orderFilter.paymentStatus != null && orderFilter.pageToken != null) {
        orders = await query
            .filter()
            .paymentStatusEqualTo(orderFilter.paymentStatus!)
            .and()
            .orderDateLessThan(DateTime.parse(orderFilter.pageToken!))
            .sortByOrderDateDesc()
            .limit(int.tryParse(orderFilter.pageLimit)!)
            .findAll();
      } else if (orderFilter.invoiceNumber != null) {
        orders = await query
            .filter()
            .invoiceNumberEqualTo(orderFilter.invoiceNumber!)
            .sortByOrderDateDesc()
            .limit(int.tryParse(orderFilter.pageLimit)!)
            .findAll();
      } else if (orderFilter.paymentStatus != null) {
        orders = await query
            .filter()
            .paymentStatusEqualTo(orderFilter.paymentStatus!)
            .sortByOrderDateDesc()
            .limit(int.tryParse(orderFilter.pageLimit)!)
            .findAll();
      } else if (orderFilter.pageToken != null) {
        orders = await query
            .filter()
            .orderDateLessThan(DateTime.parse(orderFilter.pageToken!))
            .sortByOrderDateDesc()
            .limit(int.tryParse(orderFilter.pageLimit)!)
            .findAll();
      } else {
        orders = await query
            .sortByOrderDateDesc()
            .limit(int.tryParse(orderFilter.pageLimit)!)
            .findAll();
      }
          String? nextCursor;
          if (orders.isNotEmpty && orders.length == int.tryParse(orderFilter.pageLimit)!) {
            nextCursor = orders.last.orderDate.toIso8601String();
          } else {
            nextCursor = null;
          }
      return OfflineOrderResponse(
        orders: orders
            .map((e) => OrderModel(
          cartItems: e.cartItems
              .map((e) => CartItem(
            productName: e.productName ?? "",
            quantity: e.quantity ?? 0,
            productID: e.productID ?? "",
            unitPrice: e.unitPrice ?? 0,
          ))
              .toList(),
          branchPhoneNumber: e.branchPhoneNumber,
          branchAddress: e.branchAddress,
          branchBinNumber: e.branchBinNumber,
          branchId: e.branchId,
          branchName: e.branchName,
          changeAmount: e.changeAmount,
          customerPhoneNumber: e.customerPhoneNumber,
          discountAmount: e.discountAmount,
          managerId: e.managerId,
          managerName: e.managerName,
          netPayableAmount: e.netPayableAmount,
          orderDate: e.orderDate.toIso8601String(),
          orderType: e.orderType,
          paidAmount: e.paidAmount,
          invoiceNumber: e.invoiceNumber,
          paymentMode: e.paymentMode,
          paymentStatus: e.paymentStatus,
          serialNumber: e.serialNumber,
          subtotalAmount: e.subtotalAmount,
          tableNumber: e.tableNumber,
          deliveryAddress: e.deliveryAddress,
          customerName: e.customerName,
          deliveryDateAndTime: e.deliveryDateAndTime,
          note: e.note,
          orderStatus: e.orderStatus,
          deliveryBoyName: e.deliveryBoyName,
          deliveryFee: e.deliveryFee,
        ))
            .toList(),
        nextPageToken: nextCursor,
      );
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }




  // @override
  // Future<OfflineOrderResponse> getOfflineAllOrder(OrderFilter orderFilter) async {
  //   try {
  //     final query = isar.orderModelIsars.where();
  //     late List<OrderModelIsar> orders;
  //     if (orderFilter.pageToken != null) {
  //       orders = await query
  //           .filter()
  //           .orderDateLessThan(DateTime.parse(orderFilter.pageToken!))
  //           .sortByOrderDateDesc()
  //           .limit(int.tryParse(orderFilter.pageLimit)!)
  //           .findAll();
  //     } else {
  //       orders = await query
  //           .sortByOrderDateDesc()
  //           .limit(int.tryParse(orderFilter.pageLimit)!)
  //           .findAll();
  //     }
  //     String? nextCursor;
  //     if (orders.isNotEmpty && orders.length == int.tryParse(orderFilter.pageLimit)!) {
  //       nextCursor = orders.last.orderDate.toIso8601String();
  //     } else {
  //       nextCursor = null;
  //     }
  //
  //     return OfflineOrderResponse(
  //       orders: orders
  //           .map((e) => OrderModel(
  //                 cartItems: e.cartItems
  //                     .map((e) => CartItem(
  //                           productName: e.productName ?? "",
  //                           quantity: e.quantity ?? 0,
  //                           productID: e.productID ?? "",
  //                           unitPrice: e.unitPrice ?? 0,
  //                         ))
  //                     .toList(),
  //                 branchPhoneNumber: e.branchPhoneNumber,
  //                 branchAddress: e.branchAddress,
  //                 branchBinNumber: e.branchBinNumber,
  //                 branchId: e.branchId,
  //                 branchName: e.branchName,
  //                 changeAmount: e.changeAmount,
  //                 customerPhoneNumber: e.customerPhoneNumber,
  //                 discountAmount: e.discountAmount,
  //                 managerId: e.managerId,
  //                 managerName: e.managerName,
  //                 netPayableAmount: e.netPayableAmount,
  //                 orderDate: e.orderDate.toIso8601String(),
  //                 orderType: e.orderType,
  //                 paidAmount: e.paidAmount,
  //                 invoiceNumber: e.invoiceNumber,
  //                 paymentMode: e.paymentMode,
  //                 paymentStatus: e.paymentStatus,
  //                 serialNumber: e.serialNumber,
  //                 subtotalAmount: e.subtotalAmount,
  //                 tableNumber: e.tableNumber,
  //                 deliveryAddress: e.deliveryAddress,
  //               ))
  //           .toList(),
  //       nextPageToken: nextCursor,
  //     );
  //   } catch (e) {
  //     log(e.toString());
  //     rethrow;
  //   }
  // }

  @override
  Future<Unit> deleteOfflineOrder() async {
    try {
      await isar.writeTxn(() async {
        await isar.orderModelIsars.clear();
      });
      return Future.value(unit);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<OrderModel>> getAllUnsyncOrder() async {
    try {
      final orderModelIsar = await isar.orderModelIsars.where().findAll();
      if (orderModelIsar.isNotEmpty) {
        return orderModelIsar
            .map((e) => OrderModel(
                  cartItems: e.cartItems
                      .map((e) => CartItem(
                            productName: e.productName ?? "",
                            quantity: e.quantity ?? 0,
                            productID: e.productID ?? "",
                            unitPrice: e.unitPrice ?? 0,
                          ))
                      .toList(),
                  branchPhoneNumber: e.branchPhoneNumber,
                  branchAddress: e.branchAddress,
                  branchBinNumber: e.branchBinNumber,
                  branchId: e.branchId,
                  branchName: e.branchName,
                  changeAmount: e.changeAmount,
                  customerPhoneNumber: e.customerPhoneNumber,
                  discountAmount: e.discountAmount,
                  managerId: e.managerId,
                  managerName: e.managerName,
                  netPayableAmount: e.netPayableAmount,
                  orderDate: e.orderDate.toIso8601String(),
                  orderType: e.orderType,
                  paidAmount: e.paidAmount,
                  invoiceNumber: e.invoiceNumber,
                  paymentMode: e.paymentMode,
                  paymentStatus: e.paymentStatus,
                  serialNumber: e.serialNumber,
                  subtotalAmount: e.subtotalAmount,
                  tableNumber: e.tableNumber,
                  deliveryAddress: e.deliveryAddress,
                 customerName: e.customerName,
                  deliveryDateAndTime: e.deliveryDateAndTime,
                  note: e.note,
                  orderStatus: e.orderStatus,
                  deliveryBoyName: e.deliveryBoyName,
                  deliveryFee: e.deliveryFee,
                ))
            .toList();
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<OrderModel> updateOrderPayment(DineInPaymentModel dineInPaymentModel) async {
    try {
      OrderModelIsar? updatedOrder;
      await isar.writeTxn(() async {
        final order = await isar.orderModelIsars
            .filter()
            .invoiceNumberEqualTo(dineInPaymentModel.invoiceNumber)
            .findFirst();

        if (order != null) {
          order.paymentStatus = dineInPaymentModel.paymentStatus;
          order.paymentMode = dineInPaymentModel.paymentMode;
          order.customerPhoneNumber = dineInPaymentModel.customerPhoneNumber;
          order.discountAmount = dineInPaymentModel.discountAmount;
          order.paidAmount = dineInPaymentModel.paidAmount;
          order.netPayableAmount = dineInPaymentModel.netPayableAmount;
          order.changeAmount = dineInPaymentModel.changeAmount;
          await isar.orderModelIsars.put(order);
          updatedOrder = order;
        }
      });

      if (updatedOrder != null) {
        return OrderModel(
          cartItems: updatedOrder!.cartItems
              .map((e) => CartItem(
            productName: e.productName ?? "",
            quantity: e.quantity ?? 0,
            productID: e.productID ?? "",
            unitPrice: e.unitPrice ?? 0,
          ))
              .toList(),
          branchPhoneNumber: updatedOrder!.branchPhoneNumber,
          branchAddress: updatedOrder!.branchAddress,
          branchBinNumber: updatedOrder!.branchBinNumber,
          branchId: updatedOrder!.branchId,
          branchName: updatedOrder!.branchName,
          changeAmount: updatedOrder!.changeAmount,
          customerPhoneNumber: updatedOrder!.customerPhoneNumber,
          discountAmount: updatedOrder!.discountAmount,
          managerId: updatedOrder!.managerId,
          managerName: updatedOrder!.managerName,
          netPayableAmount: updatedOrder!.netPayableAmount,
          orderDate: updatedOrder!.orderDate.toIso8601String(),
          orderType: updatedOrder!.orderType,
          paidAmount: updatedOrder!.paidAmount,
          invoiceNumber: updatedOrder!.invoiceNumber,
          paymentMode: updatedOrder!.paymentMode,
          paymentStatus: updatedOrder!.paymentStatus,
          serialNumber: updatedOrder!.serialNumber,
          subtotalAmount: updatedOrder!.subtotalAmount,
          tableNumber: updatedOrder!.tableNumber,
          deliveryAddress: updatedOrder!.deliveryAddress,
          customerName: updatedOrder!.customerName,
          deliveryDateAndTime: updatedOrder!.deliveryDateAndTime,
          note: updatedOrder!.note,
          orderStatus: updatedOrder!.orderStatus,
          deliveryBoyName: updatedOrder!.deliveryBoyName,
          deliveryFee: updatedOrder!.deliveryFee,
        );
      } else {
        throw Exception("Order not found");
      }
    } catch (e) {
      rethrow;
    }
  }



}
