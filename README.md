# 🐴 달릴까말까

가벼운 내기, 예측 불가 레이스! '달릴까말까' 지금 시작해보세요!  

<br>  

### ✏️ 간단한 프로젝트 소개

> ‘달릴까말까’는 말 캐릭터들이 출발선에서 결승선까지 달리며 순위를 정하는 복불복 게임이에요.  
> 말들이 느려졌다 빨라졌다, 갑자기 뒤로 가기도 하며 예측할 수 없는 레이스를 펼쳐요.  
> 중간중간 속도 변화와 반전이 있어 끝까지 긴장감을 놓을 수 없죠.  
> 또한, 세로와 가로 모드를 모두 지원해 어느 방향으로도 편리하게 즐길 수 있어요.  
> 커피 내기, 점심 메뉴 정하기처럼 가벼운 결정이 필요할 땐 ‘달릴까말까’로 재미있고 빠르게 정해보세요!

<br>

### 🐎 말 특수 효과

특수 효과는 기본 주행 중 100ms마다 확률적으로 발동하며, 동시에 하나만 적용됩니다.

| 효과 | 발동 확률 | 지속 시간 및 동작 |
| --- | ---: | --- |
| 부스터 | 0.1% | 현재 속도의 4~7배로 한 번 전진하며 부스터 불꽃이 표시됩니다. |
| 역주행 | 0.1% | 현재 속도의 4~7배로 한 번 후진하고, 역주행 UI는 약 0.5초 유지됩니다. |
| 감속 | 0.2% | 1.5초 동안 속도가 30~55%로 감소합니다. 망치가 한 번 내려친 뒤 별이 종료까지 회전합니다. |
| 정지 | 0.15% | 1초 동안 멈추며 빙결 효과가 표시됩니다. |

<br>

### 🔗 스토어 링크  

- [App Store](https://apps.apple.com/kr/app/%EB%8B%AC%EB%A6%B4%EA%B9%8C%EB%A7%90%EA%B9%8C/id6747607216)  
- [Play Store](https://play.google.com/store/apps/details?id=com.appisode.run_or_not)  

<br> 

### 🛠️ 앱 개발에 사용한 기술 및 환경

```
- 프레임워크 & 언어
    - Flutter
    - Dart  
- 개발 환경
    - Xcode
    - Android Studio
- 개발 도구 & 협업 툴  
    - Git
    - Github
    - Figma
    - Notion
- 사용 기술
    - MVI Pattern
    - Clean Architecture
    - DI
- 외부 패키지
    - provider(v6.1.5)
    - go_router(v15.1.2)
    - get_it(v8.0.3)
    - rive(v0.14.11)
```

<br>

### 🧑🏻‍💻 팀원

- [Jumy's Github](https://github.com/kdjun97)
- [Ujun's Github](https://github.com/MentalJava)

<br>

### 🚀 Android CI/CD

Android 배포 태그 형식: `android/<version>+<build-number>-<YYMMDDHHMM>`

```bash
git tag -a "android/1.0.2+10-2608192212" -m "Android 1.0.2+10"
git push origin "android/1.0.2+10-2608192212"
```

<br>

### 🚀 iOS CI/CD

iOS 배포 태그 형식: `ios/<version>+<build-number>-<YYMMDDHHMM>`

```bash
git tag -a "ios/1.0.2+10-2608192212" -m "iOS 1.0.2+10"
git push origin "ios/1.0.2+10-2608192212"
```

<br>

### 🌴 Git Flow

```mermaid
%%{init: { 'logLevel': 'debug', 'theme': 'base', 'gitGraph': {'mainBranchName': 'master'}} }%%
gitGraph
  commit id: "master init"
  branch development
  checkout development
  commit id: "start development"
  branch "rc-1.0.0"
  checkout "rc-1.0.0"
  commit id: "release 1.0.0 prep"
  checkout development
  branch "rc-2.0.0"
  checkout "rc-2.0.0"
  commit id: "release 2.0.0 prep"
  branch feat1
  checkout feat1
  commit id: "feat1 작업"
  checkout "rc-2.0.0"
  merge feat1
  branch feat2
  checkout feat2
  commit id: "feat2 작업"
  checkout "rc-2.0.0"
  merge feat2
  checkout development
  merge "rc-1.0.0"
  merge "rc-2.0.0"
  checkout master
  merge development
  
  checkout master
  branch "hotfix-2.0.1"
  checkout "hotfix-2.0.1"
  commit id: "중요 버그 수정"
  checkout master
  merge "hotfix-2.0.1" tag: "v2.0.1"
  checkout development
  merge "hotfix-2.0.1"
```
