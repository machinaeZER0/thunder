## Unreleased
### Added
- Added community icons to subscription list and search - contribution from @CTalvio
- Added ability to return to homescreen when swiping from post body - contribution from @bactaholic
- Added scroll to top buttons on various pages - contribution from @bactaholic
- Added double swipe to exit - contribution from @bactaholic
- Added ability to set post as read when opening media - contribution from @ajsosa
- Added initial support for 2 column viewing for tablet modes - contribution from @Fmstrat
- Adjustments to the login screen to include instance images, and tweaks - contribution from @micahmo
- Added ability to copy/share comment on long press - contribution from @vbh
- Changes to support user display names, additional profile information, and UI tweaks - contribution from @CTalvio
- Added ability to set no action for swipe gestures on posts and comments
- Added ability to select/upload image when creating post - contribution from @MrAntonS
- Added instance name into sidebar menu - contribution from @micahmo
- Navigating back from a page will first go to the feed page before exiting - contribution from @micahmo
- Settings have been re-organized to be more consistent, and to show available options between different views - contribution from @CTalvio
- Feed view will no longer show full screen error messages
- Added comment button actions and added an option to toggle comment button actions
- Added maximum depth to comments. You can now tap on Load more replies to get more replies for a comment thread within a post
- Various login flow improvements - contribution from @micahmo
- In app browser is now switched over to use custom tabs - contribution from @micahmo
- Adjusted theming options to show a modal rather than toggles to reduce confusion - contribution from @coslu
- Added ability to share post, external link, or media from post share button - contribution from @micahmo
- Added ability to disable post and comment swipe actions separately
- Added debug page to settings to clear preferences and local database
- Updated image viewer buttons to the bottom for better accessibility - contribution from @CTalvio
- Added confirmation dialog when logging out of account - contribution from @ggichure
- Added options for hourly sorts - contribution from @Fmstrat
- Added improvements to swipe gestures on image viewer - contribution from @CTalvio
- Added tap to scroll to top on feed view - contribution from @micahmo
- Optimized post loading to load posts faster on startup
- Added images to links in compact view - contribution from @CTalvio
- Added search sort options - contribution from @micahmo

### Changed
- Adjusted subscription styling to be more consistent - contribution from @micahmo
- Removed Sentry error logging
- Tapping outside of the text field when creating a comment/reply will dismiss the keyboard
- Adjusted divider and link preview card colours to have better contrast

### Fixed
- Fixed issue with styling differences in compact and normal view for community/instance - contribution from @machinaeZER0
- Fixed issue with webp previews not showing - contribution from @Fmstrat
- Fixed issue with some links not being parsed properly (GitHub release links)
- Fixed issue where copy/pasting was non-functional on the Search input - contribution from @ajsosa
- Fixed issue where subscribing to a community from the search page would not refresh sidebar subscriptions - contribution from @micahmo
- Fixed issue where only some subscriptions would show up on the sidebar
- Fixed issue where refreshing community when tapping on a link would show local posts rather than the community's posts
- Fixed issue where you could not log in through email
- Potentially fixed issue with profile showing to wrong user

## 0.2.1+11 - 2023-07-09
### Added
- Added colour to username in comments to distinguish your own comments
- Added option to allow text preview on text posts in normal view - contribution from @coslu
- Added option to share media link or external URL links in the dialog popup on post long press
- Added back featured post icon on posts within a community
- Added ability to customize swipe gestures on comments and posts
- Added ability to develop with hot reload using docker - contribution from @Fmstrat
- Added initial implementation for font size scaling for titles and content
- Added comment sorting - contribution from @guigs4
- Added option to show title before content - contribution from @Fmstrat
- Added option to show images edge-to-edge - contribution from @Fmstrat
- Addition of manual refresh icons to different screens - contribution from @bactaholic
- Addition of user and community banners - contribution from @CTalvio
- Added ability to share media directly - contribution from @micahmo
- Added initial ability to block community
- Comments now show the number of direct replies - contribution from @micahmo
- Added minor UI changes to the post view - contribution from @CTalvio

