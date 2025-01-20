import 'package:flutter/material.dart';

import '../../../../core/constants/color_constants.dart';

class NewOrderScreen extends StatefulWidget {
  const NewOrderScreen({super.key});

  @override
  State<NewOrderScreen> createState() => _NewOrderScreenState();
}

class _NewOrderScreenState extends State<NewOrderScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    hintText: "Search here ...",
                    fillColor: ColorConstants.cardBackgroundColor,
                    filled: true,
                    isDense: true,
                    suffixIcon: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        color: ColorConstants.primaryColor,
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.search, color: Colors.white),
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    // _searchSubject.add(value);
                  },
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        color: Colors.red,
                      ),
                      Expanded(child: Container(color: Colors.green,))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Expanded(child: Container())
      ],
    );
  }
}
