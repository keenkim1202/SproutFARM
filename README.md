# SproutFARM
로그인 후 게시글을 작성/수정/삭제하고, 게시글에 대한 댓글을 작성/수정/삭제할 수 있는 앱입니다.

## 디자인 패턴
- MVC

# 평가 과제 구현 항목
## Login
- [x] 회원가입 UI 구현
- [x] 로그인 UI 구현
- [x] 회원가입 화면에서 모든 정보를 입력 후 '시작하기'를 누르면 서버로 사용자가 입력한 정보를 post 합니다.
- [x] 회원가입 성공 시 회원가입이 성공했다는 얼럿을 띄웁니다.
- [x] 회원가입 시 '비밀번호'와 '비밀번호 확인'이 일치하는 경우에만 '가입하기'버튼이 활성화 됩니다.
- [x] 로그인 시 아이디와 비밀번호를 모두 입력 시 '시작하기' 버튼히 활성화 됩니다.
- [x] 비밀번호 입력 시 * 표 처리를 합니다.

## Post
- [x] 로그인 성공 시 최신 순으로 게시글 목록을 불러옵니다.
- [x] 오른쪽 하단의 + 기호의 floating button을 통해 새로운 게시글를 작성합니다.
- [x] 게시글 클릭 시 게시글의 전문과 댓글을 확인할 수 있는 상세 페이지를 띄웁니다.
- [x] 상세 페이지의 오른쪽 상단 ... 버튼을 통해 게시글를 수정/삭제할 수 있습니다.
- [x] 게시글은 본인이 작성한 게시글만 수정이 가능합니다. 
- [x] 본인이 작성하지 않은 게시글을 수정/삭제하려고 하는 경우 '본인의 게시글만 수정/삭제가 가능합니다.' 라는 얼럿을 띄웁니다.
- [x] 본인이 작성한 게시글을 지우고자 할 때, 삭제 전 사용자에게 한번 더 확인합니다.
- [x] 삭제가 완료되면 게시글 조회 화면으로 돌아옵니다. 

## Comment
- [x] 게시글 상세 화면으로 진입했을 경우, 해당 게시글에 달린 댓글 조회를 진행합니다.
- [x] 댓글의 오른쪽 ... 버튼을 통해 수정/삭제가 가능합니다.
- [x] 본인이 작성하지 않은 댓글을 수정/삭제하려는 경우 '본인의 댓글만 수정/삭제가 가능합니다.'라는 얼럿을 띄웁니다.
- [x] 본인이 작성한 댓글을 지우고자 할 때, 수정/삭제 옵션이 담긴 action sheet을 띄웁니다.

## 추가 구현 사항
- [x] 다크 모드 대응을 하였습니다.
- [x] 사용자가 닉네임을 공백으로 처리한 경우 '이름 없음'으로 처리하였습니다.
- [x] pagenation을 구현하였습니다.

# 실행 영상
https://user-images.githubusercontent.com/59866819/153756443-a0d77c37-2c58-48f3-9abb-3b0562121963.mp4
