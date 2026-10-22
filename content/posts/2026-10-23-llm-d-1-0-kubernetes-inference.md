---
title: "레드햇·IBM·구글 등, 쿠버네티스 네이티브 추론 스택 llm-d 1.0 공개"
description: "레드햇, IBM, 구글, CoreWeave, NVIDIA 등이 함께 만든 오픈소스 분산 추론 스택 llm-d가 PyTorch Conference에서 1.0으로 출시되며 CNCF 샌드박스 프로젝트로 편입됐습니다."
date: 2026-10-23
tags: ["오픈소스", "인프라", "추론비용", "에이전트", "Google"]
sources:
  - title: "llm-d 1.0 hardens open-source AI inference for production (IBM Research)"
    url: "https://research.ibm.com/blog/llmd-1-0-is-ready-for-production-inference-serving"
  - title: "llm-d 1.0, an open source stack for distributed inference (Google Cloud Blog)"
    url: "https://cloud.google.com/blog/topics/ai-infrastructure/llm-d-1-0-an-open-source-stack-for-distributed-inference"
---

## 왜 지금 이 주제인가

2026년 10월 20일 PyTorch Conference North America에서 레드햇, IBM, 구글, CoreWeave, NVIDIA가 공동으로 llm-d 1.0을 발표했습니다. llm-d는 쿠버네티스 클러스터 위에서 거대언어모델(LLM) 추론 요청을 여러 GPU·TPU 레플리카에 자동으로 분산시키는 오픈소스 스택입니다. 2025년 프로젝트로 시작해 1년여 만에 Cloud Native Computing Foundation(CNCF) 샌드박스 프로젝트로 편입되고, 25개 이상 조직에서 500명 넘는 기여자가 참여하는 규모로 커졌습니다. 추론 비용이 AI 운영비의 큰 비중을 차지하는 상황에서, 특정 클라우드 제공업체에 묶이지 않고 자체 인프라로 추론 서버를 운영하려는 수요가 이 프로젝트를 키운 배경입니다.

## 핵심 내용

llm-d는 vLLM, SGLang 같은 기존 추론 엔진 앞에 쿠버네티스 네이티브 라우팅·스케줄링 계층을 얹는 구조입니다. 1.0 버전에서 새로 들어온 기능은 크게 세 갈래입니다.

첫째는 멀티테넌트 서비스 품질(QoS)입니다. 우선순위와 공정성을 반영한 플로우 제어로, 지연 시간에 민감한 대화형 요청과 버스트성 에이전트 작업이 같은 클러스터를 공유하면서도 각자의 서비스 수준 목표(SLO)를 지킬 수 있게 했습니다.

둘째는 무중단 운영입니다. DisaggregatedSet 컨트롤러가 프리필(prefill)과 디코드(decode) 레플리카를 하나의 논리 단위로 관리해, 활성 세션이나 컨텍스트를 잃지 않고 롤링 업데이트를 할 수 있습니다.

셋째는 에이전트 인식 서빙입니다. 핵심은 프리픽스 캐시 인식 라우팅으로, 라우터가 각 캐시된 프리픽스를 어느 레플리카가 들고 있는지 추적해 같은 대화의 후속 요청을 그 레플리카로 보냅니다. 메모리가 부족해지면 KV 캐시를 호스트 메모리, SSD, 구글의 Managed Lustre 순으로 오프로드합니다.

구글은 발표 데모에서 GKE(Google Kubernetes Engine) 위에 TPU와 GPU를 섞은 플릿을 구성하고, vLLM과 SGLang을 함께 쓰는 1,000개의 샌드박스 에이전트가 하나의 llm-d 엔드포인트에 요청을 보내는 모습을 시연했습니다. 구글이 공개한 수치에 따르면 Ironwood TPU에서 에이전트 코딩 워크로드를 프리픽스 인식 라우팅과 호스트 메모리 오프로드로 처리했을 때 첫 토큰 생성 시간(TTFT)의 중앙값이 85% 이상 줄었고 처리량은 일반 쿠버네티스 서비스 대비 2.4배로 늘었습니다. 자사 Gemini 플랫폼의 실제 운영 트래픽에서도 GKE Inference Gateway 적용 후 프리픽스 캐시 적중률이 35%에서 70%로, 코딩 에이전트 TTFT는 35% 이상, 버스트성 채팅 트래픽의 P95 TTFT는 50% 이상 줄었다고 밝혔습니다. IBM과 레드햇은 자체 호스팅 배포를 통해 3,000개의 소프트웨어 엔지니어링 에이전트를 동시에 돌리면서 기존 대비 5~10배 낮은 비용을 냈다고 전했습니다.

## 의미와 한계

llm-d 1.0의 의미는 쿠버네티스 생태계와 PyTorch 추론 엔진 생태계를 잇는 표준 계층이 CNCF라는 중립적 거버넌스 아래 자리 잡았다는 점입니다. 특정 벤더의 매니지드 서비스에 의존하지 않고도 멀티 엔진·멀티 하드웨어 환경에서 프로덕션급 추론을 운영할 길이 넓어진 셈입니다. 구글, IBM, 레드햇처럼 경쟁 관계에 있는 기업들이 같은 코드베이스에 기여한다는 점도 추론 인프라가 더 이상 개별 회사의 차별화 요소가 아니라 공동 투자할 공공재로 취급되고 있음을 보여줍니다.

다만 공개된 성능 수치는 각 기업이 자사 환경에서 측정해 발표한 것으로, 외부의 독립적인 재현이나 제3자 벤치마크로 검증된 값은 아닙니다. 수치 대부분이 구글의 TPU·GKE 환경에 치우쳐 있어 다른 하드웨어나 소규모 클러스터에서 동일한 개선폭을 기대할 수 있는지는 아직 알려지지 않았습니다. 샌드박스 단계인 CNCF 프로젝트인 만큼 API와 운영 방식이 앞으로도 더 바뀔 가능성이 있다는 점도 고려할 부분입니다.

## 한 줄 정리

쿠버네티스 기반 분산 추론 스택 llm-d가 1.0으로 정식 출시되며 CNCF 샌드박스 프로젝트로 편입됐습니다.
