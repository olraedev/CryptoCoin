![메인](https://github.com/olraedev/CryptoCoin/assets/109517070/9941ae44-fd54-4847-a4f9-5babb48a3175)

## 🗳️ CryptoCoin
```
Coingecko API를 이용한 코인 정보 앱
```

> 1인 개발
<br> - 기간: 24.02.27 ~ 24.03.04 (약 1주)
<br> - 최소 버전: 15.0 
<br> - 세로 모드
<br> - 라이트 모드 

<br>

## ⚙️ 주요 기능
### 🏡 홈
- 즐겨찾기 목록 / Trending Top15 Coin, Top7 NFT 조회

### 🔍 검색
- Coin 및 NFT 검색 / 상세 조회

### ⭐ 즐겨찾기
- 즐겨찾기한 Coin 및 NFT 조회 / 상세 조회

<br>

## 📚 기술 스택
### 1) User Interface
- UIKit / Code Base / SnapKit / Compositional Layout / Flow Layout / Diffable DataSource / Toast

### 2) Network
- Alamofire / Codable / NWPathMonitor

### 3) Data Base
- Realm

### 4) Design Pattern
- MVVM / Singleton / Custom Observable / Repository

### 5) ETC
- Kingfisher / DGCharts

<br>

## 💬 기술 상세 설명
### 1) User Interface
- `SnapKit`을 활용해 다양한 디바이스에 맞는 Layout 설계
- `Compositional Layout`을 통한 Trending View의 복잡한 Layout 설계

### 2) Network
- 코드의 간소화와 가독성 측면에서 `Alamofire` 사용
- `Codable` 프로토콜을 사용해 JSON 데이터 파싱
- 실시간 네트워크 감지를 위해 `NWPathMonitor` 사용

### 3) Data Base
- 빠른 쿼리 속도와 사용성 측면에서 `Realm` 사용

### 4) Design Pattern
- `MVVM Pattern`으로 View와 비지니스 로직을 분리하여 유지보수성을 높임
- 여러 스레드 간 데이터 공유 목적과 메모리 낭비를 방지하기 위해 `Singleton Pattern` 사용
- `Custom Observable Pattern`를 사용한 비동기 및 이벤트 기반 처리
- `Repository Pattern`을 사용하여 비지니스 로직과 분리

### 5) ETC
- `Kingfisher`를 활용한 비동기 이미지 다운로드 및 캐싱으로 앱 성능 최적화
- 그래프를 표현하기 위해 `DGCharts` 사용

<br>

## ❗ 핵심 기능

### 1) Custom Observable Pattern를 사용한 비동기 및 이벤트 기반 처리
<details>
<summary>Custom Observable</summary>

   <img width="700" alt="image" src="https://github.com/olraedev/CryptoCoin/assets/109517070/86e6b950-f80c-4ddf-8901-a3ef41617585">

</details>

<br>

<details>
<summary>ViewModel</summary>

   <img width="700" alt="image" src="https://github.com/olraedev/CryptoCoin/assets/109517070/77f0d917-e110-4316-9cb9-e54a4da422b6">

</details>

<br>

<details>
<summary>ViewController</summary>

   <img width="700" alt="image" src="https://github.com/olraedev/CryptoCoin/assets/109517070/e5d6208c-6302-4286-9b15-ec3743efc7f9">

</details>

<br>

### 2) 실시간 네트워크 감지를 위해 NWPathMonitor 사용

<details>
<summary>싱글톤 패턴을 활용해 모든 스레드에서 접근 가능하도록 함</summary>

   <img width="700" alt="image" src="https://github.com/olraedev/CryptoCoin/assets/109517070/d82f0061-1dcd-4176-92af-b152e8047caf">

</details>

<br>

## 😵‍💫 트러블 슈팅

### 1) 검색 API Requst Call을 줄이기 위한 데이터 관리

#### A. 적용 이유
1. 검색 버튼을 계속해서 누르면 그만큼의 불필요한 Requst Call을 소모
2. 검색 API의 명세서를 보면 업데이트 간격은 15분이라고 명시
    <details>
    <summary>API 명세서</summary>

    <img src="https://github.com/olraedev/CryptoCoin/assets/109517070/1f02157d-06d2-41f0-8116-7c940a875cea" width="400" height="300"/>

    </details>

#### B. 흐름
1. 검색어가 Realm에 저장되어 있는지 확인
2. (검색어가 없을 경우) API 요청
3. (검색어가 있을 경우) 검색한지 15분이 지났는지 확인

    <details>
    <summary>플로우 차트</summary>
    <img src="https://github.com/olraedev/CryptoCoin/assets/109517070/5aab308d-6281-454b-ac5a-aaf772545600" width="600" height="400"/>
    </details>

    <details>
    <summary>코드</summary>
    <img src="https://github.com/olraedev/CryptoCoin/assets/109517070/47652215-279c-4c3d-ad2a-285507f07a85"width="600" height="400"/>
    </details>

<br>

## 🖥️ 화면별 동작

### 1) 홈
| <img src="https://github.com/olraedev/CryptoCoin/assets/109517070/b65ae0b0-c3d3-4c5d-b448-7e69f5612451" width="200" height="400"/> | <img src="https://github.com/olraedev/CryptoCoin/assets/109517070/cc7afa5f-7d76-4bee-9aac-7529e830eec3" width="200" height="400"/> |
|:----------:|:----------:|
| 기본 | 상세 조회 |

<br>

### 2) 검색
| <img src="https://github.com/olraedev/CryptoCoin/assets/109517070/afcb1f39-2b76-40d1-9164-9b5fea163bb5" width="200" height="400"/> | <img src="https://github.com/olraedev/CryptoCoin/assets/109517070/62a2e062-6bbb-42f6-b7bc-190200ae2b7d" width="200" height="400"/> |
|:----------:|:----------:|
| 기본 | 상세 조회 |

<br>

### 3) 피드
| <img src="https://github.com/olraedev/CryptoCoin/assets/109517070/42e38f82-b2ba-46ca-ad09-810c699c3c49" width="200" height="400"/> | <img src="https://github.com/olraedev/CryptoCoin/assets/109517070/45269edd-64bb-484d-adc3-9e39fb8de098" width="200" height="400"/> |
|:----------:|:----------:|
| 기본 | 새로고침 |