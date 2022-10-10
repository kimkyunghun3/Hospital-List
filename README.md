## 🏥 Hospital-List

- 프로젝트 기간 2022.09.30 ~ 2022.10.05
    
    

## 프로젝트 소개

네이버 지도 맵 API, 병원 리스트 API를 이용하여 맵에 병원 리스트 보여주는 어플

## 실행화면
저장 화면|목록 화면
---|---
![](https://user-images.githubusercontent.com/52434820/194063456-aad10848-f872-49b5-8ef4-60ccee94f1fa.gif)|![](https://user-images.githubusercontent.com/52434820/194063468-30808cf5-4d7b-44bf-b22e-c564036b98fa.gif)

## 개발환경 및 라이브러리
- [![swift](https://img.shields.io/badge/swift-5.6-orange)]()
- [![xcode](https://img.shields.io/badge/Xcode-13.4.1-blue)]()
- [![xcode](https://img.shields.io/badge/RxSwift-6.5-hotpink)]()
- [![xcode](https://img.shields.io/badge/Alamofire-5.6.1-black)]()
- [![xcode](https://img.shields.io/badge/SnapKit-5.6.0-skyblue)]()

## Trouble Shooting

1. API Key 은닉화
- API Key를 사용하게되면 git에서 추적하여 외부에 유출될 수 있으며 이것이 큰 문제가 될 수도 있다.
- 그리하여 plist를 활용하고 Bundle에 Extension를 해서 API Key를 사용자가 입력하여 사용하도록 구현

2. API에 %가 있는 경우 변환되는 이슈
- API Key에 %2D와 같이 %가 들어간 경우 특수문자 인코딩으로 받아서 실제 API를 Request할 때 자동으로 변환되어서 제대로 요청이 되지 않는 에러가 발생
- 이를 해결하기 위해 변환된 문자를 넣어서 사용하여 해결

[변환표](https://leelsm.tistory.com/52)

3. CoreData 사용 및 Storage 추상화
- 현재 앱에서는 CoreData만 사용하기 때문에 하나의 create, fetch만 필요하다.
- 하지만 추후 여러 LocalDB가 생길 수 있는 확장성을 고려하여 Storage로 추상화하여 사용하는 곳에서 갈아끼우는 방식으로 구현

4. Relay의 사용 시 에러 처리
- Relay 사용 시 onNext만 존재하기 때문에 에러처리를 손쉽게 할 수 없다.
- 그러므로 ErrorRelay를 구현하여 에러부분을 처리할 수 있도록 구현하여 에러처리를 해주었다.

5. Radius 계산
- Radius가 사용자가 카메라 이동과 줌여부에 따라 변하게 되므로 계산된 값이 필요하다고 판단했다.
- 카메라 Point와 픽셀을 활용해서 실제 Radius를 계산하여 이를 대입하여 사용하도록 구현
