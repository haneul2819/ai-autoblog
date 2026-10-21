---
title: "DeepSeek, 프로덕션 추론 엔진 DeepInfer를 오픈소스로 공개"
description: "DeepSeek가 자사 서비스를 실제로 돌리는 추론 프레임워크 DeepInfer를 Apache 2.0으로 공개했습니다. 핵심 처리량 수치는 빠졌습니다."
date: 2026-10-21
tags: ["DeepSeek", "오픈소스", "인프라", "추론비용", "벤치마크"]
sources:
  - title: "deepseek-ai/DeepInfer (GitHub)"
    url: "https://github.com/deepseek-ai/DeepInfer"
  - title: "DeepSeek open-sources DeepInfer, the inference framework behind its production services"
    url: "https://siliconangle.com/2026/10/20/deepseek-open-sources-deepinfer-the-inference-framework-behind-its-production-services/"
  - title: "Notice of Order Regarding Exclusion and Removal of DeepSeek Products From Federal Civilian Executive Branch IT Systems"
    url: "https://www.federalregister.gov/documents/2026/10/20/2026-21447/notice-of-order-regarding-exclusion-and-removal-of-deepseek-products-from-federal-civilian-executive"
  - title: "DeepSeek DeepInfer: Open Engine, 155T Tokens/Day Claim vs Verified"
    url: "https://explainx.ai/blog/deepseek-deepinfer-open-source-inference-engine-v4-1-flash-155-trillion-tokens-claimed-vs-verified-2026"
---

## 왜 지금 이 주제인가

DeepSeek가 10월 19일 자사 서비스를 실제로 돌리는 추론 프레임워크 DeepInfer를 GitHub에 공개했습니다. 공개 모델 가중치를 내놓는 일은 이제 흔하지만, 그 가중치를 대규모로 서비스하는 운영 코드를 통째로 공개하는 일은 드뭅니다. 공교롭게도 같은 주 미국 국토안보부(DHS)가 연방 민간기관에 DeepSeek 제품과 그 기술로 만든 제3자 제품까지 걷어내라는 명령을 공개했습니다. 사용은 막히는데 코드는 더 열리는, 엇갈린 흐름이 동시에 벌어진 셈입니다.

## 핵심 내용

DeepInfer는 "대규모 생산 서비스를 지원하는 고성능 추론 프레임워크"라는 설명으로 Apache 2.0 라이선스 아래 공개됐습니다. 저장소 설명에 따르면 원래 오픈소스 프로젝트 vLLM을 기반으로 만들어졌고, SGLang과 TensorRT-LLM에서도 아이디어를 가져와 이후 크게 다시 작성했습니다. 현재 지원 모델은 DeepSeek-V4.1-Flash-1017 체크포인트 하나뿐입니다.

눈에 띄는 부분은 하드웨어 지원입니다. NVIDIA의 SM100 데이터센터 GPU뿐 아니라 Huawei의 Ascend 950 NPU도 처음부터 지원 대상에 올렸습니다. 실행 요구사항도 두 갈래로 나뉘어, NVIDIA 쪽은 CUDA 13, Ascend 쪽은 Huawei의 CANN 9.2를 요구합니다. Linux, GCC 13 이상, Python 3.12가 공통 요구사항입니다.

기능 목록도 구체적입니다.

- **투기적 디코딩**: DSpark라는 자체 방식과 신뢰도 기반 검증 스케줄링으로 초안 토큰을 미리 생성해 디코딩을 앞당깁니다.
- **병렬화**: 어텐션 단계에서는 데이터 병렬과 균형 잡힌 컨텍스트 병렬을, MoE(전문가 혼합) 단계에서는 전문가 병렬과 전문가 부하 균형(EPLB)을 지원합니다.
- **구조화된 출력**: 정규식, JSON 스키마, EBNF 문법으로 생성 결과의 형식을 강제할 수 있습니다.
- **배치 불변 추론과 결정론적 샘플링**: 같은 입력과 샘플링 파라미터를 넣으면 배치 구성이 달라져도 같은 출력을 보장합니다. 이는 서비스 운영에서 재현성을 따지는 현장 요구를 반영한 설계입니다.

저장소에 실린 성능 자료는 prefill과 decode 단계를 나눈 파레토 차트 형태로 제공되며, prefill은 SM100 GPU 4장, decode는 64장 기준으로 측정됐습니다. 다만 구체적인 처리량이나 비용 수치는 README에 명시돼 있지 않고, 세부 평가 방법은 별도 평가 문서를 참조하도록 안내돼 있을 뿐입니다. 공개 범위에서 빠진 부분도 있습니다. 키-값 캐시 관리 시스템, prefill과 decode 단계를 분리해 처리하는 디스어그리게이션 구조, 여러 장비에 걸친 부하 분산 코드는 DeepSeek 내부 인프라와 밀접하게 묶여 있어 이번 공개에 포함되지 않았습니다.

## 의미와 한계

실제 서비스를 돌리는 코드를 공개하면 외부 개발자가 DeepSeek가 대규모로 저지연 추론을 어떻게 구현했는지 직접 들여다볼 수 있습니다. Huawei Ascend를 처음부터 지원 대상에 넣은 점도 주목할 만합니다. 특정 모델에 한정된 전용 엔진이 아니라 NVIDIA 바깥의 칩 생태계까지 겨냥한 실전 코드라는 뜻입니다. 배치 불변 추론과 결정론적 샘플링을 코드 수준에서 보장한 점도 실무적인 가치가 있습니다. 같은 요청을 반복했을 때 서버의 배치 상황에 따라 답이 달라지는 문제는 그동안 추론 서비스 운영에서 흔히 겪던 어려움이었는데, 이를 프레임워크 차원에서 해결한 사례를 공개 코드로 확인할 수 있게 됐습니다.

다만 한계도 분명합니다. 지원 모델이 V4.1-Flash 하나뿐이고, KV 캐시와 부하 분산 등 운영에 필수적인 구성 요소가 빠져 있어 이 코드만으로 DeepSeek와 같은 수준의 서비스를 그대로 재현할 수는 없습니다. 공개 직후 중국 기술 커뮤니티 Zhihu를 인용하는 형태로 "단일 클러스터가 하루 155조 토큰을 처리한다"는 수치가 돌았지만, 이 수치는 저장소 어디에도 없고 DeepSeek의 공식 언급도 아닙니다. 공개된 코드와 문서만으로는 검증할 수 없는 수치라는 점을 분명히 해 둘 필요가 있습니다.

## 한 줄 정리

DeepSeek가 미국 정부의 제품 사용 금지 조치와 같은 주에 자사 프로덕션 추론 엔진 DeepInfer를 Apache 2.0으로 공개했지만, 핵심 운영 수치는 공개 범위에 포함하지 않았습니다.
