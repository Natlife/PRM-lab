import 'package:flutter/material.dart';
import '../models/book.dart';
import '../theme/book_app_theme.dart';

class BookReaderScreen extends StatefulWidget {
  final Book book;
  final int initialChapterIndex;

  const BookReaderScreen({
    super.key,
    required this.book,
    required this.initialChapterIndex,
  });

  @override
  State<BookReaderScreen> createState() => _BookReaderScreenState();
}

class _BookReaderScreenState extends State<BookReaderScreen> {
  late int currentChapterIndex;
  double fontSize = 17.0;
  ReadingMode currentMode = ReadingMode.sepia;
  String fontFamily = 'Serif';
  bool isBookmarked = false;
  bool isControlsVisible = true;
  late ScrollController _scrollController;

  final List<String> fontFamilies = ['Serif', 'Sans-Serif', 'Monospace'];

  @override
  void initState() {
    super.initState();
    currentChapterIndex = widget.initialChapterIndex;
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _nextChapter() {
    if (currentChapterIndex < widget.book.chapters.length - 1) {
      setState(() {
        currentChapterIndex++;
        if (_scrollController.hasClients) {
          _scrollController.jumpTo(0);
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bạn đã đọc đến chương cuối cùng! 🎉')),
      );
    }
  }

  void _previousChapter() {
    if (currentChapterIndex > 0) {
      setState(() {
        currentChapterIndex--;
        if (_scrollController.hasClients) {
          _scrollController.jumpTo(0);
        }
      });
    }
  }

  TextStyle _getReadingTextStyle(Color textColor) {
    TextStyle baseStyle = TextStyle(
      fontSize: fontSize,
      color: textColor,
      height: 1.6,
      letterSpacing: 0.2,
    );

    switch (fontFamily) {
      case 'Serif':
        return baseStyle.copyWith(fontFamily: 'Georgia');
      case 'Monospace':
        return baseStyle.copyWith(fontFamily: 'Courier');
      case 'Sans-Serif':
      default:
        return baseStyle.copyWith(fontFamily: 'Roboto');
    }
  }

  void _showSettingsBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            final theme = Theme.of(context);
            final sheetBgColor = theme.brightness == Brightness.dark
                ? const Color(0xFF1E1C2C)
                : Colors.white;

            return Container(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
              decoration: BoxDecoration(
                color: sheetBgColor,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Cài đặt hiển thị',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onBackground,
                    ),
                  ),
                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Cỡ chữ',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onBackground.withOpacity(0.8),
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              if (fontSize > 13) {
                                setState(() {
                                  fontSize--;
                                });
                                setModalState(() {});
                              }
                            },
                            icon: const Icon(Icons.remove_circle_outline_rounded),
                          ),
                          Text(
                            fontSize.toInt().toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            onPressed: () {
                              if (fontSize < 30) {
                                setState(() {
                                  fontSize++;
                                });
                                setModalState(() {});
                              }
                            },
                            icon: const Icon(Icons.add_circle_outline_rounded),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(height: 24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Kiểu chữ',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onBackground.withOpacity(0.8),
                        ),
                      ),
                      Row(
                        children: fontFamilies.map((family) {
                          final isSelected = fontFamily == family;
                          return Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: ChoiceChip(
                              label: Text(family),
                              selected: isSelected,
                              onSelected: (selected) {
                                if (selected) {
                                  setState(() {
                                    fontFamily = family;
                                  });
                                  setModalState(() {});
                                }
                              },
                              selectedColor: theme.colorScheme.primary,
                              labelStyle: TextStyle(
                                color: isSelected ? Colors.white : theme.colorScheme.onBackground,
                              ),
                              showCheckmark: false,
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  const Divider(height: 24),

                  Text(
                    'Chế độ màu nền',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onBackground.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: ReadingMode.values.map((mode) {
                      final modeTheme = AppBookTheme.readerThemes[mode]!;
                      final isSelected = currentMode == mode;
                      
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            currentMode = mode;
                          });
                          setModalState(() {});
                        },
                        child: Container(
                          width: (MediaQuery.of(context).size.width - 72) / 4,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: modeTheme.backgroundColor,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected
                                  ? theme.colorScheme.primary
                                  : Colors.grey.withOpacity(0.2),
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Aa',
                                style: TextStyle(
                                  color: modeTheme.textColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                modeTheme.name,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: modeTheme.textColor.withOpacity(0.7),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final book = widget.book;
    final currentChapter = book.chapters[currentChapterIndex];
    final readerTheme = AppBookTheme.readerThemes[currentMode]!;
    
    return Scaffold(
      backgroundColor: readerTheme.backgroundColor,
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                isControlsVisible = !isControlsVisible;
              });
            },
            child: SafeArea(
              child: SingleChildScrollView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(24, 76, 24, 90),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.title.toUpperCase(),
                      style: TextStyle(
                        fontSize: 12,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.bold,
                        color: readerTheme.textColor.withOpacity(0.4),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      currentChapter.title,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                        color: readerTheme.textColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: 40,
                      height: 3,
                      decoration: BoxDecoration(
                        color: readerTheme.accentColor.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(height: 28),

                    Text(
                      currentChapter.content,
                      style: _getReadingTextStyle(readerTheme.textColor),
                    ),
                    
                    const SizedBox(height: 40),
                    Center(
                      child: Text(
                        '•••',
                        style: TextStyle(
                          fontSize: 20,
                          color: readerTheme.textColor.withOpacity(0.3),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),

          AnimatedPositioned(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            top: isControlsVisible ? 0 : -88,
            left: 0,
            right: 0,
            child: Container(
              height: 88,
              padding: const EdgeInsets.only(top: 24),
              decoration: BoxDecoration(
                color: readerTheme.backgroundColor.withOpacity(0.95),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios_new_rounded, color: readerTheme.textColor),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Expanded(
                    child: Text(
                      currentChapter.title,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: readerTheme.textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          isBookmarked ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                          color: isBookmarked ? Colors.amber : readerTheme.textColor,
                        ),
                        onPressed: () {
                          setState(() {
                            isBookmarked = !isBookmarked;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              duration: const Duration(seconds: 1),
                              content: Text(
                                isBookmarked ? 'Đã thêm đánh dấu trang!' : 'Đã gỡ đánh dấu trang!',
                              ),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.text_format_rounded, color: readerTheme.textColor),
                        onPressed: _showSettingsBottomSheet,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          AnimatedPositioned(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            bottom: isControlsVisible ? 0 : -90,
            left: 0,
            right: 0,
            child: Container(
              height: 90,
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              decoration: BoxDecoration(
                color: readerTheme.backgroundColor.withOpacity(0.95),
                border: Border(
                  top: BorderSide(color: readerTheme.textColor.withOpacity(0.05)),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: currentChapterIndex > 0 ? _previousChapter : null,
                        icon: Icon(
                          Icons.navigate_before_rounded,
                          color: currentChapterIndex > 0
                              ? readerTheme.textColor
                              : readerTheme.textColor.withOpacity(0.2),
                          size: 32,
                        ),
                      ),
                      
                      Text(
                        'Chương ${currentChapterIndex + 1} / ${book.chapters.length}',
                        style: TextStyle(
                          color: readerTheme.textColor.withOpacity(0.8),
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      IconButton(
                        onPressed: currentChapterIndex < book.chapters.length - 1 ? _nextChapter : null,
                        icon: Icon(
                          Icons.navigate_next_rounded,
                          color: currentChapterIndex < book.chapters.length - 1
                              ? readerTheme.textColor
                              : readerTheme.textColor.withOpacity(0.2),
                          size: 32,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
