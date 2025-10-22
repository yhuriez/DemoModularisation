import 'package:flutter/material.dart';

/// Widget d'indicateur de chargement
class LoadingIndicator extends StatelessWidget {
  final String? message;
  
  const LoadingIndicator({
    super.key,
    this.message,
  });
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          if (message != null) ...[
            const SizedBox(height: 16),
            Text(
              message!,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}

