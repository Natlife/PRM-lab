import 'package:flutter/material.dart';
import '../models/book_model.dart';
import '../services/storage_service.dart';

class LibraryTab extends StatefulWidget {
  const LibraryTab({super.key});

  @override
  State<LibraryTab> createState() => _LibraryTabState();
}

class _LibraryTabState extends State<LibraryTab> {
  final StorageService _storageService = StorageService();
  final List<BookModel> _allBooks = [];
  List<BookModel> _filteredBooks = [];
  bool _isLoading = true;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadBooks();
  }

  Future<void> _loadBooks() async {
    setState(() {
      _isLoading = true;
    });
    final books = await _storageService.loadBooksFromStorage();
    setState(() {
      _allBooks.clear();
      _allBooks.addAll(books);
      _filterBooks();
      _isLoading = false;
    });
  }

  void _filterBooks() {
    setState(() {
      if (_searchQuery.isEmpty) {
        _filteredBooks = List.from(_allBooks);
      } else {
        _filteredBooks = _allBooks.where((book) {
          final query = _searchQuery.toLowerCase();
          return book.title.toLowerCase().contains(query) ||
              book.author.toLowerCase().contains(query) ||
              book.genre.toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  Future<void> _saveChanges() async {
    await _storageService.saveBooksToStorage(_allBooks);
  }

  void _showBookForm({BookModel? book}) {
    final titleController = TextEditingController(text: book?.title ?? '');
    final authorController = TextEditingController(text: book?.author ?? '');
    final yearController = TextEditingController(text: book?.year.toString() ?? '');
    final genreController = TextEditingController(text: book?.genre ?? '');
    final formKey = GlobalKey<FormState>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Color(0xFF1E1E2E),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 24,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: 48,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  book == null ? 'Add New Book' : 'Edit Book',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: titleController,
                  style: const TextStyle(color: Colors.white),
                  decoration: _getInputDecoration('Title'),
                  validator: (value) => value == null || value.trim().isEmpty ? 'Please enter a title' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: authorController,
                  style: const TextStyle(color: Colors.white),
                  decoration: _getInputDecoration('Author'),
                  validator: (value) => value == null || value.trim().isEmpty ? 'Please enter an author' : null,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: yearController,
                        style: const TextStyle(color: Colors.white),
                        keyboardType: TextInputType.number,
                        decoration: _getInputDecoration('Year'),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Enter year';
                          }
                          if (int.tryParse(value) == null) {
                            return 'Invalid year';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: genreController,
                        style: const TextStyle(color: Colors.white),
                        decoration: _getInputDecoration('Genre'),
                        validator: (value) => value == null || value.trim().isEmpty ? 'Enter genre' : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      final title = titleController.text.trim();
                      final author = authorController.text.trim();
                      final year = int.parse(yearController.text.trim());
                      final genre = genreController.text.trim();

                      setState(() {
                        if (book == null) {
                          final newId = _allBooks.isEmpty ? 1 : _allBooks.map((b) => b.id).reduce((a, b) => a > b ? a : b) + 1;
                          _allBooks.add(BookModel(id: newId, title: title, author: author, year: year, genre: genre));
                        } else {
                          final index = _allBooks.indexWhere((b) => b.id == book.id);
                          if (index != -1) {
                            _allBooks[index] = BookModel(id: book.id, title: title, author: author, year: year, genre: genre);
                          }
                        }
                        _filterBooks();
                      });
                      _saveChanges();
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(book == null ? 'Book added successfully!' : 'Book updated successfully!'),
                          backgroundColor: const Color(0xFFA6E3A1),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFCBA6F7),
                    foregroundColor: const Color(0xFF1E1E2E),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                  child: Text(
                    book == null ? 'Add Book' : 'Save Changes',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  InputDecoration _getInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white70),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.white24),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFCBA6F7), width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFF38BA8)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFF38BA8), width: 2),
      ),
    );
  }

  void _confirmDelete(BookModel book) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1E1E2E),
          title: const Text('Confirm Delete', style: TextStyle(color: Colors.white)),
          content: Text('Are you sure you want to delete "${book.title}"?', style: const TextStyle(color: Colors.white70)),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(color: Colors.white38)),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _allBooks.removeWhere((b) => b.id == book.id);
                  _filterBooks();
                });
                _saveChanges();
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Book deleted successfully!'),
                    backgroundColor: const Color(0xFFF38BA8),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                );
              },
              child: const Text('Delete', style: TextStyle(color: Color(0xFFF38BA8))),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF11111B),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 8.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E2E),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withOpacity(0.05)),
              ),
              child: TextField(
                controller: _searchController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search by title, author, or genre...',
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
                  prefixIcon: const Icon(Icons.search_rounded, color: Colors.white54),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, color: Colors.white54),
                          onPressed: () {
                            _searchController.clear();
                            setState(() {
                              _searchQuery = '';
                              _filterBooks();
                            });
                          },
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                    _filterBooks();
                  });
                },
              ),
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFCBA6F7)),
                    ),
                  )
                : _filteredBooks.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.library_books_rounded, color: Colors.white24, size: 64),
                            const SizedBox(height: 16),
                            Text(
                              _searchQuery.isEmpty ? 'Your library is empty' : 'No matches found',
                              style: const TextStyle(color: Colors.white54, fontSize: 16),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: _filteredBooks.length,
                        itemBuilder: (context, index) {
                          final book = _filteredBooks[index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1E1E2E),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.white.withOpacity(0.05)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              leading: Container(
                                height: 48,
                                width: 48,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFCBA6F7).withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(Icons.bookmark_rounded, color: Color(0xFFCBA6F7)),
                              ),
                              title: Text(
                                book.title,
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 4),
                                  Text(
                                    'by ${book.author}',
                                    style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 13),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    '${book.genre} • ${book.year}',
                                    style: TextStyle(color: Colors.white.withOpacity(0.35), fontSize: 11),
                                  ),
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit_rounded, color: Color(0xFFA6E3A1), size: 20),
                                    onPressed: () => _showBookForm(book: book),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete_rounded, color: Color(0xFFF38BA8), size: 20),
                                    onPressed: () => _confirmDelete(book),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showBookForm(),
        backgroundColor: const Color(0xFFCBA6F7),
        foregroundColor: const Color(0xFF11111B),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: const Icon(Icons.add_rounded, size: 28),
      ),
    );
  }
}
