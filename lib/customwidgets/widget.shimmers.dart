import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class DashboardShimmerLoader extends StatelessWidget {
  const DashboardShimmerLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 12,
                  child: Container(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: CircleAvatar(
                            radius: 75,
                            backgroundColor: Colors.white,
                          ),
                        ),
                        Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            width: 150.0,
                            height: 150.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const Divider(),
            _buildShimmerDetailRow(),
            const Divider(),
            _buildShimmerStatsRow(),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerDetailRow() {
    return Row(
      children: [
        Expanded(
          flex: 9,
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 20.0,
                    color: Colors.white,
                    margin: EdgeInsets.symmetric(vertical: 5.0),
                  ),
                ),
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 20.0,
                    color: Colors.white,
                    margin: EdgeInsets.symmetric(vertical: 5.0),
                  ),
                ),
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 20.0,
                    color: Colors.white,
                    margin: EdgeInsets.symmetric(vertical: 5.0),
                  ),
                ),
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 20.0,
                    color: Colors.white,
                    margin: EdgeInsets.symmetric(vertical: 5.0),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            decoration: const BoxDecoration(
              border: BorderDirectional(
                start: BorderSide(color: Colors.grey, width: 1),
              ),
            ),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                height: 60.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildShimmerStatsRow() {
    return Row(
      children: [
        Expanded(
          flex: 12,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: Column(
                      children: [
                        Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            height: 20.0,
                            color: Colors.white,
                            margin: EdgeInsets.symmetric(vertical: 5.0),
                          ),
                        ),
                        Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            height: 20.0,
                            color: Colors.white,
                            margin: EdgeInsets.symmetric(vertical: 5.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Column(
                      children: [
                        Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            height: 20.0,
                            color: Colors.white,
                            margin: EdgeInsets.symmetric(vertical: 5.0),
                          ),
                        ),
                        Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            height: 20.0,
                            color: Colors.white,
                            margin: EdgeInsets.symmetric(vertical: 5.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ListShimmerLoader extends StatelessWidget {
  const ListShimmerLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: CircleAvatar(
              radius: 30.0,
              backgroundColor: Colors.white,
            ),
          ),
          title: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 20.0,
              color: Colors.white,
              margin: EdgeInsets.symmetric(vertical: 5.0),
            ),
          ),
          subtitle: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 20.0,
              color: Colors.white,
              margin: EdgeInsets.symmetric(vertical: 5.0),
            ),
          ),
        );
      },
    );
  }
}

class SingleBoxShimmer extends StatelessWidget {
  const SingleBoxShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      padding: const EdgeInsets.all(10.0),
      alignment: Alignment.center,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          width: double.infinity,
          height: 250.0,
          color: Colors.white,
        ),
      ),
    );
  }
}

class SingleLineShimmer extends StatelessWidget {
  const SingleLineShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 12,
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 20.0,
              color: Colors.white,
              margin: EdgeInsets.symmetric(vertical: 5.0),
            ),
          ),
        ),
      ],
    );
  }
}
