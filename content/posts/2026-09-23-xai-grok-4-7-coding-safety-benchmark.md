---
title: "xAI, Grok 4.7 공개하며 코딩 벤치마크와 안전 테스트 수치를 함께 발표"
description: "xAI가 9월 21일 공개한 Grok 4.7은 코딩 에이전트 벤치마크에서 전작보다 오른 점수를 냈고, 거부·탈옥 저항성과 위험 프롬프트 차단율도 같은 자리에서 공개했습니다."
date: 2026-09-23
tags: ["xAI", "Grok", "벤치마크", "추론비용", "안전성"]
sources:
  - title: "Grok 4.7 (xAI 공식 발표)"
    url: "https://x.ai/news/grok-4-7"
  - title: "Grok 4.7 is now available in GitHub Copilot"
    url: "https://github.blog/changelog/2026-09-21-grok-4-7-is-now-available-in-github-copilot/"
  - title: "xAI Launches Grok 4.7, Its Most Capable Coding Model Yet"
    url: "https://sqmagazine.co.uk/xai-launches-grok-4-7-coding-model/"
---

## 왜 지금 이 주제인가

xAI가 9월 21일 코딩·에이전트 작업에 초점을 맞춘 신모델 Grok 4.7을 공개했습니다. 같은 날 GitHub Copilot에 바로 편입됐고, Cursor와 Grok Build, Grok API, 여러 서드파티 코딩 하니스에서도 동시에 쓸 수 있게 됐습니다. 프런티어 랩들이 코딩 벤치마크 점수를 두고 몇 주 간격으로 모델을 갱신하는 가운데, 이번 발표는 성능 수치와 함께 거부율·탈옥 저항성·위험 프롬프트 차단율 같은 안전 지표를 같은 자리에서 공개했다는 점에서 살펴볼 만합니다.

## 핵심 내용

xAI 발표에 따르면 Grok 4.7은 더 크고 새로운 기반 모델에 더 긴 강화학습을 거쳤고, 몇 시간 걸리는 어려운 과제에 학습 비중을 더 뒀습니다. 코딩 벤치마크 CursorBench 4.0에서 46.3%로 전작 Grok 4.6의 40.4%를 앞섰고, DeepSWE v1.1(고난도 설정)에서는 71.0%로 Grok 4.6의 65.2%보다 올랐습니다. 이 밖에 EEBench 64.0%, Harvey Legal Agent Benchmark 19.6%, HealthBench Professional 56.7%를 기록했습니다.

모델은 텍스트·이미지를 입력받아 텍스트만 출력하며 컨텍스트 윈도우는 50만 토큰입니다. 추론 강도는 낮음·중간·높음(기본값)·초고 네 단계로 조절할 수 있습니다. 가격은 20만 토큰 이하 구간에서 입력 100만 토큰당 2달러, 출력 100만 토큰당 6달러이며, 이를 넘는 구간에서는 각각 4달러·12달러로 두 배가 됩니다.

안전성 항목에서는 "지금까지 테스트한 모델 중 거부·탈옥 저항성이 가장 강하다"고 소개했습니다. 이중용도 프롬프트를 평가하는 HackerBench v0.3에서는 위험한 요청의 3.3%만 통과시키면서도 정상 보안 작업은 거의 차단하지 않았다고 설명했습니다. 생물안전 관련 LatchBio 벤치마크 점수는 62.4%였습니다. GitHub Copilot에서는 Pro, Pro+, Max, Business, Enterprise 등급에서 순차 제공됩니다.

## 의미와 한계

이번 발표는 강화학습 시간을 늘리고 어려운 과제에 학습 비중을 두는 방식이 코딩·에이전트 벤치마크 점수를 끌어올렸다는 사례를 하나 더 보탰습니다. 안전 수치를 모델 카드 뒤로 미루지 않고 성능 발표와 한자리에서 공개한 점도 눈에 띕니다.

다만 한계도 있습니다. xAI는 파라미터 수나 학습 데이터 구성, 세부 아키텍처는 공개하지 않았습니다. 벤치마크 점수도 xAI가 자체 측정해 발표한 것으로, 외부 독립 검증은 아직 없습니다. CursorBench나 HackerBench, LatchBio 같은 벤치마크의 설계와 채점 기준도 완전히 공개돼 있지 않아, 다른 모델과의 직접 비교에는 신중할 필요가 있습니다.

## 한 줄 정리

xAI가 Grok 4.7로 코딩 벤치마크와 안전 테스트 수치를 함께 공개했지만, 검증은 아직 자체 발표 단계에 머물러 있습니다.
