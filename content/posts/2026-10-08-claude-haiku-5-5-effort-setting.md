---
title: "Anthropic, 소형 모델 Claude Haiku 5.5 공개하며 가격을 90% 낮췄습니다"
description: "Anthropic이 Haiku 5.5를 출시해 입력 토큰 가격을 90% 낮추고, 비용과 성능을 조절하는 effort 설정을 처음 도입했습니다."
date: 2026-10-08
tags: ["Anthropic", "Claude", "벤치마크", "추론비용", "에이전트"]
sources:
  - title: "Introducing Claude Haiku 5.5"
    url: "https://www.anthropic.com/claude-haiku-5-5"
  - title: "Anthropic launches Claude Haiku 5.5 with 90% API price reduction, matching GPT-6 Luna"
    url: "https://venturebeat.com/technology/anthropic-launches-claude-haiku-5-5-with-90-api-price-reduction-matching-gpt-6-luna"
---

## 왜 지금 이 주제인가

Anthropic이 2026년 10월 7일 소형 모델 라인의 신작 Claude Haiku 5.5를 발표했습니다. 지난주 Sonnet 5.5가 가격을 유지한 채 속도만 높이는 쪽으로 움직였던 것과 달리, 이번에는 가장 저렴한 모델 체급에서 가격을 큰 폭으로 낮추면서 동시에 성능 지표를 끌어올렸습니다. 대량 요약, 분류, 데이터베이스 질의처럼 비용에 민감한 반복 작업을 처리하는 실무용 모델이 어떤 방향으로 진화하고 있는지 보여주는 사례입니다.

## 핵심 내용

Haiku 5.5는 Claude Platform, AWS, Google Cloud, Microsoft Azure에서 모델 ID `claude-haiku-5-5`로 바로 사용할 수 있습니다.

**가격**은 입력 토큰 10만 개 이하 구간에서 입력 100만 토큰당 0.10달러, 출력 100만 토큰당 0.50달러로 책정됐습니다. Haiku 4.5가 각각 1.00달러, 5.00달러였던 것과 비교하면 토큰당 90% 인하입니다. 10만 토큰을 넘는 구간은 입력 0.50달러, 출력 2.50달러로 오르며, Anthropic은 이를 평균치로 환산하면 Haiku 4.5보다 약 75% 비용이 줄어든다고 설명했습니다. 캐시 읽기 비용도 100만 토큰당 0.10달러에서 0.01달러로 낮아졌습니다.

**effort 설정**은 이번 버전에서 처음 Haiku급 모델에 적용된 기능입니다. Low, Med, High, Xhigh, Max 다섯 단계로 나뉘며 사용자가 비용과 성능 사이에서 직접 균형을 고를 수 있습니다. 같은 모델 하나로 저비용 분류 작업과 고성능 추론 작업을 모두 처리하게 만드는 설계입니다.

**벤치마크 수치**는 전반적으로 Haiku 4.5 대비 큰 격차를 보였습니다.
- GDPval-AA v2.1(지식노동 평가): Haiku 5.5 1,620 Elo, Haiku 4.5 735 Elo
- OSWorld 2.1(컴퓨터 사용, 오프라인 부분집합): Haiku 5.5 72.4%, Haiku 4.5 15.7%
- Humanity's Last Exam(다학제 추론, 도구 사용): Haiku 5.5 57.4%, Haiku 4.5 18.7%
- Terminal-Bench 4.0(에이전트 코딩): Haiku 5.5 39.2%, Haiku 4.5 0.0%
- Chartography(시각 추론, 도구 미사용): Haiku 5.5 46.4%, Haiku 4.5 6.4%

Anthropic은 고객 사례로 Box가 지연 시간이 절반으로 줄었다고 보고했고 Asana는 작업 지연이 30% 이상 단축됐다고 언급했다고 전했습니다. HubSpot의 CRM 평가에서는 92.8%의 정확도를 기록했습니다.

같은 날 Sonnet 5.5의 캐시 읽기 비용도 100만 토큰당 0.20달러에서 0.10달러로 추가 인하됐고, Max 5x 구독자는 월 100달러, Max 20x는 200달러, Team 구독자는 500달러의 API 크레딧을 받게 됐습니다.

경쟁 모델과 비교하면 OpenAI의 GPT-6 Luna도 입력 0.10달러, 출력 0.50달러로 가격대가 같지만, Luna는 27만 2천 토큰을 넘을 때부터 추가 요금이 붙는 반면 Haiku 5.5는 10만 토큰부터 가격이 오르는 구조입니다.

## 의미와 한계

소형 모델 체급에서도 effort 조절 기능이 들어왔다는 점은 하나의 모델을 여러 작업 단가에 맞춰 쓸 수 있게 하는 흐름을 보여줍니다. 대량 처리 작업에서는 저비용 모드를, 복잡한 에이전트 작업에서는 고성능 모드를 선택하는 식으로 운영 비용을 세밀하게 조정할 수 있게 됩니다. OSWorld나 Terminal-Bench처럼 에이전트형 과제에서 나타난 점수 격차는 소형 모델이 단순 텍스트 생성을 넘어 화면 조작이나 터미널 작업까지 감당할 수 있는 수준으로 올라오고 있다는 신호로 볼 수 있습니다.

다만 한계도 분명합니다. Anthropic은 Haiku 5.5의 SWE-bench Verified 점수를 공개하지 않았는데, 전신인 Haiku 4.5가 73.3%를 기록했던 지표라는 점에서 소프트웨어 엔지니어링 성능에 대한 직접 비교는 아직 불완전합니다. 또한 발표에 나온 벤치마크 수치는 모두 Anthropic이 자체적으로 선정하고 공개한 지표로, 독립된 제3자 검증은 아직 이뤄지지 않았습니다. 고객 인용으로 소개된 지연 시간 단축 수치 역시 구체적인 측정 조건이 공개되지 않아 일반화하기는 이릅니다.

## 한 줄 정리

Anthropic이 소형 모델 Haiku 5.5의 가격을 최대 90% 낮추면서 비용과 성능을 조절하는 effort 설정을 함께 도입했습니다.
