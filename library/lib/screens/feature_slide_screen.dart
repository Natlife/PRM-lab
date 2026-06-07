import 'package:flutter/material.dart';

class FeatureSlideScreen extends StatefulWidget {
  const FeatureSlideScreen({super.key});

  @override
  State<FeatureSlideScreen> createState() => _FeatureSlideScreenState();
}

class _FeatureSlideScreenState extends State<FeatureSlideScreen> {
  late PageController _pageController;
  int _currentPage = 0;

  final List<Map<String, String>> _features = [
    {
      'image': 'https://images.unsplash.com/photo-1531403009284-440f080d1e12?w=500',
      'title': 'Tính Năng',
      'desc': 'Tính bài cho phó thám hiểm cho bưu được hàng tráp',
    },
    {
      'image': 'https://images.unsplash.com/photo-1460925895917-afdab827c52f?w=500',
      'title': 'Giới Thiệu',
      'desc': 'Tinh anh hội tụ mang lại trải nghiệm tối ưu nhất cho bạn',
    },
    {
      'image': 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=500',
      'title': 'Phân Tích',
      'desc': 'Biểu đồ trực quan giúp theo dõi tiến độ một cách chính xác',
    },
    {
      'image': 'https://images.unsplash.com/photo-1551288049-bebda4e38f71?w=500',
      'title': 'Báo Cáo',
      'desc': 'Xuất báo cáo chi tiết chỉ với một cú chạm nhanh chóng',
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0, viewportFraction: 0.75);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryPurple = Colors.purple;
    const Color primaryPurpleLight = Colors.purpleAccent;
    const Color surfaceWhite = Colors.white;
    const Color onSurfaceBlack = Colors.black;
    const Color textGrey = Colors.grey;

    return Scaffold(
      backgroundColor: Colors.white60,
      appBar: AppBar(
        backgroundColor: onSurfaceBlack,
        title: const Text(
          'Giới thiệu tính năng',
          style: TextStyle(
            color: surfaceWhite,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            height: 10,
            color: onSurfaceBlack,
          ),

          Column(
            children: [
              const SizedBox(height: 40),

              SizedBox(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _features.length,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  itemBuilder: (context, index) {
                    final double scale = _currentPage == index ? 1.0 : 0.92;

                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOutCubic,
                      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                      transform: Matrix4.identity()..scale(scale),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E1E1E),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 1. Phần hình ảnh phía trên
                            Expanded(
                              flex: 6,
                              child: Image.network(
                                _features[index]['image']!,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),

                            Expanded(
                              flex: 4,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      _features[index]['title']!,
                                      style: const TextStyle(
                                        color: surfaceWhite,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      _features[index]['desc']!,
                                      style: TextStyle(
                                        color: surfaceWhite.withOpacity(0.7),
                                        fontSize: 14,
                                        height: 1.4,
                                      ),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _features.length,
                      (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    height: 8,
                    width: _currentPage == index ? 16 : 8,
                    decoration: BoxDecoration(
                      color: _currentPage == index ? onSurfaceBlack : textGrey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}