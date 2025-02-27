import 'package:flutter/material.dart';

import 'package:lemmy_api_client/v3.dart';

import 'package:thunder/core/enums/swipe_action.dart';
import 'package:thunder/core/models/post_view_media.dart';
import 'package:thunder/thunder/bloc/thunder_bloc.dart';

void triggerPostAction({
  required BuildContext context,
  SwipeAction? swipeAction,
  required Function(int, VoteType) onVoteAction,
  required Function(int, bool) onSaveAction,
  required VoteType voteType,
  bool? saved,
  required PostViewMedia postViewMedia,
}) {
  switch (swipeAction) {
    case SwipeAction.upvote:
      onVoteAction(postViewMedia.postView.post.id, voteType == VoteType.up ? VoteType.none : VoteType.up);
      return;
    case SwipeAction.downvote:
      onVoteAction(postViewMedia.postView.post.id, voteType == VoteType.down ? VoteType.none : VoteType.down);
      return;
    case SwipeAction.reply:
    case SwipeAction.edit:
      SnackBar snackBar = const SnackBar(
        content: Text('Replying from this view is currently not supported yet'),
        behavior: SnackBarBehavior.floating,
      );

      if (context.mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }

      break;
    case SwipeAction.save:
      onSaveAction(postViewMedia.postView.post.id, !(saved ?? false));
      break;
    default:
      break;
  }
}

DismissDirection determinePostSwipeDirection(bool isUserLoggedIn, ThunderState state) {
  if (!isUserLoggedIn) return DismissDirection.none;

  // If all of the actions are none, then disable swiping
  if (state.leftPrimaryPostGesture == SwipeAction.none &&
      state.leftSecondaryPostGesture == SwipeAction.none &&
      state.rightPrimaryPostGesture == SwipeAction.none &&
      state.rightSecondaryPostGesture == SwipeAction.none) {
    return DismissDirection.none;
  }

  // If there is at least 1 action on either side, then allow swiping from both sides
  if ((state.leftPrimaryPostGesture != SwipeAction.none || state.leftSecondaryPostGesture != SwipeAction.none) &&
      (state.rightPrimaryPostGesture != SwipeAction.none || state.rightSecondaryPostGesture != SwipeAction.none)) {
    return DismissDirection.horizontal;
  }

  // If there is no action on left side, disable left side swiping
  if (state.leftPrimaryPostGesture == SwipeAction.none && state.leftSecondaryPostGesture == SwipeAction.none) {
    return DismissDirection.endToStart;
  }

  // If there is no action on the right side, disable right side swiping
  if (state.rightPrimaryPostGesture == SwipeAction.none && state.rightSecondaryPostGesture == SwipeAction.none) {
    return DismissDirection.startToEnd;
  }

  return DismissDirection.none;
}
