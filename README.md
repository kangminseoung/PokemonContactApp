# PokemonContactApp

## 🌟 개요
포켓몬 연락처 앱은 무작위로 생성된 포켓몬 이름과 프로필 이미지로 연락처를 만들 수 있는 재미있는 iOS 애플리케이션입니다. 앱은 PokeAPI를 활용하여 무작위 포켓몬을 가져오고 CoreData를 사용하여 데이터를 영구 저장합니다.

## ✨ 주요 기능

📱 무작위 포켓몬 이름으로 연락처 추가
🖼️ PokeAPI에서 자동 프로필 이미지 생성
📋 연락처 목록 보기
🗑️ 스와이프 제스처로 연락처 삭제
💾 CoreData를 사용한 영구 데이터 저장

## 🛠 사용 기술

Swift
UIKit
SnapKit (Auto Layout)
CoreData
PokeAPI

## 📦 의존성

SnapKit: Auto Layout 제약 조건 단순화
CoreData: 로컬 데이터 영구 저장
PokeAPI: 무작위 포켓몬 데이터 제공

## 🗂️ 프로젝트 구조

MainViewController: 연락처 목록 표시
PhoneBookViewController: 새 연락처 추가 화면
InventoryTableView: 연락처 테이블 뷰 관리
CoreDataManager: CoreData 작업 처리
PokemonAPIManager: PokeAPI 호출 관리

## 🔧 작동 방식

"추가" 버튼을 눌러 연락처 생성 화면 열기
"랜덤 이미지 생성" 클릭으로 무작위 포켓몬 가져오기
앱이 자동으로 이름과 전화번호 채우기
연락처 저장 후 메인 목록에서 확인
스와이프로 연락처 삭제

## 📝 주요 구성 요소

무작위 포켓몬 생성: PokeAPI를 사용해 무작위 포켓몬 가져오기
CoreData 통합: 연락처 정보 저장 및 관리
동적 UI: SnapKit 제약 조건을 이용한 반응형 디자인

## 🤝 기여 방법
변경 사항 커밋

## 📧 연락처
[이름]
[이메일 또는 GitHub 프로필]
