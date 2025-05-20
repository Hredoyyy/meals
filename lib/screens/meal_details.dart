import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';

class Mealdetails extends StatelessWidget {
  const Mealdetails({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(meal.name)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              meal.imageUrl,
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),

            Text(
              "Ingredients",
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            SizedBox(height: 10),
            for (final ingredient in meal.ingredients)
              Text(
                ingredient,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            SizedBox(height: 20),
            Text(
              "Steps",
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            SizedBox(height: 10),
            for (var i = 0; i < meal.steps.length; i++)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "${i + 1}. ${meal.steps[i]}",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
