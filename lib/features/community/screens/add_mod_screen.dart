import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_clone/core/common/error_text.dart';
import 'package:reddit_clone/core/common/loader.dart';
import 'package:reddit_clone/features/auth/controllers/auth_controller.dart';
import 'package:reddit_clone/features/community/controller/community_controller.dart';

class AddModScreen extends ConsumerStatefulWidget {
  final String name;

  const AddModScreen({super.key, required this.name});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddModScreenState();
}

class _AddModScreenState extends ConsumerState<AddModScreen> {
  int cnt = 0; // counter to delete already present mods
  Set<String> uids = {};
  void addUid(String uid) {
    setState(() {
      uids.add(uid);
    });
  }

  void removeUid(String uid) {
    setState(() {
      uids.remove(uid);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.done),
          )
        ],
      ),
      body: ref.watch(getCommunityByNameProvider(widget.name)).when(
          data: (community) => ListView.builder(
                itemCount: community.members.length,
                itemBuilder: (BuildContext context, int index) {
                  final member = community.members[index];

                  return ref.watch(getuserDataProvider(member)).when(
                        data: (user) {
                          // populate the check list with current mods
                          if (community.mods.contains(member) && cnt == 0) {
                            uids.add(member);
                          }
                          cnt++; // increment the count so next time the already present mods will not be added again into uids
                          // if not using cnt var the set state will run and uids will get populated with already present mods
                          return CheckboxListTile(
                              value: uids.contains(user.uid),
                              onChanged: (val) {
                                if (val!) {
                                  addUid(user.uid);
                                } else {
                                  removeUid(user.uid);
                                }
                              },
                              title: Text(user.name));
                        },
                        error: (error, stackTrace) =>
                            ErrorText(error1: error.toString()),
                        loading: () => const Loader(),
                      );
                },
              ),
          error: (error, stackTrace) => ErrorText(error1: error.toString()),
          loading: () => const Loader()),
    );
  }
}
