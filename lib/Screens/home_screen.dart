import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomerance_app/AppColors/appcolors.dart';
import 'package:ecomerance_app/CustomWidgets/CustomButton.dart';
import 'package:ecomerance_app/CustomWidgets/CustomTextformField.dart';
import 'package:ecomerance_app/CustomWidgets/appText.dart';
import 'package:ecomerance_app/Screens/Categories_screen.dart';
import 'package:ecomerance_app/Screens/HomeScreenTabs/clothesItem.dart';
import 'package:ecomerance_app/Screens/HomeScreenTabs/shoesItem.dart';
import 'package:ecomerance_app/Screens/product_detail_screen.dart';
import 'package:ecomerance_app/controllers/home_screen_controller.dart';
import 'package:ecomerance_app/googlemap.dart';
import 'package:ecomerance_app/routes/route_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../Auth/firestore.dart';
import 'HomeScreenTabs/AllItem.dart';
import 'HomeScreenTabs/bagItem.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final CarouselController _controller = CarouselController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _searchController = TextEditingController();
  List<String> productsType = ["All", "Bags", "Clothes", "Shoes"];
  List<String> productIcons = [
    "assets/icons/bag.png",
    "assets/icons/laptop.png",
    "assets/icons/jewelry.png",
    "assets/icons/kitchen.png",
    "assets/icons/shirt.png",
    "assets/icons/shoes.png",
    "assets/icons/toys.png",
    "assets/icons/watch.png",
  ];
  List<String> productnames = [
    'Bag',
    'Laptop',
    'Jewelry',
    'Kitchen',
    'shirt',
    'shoes',
    'toys',
    'watch',
  ];
  bool startValue = false;
  bool startsValue = false;
  List<int> favoriteIndices = []; // Define selectedIndex here
  List<int> favoritesIndices = []; // Define selectedIndex here

  final List<Map<String, dynamic>> chairProducts = [
    {
      'image': 'assets/images/chair2.PNG',
      'name': 'Another Chair',
      'description': 'Another Model',
      'price': '\$25',
      'originalPrice': '\$30',
    },
    {
      'image': 'assets/images/chair3.PNG',
      'name': 'Another Chair',
      'description': 'Another Model',
      'price': '\$25',
      'originalPrice': '\$30',
    },
    {
      'image': 'assets/images/chair4.PNG',
      'name': 'Another Chair',
      'description': 'Another Model',
      'price': '\$25',
      'originalPrice': '\$30',
    },
    {
      'image': 'assets/images/chair5.PNG',
      'name': 'Another Chair',
      'description': 'Another Model',
      'price': '\$25',
      'originalPrice': '\$30',
    },

    {
      'image': 'assets/images/chair2.PNG',
      'name': 'Another Chair',
      'description': 'Another Model',
      'price': '\$25',
      'originalPrice': '\$30',
    },
    {
      'image': 'assets/images/chair3.PNG',
      'name': 'Another Chair',
      'description': 'Another Model',
      'price': '\$25',
      'originalPrice': '\$30',
    },
    // Add more chair products as needed
  ];
  final HomeScreenController controller = Get.put(HomeScreenController());
  final ScrollController _scrollController = ScrollController();
  final ScrollController _scrollsController = ScrollController();
  @override
  void initState() {
    super.initState();
    fetchUserData(); // Fetch user data when the screen initializes
  }

  Map<String, dynamic>? userData;
  String username = '';

  final FirestoreService _firestoreService = FirestoreService();
  Future<void> fetchUserData() async {
    try {
      userData = await _firestoreService.getUserData();
      if (userData != null) {
        username = userData?['userName'] ?? 'Guest';
      }
      setState(() {}); // Update the UI after fetching data
    } catch (e) {
      // Handle error fetching user data
      print('Error fetching user data: $e');
      Get.snackbar(
        'Error',
        'Failed to fetch user data',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0), // Set custom height
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.primary,
          title: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: (userData?["imageUrl"] != null &&
                          userData?["imageUrl"] != '')
                      ? CachedNetworkImage(
                          fit: BoxFit.cover,
                          progressIndicatorBuilder: (context, url, progress) =>
                              Center(
                            child: CircularProgressIndicator(
                              value: progress.progress,
                            ),
                          ),
                          imageUrl: userData?["imageUrl"],
                        )
                      : Icon(Icons.camera_alt,
                          size: 50, color: AppColors.primary),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: 'Good Morning',
                    fontWeight: FontWeight.w500,
                    textColor: Colors.white,
                    fontSize: 20,
                  ),
                  AppText(
                    text: username.toUpperCase(),
                    fontSize: 16,
                    textColor: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Get.toNamed(RouteName.notificationScreen);
                },
                child: const Icon(
                  Icons.notifications_outlined,
                  color: Colors.white,
                ),
              ),
             
            ],
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: DefaultTabController(
          length: 4,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    children: [
                      CustomTextFormField(
                        contentPadding: const EdgeInsets.all(10),
                        controller: _searchController,
                        hintText: 'Search',
                        prefixIcon: Icons.search,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CarouselSlider(
                        carouselController: _controller,
                        options: CarouselOptions(
                          height: 200,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          enableInfiniteScroll: true,
                          viewportFraction: 1,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                        ),
                        items: [
                          'assets/images/banner1.png',
                          'assets/images/banner2.png',
                          'assets/images/banner3.png',
                          'assets/images/banner4.png',
                          'assets/images/banner5.png',
                        ].map((item) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset(
                                    item,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 10),
                      AnimatedSmoothIndicator(
                        activeIndex: _currentIndex,
                        count: 5,
                        effect: ExpandingDotsEffect(
                          radius: 10,
                          dotHeight: 8,
                          dotWidth: 14,
                          activeDotColor: AppColors.primary,
                          dotColor: Colors.grey,
                        ),
                        onDotClicked: (index) {
                          _controller.animateToPage(index);
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const AppText(
                            text: 'Popular Categories',
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => CategoriesScreen());
                            },
                            child: const AppText(
                              text: 'See All',
                              fontWeight: FontWeight.bold,
                              textColor: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 200,
                        child: GridView.builder(
                          itemCount: productIcons.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10),
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  height: 50,
                                  width: 50,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.primary,
                                    //  border: Border.all(color: Colors.black),
                                  ),
                                  child: Image.asset(
                                    productIcons[index],
                                    fit: BoxFit.fill,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                AppText(
                                    text: productnames[index],
                                    textColor: Colors.black)
                              ],
                            );
                          },
                        ),
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText(
                            text: 'Most Popular',
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          AppText(
                            text: 'See All',
                            fontWeight: FontWeight.bold,
                            textColor: AppColors.primary,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Stack(
                        children: [
                          SizedBox(
                            height: 255,
                            child: ListView.builder(
                              controller: _scrollController,
                              scrollDirection: Axis.horizontal,
                              itemCount: chairProducts.length,
                              itemBuilder: (context, index) {
                                return _buildDealOfTheDayContainer(
                                  chairProducts[index]['image'],
                                  chairProducts[index]['name'],
                                  chairProducts[index]['description'],
                                  chairProducts[index]['price'],
                                  chairProducts[index]['originalPrice'],
                                  index,
                                );
                              },
                            ),
                          ),
                          Positioned(
                            top: 0,
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () {
                                _scrollController.animateTo(
                                  _scrollController.position.maxScrollExtent,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut,
                                );
                              },
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.3),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const AppText(
                            text: 'Deals of the Day',
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          GestureDetector(
                              onTap: () {
                                Get.toNamed(RouteName.productScreen);
                              },
                              child: const AppText(
                                text: 'See All',
                                fontWeight: FontWeight.bold,
                                textColor: AppColors.primary,
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SingleChildScrollView(
                        child: Container(
                          height: 240,
                          child: StreamBuilder<QuerySnapshot>(
                            stream: _firestore
                                .collection('createPosts')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              }

                              if (!snapshot.hasData ||
                                  snapshot.data!.docs.isEmpty) {
                                return Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/ground.png',
                                        height: 200,
                                        width: 200,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'No Data Found',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                );
                              }

                              List<QueryDocumentSnapshot> documents =
                                  snapshot.data!.docs;

                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: documents.length,
                                itemBuilder: (context, index) {
                                  var data = documents[index].data()
                                      as Map<String, dynamic>;
                                  var postName = data['postName'] ?? 'Unknown';
                                  var postDescription =
                                      data['postDescription'] ??
                                          'No description';
                                  var postImage = data['postImage'] ?? '';

                                  return Card(
                                    elevation: 1,
                                    child: Container(
                                      width: 315,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          if (postImage.isNotEmpty)
                                            ClipRRect(
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(10),
                                                  topLeft: Radius.circular(10)),
                                              child: Image.network(
                                                postImage,
                                                height: 150,
                                                width: double.infinity,
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                          else
                                            Placeholder(
                                              fallbackHeight: 150,
                                              color: Colors.grey,
                                            ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 13, vertical: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    AppText(
                                                      text: postName,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 20,
                                                    ),
                                                    AppText(
                                                      text: postDescription,
                                                      fontSize: 16,
                                                    ),
                                                  ],
                                                ),
                                                CustomButton(
                                                  onTap: () {},
                                                  label: 'view more',
                                                  width: 60,
                                                  height: 25,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w600,
                                                  bgColor: AppColors.primary,
                                                  labelColor: Colors.white,
                                                  borderRadius: 5,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText(
                            text: 'Trending Products',
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          AppText(
                            text: 'See All',
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Stack(
                        children: [
                          SingleChildScrollView(
                            child: Container(
                              height: 255,
                              child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('addproducts')
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  }

                                  if (!snapshot.hasData ||
                                      snapshot.data!.docs.isEmpty) {
                                    return Center(
                                      child: Text(
                                        'No products found.',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    );
                                  }

                                  // Extract product list once to avoid rebuilding excessively
                                  final products =
                                      snapshot.data!.docs.map((doc) {
                                    return {
                                      'productName': doc['productName'],
                                      'productDescription':
                                          doc['productDescription'],
                                      'productPrice': doc['productPrice'],
                                      'productImage': doc['productImage'],
                                      'originalPrice': doc['originalPrice'],
                                    };
                                  }).toList();

                                  return ListView.builder(
                                    key:
                                        UniqueKey(), // Ensure the ListView has a unique key
                                    controller: _scrollsController,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: products.length,
                                    itemBuilder: (context, index) {
                                      final product = products[index];
                                      return _buildTrendingProductsContainer(
                                        product['productImage'],
                                        product['productName'],
                                        product['productPrice'],
                                        product['productDescription'],
                                        product['originalPrice'],
                                        index,
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () {
                                _scrollsController.animateTo(
                                  _scrollsController.position.maxScrollExtent,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut,
                                );
                              },
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.3),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const AppText(
                            text: 'Popular Categories',
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => CategoriesScreen());
                            },
                            child: const AppText(
                              text: 'See All',
                              fontWeight: FontWeight.bold,
                              textColor: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Obx(() => Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 40,
                        child: TabBar(
                          tabAlignment: TabAlignment.start,
                          isScrollable: true,
                          dividerColor: Colors.transparent,
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.transparent,
                          ),
                          onTap: (index) {
                            controller.changeTabIndex(index);
                          },
                          tabs: productsType.map<Widget>((type) {
                            return Tab(
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () {
                                    controller.changeTabIndex(
                                        productsType.indexOf(type));
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(1),
                                    width: 90,
                                    decoration: BoxDecoration(
                                      color: controller.selectedIndex ==
                                              productsType.indexOf(type)
                                          ? AppColors.primary
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: controller.selectedIndex ==
                                                productsType.indexOf(type)
                                            ? Colors.transparent
                                            : AppColors.primary,
                                        width: 2,
                                      ),
                                    ),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        type,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .merge(
                                              TextStyle(
                                                color:
                                                    controller.selectedIndex ==
                                                            productsType
                                                                .indexOf(type)
                                                        ? Colors.white
                                                        : Colors.black,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                              ),
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    )),
                SizedBox(
                  height: 500,
                  child: Obx(() {
                    switch (controller.selectedIndex) {
                      case 0:
                        return const AllItem();
                      case 1:
                        return const BagItem();
                      case 2:
                        return const ClothesItem();
                      case 3:
                        return const ShoesItem();
                      default:
                        return const SizedBox.shrink();
                    }
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDealOfTheDayContainer(
    String image,
    String name,
    String description,
    String price,
    String originalPrice,
    int index,
  ) {
    bool isFavorite = favoriteIndices.contains(index);
    return GestureDetector(
      onTap: () {
        Get.to(() => ProductDetailScreen(
              image: image,
              name: name,
              description: description,
              price: price,
              originalPrice: originalPrice,
            ));
      },
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.all(10),
            width: 150,
            decoration: BoxDecoration(
              color: AppColors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      image,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                AppText(
                  text: name,
                  textColor: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
                AppText(
                  text: description,
                  textColor: Colors.grey,
                ),
                const Spacer(),
                Row(
                  children: [
                    AppText(
                      text: price,
                      textColor: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    const SizedBox(width: 5),
                    AppText(
                      decoration: TextDecoration.lineThrough,
                      text: originalPrice,
                      textColor: Colors.grey,
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          startValue = !startValue;
                        });
                      },
                      child: SizedBox(
                        width: 70,
                        height: 30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            startValue
                                ? Image.asset(
                                    'assets/icons/star.png',
                                    width: 15,
                                    height: 15,
                                    color: AppColors.secondary,
                                  )
                                : Image.asset(
                                    'assets/icons/filled_star.png',
                                    width: 15,
                                    height: 15,
                                    color: AppColors.secondary,
                                  ),
                            const SizedBox(width: 5),
                            const AppText(
                              text: '4.5',
                              textColor: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            right: 20,
            top: 15,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  if (isFavorite) {
                    favoriteIndices.remove(index);
                  } else {
                    favoriteIndices.add(index);
                  }
                });
              },
              child: SizedBox(
                width: 30,
                height: 30,
                child: isFavorite
                    ? const Icon(Icons.favorite, color: Colors.red)
                    : const Icon(
                        Icons.favorite_outline,
                        color: Colors.grey,
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendingProductsContainer(
    String image,
    String name,
    String description,
    String price,
    String originalPrice,
    int index,
  ) {
    bool isFavorite = favoritesIndices.contains(index);
    return GestureDetector(
      onTap: () {
        Get.to(() => ProductDetailScreen(
              image: image,
              name: name,
              description: description,
              price: price,
              originalPrice: originalPrice,
            ));
      },
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.all(10),
            width: 150,
            decoration: BoxDecoration(
              color: AppColors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      image,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                AppText(
                  text: name,
                  textColor: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
                AppText(
                  text: price,
                  textColor: Colors.grey,
                ),
                const Spacer(),
                Row(
                  children: [
                    AppText(
                      text: description,
                      textColor: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    const SizedBox(width: 5),
                    AppText(
                      decoration: TextDecoration.lineThrough,
                      text: originalPrice,
                      textColor: Colors.grey,
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          startsValue = !startsValue;
                        });
                      },
                      child: SizedBox(
                        width: 70,
                        height: 30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            startsValue
                                ? Image.asset(
                                    'assets/icons/star.png',
                                    width: 15,
                                    height: 15,
                                    color: AppColors.secondary,
                                  )
                                : Image.asset(
                                    'assets/icons/filled_star.png',
                                    width: 15,
                                    height: 15,
                                    color: AppColors.secondary,
                                  ),
                            const SizedBox(width: 5),
                            const AppText(
                              text: '4.5',
                              textColor: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            right: 20,
            top: 15,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  if (isFavorite) {
                    favoritesIndices.remove(index);
                  } else {
                    favoritesIndices.add(index);
                  }
                });
              },
              child: SizedBox(
                width: 30,
                height: 30,
                child: isFavorite
                    ? const Icon(Icons.favorite, color: Colors.red)
                    : const Icon(
                        Icons.favorite_outline,
                        color: Colors.grey,
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
