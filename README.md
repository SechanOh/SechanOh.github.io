# SechanOh.github.io

Sechan Oh의 GitHub Pages 개인 홈페이지입니다. 정적 파일만으로 동작하며, GitHub Pages는 저장소 루트의 `index.html`을 그대로 배포합니다.

## 전체 구조

```text
.
├── index.html
├── content/
│   └── site-config.js
├── figures/
│   ├── brand-mark.svg
│   └── SechanOh_picture.jpg
├── scripts/
│   └── test-site.ps1
├── docs/
│   └── github-issues-workflow.md
├── .github/
│   └── ISSUE_TEMPLATE/
│       ├── config.yml
│       └── homepage-request.yml
├── brainstorm-preview.html
└── README.md
```

## 배포 진입점

`index.html`이 실제 홈페이지입니다. HTML, CSS, JavaScript가 한 파일 안에 들어 있는 단일 페이지 구조이며, 별도 빌드 과정 없이 GitHub Pages에서 바로 서비스됩니다.

페이지는 다음 영역으로 구성되어 있습니다.

- 고정 상단 메뉴: 홈 브랜드 링크, Work, Notes, Contact, 다크/라이트 토글, EN/KO 언어 토글
- 히어로 영역: 프로필 사진, 직무 정체성, Radar processing / Sensor fusion 소개, 핵심 문구
- Work 영역: 대표 작업 방향을 카드 모듈로 표시
- Notes 영역: 기술 노트로 확장할 글감 표시
- Contact 영역: GitHub와 이메일 연결
- Footer: 유지보수 중임을 보여주는 업데이트 날짜 표시

## 쉽게 바꾸는 파일

`content/site-config.js`는 사진, 마크, 유튜브 영상, 업데이트 날짜처럼 자주 바뀔 수 있는 값을 모아둔 설정 파일입니다.

```js
window.siteContent = {
  brandName: "Sechan Oh",
  brandSubtitle: "signal systems",
  profileImage: "figures/SechanOh_picture.jpg",
  brandMark: "figures/brand-mark.svg",
  youtubeId: "REPLACE_WITH_YOUTUBE_ID",
  workVisual: "",
  lastUpdatedLabel: "May 29, 2026",
  lastUpdatedDate: "2026-05-29"
};
```

- 프로필 사진을 바꾸려면 `figures/SechanOh_picture.jpg`를 교체하거나 `profileImage` 경로를 수정합니다.
- 브라우저 탭 아이콘과 브랜드 마크를 바꾸려면 `figures/brand-mark.svg`를 교체합니다.
- 배경 유튜브 영상을 넣으려면 `youtubeId`에 유튜브 영상 ID만 넣습니다. 페이지는 자동재생과 무음을 기본으로 요청합니다.
- 업데이트 날짜를 바꾸려면 `lastUpdatedLabel`과 `lastUpdatedDate`를 함께 수정합니다.

## 디자인과 동작

색상, 레이아웃, 반응형 동작은 `index.html`의 `<style>` 영역에서 관리합니다. 기본 테마는 시스템 설정을 따르고, 사용자가 토글을 누르면 `localStorage`에 다크/라이트 선택이 저장됩니다.

언어 전환은 `index.html` 하단 스크립트의 `translations.en`과 `translations.ko` 객체로 동작합니다. 화면의 텍스트는 `data-i18n` 속성을 통해 해당 번역 키와 연결됩니다.

주요 반응형 기준은 모바일 폭에서 다음을 유지하는 것입니다.

- 상단 메뉴는 한 줄 메뉴처럼 사용 가능해야 합니다.
- 프로필 사진과 이름 영역은 모바일에서도 좌우 배치가 유지됩니다.
- Work, Notes, Contact는 같은 모듈 디자인 언어를 공유합니다.
- 앵커 이동 시 고정 메뉴에 제목이 가려지지 않도록 `scroll-padding-top`과 `scroll-margin-top`을 사용합니다.

## 이미지와 미디어

`figures/`는 홈페이지에서 직접 참조하는 시각 자료 폴더입니다.

- `figures/SechanOh_picture.jpg`: 원형 프로필 사진으로 사용됩니다.
- `figures/brand-mark.svg`: favicon과 브랜드 마크 자산입니다. 원본 비율을 유지하기 위해 SVG에는 `preserveAspectRatio="xMidYMid meet"`가 있어야 합니다.

미디어를 나중에 쉽게 교체할 수 있도록 실제 경로와 유튜브 ID는 `content/site-config.js`에서 관리합니다.

## 검증

수정 후에는 아래 명령으로 기본 구조와 디자인 요구사항을 확인합니다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts\test-site.ps1
```

`scripts/test-site.ps1`는 다음을 검사합니다.

- GitHub Pages 루트에 필요한 `index.html` 존재 여부
- 프로필 사진, 브랜드 SVG, 설정 파일 참조 여부
- 테마 토글, 언어 토글, 반응형 프로필 레이아웃
- 시스템 라이트/다크 모드 배경 처리
- Work, Notes, Contact 섹션과 주요 문구
- GitHub Issues 요청 템플릿과 문서 존재 여부

## GitHub Issues 요청 흐름

`.github/ISSUE_TEMPLATE/homepage-request.yml`은 홈페이지 수정 요청을 이슈로 남기기 위한 템플릿입니다. 모바일에서 수정 요청을 남기거나 변경사항을 추적해야 할 때 사용합니다.

자세한 흐름은 `docs/github-issues-workflow.md`에 있습니다.

## 참고 파일

`brainstorm-preview.html`은 초기 디자인 방향을 비교하기 위한 미리보기 파일입니다. 실제 GitHub Pages 배포의 중심 파일은 `index.html`입니다.
