---
title: "Anthropic, Claude Sonnet 5.5 공개하며 가격은 그대로 두고 속도만 높였습니다"
description: "Anthropic이 9월 28일 Claude Sonnet 5.5를 출시하며 기존 가격을 유지한 채 출력 속도 30% 이상, 작업당 비용 최대 30% 절감을 발표했습니다."
date: 2026-09-29
tags: ["Anthropic", "Claude", "벤치마크", "추론비용", "안전성"]
sources:
  - title: "Introducing Claude Sonnet 5.5"
    url: "https://www.anthropic.com/claude-sonnet-5-5"
  - title: "Anthropic launches Claude Sonnet 5.5 with 30% cost reduction per-task due to faster speeds and fewer tool calls"
    url: "https://venturebeat.com/technology/anthropic-launches-claude-sonnet-5-5-with-30-cost-reduction-per-task-due-to-faster-speeds-and-fewer-tool-calls"
---

## 왜 지금 이 주제인가

Anthropic이 9월 28일 Claude Sonnet 5.5를 공개했습니다. 지난 9월 2일 Claude Fable 5.1의 캐시 읽기 단가 인하를 발표한 지 한 달이 채 지나지 않은 시점입니다. Sonnet 5.5는 앞서 나온 Opus 5.5, Haiku 5.5와 함께 Claude 5.5 패밀리를 이루는 세 번째 모델로, 복잡한 판단이 필요한 작업은 Opus 5.5에 맡기고 일상적인 코드 수정이나 문서·슬라이드 작업은 Sonnet이 처리한다는 역할 분담을 그대로 유지합니다. 가격을 올리지 않고 속도와 비용 효율만 개선했다고 밝힌 점이 이번 발표의 핵심입니다.

## 핵심 내용

Sonnet 5.5의 API 가격은 입력 토큰 백만 개당 2달러, 출력 토큰 백만 개당 10달러로 이전 Sonnet 5와 동일합니다. 캐시 읽기는 백만 토큰당 0.20달러, 캐시 쓰기는 2.50달러입니다. Anthropic은 이 가격을 유지한 채 출력 생성 속도를 30% 이상 높였고, 같은 작업을 처리하는 데 드는 토큰 수와 도구 호출 횟수를 줄여 작업당 비용을 최대 30% 낮췄다고 설명했습니다.

벤치마크 결과도 함께 공개됐습니다. 지식 작업 평가인 GDPval-AA에서 Sonnet 5.5는 1844 Elo를 기록해 Opus 5.5의 1846과 거의 차이가 없었습니다. 컴퓨터 사용 능력을 재는 OSWorld 2.1에서는 Sonnet 5.5가 80.1%, Opus 5.5가 81.8%였습니다. 코딩 도구 사용 능력을 보는 CursorBench 4.0은 Sonnet 5.5 55.5%, Opus 5.5 57.8%로 역시 Opus 5.5가 근소하게 앞섰습니다.

눈에 띄는 것은 터미널 작업 능력을 측정하는 Terminal-Bench 4.0입니다. Sonnet 5.5는 70.6%를 기록해 Opus 5.5의 66.4%를 앞섰습니다. Anthropic이 공개한 수치에 따르면 이전 세대인 Sonnet 5는 이 벤치마크에서 10.3%에 그쳤던 것과 비교하면 큰 폭의 상승입니다.

보안 측면에서는 Sonnet 5.5가 처음으로 최상위 모델에 적용하던 사이버 안전장치를 함께 받았습니다. 사이버보안 관련 고위험 요청이 들어오면 자동으로 이전 모델인 Sonnet 5로 전환되도록 했고, 모델 추론 과정을 외부로 추출하려는 공격을 막는 안전 분류기도 탑재했습니다. 모델은 Amazon Web Services, Google Cloud, Microsoft Azure를 포함한 모든 플랫폼에서 이용할 수 있으며, 모델 ID는 claude-sonnet-5-5이고 데이터 보존 없이 사용하는 옵션도 제공됩니다.

Anthropic은 실제 도입 기업의 사례도 함께 소개했습니다. Box는 처리 속도가 2.4배 빨라지고 사용 토큰이 12% 줄었다고 밝혔고, Zendesk는 티켓 처리 속도가 20% 향상됐다고 전했습니다. Slack은 출력 토큰이 14% 줄었으며, Lovable은 도구 호출 횟수가 3분의 1로 줄었다고 보고했습니다.

## 의미와 한계

가격을 동결한 채 속도와 비용 효율을 함께 끌어올린 것은 실제로 API를 대량 호출하는 기업 입장에서 체감할 수 있는 변화입니다. 특히 Terminal-Bench 4.0에서 저가 모델인 Sonnet 5.5가 고가 모델인 Opus 5.5를 앞섰다는 점은, 특정 작업 유형에 한해서는 굳이 비싼 모델을 쓸 필요가 없어졌다는 뜻으로 해석할 수 있습니다.

다만 GDPval-AA, OSWorld, CursorBench 등 나머지 벤치마크에서는 여전히 Opus 5.5가 앞서 있어, 복잡한 판단이 필요한 작업까지 Sonnet 5.5로 대체할 수 있다고 보기는 어렵습니다. 또한 이번 벤치마크 수치는 모두 Anthropic이 자체적으로 측정해 공개한 것으로, 제3자의 독립적인 검증은 아직 이뤄지지 않았습니다. Terminal-Bench 점수가 10.3%에서 70.6%로 뛴 것도 벤치마크 버전이 4.0으로 바뀐 데 따른 것일 수 있어, 이전 세대와 수치를 단순 비교하는 데는 주의가 필요합니다.

## 한 줄 정리

Anthropic은 Sonnet 5.5를 기존 가격 그대로 내놓으며 속도와 비용에서 실질적인 개선을 보여줬지만, 복잡한 작업에서는 여전히 Opus 5.5가 우위에 있습니다.
