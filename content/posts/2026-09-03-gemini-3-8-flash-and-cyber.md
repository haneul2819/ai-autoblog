---
title: "Google, Gemini 3.8 Flash 공개하며 보안 변형은 심사제로 배포"
description: "Google이 9월 2일 Gemini 3.8 Flash를 출시했습니다. 토큰 단가는 그대로지만 과제당 비용은 올랐고, 보안 특화 변형은 심사를 거친 곳에만 열립니다."
date: 2026-09-03
tags: ["Google", "Gemini", "추론비용", "벤치마크", "보안"]
sources:
  - title: "Introducing Gemini 3.8 Flash and 3.8 Flash Cyber"
    url: "https://blog.google/innovation-and-ai/models-and-research/gemini-models/3-8-flash-and-3-8-flash-cyber/"
  - title: "What's new in Gemini 3.8 Flash | Gemini API | Google AI for Developers"
    url: "https://ai.google.dev/gemini-api/docs/latest-model"
  - title: "Google has released Gemini 3.8 Flash, its fourth Flash model in under four months"
    url: "https://artificialanalysis.ai/articles/gemini-3-8-flash"
---

## 왜 지금 이 주제인가

Google이 9월 2일 Gemini 3.8 Flash를 정식 출시했습니다. 같은 날 보안 작업에 특화된 Gemini 3.8 Flash Cyber도 함께 공개했는데, 이쪽은 API로 누구나 쓸 수 있는 모델이 아니라 Fairwind Program이라는 별도 절차를 거친 곳에만 열립니다. 저가형 모델이 상위 모델 점수를 따라붙는 흐름과, 특정 능력을 가진 모델을 선별해서 배포하는 흐름이 한 발표 안에 같이 들어 있습니다.

## 발표 내용

모델 사양부터 보면, 모델 ID는 `gemini-3.8-flash`이고 컨텍스트 창은 100만 토큰, 최대 출력은 6만 4천 토큰입니다. 사고 강도(thinking level)는 low, medium, high 세 단계로 조절할 수 있고 기본값은 medium입니다. 이전에 있던 minimal 단계는 지원하지 않습니다. Google의 관리형 코딩 에이전트 Antigravity의 기본 모델도 이 모델로 바뀌었습니다.

가격은 100만 토큰당 입력 0.75달러, 출력 3.75달러입니다. 다만 이 값은 2026년 12월 31일까지 적용되는 도입 가격이고, 2027년 1월 1일부터는 입력 1.50달러, 출력 7.50달러로 두 배가 됩니다.

Google이 본문에서 수치로 밝힌 것은 두 가지입니다. 다단계 추론을 재는 HLE-Verified에서 54.9%를 기록했고, 보안 변형인 3.8 Flash Cyber는 취약점 패치 벤치마크 CWE-Bench에서 pass@1 47.2%로 선두 프런티어 모델의 47.8%에 근접했다고 설명했습니다. 여기에 실제 취약점 탐색에서 20개 프로그래밍 언어에 걸쳐 70%가 넘는 성공률을 보였고, Chrome 보안팀 평가에서는 상용 대안보다 올바른 패치를 2.6배 더 많이 만들어 냈다고 덧붙였습니다.

배포 경로는 개발자 쪽이 Google AI Studio와 Android Studio, Gemini API이고, 기업은 Gemini Enterprise를 통해 씁니다. 일반 사용자는 Google AI Pro와 Ultra 구독으로 Gemini 앱과 Search의 AI 모드에서 접근할 수 있습니다. 안전 쪽으로는 CBRN(화학·생물·방사능·핵)과 공격적 사이버 활용에 대한 방어 장치를 넣었고, 프롬프트 인젝션 내성이 Gray Swan 평가 기준으로 이전보다 개선됐다고 밝혔습니다. Cyber 변형은 방어 업무에 필요한 범위에서 이 완화 정책을 더 느슨하게 적용합니다.

### 독립 측정치

Artificial Analysis는 high 사고 강도에서 Intelligence Index 59점을 측정했습니다. 직전 3.7 Flash보다 3점 오른 값이고, GPT-5.6 Sol과 Grok 4.6이 같은 59점입니다. 속도는 초당 약 300토큰, 과제 하나를 끝내는 데 2.5분이 걸렸습니다.

여기서 눈에 띄는 대목은 비용입니다. 토큰 단가는 이전 세대와 같은데, Intelligence Index 과제 하나당 비용은 high에서 0.58달러로 약 40% 올랐습니다. medium은 0.41달러, low는 0.24달러입니다. 출력 토큰을 30% 더 쓰고(4만 8천 토큰), 에이전트 평가에서 주고받는 횟수가 늘어난 것이 원인이라는 분석입니다.

## 의미와 한계

두 갈래로 나눠 볼 수 있습니다. 하나는 단가와 실제 지출이 어긋나기 시작했다는 점입니다. 사고 강도를 스스로 조절하는 모델에서는 100만 토큰당 얼마라는 표시가가 지출을 예측해 주지 못합니다. 같은 가격표로도 40% 더 나올 수 있다는 뜻이고, 도입 가격이 끝나는 2027년 1월에는 여기에 단가 두 배가 겹칩니다. 예산을 세울 때는 표시가가 아니라 과제 단위 실측이 필요해 보입니다.

다른 하나는 배포 방식입니다. Cyber 변형은 정부 기관, 핵심 인프라 운영자, 소프트웨어 유지보수자에게 우선 열리고, 일반 모델보다 완화된 안전 필터를 씁니다. 방어에 쓰려면 공격 쪽 지식도 필요하니 필터를 풀되 대상을 심사로 좁히겠다는 선택입니다. 다만 이 심사가 실제로 무엇을 걸러 내는지, 통과 기준이 무엇인지는 공개되지 않았습니다.

검증 측면의 한계도 있습니다. Google이 함께 실은 DeepSWE v1.1, Vals Finance Agent V2, 법률 에이전트 벤치마크 등은 그래프로만 제시돼 정확한 값을 확인하기 어렵습니다. 자체 발표 점수는 비교 대상과 실행 설정이 함께 공개되기 전까지 순위 그대로 받아들이기 어렵습니다.

## 한 줄 정리

토큰 단가는 그대로인데 작업당 비용은 올랐고, 가장 센 보안 모델은 심사를 거쳐야 열립니다.
