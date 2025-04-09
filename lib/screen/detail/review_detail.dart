import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/data/model/customer_review.dart';
import 'package:resto_app/provider/detail/resto_review_provider.dart';
import 'package:resto_app/helper/resto_review_result_state.dart';

class ReviewDetail extends StatefulWidget {

  final List<CustomerReview> customerReviews;

  const ReviewDetail({super.key, required this.customerReviews});

  @override
  State<ReviewDetail> createState() => _ReviewDetailFormXState();
}

class _ReviewDetailFormXState extends State<ReviewDetail> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _reviewController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RestoReviewProvider>(context, listen: false);
    final restaurantId = ModalRoute.of(context)!.settings.arguments as String;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _reviewController,
                  decoration: const InputDecoration(
                    labelText: 'Review',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 1,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your review';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          await provider.addReview(
                            restaurantId,
                            _nameController.text,
                            _reviewController.text,
                          );

                          if (provider.resultState is RestoReviewLoadedState) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Review added successfully!')),
                            );
                            _nameController.clear();
                            _reviewController.clear();

                          } else if (provider.resultState is RestoReviewErrorState) {
                            final errorState = provider.resultState as RestoReviewErrorState;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error: ${errorState.message}')),
                            );
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Failed to add review: $e')),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text(
                      'Submit',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(color: Theme.of(context).colorScheme.surface),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Consumer<RestoReviewProvider>(
              builder: (context, provider, child) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: provider.resultState is RestoReviewLoadedState
                        ? (provider.resultState as RestoReviewLoadedState).customerReviews.length
                        : widget.customerReviews.length,
                    itemBuilder: (context, index) {
                      final reviews = provider.resultState is RestoReviewLoadedState
                          ? (provider.resultState as RestoReviewLoadedState).customerReviews
                          : widget.customerReviews;
                      final review = reviews[index];

                      debugPrint("CEK ERROR: ${provider.resultState}");

                      return Card(
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                review.name,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                review.review,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}