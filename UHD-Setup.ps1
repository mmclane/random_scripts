Param($user, $target)

$dfspath = "\\umroot\mws\support\testing\UHD\$user"

DFSUtil Link Add $dfspath $target

$user = "umroot\$user"

dfsutil.exe property sd grant $dfspath $user`:F protect replace
