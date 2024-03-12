import "package:app_delivery/src/models/category.dart";
import "package:app_delivery/src/models/product.dart";
import "package:app_delivery/src/models/user.dart";
import "package:app_delivery/src/pages/client/products/detail/client_products_detail_page.dart";
import "package:app_delivery/src/provider/categories_provider.dart";
import "package:app_delivery/src/provider/products_provider.dart";
import "package:app_delivery/src/utils/shared_pref.dart";
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import "package:flutter/widgets.dart";
import "package:modal_bottom_sheet/modal_bottom_sheet.dart";

class ClientProductsListController {
  BuildContext? context;
  SharedPref _sharedPref = SharedPref();
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  Function? refresh;

  User? user;
  CategoriesProvider _categoriesProvider = CategoriesProvider();
  ProductsProvider _productsProvider = ProductsProvider();

  List<Category> categories = [];

  Future? init(BuildContext context, Function refresh) async {
    this.context = context;
    user = User.fromJson(await _sharedPref.read('user'));
    _categoriesProvider.init(context, user! as User);
    _productsProvider.init(context, user as User);
    getCategories();
    refresh!();
  }

  Future<List<Product>> getProducts(String idCategory) async {
    return await _productsProvider.getByCategory(idCategory);
  }

  void getCategories() async {
    categories = await _categoriesProvider.getAll();
    refresh!();
  }

  void openBottomSheet(Product product) {
    showMaterialModalBottomSheet(
        context: context as BuildContext,
        builder: (context) => ClientProductsDetailPage(
              product: product,
            ) as Widget);
  }

  void logout() {
    if (context != null) {
      _sharedPref.logout(context!,
          user!.id as String); // Using null-aware operator to assert non-null
    }
  }

  void openDrawer() {
    key.currentState?.openDrawer();
  }

  void goToUpdatePage() {
    Navigator.pushNamed(context!, 'client/update');
  }

  void goToRoles() {
    Navigator.pushNamedAndRemoveUntil(context!, 'roles', (route) => false);
  }

  void goToOrderCreatePage() {
    Navigator.pushNamed(context!, 'client/orders/create');
  }
}
