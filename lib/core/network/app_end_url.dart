import 'package:biotech_maali/import.dart';

class EndUrl {
  static String baseUrl = BaseUrl.baseUrl;
  static String checkTokenValidityUrl = "${baseUrl}api/token/verify/";
  static String checkRefreshTokenUrl = "${baseUrl}api/token/refresh/";

  static String registerWithMobileUrl = "${baseUrl}account/registerWithMobile/";
  static String homeProductsUrl = '${baseUrl}product/homeProducts/';
  static String promotionBannerUrl = "${baseUrl}promotion/banner/";
  static String getProductDetailsUrl = "${baseUrl}product/defaultProduct/";
  static String addToCartUrl = "${baseUrl}order/cart/";
  static String getCartProductListUrl = "${baseUrl}order/cart/";
  static String updateCartProductQuantityUrl = "${baseUrl}order/cart/";
  static String deleteCartProductUrl = "${baseUrl}order/cart/";

  static String getAllWhishListUrl = "${baseUrl}order/wishlist/";
  static String addOrRemoveWilistProduct = "${baseUrl}order/wishlist/";
  static String getMainCategoriesUrl = "${baseUrl}category/";
  static String getCategoryWiseSubCategoryUrl =
      "${baseUrl}category/categoryWiseSubCategory/";
  static String getServiceListUrl = "${baseUrl}services/publicservice_list/";
  static String serviceEnquiryUrl = "${baseUrl}services/service_enquiry/";
  static String getStoreList = "${baseUrl}store/store_list";
  static String addContactUs = "${baseUrl}promotion/contactUs/";
  static String addFranchiseEnquiryUrl = "${baseUrl}franchise/";
  static String accountRegister = "${baseUrl}account/register/";
  static String getWhishListIdUrl =
      "${baseUrl}order/wishlist/?main_product_id_list=true";
  static String addOrRemoveWishListUrl = "${baseUrl}order/wishlist/";
  static String filterProductUrl = "${baseUrl}product/filterProduct/";
  static String getOrUpdateProfileUrl = "${baseUrl}account/profile/";
  static String addOrEditAddressUrl = "${baseUrl}account/address/";
}
