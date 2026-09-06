---
title: "NVIDIA, 모델 허브 Hugging Face를 129억 달러에 인수"
description: "NVIDIA가 9월 3일 Hugging Face 인수를 발표했습니다. 발표문에 담긴 중립성 약속과 오픈 모델 생태계에 남는 구조적 변수를 정리했습니다."
date: 2026-09-06
tags: ["HuggingFace", "오픈소스", "반도체", "인프라", "규제"]
sources:
  - title: "NVIDIA to Acquire Hugging Face"
    url: "https://blogs.nvidia.com/blog/nvidia-to-acquire-hugging-face/"
  - title: "Nvidia confirms it will buy Hugging Face for $12.9 billion"
    url: "https://techcrunch.com/2026/09/03/nvidia-confirms-it-will-buy-hugging-face-for-12-9-billion/"
  - title: "Nvidia acquires Hugging Face after Stripe nabs OpenRouter: here's what open source AI builders should do"
    url: "https://venturebeat.com/infrastructure/nvidia-acquires-hugging-face-after-stripe-nabs-openrouter-heres-what-open-source-ai-builders-should-do"
---

## 왜 지금 이 주제인가

NVIDIA가 2026년 9월 3일 Hugging Face 인수를 공식 발표했습니다. 금액은 129억 3,030만 달러입니다. Hugging Face는 오픈웨이트 모델과 데이터셋이 오가는 사실상의 기본 배포처입니다. 그래서 이 거래는 회사 하나의 주인이 바뀌는 일이 아니라, 오픈 모델 생태계를 떠받치는 배관이 누구 소유가 되는지의 문제에 가깝습니다. 지난달에는 Stripe가 모델 라우팅 서비스 OpenRouter를 인수했습니다. 모델 자체가 아니라 모델을 실어 나르는 층이 연달아 팔리고 있습니다.

## 발표에 담긴 내용

숫자부터 정리합니다. NVIDIA 발표문에 따르면 Hugging Face 플랫폼에는 1,800만 명 이상의 개발자와 연구자, 창작자가 있고, 공유된 모델은 300만 개 이상, 데이터셋은 50만 개 이상, 애플리케이션은 100만 개 이상입니다. 이 플랫폼을 쓰는 기업은 20만 곳 이상입니다. TechCrunch 보도에 따르면 Hugging Face의 연환산 매출은 1억 5,000만 달러 수준이었고 흑자 전환에 근접해 있었습니다.

### 중립성에 대한 약속

Jensen Huang은 발표문에서 "Hugging Face는 AI 생태계 전체를 위한 개방형 플랫폼으로 남을 것"이라고 밝혔습니다. 이어 개발자가 원하는 모델과 프레임워크, 클라우드와 추론 서비스 제공자, 컴퓨팅 플랫폼을 직접 고르게 되며 "Hugging Face에서 무언가를 만들거나 배포하는 데 NVIDIA 컴퓨트가 필요하지는 않다"고 못박았습니다. 멀티 클라우드와 멀티 액셀러레이터 지원을 계속하고, 생태계 전반의 오픈소스·오픈웨이트 모델을 계속 다루겠다는 문장도 함께 실렸습니다. 창업 팀은 잔류하고 브랜드도 유지됩니다. Huang은 "우리는 함께 Hugging Face의 플랫폼을 키우고 인프라를 강화하며 전 세계 개발자와 기관의 AI 접근성을 넓힐 것"이라고 적었습니다.

Hugging Face CEO Clem Delangue는 이번 인수로 "더 많은 컴퓨트, 더 많은 지원, 더 많은 협업, 더 많은 가시성"을 얻게 된다고 말했습니다. 그는 커뮤니티가 Hugging Face를 폐쇄형 API의 대안으로 자리 잡게 해 준 데 감사를 표하기도 했습니다. 다만 NVIDIA 발표문과 TechCrunch 기사 모두 거래 종결 시점이나 규제 승인 조건은 구체적으로 밝히지 않았습니다. 위에 적은 플랫폼 규모 수치는 모두 NVIDIA가 발표문에 직접 적은 값이며, 외부 검증을 거친 집계는 아닙니다.

### 한 달 사이 두 번째 인수

VentureBeat 정리에 따르면 Stripe는 2026년 8월 19일 OpenRouter 인수를 발표했습니다. 금액은 공식적으로 공개되지 않았고, Reuters와 Axios는 80억 달러를 조금 넘는 수준으로 보도했습니다. OpenRouter는 하루 10조 개가 넘는 토큰을 400개 이상의 모델로 중계하며, 1,000만 곳 이상의 개발자와 기업이 사용합니다. 모델 배포처와 모델 중계층이 3주 간격으로 각각 다른 대기업 산하로 들어간 셈입니다. 두 회사 모두 모델을 직접 만들지는 않습니다. 대신 남이 만든 모델이 배포되고 호출되는 길목에 서 있었고, 값이 매겨진 것도 그 위치였습니다.

## 의미와 한계

Hugging Face가 가진 힘은 가중치 파일을 보관한다는 데 있지 않습니다. VentureBeat는 저장과 버전 관리, 문서화 체계, 모델 카드와 커뮤니티 평판 지표, 데이터셋 호스팅, 기업용 협업과 인증 계층, 추론 엔드포인트, TRL 같은 학습 라이브러리가 남기는 사용 신호까지가 한 덩어리로 묶여 있다고 정리했습니다. GPU와 CUDA를 가진 회사가 이 층을 함께 갖게 되는 구조입니다.

여기서 나오는 우려는 노골적인 차별이 아닙니다. 새로운 양자화 포맷이나 서빙 최적화가 NVIDIA 경로에서 먼저 동작하고 다른 백엔드가 뒤따르는 식의 비대칭이 조용히 쌓이는 쪽입니다. 개발자는 가장 빨리 지원되는 경로에 머무는 경향이 있기 때문입니다. 이것은 확정된 사실이 아니라 관측자들이 제기한 가능성입니다. 규제도 변수입니다. 자기가 의존하는 계층을 자기가 소유하는 형태라서 미국과 EU 경쟁 당국의 심사를 피하기 어려울 것으로 보이며, NVIDIA가 과거 Arm 인수를 규제 압박 속에 접었던 전례도 있습니다. 이 대목 역시 추측입니다.

당장 할 수 있는 일은 단순합니다. 중요한 모델 아티팩트를 미러링하고, 리비전을 정확히 고정하고, 라이선스와 메타데이터를 로컬에 보관하고, 아티팩트 저장과 런타임 추론을 분리해 두는 것입니다. 이식성은 필요해진 다음에 시험하면 늦습니다.

## 한 줄 정리

오픈 모델 생태계의 기본 배포 경로가 GPU 공급자의 자산이 됐고, 중립성은 이제 약속의 문제로 남았습니다.
