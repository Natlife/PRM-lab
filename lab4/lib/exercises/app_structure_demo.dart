import 'package:flutter/material.dart';

class AppStructureDemo extends StatelessWidget {
  final ThemeMode currentThemeMode;
  final ValueChanged<ThemeMode> onThemeModeChanged;

  const AppStructureDemo({
    super.key,
    required this.currentThemeMode,
    required this.onThemeModeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('App Structure & Theme'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              onThemeModeChanged(isDark ? ThemeMode.light : ThemeMode.dark);
            },
            tooltip: 'Toggle Theme',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome to Scaffold Screen!',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'This screen demonstrates a complete screen structure, including AppBar, Body, FAB, and dynamic theme switching using ThemeData.',
                      style: TextStyle(
                        fontSize: 14,
                        color: theme.colorScheme.onPrimaryContainer.withAlpha(204),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              const Text(
                'Theme Settings',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: SwitchListTile(
                  secondary: CircleAvatar(
                    backgroundColor: isDark ? Colors.amber.shade100 : Colors.indigo.shade100,
                    child: Icon(
                      isDark ? Icons.dark_mode : Icons.light_mode,
                      color: isDark ? Colors.amber.shade900 : Colors.indigo.shade900,
                    ),
                  ),
                  title: const Text(
                    'Dark Mode Toggle',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('Currently active: ${isDark ? 'Dark Mode' : 'Light Mode'}'),
                  value: isDark,
                  onChanged: (bool value) {
                    onThemeModeChanged(value ? ThemeMode.dark : ThemeMode.light);
                  },
                ),
              ),
              const SizedBox(height: 24),

              const Text(
                'Active ThemeData Visualizer',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 2.2,
                children: [
                  _buildThemeColorIndicator('Primary', theme.colorScheme.primary, theme.colorScheme.onPrimary),
                  _buildThemeColorIndicator('Secondary', theme.colorScheme.secondary, theme.colorScheme.onSecondary),
                  _buildThemeColorIndicator('Background', theme.colorScheme.surface, theme.colorScheme.onSurface),
                  _buildThemeColorIndicator('Surface Tint', theme.colorScheme.surfaceTint, Colors.white),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: theme.colorScheme.secondary,
              content: Text(
                'FAB clicked! Current Mode: ${isDark ? 'Dark' : 'Light'}',
                style: TextStyle(color: theme.colorScheme.onSecondary),
              ),
              action: SnackBarAction(
                label: 'Dismiss',
                textColor: theme.colorScheme.onSecondary.withAlpha(230),
                onPressed: () {},
              ),
            ),
          );
        },
        icon: const Icon(Icons.info),
        label: const Text('Show Details'),
      ),
    );
  }

  Widget _buildThemeColorIndicator(String name, Color color, Color textColor) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withAlpha(51)),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: textColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '#${color.toARGB32().toRadixString(16).substring(2).toUpperCase()}',
              style: TextStyle(
                fontSize: 10,
                color: textColor.withAlpha(204),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
