abstract class SocialStates {}

class SocialInitailState extends SocialStates {}

class SocialGetUserLoadingState extends SocialStates {}

class SocialGetUserSuccessState extends SocialStates {}

class SocialGetUserErrorState extends SocialStates {
  final dynamic error;

  SocialGetUserErrorState(this.error);
}

class SocialChangeBottomNavState extends SocialStates {}

class SocialNewPostState extends SocialStates {}

//-----------------------------------------------------------------

// Pick profile image

class SocialProfileImagePickedSuccessState extends SocialStates {}

class SocialProfileImagePickedErrorState extends SocialStates {}

//-----------------------------------------------------------------

// Pick cover image

class SocialCoverImagePickedSuccessState extends SocialStates {}

class SocialCoverImagePickedErrorState extends SocialStates {}

//-----------------------------------------------------------------

// Upload profile image

class SocialUploadProfileImageSuccessState extends SocialStates {}

class SocialUploadProfileImageErrorState extends SocialStates {}

//-----------------------------------------------------------------

// Upload cover image

class SocialUploadCoverImageSuccessState extends SocialStates {}

class SocialUploadCoverImageErrorState extends SocialStates {}

//--------------------------------------------------------------------

// User update

class SocialUserUpdateLoadingState extends SocialStates {}

class SocialUserUpdateErrorState extends SocialStates {}

//-----------------------------------------------------------------------

// Create new post

class SocialCreateNewPostLoadingState extends SocialStates {}

class SocialCreateNewPostSuccessState extends SocialStates {}

class SocialCreateNewPostErrorState extends SocialStates {}

class SocialNewPostImagePickedSuccessState extends SocialStates {}

class SocialNewPostImagePickedErrorState extends SocialStates {}

class SocialRemoveNewPostImageState extends SocialStates {}

//------------------------------------------------------------------------

// Get Posts

class SocialGetPostsLoadingState extends SocialStates {}

class SocialGetPostsSuccessState extends SocialStates {}

class SocialGetPostsErrorState extends SocialStates {
  final dynamic error;

  SocialGetPostsErrorState(this.error);
}

//-------------------------------------------------------------------------

// Like Posts

class SocialLikePostSuccessState extends SocialStates {}

class SocialLikePostErrorState extends SocialStates {
  final dynamic error;

  SocialLikePostErrorState(this.error);
}

//-------------------------------------------------------------------------