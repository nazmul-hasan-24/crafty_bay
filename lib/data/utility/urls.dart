class Urls {
  static const String _baseUrl = 'http://ecom-api.teamrabbil.com/api';

  static String sentEmailOtp(String email) => '$_baseUrl/UserLogin/$email';

  static String verifyOtp(String email, String otp) =>
      '$_baseUrl/VerifyLogin/$email/$otp';

  static String readProfile = '$_baseUrl/ReadProfile';
  static String createProfile = '$_baseUrl/CreateProfile';
  static String homeBanner = '$_baseUrl/ListProductSlider';
  static String categoryList = '$_baseUrl/CategoryList';
  static String popularProductList = '$_baseUrl/ListProductByRemark/Popular';
  static String newProductList = '$_baseUrl/ListProductByRemark/New';
  static String specialProductList = '$_baseUrl/ListProductByRemark/Special';
  static String productByCategory(int categoryId) =>
      '$_baseUrl/ListProductByCategory/$categoryId';
  static String productDetails(int productId) =>
      '$_baseUrl/ProductDetailsById/$productId';
  static String addToCart = '$_baseUrl/CreateCartList';
  static String cartList = '$_baseUrl/CartList';
  static String deleteCartList(int id) => "$_baseUrl/DeleteCartList/$id";
  static String createInvoice = '$_baseUrl/InvoiceCreate';
  static String createReview = '$_baseUrl/CreateProductReview';
  static String review(int id) => '$_baseUrl/ListReviewByProduct/$id';
  static String listReviewByProduct(int id) =>
      "$_baseUrl/ListReviewByProduct/$id";
  static String addToWishList(int id) => "$_baseUrl/CreateWishList/$id";
  static String wishList = "$_baseUrl/ProductWishList";
  static String removeWishList(int id) => "$_baseUrl/RemoveWishList/$id";
}
