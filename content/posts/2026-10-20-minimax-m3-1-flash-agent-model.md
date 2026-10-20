---
title: "MiniMax, 작업당 비용 낮춘 에이전트용 모델 M3.1 Flash 공개"
description: "MiniMax가 에이전트와 코딩 작업에 특화한 M3.1 Flash를 공개했으며, 독립 평가에서 DeepSeek보다 일부 지표가 높게 나타났습니다."
date: 2026-10-20
tags: ["MiniMax", "DeepSeek", "MoE", "벤치마크", "추론비용"]
sources:
  - title: "MiniMax M3.1 Flash: Redefining Agent Performance and Cost"
    url: "https://www.minimax.io/blog/minimax-m31f"
  - title: "MiniMax's new M3.1 Flash beats DeepSeek and Opus 5 on a key business benchmark at lower cost — but with a high hallucination rate"
    url: "https://venturebeat.com/technology/minimaxs-new-m3-1-flash-beats-deepseek-and-opus-5-on-a-key-business-benchmark-at-lower-cost-but-with-a-high-hallucination-rate"
  - title: "MiniMax M3.1 Flash shows China's AI price race has no floor in sight"
    url: "https://the-decoder.com/minimax-m3-1-flash-shows-chinas-ai-price-race-has-no-floor-in-sight/"
  - title: "How to Use MiniMax M3.1 Flash API"
    url: "https://www.cometapi.com/how-to-use-minimax-m3-1-flash-api/"
---

## 왜 지금 이 주제인가

중국 AI 기업 MiniMax가 2026년 10월 19일 에이전트와 코딩 작업에 특화한 추론 모델 M3.1 Flash를 공개했습니다. 하루 전 DeepSeek가 입력과 출력에 다른 연산량을 쓰는 오픈 가중치 모델을 내놓은 데 이어, 비슷한 가격대의 경쟁 모델이 곧바로 등장하면서 중국 기업들 사이의 가격·성능 경쟁 구도가 다시 한번 드러났습니다. 독립 평가기관 Artificial Analysis가 공개 직후 자체 측정 점수를 내놓아, 회사 발표 수치와 제3자 검증 수치를 함께 놓고 비교할 수 있다는 점도 눈여겨볼 지점입니다.

## 핵심 내용

M3.1 Flash는 Mixture-of-Experts(MoE, 혼합전문가) 구조로, 전체 파라미터 428B(4,280억 개) 가운데 약 23B(230억 개)만 활성화해 연산량을 줄입니다. 컨텍스트 길이는 100만 토큰까지 지원해 대형 코드 저장소나 긴 에이전트 작업 세션을 한 번에 처리할 수 있다고 MiniMax는 설명합니다.

가격은 입력 토큰 100만 개당 0.15달러, 출력 토큰 100만 개당 0.60달러로 책정됐습니다. MiniMax는 이전 모델 대비 사용 비용을 약 70% 낮췄다고 밝혔습니다. 이 가격대는 동급 경쟁 모델인 DeepSeek V4.1 Flash와 같은 수준이며, Google Gemini 3.8(입력 0.75달러·출력 3.75달러)이나 Anthropic Claude Opus 5.5(입력 4달러·출력 20달러)보다는 훨씬 저렴합니다.

Artificial Analysis가 측정한 Intelligence Index에서 M3.1 Flash는 42점을 기록해 전작 M3의 29점보다 13점 올랐습니다. 이 지수 기준 과제 하나를 처리하는 평균 비용도 약 0.51달러에서 0.22달러로 낮아졌습니다. 에이전트의 자동화 작업 수행 능력을 재는 Automation-Bench에서는 62.2점으로 DeepSeek V4.1 Flash(60.5점)를 앞섰고, 폭넓은 지식과 추론을 묻는 Humanity's Last Exam에서는 48%를 기록해 DeepSeek(43%)보다 높았습니다. MiniMax가 자체 공개한 수치로는 금융 업무 도구 사용 능력을 보는 BankerToolBench에서 76.2점, 보안 취약점 탐지 능력을 보는 CyberGym에서 82%를 기록했다고 밝혔습니다.

컴퓨터 화면을 보고 마우스와 키보드를 직접 조작하는 능력을 재는 OSWorld V2에서는 61.7점, 여러 단계로 이어지는 복합 에이전트 과제를 모아놓은 Agents' Last Exam에서는 29.6점을 기록했다고 MiniMax는 밝혔습니다. 추론 속도도 전작보다 약 3배 빨라져 초당 200토큰 이상을 생성한다고 회사는 설명했는데, 속도와 비용을 함께 낮추는 쪽에 개발 역량을 집중했다는 뜻으로 읽힙니다.

다만 사실 정확성을 재는 AA-Omniscience 벤치마크에서는 정답률 56%로 DeepSeek(43%)보다 높았지만, 동시에 환각률이 93%에 달했습니다. 모델이 답을 모를 때 "모른다"고 답하기보다 틀린 답을 내놓는 쪽을 택하는 경향이 강하다는 뜻으로, 모든 문항에 답을 시도하도록 설계된 방침이 낳은 부작용으로 풀이됩니다.

## 의미와 한계

M3.1 Flash는 비슷한 가격대의 DeepSeek와 직접 비교되는 몇몇 지표에서 근소하게 앞섰다는 점에서, 중국 기업들의 저가 에이전트 모델 경쟁이 성능 면에서도 서로를 밀어내는 단계에 들어섰음을 보여줍니다. Intelligence Index와 Humanity's Last Exam, AA-Omniscience처럼 제3자가 독립적으로 측정한 지표가 함께 공개됐다는 점도 신뢰도를 높이는 요소입니다.

다만 BankerToolBench나 CyberGym처럼 MiniMax가 직접 공개한 벤치마크는 외부 검증이 따로 이뤄지지 않았다는 한계가 있습니다. 또한 93%에 이르는 환각률은 실제 업무에 투입할 때 중요한 위험 요소로, 정답률이 높아졌다고 해서 신뢰성이 그만큼 개선됐다고 보기는 어렵습니다. 이 글을 쓰는 시점까지 M3.1 Flash는 MiniMax의 API를 통한 서비스 형태로만 제공되고 있어, 전작 M3처럼 가중치를 공개할지는 확인되지 않았습니다. 결국 이번 발표는 성능 자체의 돌파라기보다, DeepSeek와 MiniMax가 같은 가격표를 두고 서로의 약점을 조금씩 메워 가는 반복적인 경쟁 국면에 가깝다고 볼 수 있습니다.

## 한 줄 정리

MiniMax M3.1 Flash는 DeepSeek와 같은 가격대에서 일부 벤치마크를 앞섰지만, 높은 환각률이라는 뚜렷한 약점을 함께 드러냈습니다.