### Changed
- Adjusted visual feedback in comment swipe gestures
- Added option in settings to enable/disable swipe on bottom navigation bar to open sidebar on feed page - contribution from @bactaholic
- Added option in settings to enable/disable double-tap on bottom navigation bar to open sidebar on feed page - contribution from @bactaholic
- Decreased scroll distance needed in order to fetch more comments from a thread
- Improved error messages when more comments fail to fetch within a post
- Decreased number of comments to fetch at a time to improve loading performance
- Posts now load first before comment threads to make viewing posts more responsive
- Slight changes to contrast of text in posts - contribution from @Fmstrat
- Added tooltip labels on sort types - contribution from @micahmo
- UI improvements to vote indication in feed view - contribution from @CTalvio
- Community pages now use their display name - contribution from @CTalvio

### Fixed
- Potentially fixed issues with HTTPS certificate errors when running on Android using Adguard with HTTPS filtering enabled
- Improved performance for comment threads with a lot of comments
- Fixed issue where the last comment on a thread could potentially not show up
- Fixed issue where markdown links were not respecting "open in external browser" option - contribution from @Fmstrat
- Fixed issue with download media not working on Android for some users - contribution from @minicit
- Fixed issue where media download button appearance in light mode - contribution from @coslu
- Fixed issue where commenting would bring you out of the post
- Fixed issue where you could not edit your comment in some instances when using your display name
- Fixed issue with duplicate posts being shown on the feed - contribution from @ajsosa
- Increased NSFW blur - contribution from @guigs4
- Fixed issue where longer comment threads would not show up properly
- Fixed a bug where the URI was not parsed to lowercase before checking extensions to parse image dimensions - contribution from @Fmstrat
- Fixed issue where not all comments would show up on the profile page - contribution from @ajsosa

## 0.2.1+10 - 2023-07-02
### Added
- Added ability to download images - contribution from @MrAntonS
- Added settings option to collapse parent comment on tap
- Added pull to refresh on posts
- Long pressing the post will bring up a modal to perform more actions such as visit community, user profile, sharing
- An additional button now shows up for each post in comfortable view to open the more actions modal
- Added initial support for viewing user profiles - including their posts and comments
- Added top sort options - contribution from @JulianPaulus
- Upvoting and downvoting posts/comments now provides you with immediate feedback rather than waiting for the instance to respond back
- Added initial ability to edit comments. This action replaces the reply action when swiping on your own comment
- Added support for TOTP - contribution from @MrAntonS

### Changed
- Adjusted thickness of divider between posts to help differentiate
- Increased threshold for triggering a upvote/downvote on comments

### Fixed
- Fixed issue where you could not exit app when swiping back or using the back button
- Potentially fixed some issues with performance, yet to be tested widely
- Fixed issue where an error would be thrown if trying to access http pages - contribution from @vbh
- Fixed issue with haptic feedback on comment actions
- Fixed issue where reply button would cover actions and comments for short posts
- Removed mark as read for mentions and replies that have already been read
- Fixed issue where setting a default sort type would cause the app to infinitely load
- Fixed issue where an error would pop up when subscribing to a community from the search page
- Dockerfile for building Android builds - contribution from @Fmstrat
- Fixing settings not reachable - contribution from @ggichure

## 0.2.1+8 - 2023-06-28
### Added
- Added adaptive icons for Android - contribution from @coslu
- Inbox mentions and replies can now be marked as read
- Added default feed type in settings - contribution from @JulianPaulus
- Added default sort type in settings - contribution from @JulianPaulus
- Added ability to switch thumbnail previews in compact mode to the right
- Added Material You dynamic colour theming
- Added system theme option
- Added option to open up links in external browser by default
- Removed custom-made lemmy library, and replaced lemmy library with https://github.com/liftoff-app/lemmy\_api\_client!
  - This change will make it easier to work with future features, and also allows a chance for collaboration on a unified dart-based lemmy api
- Added ability to tap on images within comments/posts to zoom in
- Added swipe gesture on botton nav bar to open up drawer in Feed
- Added settings option to disable swipe gestures on posts

### Changed
- Moved theming options into a separate section in settings
- Adjusted inbox show all toggle to be a button to be more descriptive
- Adjusted logic for fetching and caching images to bring better performance
- Changed slide to dismiss images to use a new library
- Tapping on a comment will only collapse the replies to that comment - contribution from @vbh

