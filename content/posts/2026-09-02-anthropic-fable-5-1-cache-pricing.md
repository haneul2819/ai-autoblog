---
title: "Anthropic, Claude Fable 5.1 공개하며 캐시 읽기 단가를 4분의 1로 인하"
description: "Anthropic이 Fable 5.1과 Mythos 5.1을 공개하며 기본 단가는 두고 캐시 읽기만 4분의 1로 내렸습니다. 벤치마크와 세이프가드 조정 내용, 그리고 그 한계를 정리했습니다."
date: 2026-09-02
tags: ["Anthropic", "Claude", "추론비용", "벤치마크", "안전성"]
sources:
  - title: "Introducing Claude Fable 5.1 and Claude Mythos 5.1"
    url: "https://www.anthropic.com/claude-fable-and-mythos-5-1"
  - title: "Pricing - Claude Platform Docs"
    url: "https://platform.claude.com/docs/en/about-claude/pricing"
  - title: "Developing Enterprise Frontier Safeguards with our customers"
    url: "https://www.anthropic.com/news/enterprise-frontier-safeguards"
---

## 왜 지금 이 주제인가

Anthropic이 9월 1일 Claude Fable 5.1과 Claude Mythos 5.1을 공개했습니다. 두 모델은 같은 기반 모델이고, Fable 5.1은 곧바로 일반 공급되는 반면 Mythos 5.1은 검증을 거친 미국 조직에만 제한적으로 열립니다. 이번 발표에서 더 눈여겨볼 것은 벤치마크 점수보다 가격표의 한 줄입니다. 입력과 출력 단가는 그대로 두고 캐시 읽기 단가만 4분의 1로 내렸습니다.

## 무엇이 바뀌었나

### 벤치마크

Anthropic이 공개한 비교표에 따르면 에이전트형 코딩 과제인 Terminal-Bench 4.0에서 Fable 5.1은 55.8%를 기록했습니다. 같은 표에서 Fable 5는 42.0%, Opus 5는 52.3%, OpenAI GPT-5.6 Sol은 37.3%입니다. 과학 연구 과제를 다루는 Terminal-Bench-Science 0.1에서는 52.6%로, Fable 5의 24.7%와 Opus 5의 29.0%에서 크게 올랐습니다. 업무 자동화 과제인 AutomationBench는 31.4%로 Fable 5의 17.1%보다 높고, 도구 없이 푸는 Humanity's Last Exam은 60.9%입니다. 모두 Anthropic 자체 측정치입니다.

### 가격

기본 단가는 100만 토큰당 입력 10달러, 출력 50달러로 Fable 5와 같습니다. 달라진 곳은 프롬프트 캐시입니다. Anthropic의 가격 문서를 보면 다른 모든 모델은 캐시 적중 단가가 기본 입력가의 0.1배인데, Fable 5.1과 Mythos 5.1에만 0.025배가 적용돼 100만 토큰당 0.25달러가 됩니다. Fable 5는 1달러였습니다. Anthropic은 이 변경으로 일반적인 워크로드에서 약 25%, 에이전트 비중이 높은 작업에서는 최대 45%가량 비용이 줄어들 것으로 추정한다고 밝혔습니다.

### 세이프가드

Fable 5와 함께 적용됐던 생물학 세이프가드는 초급 생물학이나 의학 질문 같은 무해한 요청까지 막는 경우가 있었는데, Fable 5.1에서는 그런 개입이 85% 줄었다고 합니다. 사이버 보안 쪽은 세션당 개입 횟수가 약 60% 감소했고, 소스 코드에서 취약점을 찾는 작업은 허용하되 익스플로잇 개발은 계속 차단하는 쪽으로 경계선을 다시 그었습니다. API에는 증류 공격을 막기 위해 다중 턴 대화에서 컨텍스트를 임의로 편집하지 못하게 하는 제한이 새로 걸렸습니다.

같은 날 공개된 Enterprise Frontier Safeguards는 그 경계선을 기업 환경으로 옮긴 장치입니다. 활동 데이터를 Anthropic이 아니라 고객사의 S3, Azure Blob Storage, Google Cloud Storage에 고객이 관리하는 키로 보관하고, Anthropic은 그 위에서 오남용 탐지만 운영합니다. Anthropic 직원이 내용을 열어 보지 않고, 자동 탐지가 표시한 패턴에 어떻게 대응할지는 기업 팀이 판단합니다. 별도 이용료는 없으며 2026년 가을부터 단계적으로 열립니다.

## 의미와 한계

캐시 적중 배수를 0.1에서 0.025로 내린 것은 단순한 할인이라기보다 청구서의 무게 중심이 어디로 옮겨 갔는지에 대한 판단으로 읽힙니다. 여러 시간 이어지는 에이전트 세션은 같은 코드베이스와 지시문을 매 턴 다시 읽어들이기 때문에, 실제 요금의 상당 부분이 새 입력이 아니라 캐시 적중에서 나옵니다. 정가를 유지한 채 캐시만 손댔다는 것은 짧은 대화보다 장시간 자율 작업 쪽에 무게를 싣겠다는 신호에 가깝습니다.

다만 25%와 45%라는 절감 폭은 Anthropic이 제시한 추정치이고, 전체 입력에서 캐시 적중이 차지하는 비율에 따라 실제 값은 달라집니다. 캐시를 거의 쓰지 않는 워크로드라면 지출은 그대로입니다. 벤치마크 점수와 세이프가드 오탐 감소율도 모두 자체 측정이라 외부 재현이 필요하고, Mythos 5.1은 제한 공급이라 독립 검증이 특히 어렵습니다. Enterprise Frontier Safeguards 역시 아직 출시 전이어서 실제 탐지 정확도는 확인할 수 없습니다.

## 한 줄 정리

Fable 5.1은 점수보다 가격 구조가 더 많은 것을 말해 주는 발표로, 장시간 에이전트 작업이 과금의 기준선이 되어 가고 있음을 보여 줍니다.
