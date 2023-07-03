import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lemmy_api_client/v3.dart';
import 'package:thunder/post/utils/comment_actions.dart';
import 'package:thunder/post/widgets/comment_header.dart';

import 'package:thunder/post/widgets/create_comment_modal.dart';
import 'package:thunder/shared/common_markdown_body.dart';
import 'package:thunder/core/auth/bloc/auth_bloc.dart';
import 'package:thunder/core/models/comment_view_tree.dart';
import 'package:thunder/post/bloc/post_bloc.dart';
import 'package:thunder/thunder/bloc/thunder_bloc.dart';

enum SwipeAction { upvote, downvote, reply, save, edit }

class CommentCard extends StatefulWidget {
  final Function(int, VoteType) onVoteAction;
  final Function(int, bool) onSaveAction;

  const CommentCard({
    super.key,
    required this.commentViewTree,
    this.level = 0,
    this.collapsed = false,
    required this.onVoteAction,
    required this.onSaveAction,
  });

  /// CommentViewTree containing relevant information
  final CommentViewTree commentViewTree;

  /// The level of the comment within the comment tree - a higher level indicates a greater indentation
  final int level;

  /// Whether the comment is collapsed or expanded
  final bool collapsed;

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> with SingleTickerProviderStateMixin {
  // @todo - make this themeable
  List<Color> colors = [
    Colors.red.shade300,
    Colors.orange.shade300,
    Colors.yellow.shade300,
    Colors.green.shade300,
    Colors.blue.shade300,
    Colors.indigo.shade300,
  ];

  bool isHidden = true;
  GlobalKey childKey = GlobalKey();

  /// The current point at which the user drags the comment
  double dismissThreshold = 0;

  /// The current swipe action that would be performed if the user let go off the screen
  SwipeAction? swipeAction;

  /// Determines the direction that the user is allowed to drag (to enable/disable swipe gestures)
  DismissDirection? dismissDirection;

  /// The first action threshold to trigger the left or right actions (upvote/reply)
  double firstActionThreshold = 0.15;

  /// The second action threshold to trigger the left or right actions (downvote/save)
  double secondActionThreshold = 0.35;

  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 100),
    vsync: this,
  );

  // Animation for comment collapse
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(1.5, 0.0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  ));

  @override
  void initState() {
    isHidden = widget.collapsed;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    VoteType? myVote = widget.commentViewTree.comment?.myVote;
    bool? saved = widget.commentViewTree.comment?.saved;

    final bool isOwnComment = widget.commentViewTree.comment?.creator.name == context.read<AuthBloc>().state.account?.username;

    final bool isUserLoggedIn = context.read<AuthBloc>().state.isLoggedIn;

    bool collapseParentCommentOnGesture = context.read<ThunderBloc>().state.preferences?.getBool('setting_comments_collapse_parent_comment_on_gesture') ?? true;

    return Container(
      decoration: BoxDecoration(
        border: widget.level > 0
            ? Border(
                left: BorderSide(
                  width: 4.0,
                  color: colors[((widget.level - 1) % 6).toInt()],
                ),
              )
            : const Border(),
      ),
      margin: const EdgeInsets.only(left: 1.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Divider(height: 1),
          Listener(
            behavior: HitTestBehavior.opaque,
            onPointerDown: (event) => {},
            onPointerUp: (event) => {
              triggerCommentAction(
                context: context,
                swipeAction: swipeAction,
                onSaveAction: (int commentId, bool saved) => widget.onSaveAction(commentId, saved),
                onVoteAction: (int commentId, VoteType vote) => widget.onVoteAction(commentId, vote),
                voteType: myVote ?? VoteType.none,
                saved: saved,
                commentViewTree: widget.commentViewTree,
              ),
            },
            onPointerCancel: (event) => {},
            child: Dismissible(
              direction: isUserLoggedIn ? DismissDirection.horizontal : DismissDirection.none,
              key: ObjectKey(widget.commentViewTree.comment!.comment.id),
              resizeDuration: Duration.zero,
              dismissThresholds: const {DismissDirection.endToStart: 1, DismissDirection.startToEnd: 1},
              confirmDismiss: (DismissDirection direction) async {
                return false;
              },
              onUpdate: (DismissUpdateDetails details) {
                SwipeAction? updatedSwipeAction;

                if (details.progress > firstActionThreshold && details.progress < secondActionThreshold && details.direction == DismissDirection.startToEnd) {
                  updatedSwipeAction = SwipeAction.upvote;
                  if (updatedSwipeAction != swipeAction) HapticFeedback.mediumImpact();
                } else if (details.progress > secondActionThreshold && details.direction == DismissDirection.startToEnd) {
                  updatedSwipeAction = SwipeAction.downvote;
                  if (updatedSwipeAction != swipeAction) HapticFeedback.mediumImpact();
                } else if (details.progress > firstActionThreshold && details.progress < secondActionThreshold && details.direction == DismissDirection.endToStart) {
                  if (isOwnComment) {
                    updatedSwipeAction = SwipeAction.edit;
                  } else {
                    updatedSwipeAction = SwipeAction.reply;
                  }
                  if (updatedSwipeAction != swipeAction) HapticFeedback.mediumImpact();
                } else if (details.progress > secondActionThreshold && details.direction == DismissDirection.endToStart) {
                  updatedSwipeAction = SwipeAction.save;
                  if (updatedSwipeAction != swipeAction) HapticFeedback.mediumImpact();
                } else {
                  updatedSwipeAction = null;
                }

                setState(() {
                  dismissThreshold = details.progress;
                  dismissDirection = details.direction;
                  swipeAction = updatedSwipeAction;
                });
              },
              background: dismissDirection == DismissDirection.startToEnd
                  ? AnimatedContainer(
                      alignment: Alignment.centerLeft,
                      color: dismissThreshold < secondActionThreshold ? Colors.orange.shade700 : Colors.blue.shade700,
                      duration: const Duration(milliseconds: 200),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * dismissThreshold,
                        child: Icon(dismissThreshold < secondActionThreshold ? Icons.north : Icons.south),
                      ),
                    )
                  : AnimatedContainer(
                      alignment: Alignment.centerRight,
                      color: dismissThreshold < secondActionThreshold ? Colors.green.shade700 : Colors.purple.shade700,
                      duration: const Duration(milliseconds: 200),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * dismissThreshold,
                        child: Icon(dismissThreshold < secondActionThreshold ? (isOwnComment ? Icons.edit : Icons.reply) : Icons.star_rounded),
                      ),
                    ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => setState(() => isHidden = !isHidden),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CommentHeader(commentViewTree: widget.commentViewTree, isOwnComment: isOwnComment),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 130),
                          switchInCurve: Curves.easeInOut,
                          switchOutCurve: Curves.easeInOut,
                          transitionBuilder: (Widget child, Animation<double> animation) {
                            return SizeTransition(
                              sizeFactor: animation,
                              child: SlideTransition(
                                position: _offsetAnimation,
                                child: child,
                              ),
                            );
                          },
                          child: (isHidden && collapseParentCommentOnGesture)
                              ? Container()
                              : Padding(
                                  padding: const EdgeInsets.only(top: 0, right: 8.0, left: 8.0, bottom: 8.0),
                                  child: CommonMarkdownBody(body: widget.commentViewTree.comment!.comment.content),
                                ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 130),
            switchInCurve: Curves.easeInOut,
            switchOutCurve: Curves.easeInOut,
            transitionBuilder: (Widget child, Animation<double> animation) {
              return SizeTransition(
                sizeFactor: animation,
                child: SlideTransition(position: _offsetAnimation, child: child),
              );
            },
            child: isHidden
                ? Container()
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => CommentCard(
                      commentViewTree: widget.commentViewTree.replies[index],
                      level: widget.level + 1,
                      collapsed: widget.level > 2,
                      onVoteAction: widget.onVoteAction,
                      onSaveAction: widget.onSaveAction,
                    ),
                    itemCount: isHidden ? 0 : widget.commentViewTree.replies.length,
                  ),
          ),
        ],
      ),
    );
  }
}
