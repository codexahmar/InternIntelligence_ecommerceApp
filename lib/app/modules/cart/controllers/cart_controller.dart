import 'package:get/get.dart';
import '../../../../services/stripe_service.dart';
import '../../../../utils/dummy_helper.dart';
import '../../../components/custom_snackbar.dart';
import '../../../data/models/product_model.dart';
import '../../base/controllers/base_controller.dart';

class CartController extends GetxController {
  // to hold the products in cart
  List<ProductModel> products = [];

  // to hold the total price of the cart products
  var total = 0.0;

  @override
  void onInit() {
    getCartProducts();
    super.onInit();
  }

  /// when the user press on purchase now button
  onPurchaseNowPressed() async {
    try {
      await StripeService.instance.makePayment(
        amount: total.round(),
        currency: 'usd',
        context: Get.context!,
      );
      // Clear the cart products after successful payment
      for (var product in DummyHelper.products) {
        product.quantity = 0; // Reset all quantities
      }
      getCartProducts(); // Refresh cart
      update(); // Update the UI
      // Only change screen and show success message if payment was successful
      Get.find<BaseController>().changeScreen(0);
      CustomSnackBar.showCustomSnackBar(
        title: 'Purchased',
        message: 'Order placed with success',
      );
    } catch (e) {
      // Payment error will be handled by StripeService
      print('Payment failed: $e');
    }
  }

  /// when the user press on increase button
  onIncreasePressed(int productId) {
    var product = DummyHelper.products.firstWhere((p) => p.id == productId);
    product.quantity = product.quantity! + 1;
    getCartProducts();
    update(['ProductQuantity']);
  }

  /// when the user press on decrease button
  onDecreasePressed(int productId) {
    var product = DummyHelper.products.firstWhere((p) => p.id == productId);
    if (product.quantity != 0) {
      product.quantity = product.quantity! - 1;
      getCartProducts();
      update(['ProductQuantity']);
    }
  }

  /// when the user press on delete icon
  onDeletePressed(int productId) {
    var product = DummyHelper.products.firstWhere((p) => p.id == productId);
    product.quantity = 0;
    getCartProducts();
  }

  /// get the cart products from the product list
  getCartProducts() {
    products = DummyHelper.products.where((p) => p.quantity! > 0).toList();
    // calculate the total price
    total = products.fold<double>(0, (p, c) => p + c.price! * c.quantity!);
    update();
  }
}
