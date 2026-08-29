---
title: "OpenAI, 자체 추론 칩 Jalapeño의 첫 벤치마크 측정치를 공개"
description: "OpenAI가 Broadcom과 만든 추론 전용 칩 Jalapeño의 InferenceX 측정 결과를 내놨습니다. 전력당 처리량과 지연 수치, 그리고 그 수치가 아직 말해 주지 못하는 것들을 정리했습니다."
date: 2026-08-29
tags: ["OpenAI", "추론비용", "반도체", "인프라", "벤치마크"]
sources:
  - title: "OpenAI's Jalapeño chip is built for fast inference at scale, benchmarks show"
    url: "https://techcrunch.com/2026/08/25/openais-jalapeno-chip-is-built-for-fast-inference-at-scale-benchmarks-show/"
  - title: "OpenAI reveals how Jalapeño Chip performs, wider deployment coming in 2027"
    url: "https://www.businesstoday.in/technology/news/story/openai-reveals-how-jalapeno-chip-performs-wider-deployment-coming-in-2027-551378-2026-08-26"
  - title: "OpenAI's Jalapeño Chip Is Fast. The Benchmark Boundary"
    url: "https://www.nxcode.io/resources/news/openai-jalapeno-inference-chip-benchmark-2026"
  - title: "OpenAI Unveils Jalapeño Chip"
    url: "https://www.startuphub.ai/ai-news/artificial-intelligence/2026/openai-unveils-jalape-o-chip"
---

## 왜 지금 이 주제인가

OpenAI가 자체 추론 전용 칩 Jalapeño의 첫 성능 측정 결과를 8월 25일 공개했습니다. 칩의 존재는 앞서 Broadcom과 함께 발표했지만 그때는 설계 방향만 있었고 숫자가 없었습니다. 이번에는 반도체 분석 업체 SemiAnalysis가 만든 추론 벤치마크 InferenceX로 잰 수치가 함께 나왔습니다. 모델을 만드는 회사가 그 모델을 돌릴 칩까지 직접 설계했을 때 무엇이 달라지는지를, 마케팅 문구가 아니라 측정치로 처음 들여다볼 수 있게 된 셈입니다.

## 공개된 측정치

측정에 쓰인 모델은 세 개입니다. GPT-OSS 120B, DeepSeek R1 670B, Kimi K2.5 1T. 모두 공개 가중치 모델이라 제3자가 같은 조건을 재구성해 볼 수 있다는 점이 이 선택의 의미입니다. 비교 대상은 Nvidia의 GB200과 GB300 기반 시스템입니다.

측정 축은 두 가지입니다. 하나는 전력당 최대 처리량, 즉 킬로와트당 초당 토큰 수이고, 다른 하나는 요청을 넣고 응답이 끝날 때까지의 종단 지연입니다. 추론 하드웨어를 비교할 때 흔히 쓰는 칩 한 장당 성능이 아니라 전력을 분모로 삼았다는 점이 눈에 띕니다. 대규모 서비스에서 실제로 부딪히는 제약은 칩의 개수가 아니라 데이터센터에 끌어올 수 있는 전력이기 때문입니다.

- GPT-OSS 120B: 킬로와트당 85,448 대 44,960, 지연 1.03초 대 1.80초
- DeepSeek R1 670B: 19,641 대 11,781, 지연 1.65초 대 5.99초
- Kimi K2.5 1T: 18,195 대 11,862, 지연 1.56초 대 5.31초

세 모델을 묶으면 전력당 처리량은 1.5배에서 1.9배, 지연은 1.7배에서 3.6배 줄었다는 계산이 나옵니다.

주목할 부분은 두 숫자가 같은 방향으로 움직였다는 점입니다. 기존 추론 시스템에서는 배치 크기를 키우면 처리량이 오르는 대신 사용자가 느끼는 응답 지연이 늘어나는 절충 관계가 생깁니다. 그래서 처리량에 맞춘 시스템과 지연에 맞춘 시스템이 따로 있었습니다. Jalapeño는 하나의 구조에서 두 축을 함께 밀어 올렸다는 것이 OpenAI의 설명이고, 그 근거로 데이터 이동과 통신 지연을 줄이는 설계, 그리고 추론 중 KV 캐시를 칩 가까이에 두는 배치를 들었습니다.

측정 조건도 함께 공개됐습니다. 입력 8k 토큰에 출력 1k 토큰, 그리고 한 번에 토큰 하나를 예측하는 방식입니다. 여러 토큰을 한꺼번에 내놓는 추측 디코딩 같은 기법을 빼고 잰 값이라는 뜻이라, 시스템 사이의 차이를 비교적 깔끔하게 드러내는 조건이기는 합니다.

배포 일정은 보수적입니다. 2026년 말에 아주 적은 물량으로 자사 인프라에 들어가고, 의미 있는 규모의 배치는 2027년입니다. OpenAI는 이 칩을 여러 세대에 걸친 로드맵의 1세대로 규정하면서 2세대는 개발이 상당히 진행됐고 3세대는 구상 단계라고 밝혔습니다.

## 의미와 한계

추론 비용은 대화형 AI 서비스 원가의 대부분을 차지합니다. 같은 전력으로 두 배 가까운 토큰을 뽑아낼 수 있다면 그것은 성능 자랑이 아니라 손익 구조의 문제입니다. 모델과 서빙 소프트웨어와 칩을 한 회사가 함께 설계하는 방식이 실제로 이득을 낸다는 첫 증거로 볼 만합니다. 지연이 함께 줄었다는 점도 그냥 넘길 대목은 아닙니다. 사용자가 대화 도중 기다리는 시간은 그동안 처리량과 맞바꾸는 항목이었는데, 두 축을 동시에 개선했다면 같은 응답 속도를 훨씬 싼 비용으로 유지할 수 있다는 뜻이 됩니다.

다만 이 숫자를 그대로 받아들이기에는 걸리는 곳이 여럿입니다. 측정은 OpenAI 쪽이 제시한 것이고 제3자가 독립적으로 재현하지 않았습니다. 앞서 본 8k 입력에 1k 출력이라는 조건도 한 번 주고받는 형태여서, 도구를 여러 번 호출하며 맥락이 길게 늘어나는 실제 에이전트 워크로드와는 모양이 다릅니다. 게다가 비교 대상인 GPU 시스템의 성능은 vLLM, SGLang, TensorRT-LLM 같은 서빙 스택이 개선될 때마다 올라가므로, 이런 대조 결과는 빠르게 낡습니다.

시점도 문제입니다. OpenAI 하드웨어 책임자 Richard Ho는 Jalapeño가 전면 배치될 무렵이면 경쟁 제품이 이미 상당히 진전해 있을 수 있다고 직접 인정했습니다. 여기서부터는 추측인데, 특정 모델군에 맞춘 전용 칩은 범용성을 일부 포기하는 대가로 효율을 얻는 구조라서, 모델 구조가 크게 바뀌면 이득의 상당 부분이 사라질 수 있습니다. 2세대를 이미 개발 중이라는 언급도 그 위험을 의식한 것으로 읽힙니다.

## 한 줄 정리

Jalapeño의 첫 수치는 모델과 칩을 함께 설계하는 방식의 가능성을 보여 주지만, 아직은 자체 측정이고 조건도 단순합니다.