### Fixed
- Fixed issue with sort type not being respected on refresh - contribution from @JulianPaulus
- Fixed issue where comment upvote/downvote did not display properly
- Fixed issue where navigation bar was black on Android devices
- Fixed issue where Thunder would redirect you to the feed page after changing settings

## 0.2.1+7 - 2023-06-25
### Fixed
- Fixed issue where creating a comment on a post would not work
- Added back icon to image preview for edge cases where the swipe down gesture does not work
- Fixed issue where inbox shows all replies and comments first, rather than just unread messages

## 0.2.1+6 - 2023-06-25
### Added
- External links can now be opened in an external browser, and also shared using the system's sharing options
- Improved GIF support - contribution from @MrAntonS
- Improved accessibility labels for icons and actions
- New compact view for posts in the feed
- New OLED black theme
- Added initial inbox feature to see your replies, mentions, and private messages
- Added about page with links to lemmy and github repository
- Added sharing option to posts
- Added reply action to posts
- Posts on the feed can now be voted on and saved through swipe gestures
- Swiping down or up on a full screen photo will now dismiss it

### Changed
- Adjusted size of create comment bottom modal, and enabled text selection within the modal for the parent's comment
- Slight improvements to account/profile selection to show which profile is currently active
- When scrolling to the bottom of comments, the FAB for replying will automatically disappear so that the comment is not obstructed
- Search now sorts by Active rather than the default provided by lemmy - contribution from @Benjamint22
- Subscriptions list on the sidebar will now load up to 50 rather than 10

### Fixed
- Potentially fixed issue where scrolling behaviour is weird when creating a new post or comment
- Fixed issue where usernames/passwords containing leading or trailing spaces may fail to login - contribution from @MrAntonS
- Fixed issue where passwords with a length > 60 would throw an error "incorrect password"

## 0.2.1+5 - 2023-06-22
### Added
- Added basic ability to post to a community with Markdown
- Added basic ability to create a comment in a post and to reply to other comments
- Added settings option to enable or disable the in-app update notifications
- Added the instance name to various parts of the app to distinguish communities across instances
- Added blur to NSFW images - contribution from @guigs4
- Added fastlane config for Android - contribution from @IzzySoft
- Initial support for opening links for lemmy communities within the app rather than through the browser
- Added community information when opening up a community
- Added ability to opt-in/opt-out of Sentry error reporting

### Changed
- Searching now fetches more results as you scroll down

### Fixed
- Fixed issue where selecting the light theme would revert back to dark theme on app relaunch
- Fixed issue where link previews were not being shown properly

## 0.2.0-alpha - 2023-06-20
### Added
- New update in-app notification to notify you of new GitHub releases
- Autofill options for logging into your account (tested on iOS, untested on Android physical device)
- Added an option to switch to a light theme
- Tapping on the community's name within a post will allow you to view the community
- When viewing a community, you can now subscribe/unsubscribe to that community directly
- You can now login with different accounts, and switch between those accounts
- Comments can now be upvoted, downvoted, and saved through swipe gesture
- Tapping on an image will show you a fullscreen view
- Added haptic feedback for some actions
- Vote and comment actions are hidden/disabled when not logged in

### Fixed
- Fixed issue where refreshing or selecting a sort option would cause the feed to show the Local feed

## 0.1.1-alpha - 2023-06-16
### Added
- Switching between tabs keeps the state of the tab
- Added Sentry to allow for debugging and logging

### Changed
- Initial feed now shows a compact version of an image, rather than the full height image

### Fixed
- Fixed issue where if you log in with an instance that does not exist, the community page will indefinitely load
- Fixed issue where a community would show a loading indicator if there were too little posts within that community

## 0.1.0-alpha - 2023-06-15
### Added
- Sorting post feed by hot, active, etc.
- Tap on community name in post to view community
- Upvote, downvote, and save posts
- Seach for communities on the same instance
- Follow and unfollow communities
- Sign in to single account

### Missing Core Features
- No ability to create a post or comment
- No user notifications
- No ability to browse saved comments and posts
- No theming options
- No multi-user ability
- Missing ability to change instances when not logged in
