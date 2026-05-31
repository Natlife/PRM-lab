import 'package:flutter/material.dart';

class Chapter {
  final String id;
  final String title;
  final String content;
  final int readingTimeMinutes;
  bool isCompleted;

  Chapter({
    required this.id,
    required this.title,
    required this.content,
    required this.readingTimeMinutes,
    this.isCompleted = false,
  });
}

class Book {
  final String id;
  final String title;
  final String author;
  final String category;
  final String description;
  final double rating;
  final int totalPages;
  final double progressPercent;
  final int currentChapterIndex;
  final List<Color> coverGradient;
  final IconData coverIcon;
  final List<Chapter> chapters;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.category,
    required this.description,
    required this.rating,
    required this.totalPages,
    required this.progressPercent,
    required this.currentChapterIndex,
    required this.coverGradient,
    required this.coverIcon,
    required this.chapters,
  });
}

final List<Book> mockBooks = [
  Book(
    id: '1',
    title: 'Nhà Giả Kim',
    author: 'Paulo Coelho',
    category: 'Tiểu thuyết',
    description: 'Cuộc phiêu lưu của Santiago, một cậu bé chăn cừu người Tây Ban Nha, trong hành trình đi tìm "Truyền thuyết cá nhân" của mình. Cuốn sách mang tính triết lý sâu sắc, thức tỉnh mỗi người theo đuổi ước mơ lớn nhất của đời mình.',
    rating: 4.9,
    totalPages: 228,
    progressPercent: 0.65,
    currentChapterIndex: 1,
    coverGradient: [const Color(0xFF1E3C72), const Color(0xFF2A5298)],
    coverIcon: Icons.explore_outlined,
    chapters: [
      Chapter(
        id: '1_1',
        title: 'Chương 1: Cậu bé chăn cừu và giấc mơ',
        readingTimeMinutes: 12,
        isCompleted: true,
        content: '''Santiago dắt bầy cừu tiến về phía ngôi nhà thờ đổ nát. Ngôi nhà thờ này đã mất mái từ lâu, và một cây vả lớn đã mọc lên ngay tại nơi trước kia là buồng thánh.

Cậu quyết định qua đêm tại đây. Cậu cho đàn cừu vào qua cánh cửa đổ nát rồi chắn lại bằng vài thanh gỗ để chúng khỏi đi lạc trong đêm. Không có sói trong vùng này, nhưng đã có lần một con cừu đi lạc làm cậu mất cả ngày hôm sau để tìm kiếm.

Santiago trải tấm áo khoác trên nền đất đầy bụi và gối đầu lên cuốn sách vừa đọc xong. Cậu tự nhủ mình phải tìm những cuốn sách dày hơn để có thể đọc được lâu hơn và làm gối đầu cũng êm hơn.

Khi cậu thức dậy, trời vẫn còn tối mịt và nhìn lên qua những bức tường đổ, cậu thấy những ngôi sao lấp lánh. Cậu thầm nghĩ: "Mình muốn ngủ thêm chút nữa". Cậu đã có cùng một giấc mơ như tuần trước, và một lần nữa cậu lại thức giấc trước khi nó kết thúc...''',
      ),
      Chapter(
        id: '1_2',
        title: 'Chương 2: Vị vua xứ Salem',
        readingTimeMinutes: 15,
        isCompleted: false,
        content: '''Tại quảng trường thị trấn Tarifa, cậu bé ngồi trên một chiếc ghế đá và bắt đầu đọc cuốn sách mới mua. Cậu muốn tập trung đọc nhưng một ông già mặc áo choàng kỳ lạ tiến đến và ngồi xuống cạnh cậu.

- Trông cuốn sách này có vẻ tẻ nhạt, - ông già nói và chỉ vào bìa sách. - Nó nói về những điều mà hầu hết các cuốn sách khác đều nói. Về việc con người không có khả năng tự lựa chọn định mệnh của mình. Và kết thúc bằng việc mọi người đều tin vào lời nói dối vĩ đại nhất thế giới.

- Lời nói dối vĩ đại nhất thế giới là gì ạ? - Santiago ngạc nhiên hỏi.

Ông già trả lời:
- Đó là: vào một thời điểm nào đó trong đời, chúng ta không thể kiểm soát được những gì đang xảy ra với mình, và cuộc sống của chúng ta sẽ bị định đoạt bởi số phận. Đó chính là lời nói dối vĩ đại nhất.

Cậu bé không hiểu hết lời ông lão, nhưng cậu cảm thấy có điều gì đó rất đặc biệt ở người đàn ông này. Ông tự giới thiệu mình là Melchizedek, Vua xứ Salem.''',
      ),
      Chapter(
        id: '1_3',
        title: 'Chương 3: Đại dương cát ấm',
        readingTimeMinutes: 18,
        isCompleted: false,
        content: '''Sa mạc Sahara đón chào Santiago bằng cái nóng hừng hực và sự im lặng mênh mông của cát. Giờ đây cậu không còn là một cậu bé chăn cừu với bầy cừu quen thuộc nữa. Cậu là một kẻ lữ hành đi tìm kho báu của mình tại Kim Tự Tháp Ai Cập.

Cậu gia nhập đoàn lữ hành lớn vượt sa mạc. Ở đây, cậu gặp một người Anh đang đi tìm nhà giả kim thực thụ - người có thể biến kim loại thường thành vàng và chế tạo ra Thuốc Trường Sinh.

Sa mạc rất rộng lớn và huyền bí. Gió thổi liên tục đổi thay hình dạng của những đồi cát. Santiago bắt đầu học cách lắng nghe sa mạc, lắng nghe những chú lạc đà và cả tiếng nói của chính trái tim mình. Cậu nhận ra rằng sa mạc cũng có một ngôn ngữ riêng, và nếu biết lắng nghe, sa mạc sẽ chỉ lối cho cậu...''',
      ),
      Chapter(
        id: '1_4',
        title: 'Chương 4: Ốc đảo Al-Fayoum',
        readingTimeMinutes: 20,
        isCompleted: false,
        content: '''Sau nhiều tuần di chuyển dưới cái nóng cháy da, đoàn lữ hành cuối cùng cũng nhìn thấy những rặng dừa xanh mướt của ốc đảo Al-Fayoum. Ốc đảo là vùng đất trung lập, nơi mọi cuộc chiến tranh của sa mạc đều phải dừng lại bên ngoài ranh giới.

Tại đây, Santiago đã gặp Fatima bên giếng nước. Vừa nhìn vào mắt cô, cậu đã biết đây là tình yêu của đời mình. Ngôn ngữ của Vũ Trụ đã kết nối hai tâm hồn họ ngay lập tức mà không cần một lời nói nào.

Cũng tại ốc đảo này, qua những dấu hiệu của loài chim bay trên bầu trời sa mạc, Santiago đã tiên đoán được cuộc tấn công bất ngờ vào ốc đảo và giúp người dân bảo vệ vùng đất thánh. Điều này đã thu hút sự chú ý của một nhân vật bí ẩn cưỡi ngựa đen: Nhà Giả Kim xứ Al-Fayoum.''',
      ),
    ],
  ),
  Book(
    id: '2',
    title: 'Đắc Nhân Tâm',
    author: 'Dale Carnegie',
    category: 'Phát triển bản thân',
    description: 'Cuốn sách bán chạy nhất mọi thời đại về nghệ thuật giao tiếp và thu phục lòng người. Tác phẩm mang lại những góc nhìn sâu sắc về cách ứng xử, tạo thiện cảm và gây ảnh hưởng tích cực đến những người xung quanh.',
    rating: 4.8,
    totalPages: 320,
    progressPercent: 0.30,
    currentChapterIndex: 0,
    coverGradient: [const Color(0xFFD4145A), const Color(0xFFFBB03B)],
    coverIcon: Icons.people_alt_outlined,
    chapters: [
      Chapter(
        id: '2_1',
        title: 'Chương 1: Muốn lấy mật thì đừng phá tổ ong',
        readingTimeMinutes: 14,
        isCompleted: true,
        content: '''Vào ngày 7 tháng 5 năm 1931, thành phố New York chứng chiến một cuộc vây bắt tội phạm kịch tính chưa từng có. Tên sát nhân hai súng khét tiếng Crowley "Độc Thủ" bị bao vây tại căn hộ của nhân tình trên đại lộ West End.

Hơn một trăm cảnh sát đã dùng súng máy, hơi cay tấn công vào pháo đài của hắn. Suốt hai tiếng đồng hồ, khu phố thượng lưu sầm uất vang rền tiếng súng. Khi bị bắt, Crowley đã viết một bức thư đẫm máu gửi cho công chúng: "Dưới lớp áo này là một trái tim mệt mỏi nhưng nhân từ - một trái tim không muốn làm hại ai."

Bạn nghĩ sao về lời tự sự của tên sát nhân máu lạnh này? Hắn không hề tự trách mình. Hắn cho rằng hành động của mình chỉ là tự vệ.

Nếu một tên tội phạm nguy hiểm như Crowley còn không tự trách mình, thì những người bình thường quanh ta sẽ phản ứng thế nào khi bị chỉ trích?

Chỉ trích là vô ích vì nó buộc người ta phải phòng thủ và tìm cách bào chữa. Chỉ trích là nguy hiểm vì nó làm tổn thương lòng tự trọng, gây ra sự phẫn nộ và oán hận. Nguyên tắc đầu tiên của nghệ thuật ứng xử là: Không chỉ trích, oán trách hay than phiền.''',
      ),
      Chapter(
        id: '2_2',
        title: 'Chương 2: Bí mật lớn nhất trong giao tiếp',
        readingTimeMinutes: 16,
        isCompleted: false,
        content: '''Chỉ có một cách duy nhất trên đời này để khiến người khác làm một việc gì đó. Bạn đã bao giờ nghĩ về điều này chưa? Đó là làm cho họ muốn làm việc đó.

Nhà triết học John Dewey nói rằng động lực sâu sắc nhất trong bản chất con người là "khao khát được cảm thấy mình quan trọng". Mọi người đều thích được khen ngợi và đánh giá cao.

Charles Schwab, một trong những người đầu tiên nhận mức lương hơn một triệu đô la một năm trong ngành thép Mỹ, đã chia sẻ bí quyết thành công của mình: "Khả năng khơi dậy lòng nhiệt huyết ở những người xung quanh là tài sản lớn nhất của tôi. Cách tốt nhất để phát triển những gì tốt đẹp nhất ở một con người là công nhận và khuyến khích họ."

Lời khen ngợi chân thành có sức mạnh thay đổi cuộc đời một con người. Hãy phân biệt rõ ràng giữa sự khen ngợi chân thành và lời nịnh bợ giả dối. Khen ngợi xuất phát từ tấm lòng; nịnh bợ chỉ từ cửa miệng. Khen ngợi là vô tư; nịnh bợ là ích kỷ.

Nguyên tắc 2: Thành thật khen ngợi và biết ơn người khác.''',
      ),
      Chapter(
        id: '2_3',
        title: 'Chương 3: Ai làm được điều này sẽ có cả thế giới',
        readingTimeMinutes: 15,
        isCompleted: false,
        content: '''Mùa hè năm ngoái, tôi đi câu cá ở vùng Maine. Cá nhân tôi rất thích ăn dâu tây kem, nhưng vì một lý do kỳ lạ nào đó, loài cá lại thích ăn giun. Vì vậy, khi đi câu cá, tôi không nghĩ về những gì tôi thích mà nghĩ về những gì lũ cá muốn. Tôi không móc dâu tây kem vào lưỡi câu mà móc một con giun.

Tại sao chúng ta không áp dụng lẽ thường đơn giản này trong mối quan hệ giữa con người với con người?

Con người thường chỉ quan tâm đến những gì họ muốn. Nhưng người khác thì không quan tâm đến những gì bạn muốn đâu. Họ cũng chỉ quan tâm đến những gì họ muốn mà thôi. Vì vậy, cách duy nhất để gây ảnh hưởng đến người khác là nói về những gì họ muốn và chỉ cho họ cách để đạt được điều đó.

Nếu bạn muốn thuyết phục ai đó làm việc gì, trước khi nói, hãy tự hỏi: "Làm thế nào để tôi có thể làm cho người này muốn làm điều đó?"

Nguyên tắc 3: Gợi ý cho người khác ý muốn thực hiện điều bạn đề nghị.''',
      ),
    ],
  ),
  Book(
    id: '3',
    title: 'Lược Sử Thời Gian',
    author: 'Stephen Hawking',
    category: 'Khoa học',
    description: 'Một cuốn sách tuyệt vời giải thích các khái niệm phức tạp của vật lý vũ trụ, thuyết tương đối, cơ học lượng tử và lỗ đen dưới ngôn ngữ dễ hiểu, đưa người đọc vào chuyến du hành kỳ thú khám phá nguồn gốc vũ trụ.',
    rating: 4.7,
    totalPages: 280,
    progressPercent: 0.15,
    currentChapterIndex: 0,
    coverGradient: [const Color(0xFF0F2027), const Color(0xFF203A43), const Color(0xFF2C5364)],
    coverIcon: Icons.blur_on_outlined,
    chapters: [
      Chapter(
        id: '3_1',
        title: 'Chương 1: Bức tranh của chúng ta về vũ trụ',
        readingTimeMinutes: 22,
        isCompleted: true,
        content: '''Một nhà khoa học nổi tiếng từng thuyết trình về thiên văn học. Bà giải thích cách Trái Đất quay quanh Mặt Trời và cách Mặt Trời quay quanh trung tâm của một dải ngân hà khổng lồ gồm hàng tỷ ngôi sao.

Khi buổi thuyết trình kết thúc, một bà cụ nhỏ bé ở cuối phòng đứng dậy và nói:
- Những gì ông vừa nói hoàn toàn là nhảm nhí. Trái Đất thực chất là một đĩa phẳng nằm trên lưng một con rùa khổng lồ.

Nhà khoa học mỉm cười kiêu hãnh và hỏi lại:
- Thế con rùa đó đứng trên cái gì?

- Ông rất thông minh, chàng trai trẻ, - bà cụ nói. - Nhưng dưới đó toàn là rùa cả!

Hầu hết mọi người ngày nay sẽ thấy hình ảnh vũ trụ như một tháp rùa vô tận là vô lý. Nhưng tại sao chúng ta lại nghĩ rằng chúng ta biết nhiều hơn thế? Chúng ta thực sự biết gì về vũ trụ, và làm thế nào chúng ta biết được điều đó? Vũ trụ bắt đầu từ đâu và nó sẽ đi về đâu? Vũ trụ có điểm khởi đầu hay không, và nếu có thì trước đó có cái gì? Bản chất của thời gian là gì? Liệu nó có bao giờ kết thúc hay không?''',
      ),
      Chapter(
        id: '3_2',
        title: 'Chương 2: Không gian và Thời gian',
        readingTimeMinutes: 25,
        isCompleted: false,
        content: '''Các quan niệm của chúng ta về chuyển động của các vật thể bắt đầu từ thời Galileo và Newton. Trước đó, người ta tin vào quan điểm của Aristotle rằng trạng thái tự nhiên của một vật thể là đứng yên, và nó chỉ chuyển động nếu bị thúc đẩy bởi một lực hoặc sự va chạm.

Newton đã bác bỏ điều này bằng các định luật chuyển động và định luật vạn vật hấp dẫn của mình. Không có một tiêu chuẩn tuyệt đối nào cho sự đứng yên: bạn không thể xác định được hai sự kiện xảy ra ở các thời điểm khác nhau có xảy ra ở cùng một vị trí trong không gian hay không.

Sự thiếu vắng một vị trí tuyệt đối trong không gian nghĩa là ta cũng không thể xác định được một thời gian tuyệt đối. 

Mọi thứ đã hoàn toàn thay đổi vào năm 1905, khi Albert Einstein đề xuất Thuyết Tương đối Hẹp của mình, bác bỏ khái niệm thời gian tuyệt đối và chứng minh rằng tốc độ ánh sáng là giới hạn tuyệt đối của vũ trụ.''',
      ),
    ],
  ),
  Book(
    id: '4',
    title: 'Sapiens: Lược Sử Loài Người',
    author: 'Yuval Noah Harari',
    category: 'Lịch sử',
    description: 'Khám phá hành trình phi thường của Homo Sapiens từ một loài vượn người không có gì nổi bật ở Đông Phi trở thành bá chủ thống trị hành tinh xanh thông qua ba cuộc cách mạng lớn.',
    rating: 4.9,
    totalPages: 560,
    progressPercent: 0.0,
    currentChapterIndex: 0,
    coverGradient: [const Color(0xFF8E2DE2), const Color(0xFF4A00E0)],
    coverIcon: Icons.history_edu_outlined,
    chapters: [
      Chapter(
        id: '4_1',
        title: 'Chương 1: Một loài động vật không có gì đặc biệt',
        readingTimeMinutes: 20,
        isCompleted: false,
        content: '''Khoảng 2,5 triệu năm trước, loài người lần đầu tiên tiến hóa từ một chi vượn người đi trước tại Đông Phi. Nhưng trong một thời gian dài dằng dặc, loài người không có gì nổi bật hay có sức ảnh hưởng lớn đến môi trường xung quanh hơn các loài khỉ, voi hay sứa.

Điều quan trọng nhất cần ghi nhớ là: trong phần lớn lịch sử tiến hóa, có rất nhiều loài người khác nhau cùng tồn tại trên Trái Đất. Chúng ta có Homo Neanderthalensis ở châu Âu, Homo Erectus ở châu Á, Homo Soloensis ở đảo Java, và Homo Sapiens của chúng ta.

Làm thế nào mà Homo Sapiens - một loài có cơ bắp yếu hơn Neanderthal, bộ não không lớn hơn - lại có thể sống sót và đẩy toàn bộ các loài người khác vào sự tuyệt chủng để trở thành loài thống trị duy nhất?

Bí quyết nằm ở cuộc Cách mạng Nhận thức nổ ra khoảng 70.000 năm trước, mang lại cho Sapiens một khả năng độc nhất vô nhị: Khả năng ngôn ngữ để truyền đạt về những điều không có thật - hay còn gọi là Khả năng Tưởng tượng Tập thể.''',
      ),
      Chapter(
        id: '4_2',
        title: 'Chương 2: Cây tri thức và Trật tự tưởng tượng',
        readingTimeMinutes: 24,
        isCompleted: false,
        content: '''Khả năng nói về những điều tưởng tượng là đặc điểm độc đáo nhất của ngôn ngữ Sapiens. Bạn không bao giờ có thể thuyết phục một con khỉ đưa cho bạn quả chuối bằng cách hứa hẹn với nó về một thiên đường đầy chuối sau khi chết.

Nhưng loài người thì có thể. Sự tưởng tượng tập thể cho phép Sapiens hợp tác linh hoạt với số lượng lớn những người xa lạ. Nó giúp tạo ra các huyền thoại chung như tôn giáo, quốc gia, luật pháp và cả tiền tệ.

Tất cả các trật tự xã hội lớn của loài người, từ Đế chế La Mã cho đến các công ty đa quốc gia ngày nay, đều được xây dựng trên những trật tự tưởng tượng này. Chúng chỉ tồn tại chừng nào hàng triệu người còn cùng tin tưởng vào chúng.''',
      ),
    ],
  ),
];
