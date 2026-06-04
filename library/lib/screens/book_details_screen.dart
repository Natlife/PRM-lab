import 'package:flutter/material.dart';
import '../models/book.dart';
import '../widgets/book_cover.dart';
import 'book_reader_screen.dart';

class BookDetailsScreen extends StatefulWidget {
  final Book book;

  const BookDetailsScreen({super.key, required this.book});

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  bool isDescriptionExpanded = false;

  @override
  Widget build(BuildContext context) {
    final book = widget.book;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_outline_rounded),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Đã thêm sách vào danh sách yêu thích!')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 110),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Hero(
                    tag: 'book_cover_${book.id}',
                    child: BookCoverWidget(
                      book: book,
                      width: 160,
                      height: 240,
                      borderRadius: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                Center(
                  child: Column(
                    children: [
                      Text(
                        book.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        book.author,
                        style: TextStyle(
                          fontSize: 16,
                          color: theme.colorScheme.onBackground.withOpacity(0.6),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildStatCard(
                      context,
                      icon: Icons.star_rounded,
                      iconColor: Colors.amber,
                      value: book.rating.toString(),
                      label: 'Đánh giá',
                    ),
                    _buildStatCard(
                      context,
                      icon: Icons.auto_stories_rounded,
                      iconColor: theme.colorScheme.primary,
                      value: '${book.totalPages} trang',
                      label: 'Độ dài',
                    ),
                    _buildStatCard(
                      context,
                      icon: Icons.donut_large_rounded,
                      iconColor: theme.colorScheme.secondary,
                      value: '${(book.progressPercent * 100).toInt()}%',
                      label: 'Đã đọc',
                    ),
                  ],
                ),
                const SizedBox(height: 28),

                const Text(
                  'Tóm tắt nội dung',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isDescriptionExpanded = !isDescriptionExpanded;
                    });
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        book.description,
                        maxLines: isDescriptionExpanded ? 100 : 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.5,
                          color: theme.colorScheme.onBackground.withOpacity(0.7),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        isDescriptionExpanded ? 'Thu gọn' : 'Đọc thêm',
                        style: TextStyle(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Mục lục',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${book.chapters.length} chương',
                      style: TextStyle(
                        fontSize: 13,
                        color: theme.colorScheme.onBackground.withOpacity(0.5),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: book.chapters.length,
                  itemBuilder: (context, index) {
                    final chapter = book.chapters[index];
                    final isCurrentlyReading = index == book.currentChapterIndex && book.progressPercent > 0;
                    
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookReaderScreen(
                                book: book,
                                initialChapterIndex: index,
                              ),
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          decoration: BoxDecoration(
                            color: isCurrentlyReading
                                ? theme.colorScheme.primary.withOpacity(0.05)
                                : theme.colorScheme.surface,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isCurrentlyReading
                                  ? theme.colorScheme.primary.withOpacity(0.2)
                                  : theme.colorScheme.onBackground.withOpacity(0.04),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: chapter.isCompleted
                                      ? Colors.green.withOpacity(0.12)
                                      : isCurrentlyReading
                                          ? theme.colorScheme.primary.withOpacity(0.12)
                                          : theme.colorScheme.onBackground.withOpacity(0.05),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: chapter.isCompleted
                                      ? const Icon(
                                          Icons.check_rounded,
                                          color: Colors.green,
                                          size: 18,
                                        )
                                      : isCurrentlyReading
                                          ? Icon(
                                              Icons.play_arrow_rounded,
                                              color: theme.colorScheme.primary,
                                              size: 18,
                                            )
                                          : Text(
                                              '${index + 1}',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: theme.colorScheme.onBackground.withOpacity(0.6),
                                              ),
                                            ),
                                ),
                              ),
                              const SizedBox(width: 16),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      chapter.title,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: isCurrentlyReading || chapter.isCompleted
                                            ? FontWeight.bold
                                            : FontWeight.w500,
                                        color: isCurrentlyReading
                                            ? theme.colorScheme.primary
                                            : theme.colorScheme.onBackground,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      '${chapter.readingTimeMinutes} phút đọc',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: theme.colorScheme.onBackground.withOpacity(0.4),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(width: 8),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: theme.colorScheme.onBackground.withOpacity(0.2),
                                size: 14,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          Positioned(
            left: 24,
            right: 24,
            bottom: 24,
            child: Container(
              height: 58,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: theme.colorScheme.primary.withOpacity(0.3),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookReaderScreen(
                        book: book,
                        initialChapterIndex: book.currentChapterIndex,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      book.progressPercent > 0 ? Icons.play_arrow_rounded : Icons.menu_book_rounded,
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      book.progressPercent > 0
                          ? 'Đọc tiếp (Chương ${book.currentChapterIndex + 1})'
                          : 'Bắt đầu đọc sách',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String value,
    required String label,
  }) {
    final cardBgColor = Theme.of(context).colorScheme.surface;
    final borderColor = Theme.of(context).colorScheme.onBackground.withOpacity(0.04);
    
    return Container(
      width: (MediaQuery.of(context).size.width - 66) / 3,
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: cardBgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 20,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: Theme.of(context).colorScheme.onBackground.withOpacity(0.4),
            ),
          ),
        ],
      ),
    );
  }
}
