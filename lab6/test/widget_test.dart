import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab6/main.dart';

void main() {
  testWidgets('Movie Genre Browser UI Smoke Test', (WidgetTester tester) async {
    // Set a large screen size for testing so all items are rendered and visible
    final TestWidgetsFlutterBinding binding = TestWidgetsFlutterBinding.ensureInitialized();
    await binding.setSurfaceSize(const Size(1200, 1000));

    // 1. Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // 2. Verify that the app title "Find a Movie" is displayed.
    expect(find.text('Find a Movie'), findsOneWidget);
    expect(find.text('Explore highly rated genres'), findsOneWidget);

    // 3. Verify that the sample movies are loaded (with A-Z sorting, these should be built).
    expect(find.text('Avatar: The Way of Water'), findsOneWidget);
    expect(find.text('Inception'), findsOneWidget);
    expect(find.text('Interstellar'), findsOneWidget);

    // 4. Verify that the search text field is present.
    expect(find.byType(TextField), findsOneWidget);

    // 5. Test search functionality: enter "Inception"
    await tester.enterText(find.byType(TextField), 'Inception');
    await tester.pump();

    // Now we should find "Inception" in the search field and the movie card (total 2), but NOT "Interstellar"
    expect(find.text('Inception'), findsNWidgets(2));
    expect(find.text('Interstellar'), findsNothing);

    // 6. Test clear search
    await tester.tap(find.byIcon(Icons.cancel_rounded));
    await tester.pump();

    // Both should be visible again, and "Inception" is only on the card (total 1)
    expect(find.text('Inception'), findsOneWidget);
    expect(find.text('Interstellar'), findsOneWidget);

    // 7. Test genre filtering
    // Let's find the "Sci-Fi" genre chip. We look inside the Wrap widget which hosts the chips.
    final sciFiChip = find.descendant(of: find.byType(Wrap), matching: find.text('Sci-Fi'));
    expect(sciFiChip, findsOneWidget);
    
    await tester.tap(sciFiChip);
    await tester.pump();

    // With "Sci-Fi" selected, Inception and Interstellar (which are Sci-Fi) should be shown,
    // but "The Dark Knight" (which is Action, Crime, Drama - not Sci-Fi) should be filtered out.
    expect(find.text('Inception'), findsOneWidget);
    expect(find.text('Interstellar'), findsOneWidget);
    expect(find.text('The Dark Knight'), findsNothing);
  });
}
