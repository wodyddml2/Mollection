# Mollection

<img width="856" alt="스크린샷 2023-03-02 오후 9 28 16" src="https://user-images.githubusercontent.com/83345066/222429110-eab870dd-fb3d-4a83-bf3d-4057bdb3dc00.png">
<img width="362" alt="스크린샷 2023-03-02 오후 9 29 00" src="https://user-images.githubusercontent.com/83345066/222429167-dc7ba5b7-1a73-4a3c-953e-288da1be88df.png">

## 💁🏻‍♂️ Introduction

- 개인 프로젝트(기획, 개발)
- 출시 기간 약 3주(2023.02.09 ~ 2023.02.26)
- 보고 싶었던 드라마나 감명 깊었던 영화 등을 폴더 별로 수집하는 앱
- Apple의 로그인과 닉네임을 등록하여 간편한 회원 가입이 가능합니다.
- 검색을 통하여 영화 또는 드라마의 정보를 제공합니다.
- 영화와 드라마를 폴더에 저장할 수 있습니다.
- 원하는 폴더명을 정하여 생성할 수 있습니다.
<br></br>
## ⚙️ Stack

> 기술 및 라이브러리
> 
- Swift, SwiftUI, Combine, MVVM, Alamofire, Kingfisher
- Firestore, Firebase Authentication
- Figma, Git

<br></br>
> 프로젝트 기술 적용
> 
- **Database**
    - **Firestore** 데이터 Collection과 Document로 구조 구성
- **Network**
    - **Alamofire**의 **URLRequestConvertible** 프로토콜을 이용해 라우터 모듈화
    - **Combine**의 **Future** 구독을 통한 비동기 처리, **Promise** 값을 통한 핸들러
- **Design Pattern**
    - **MVVM** 패턴을 이용해 비즈니스 로직 분리
    - **Singleton** 패턴으로 하나의 객체만 생성해 메모리 낭비 방지
- **Login View**
    - **AuthenticationServices** framework를 사용해 애플 로그인
    - **Firebase Authentication**에 Apple의 ID Token 응답을 사용해 인증
- **Main View**
    - **ScrollView**와 **LazyVGrid**를 사용해 UICollectionView 대체
    - **toolbarTitleMenu**와 **@StateObject**, **@Published**를 사용해 폴더 선택 시 화면 재구성
- **Search View**
    - **RESTful API** 통신을 통해 받은 응답 값을 **List**에 적용
- **Detail View**
    - 필요한 서버 호출 만으로 불필요한 서버 통신을 최소화
    - navigationButton 클릭 시 **Menu**와 **Picker**를 사용해 원하는 폴더를 선택하도록 구현
    - 폴더 선택 시 **Alert**을 띄우고 **Firestore** **DB**에 저장
- **Setting View**
    - **Section** 별로 나눠 **List** 구성
- **Folder View**
    - **Firestore**를 이용해 Folder 생성, 삭제 구현
    - 기본 폴더는 삭제할 수 없도록 List 생성 시 제외

<br></br>
## 📝 디자인 기획

[Figma 디자인](https://www.figma.com/file/o93Smct6DPKzMe59c1JWsr/Mollection_Project?t=IqbrysdbTi1x4Kd4-6)

<br></br>
## ⚒ Trouble Shooting

1. Realm의 테이블 구조와 다른 Firestore의 트리 구조에 익숙하지 않아 사용자 UID로 유일성을 만들어주는 것에 어려움을 겪었습니다. Firestore에 저장 시 사용자 UID를 DocumentID로 지정하여 문제를 해결하였습니다.
2. 앱의 진입점인 App 프로토콜을 채택하는 부분에서 environmentObject로 View 간에 공유되는 클래스 인스턴스를 @StateObject로 사용해 랜더링 비용이 증가되었습니다. 
특성상 클래스 안의 값이 바뀌면 화면이 자꾸 재구성되어 랜더링 비용이 많이 들기 때문에 제거하였습니다.
3. MVVM 패턴의 ViewModel 역할에 맞지 않게 View에서 Model(Firestore) 로직을 다루고 있었습니다.
따라서 @EnvironmentObject를 사용하는 Model이 init 구문에서 초기화되지 않아 ViewModel에 주입하기 위해 부모 뷰에서 할당해주는 형식으로 구현하였습니다.
    
    **부모 뷰**
    
    ```swift
    SignupView(isLogged: $isLogged, fbStore: fbStore)
    ```
    
    **자식 뷰**
    
    ```swift
    init(isLogged: Binding<Bool>, fbStore: FBStore) {
            self._viewModel = StateObject(wrappedValue: SignupViewModel(fbStore: fbStore))
            self._isLogged = isLogged
    }
    ```
    
4. View를 구성하면서 가독성을 높이기 위해 @ViewBuilder 속성을 사용하여 기능 별로 View를 추출하였습니다.
    
    ```swift
    var body: some View {
        NavigationStack {
           VStack {
              logoImage
                    
              signInButton
           }
        }
     }
    
    @ViewBuilder
    var logoImage: some View {
               ...
    }
    
    @ViewBuilder
    var signInButton: some View {
               ...
    }
    
    ```
    
<br></br>
## 🔥 프로젝트 회고

### **Keep**

1. Custom View와 **@ViewBuilder**를 사용해 View를 추출하여, 코드의 가독성과 재사용성을 높일 수 있었습니다. 
2. **Firestore**와 **Firebase** **Authentication**를 통해 DB에 사용자 UID와 연동시켜 사용자 정보를 안전하게 저장하는 계정 생성 과정을 진행할 수 있었습니다.

### Problem • Try

1. SwiftUI에서 값이 변할 때 View가 업데이트 되는 Property Wrapper를 사용 시 발생하는 문제에 대해 고민해보았습니다. 값이 변할 때마다 렌더링 비용이 발생할 것이라 생각하기 때문에 필요한 부분에서 수동으로 처리하는 것이 필요하다고 생각합니다.
2. Combine을 네트워크 요청 비동기 로직에서 적용해보았습니다. 다른 필요한 부분에서 Combine을 다양하게 활용 하지 못하는 느낌이 들어 개선이 필요하다고 생각합니다.
3. @EnvironmentObject를 사용한 Model을 ViewModel에 주입하였습니다. Model을 직접 주입하면 ViewModel이 너무 많은 책임을 가지게 되어서 유연성과 재사용성이 떨어지게 된다고 생각이 듭니다. 따라서 @EnvironmentObject을 제거하고 ViewModel에 주입하지 않는 방향으로 수정할 필요를 느낍니다.

