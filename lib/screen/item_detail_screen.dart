import 'package:busan_trip/screen/booking_calendar_screen.dart';
import 'package:busan_trip/screen/pay_screen.dart';
import 'package:busan_trip/screen/review_screen.dart';
import 'package:busan_trip/screen/store_detail_screen.dart';
import 'package:busan_trip/screen/test1.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../vo/item.dart';

class ItemDetailScreen extends StatefulWidget {
  final Item item; // Item 객체를 받도록 수정

  const ItemDetailScreen({Key? key, required this.item}) : super(key: key);

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {

  late Future<void> _loadingFuture;

  @override
  void initState() {
    super.initState();
    _loadingFuture = _simulateLoading();
  }

  Future<void> _simulateLoading() async {
    await Future.delayed(const Duration(seconds: 6));
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
    ));

    return Scaffold(
      body: FutureBuilder<void>(
        future: _loadingFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildDetailContent();
          } else {
            return _buildDetailContent();
          }
        },
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[100],
                  padding: EdgeInsets.symmetric(vertical: 17,),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: Icon(Icons.share_outlined, size: 18, color: Colors.grey[600],),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder:  (context) => BookingCalendarScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff0e4194),
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  '결제하기',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }



  Widget _buildDetailContent() {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 200.0,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          flexibleSpace: FlexibleSpaceBar(
            background: Image.network(
              '${widget.item.i_image}',
              fit: BoxFit.cover,
            ),
          ),
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          elevation: 0,
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              DetailContent(
                image: widget.item.i_image,
                name: widget.item.i_name,
                // wishes: widget.item.i_wishes,
                avgScore: widget.item.averageScore,
                // reviews: widget.item.i_reviews,
                price: widget.item.i_price,
                // shop_img_url: widget.item.s_img_url,
                // shop_name: widget.item.s_name,
                address: widget.item.i_address,
                opr_house: widget.item.operation_house,
                cld_days: widget.item.closed_days,
                content: widget.item.i_content,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DetailContent extends StatefulWidget {
  final String image;
  final String name;
  // final int wishes; (누적 좋아요 갯수)
  final double avgScore;
  // final int reviews; (누적 리뷰 갯수)
  final int price;
  // final String shop_img_url (상점 이미지)
  // final String shop_name; (상점 이름)
  final String address;
  final String opr_house;
  final String cld_days;
  final String content;

  const DetailContent({
    Key? key,
    required this.image,
    required this.name,
    // required this.wishes,
    required this.avgScore,
    // required this.reviews,
    required this.price,
    // required this.shop_img_url,
    // required this.shop_name,
    required this.address,
    required this.opr_house,
    required this.cld_days,
    required this.content,
  }) : super(key: key);

  @override
  _DetailContentState createState() => _DetailContentState();
}

class _DetailContentState extends State<DetailContent> {
  bool isFavorited = false;
  final formatter = NumberFormat('#,###');

  void toggleFavorite() {
    setState(() {
      isFavorited = !isFavorited;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,  // Use screen width
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Container(
                        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 100), // 32는 패딩 등을 고려한 너비
                        child: Text(
                          '${widget.name}',
                          style: TextStyle(
                            fontFamily: 'NotoSansKR',
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          softWrap: true,
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 40,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: toggleFavorite,
                            child: Icon(
                              isFavorited ? Icons.favorite : Icons.favorite_outline,
                              size: 22,
                              color: isFavorited ? Colors.red : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.star_rounded,
                            size: 22,
                            color: Colors.yellow,
                          ),
                          SizedBox(width: 2),
                          Text(
                            '${widget.avgScore}',
                            style: TextStyle(
                              fontFamily: 'NotoSansKR',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            ' · ',
                            style: TextStyle(
                              fontFamily: 'NotoSansKR',
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                              color: Colors.grey[400],
                            ),
                          ),
                          Icon(
                            Icons.favorite,
                            size: 22,
                            color: Colors.red,
                          ),
                          SizedBox(width: 2),
                          Text(
                            '100',
                            style: TextStyle(
                              fontFamily: 'NotoSansKR',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            ' · ',
                            style: TextStyle(
                              fontFamily: 'NotoSansKR',
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                              color: Colors.grey[400],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder:  (context) => ReviewScreen()),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: Colors.black,width: 1.0),
                                ),
                              ),
                              child: Text(
                                '후기 763개',
                                style: TextStyle(
                                  fontFamily: 'NotoSansKR',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            '${formatter.format(widget.price)}원 ',
                            style: TextStyle(
                              fontFamily: 'NotoSansKR',
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            '~',
                            style: TextStyle(
                              fontFamily: 'NotoSansKR',
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(color: Colors.grey[200], thickness: 1.0,),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => StoreDetailScreen()),
                    );
                  },
                  child: Row(
                    children: [
                      Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey[300]!,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                            'https://scontent-ssn1-1.xx.fbcdn.net/v/t39.30808-6/332953938_1879697915719235_6365380102897356357_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=hes9gGl4of4Q7kNvgEKagxf&_nc_ht=scontent-ssn1-1.xx&oh=00_AYCezD298ihgq6Pr_APxLWaALs16AHtZB15Fv8yV9lio2g&oe=66D508B1',
                            width: 35,
                            height: 35,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        '롯데월드 어드벤처 부산',
                        style: TextStyle(
                          fontFamily: 'NotoSansKR',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(color: Colors.grey[200], thickness: 7.0,),
          _buildInfoSection(),
          Divider(color: Colors.grey[200], thickness: 7.0,),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '상품 설명',
                  style: TextStyle(
                    fontFamily: 'NotoSansKR',
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 10),
                Divider(color: Colors.grey[200], thickness: 1.0,),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    children: [
                      Text(
                        '${widget.content}',
                        style: TextStyle(
                          fontFamily: 'NotoSansKR',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.visible,
                      ),
                      SizedBox(height: 15),
                      Image.network(
                        '${widget.image}',
                        fit: BoxFit.cover,
                      ),
                      // Image.network(
                      //   'https://image6.yanolja.com/leisure/eSeHbg8cH0gPskLE',
                      //   fit: BoxFit.cover,
                      // ),
                      // Image.network(
                      //   'https://image6.yanolja.com/leisure/achV2D1nsKKi4KsP',
                      //   fit: BoxFit.cover,
                      // ),
                      // Image.network(
                      //   'https://image6.yanolja.com/leisure/jbq0y0E4SCCpBVeX',
                      //   fit: BoxFit.cover,
                      // ),
                      // Image.network(
                      //   'https://image6.yanolja.com/leisure/86ccgNX3RHA8sQ0l',
                      //   fit: BoxFit.cover,
                      // ),
                      // Image.network(
                      //   'https://image6.yanolja.com/leisure/PDnHAa15yO2f0NML',
                      //   fit: BoxFit.cover,
                      // ),
                      // Image.network(
                      //   'https://image6.yanolja.com/leisure/kLHpL4hlSYZCItxS',
                      //   fit: BoxFit.cover,
                      // ),
                      // Image.network(
                      //   'https://image6.yanolja.com/leisure/uGJuI9R0WQEPxL3H',
                      //   fit: BoxFit.cover,
                      // ),
                      // Image.network(
                      //   'https://image6.yanolja.com/leisure/ch2khfEECTJESUcg',
                      //   fit: BoxFit.cover,
                      // ),
                      // Image.network(
                      //   'https://image6.yanolja.com/leisure/sd8CHbgrG90YJLo7',
                      //   fit: BoxFit.cover,
                      // ),
                      // Image.network(
                      //   'https://image6.yanolja.com/leisure/CoYb4UJB7KJHMZ3O',
                      //   fit: BoxFit.cover,
                      // ),
                      // Image.network(
                      //   'https://image6.yanolja.com/leisure/fyjtVXwzPMJgBe7c',
                      //   fit: BoxFit.cover,
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildInfoSection() {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '이용 안내',
              style: TextStyle(
                fontFamily: 'NotoSansKR',
                fontWeight: FontWeight.w800,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10),
            Divider(color: Colors.grey[200], thickness: 1.0,),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow('주소', '${widget.address}'),
                  // _buildInfoRow('홈페이지', 'https://adventurebusan.lotteworld.com/kor/main/index.do'),
                  _buildInfoRow('운영요일 및 시간', '${widget.opr_house}'),
                  // _buildInfoRow('전화번호', '1661-2000'),
                  _buildInfoRow('휴무일', '${widget.cld_days}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: 'NotoSansKR',
              fontWeight: FontWeight.w800,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 5),
          Text(
            content,
            style: TextStyle(
              fontFamily: 'NotoSansKR',
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
