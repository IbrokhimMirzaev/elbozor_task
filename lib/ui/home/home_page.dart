import 'package:elbozor_task/cubits/data_cubit.dart';
import 'package:elbozor_task/cubits/state.dart';
import 'package:elbozor_task/ui/detail/detail_page.dart';
import 'package:elbozor_task/ui/widgets/item_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = ScrollController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<DataCubit>(context).fetchData();
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        BlocProvider.of<DataCubit>(context).fetchData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home Page")),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Colors.blue, width: 1.5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.grey.shade300, width: 1.5),
                ),
                hintText: "Поиск товара и услуги",
                hintStyle: const TextStyle(color: Colors.blueGrey),
                prefixIcon: const Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 25),
            Expanded(
              child: BlocBuilder<DataCubit, DataState>(
                builder: (context, state) {
                  var st = state.state;
                  if (st == Status.LOADING) {
                    return ListView(
                      physics: const BouncingScrollPhysics(),
                      children: List.generate(10, (index) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 10,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 40),
                                    Container(
                                      margin: const EdgeInsets.only(right: 20),
                                      height: 10,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    );
                  } else if (st == Status.ERROR) {
                    return Center(child: Text(state.errorText.toString()));
                  } else if (st == Status.SUCCESS) {
                    return RefreshIndicator(
                      onRefresh: () async {
                        context.read<DataCubit>().refreshData();
                      },
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          controller: controller,
                          itemCount: state.listData.length + 1,
                          itemBuilder: (context, index) {
                            if (index < state.listData.length) {
                              final item = state.listData[index];
                              return ItemView(
                                  item: item,
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                DetailPage(item: item)));
                                  });
                            } else {
                              if (state.hasMoreData) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else {
                                return const Center(
                                    child: Text("No more data to load"));
                              }
                            }
                          }),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
