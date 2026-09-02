---
title: "OpenAI, Astra가 사이버 능력 Critical 기준을 넘었다고 발표"
description: "OpenAI가 차기 모델 Astra를 두고 자사 Preparedness Framework의 사이버 보안 최고 등급을 처음 넘었다고 밝히며, 고급 공격 기능 접근을 알파 테스터로 좁혔습니다."
date: 2026-09-02
tags: ["OpenAI", "보안", "안전성", "평가", "정책"]
sources:
  - title: "Open AI's Astra model is on the way — and very good at breaking into computer systems"
    url: "https://techcrunch.com/2026/09/01/open-ais-astra-model-is-on-the-way-and-very-good-at-breaking-into-computer-systems/"
  - title: "OpenAI to limit access to Astra model's advanced cyber features due to hacking concerns"
    url: "https://fortune.com/2026/09/01/openai-to-limit-release-of-its-asttra-model-astra-due-to-hacking-concerns/"
  - title: "CSA Research Note: OpenAI Astra and the Critical Cyber Threshold"
    url: "https://labs.cloudsecurityalliance.org/research/csa-research-note-openai-astra-critical-cyber-threshold-2026/"
---

## 왜 지금 이 주제인가

OpenAI가 9월 1일 "Path to Astra: critical capabilities and frontier safeguards"라는 글을 올려, 아직 공개하지 않은 차기 모델 Astra가 자사 Preparedness Framework에서 사이버 보안 능력의 최고 등급인 Critical 기준을 넘었다고 밝혔습니다. 프런티어 연구소가 자사 모델이 위험 기준의 최고선을 넘었다고 스스로 선언한 것은 처음입니다. 성능 자랑이 아니라 출시 조건을 스스로 조이겠다는 발표라는 점에서, 앞으로 프런티어 모델이 어떤 방식으로 풀려 나올지 가늠할 만한 사례입니다.

## 무엇을 근거로 Critical이라고 판단했나

Preparedness Framework에서 사이버 보안의 Critical 기준은 두 갈래로 정의됩니다. 사람이 단계마다 개입하지 않아도 잘 방어된 실제 핵심 시스템 다수에서 심각도를 가리지 않고 동작하는 제로데이 익스플로잇을 찾아 만들어 내거나, 높은 수준의 목표만 주어졌을 때 방어가 단단한 대상을 향해 처음부터 끝까지 새로운 공격 전략을 세우고 실행하는 경우입니다. 그 아래 High 등급이 이미 존재하는 공격 경로를 넓히는 수준을 가리킨다면, Critical은 없던 경로를 새로 여는 수준을 가리킵니다.

측정 근거로는 ExploitBench가 제시됐습니다. 심각한 취약점 20건으로 구성된 평가로, 알려진 취약점에서 실제로 동작하는 익스플로잇을 만들어 내는 능력을 봅니다. Astra는 여기서 만점을 받았고, 평가 과정에서 익스플로잇 체인의 일부로 제로데이 취약점 두 건을 직접 찾아내 사용했습니다. TechCrunch는 이 제로데이가 OpenAI가 시험용으로 변형해 둔 환경에서 나온 것이라고 전했습니다. 현행 모델인 GPT-5.6 Sol과 비교하면 취약점 식별과 익스플로잇 개발 양쪽에서 더 나았고 토큰 소모도 적었다는 것이 OpenAI의 설명입니다.

거절률도 함께 나왔습니다. 부적절한 요청에 대해 Astra는 91.5%를 거절했고, 같은 조건에서 GPT-5.6 Sol은 59%였습니다.

배포 방식은 능력 판정에 맞춰 좁혔습니다. 고급 사이버 기능은 우선 알파 테스터에게만 열립니다. 핵심 디지털 인프라를 방어하는 개인과 조직, 미국 정부 기관, OpenAI의 신뢰 보안 프로그램에 속한 기업들이 여기에 해당합니다. 이후 Daybreak Blue라는 프로그램을 통해 단계적으로 대상을 넓힐 계획입니다. 안전장치로는 오용과 탈옥 탐지 강화, 위험도가 높은 계정에 대한 사용 제한, 사고 과정(chain-of-thought) 모니터링이 언급됐습니다. 7월 Hugging Face 침해 사건 이후 OpenAI는 Astra 학습을 포함한 프런티어 훈련을 2주간 멈췄고, 새 안전·보안 요건을 적용한 뒤 8월 28일에 대규모 강화학습을 재개했습니다.

## 의미와 한계

달라지는 것은 등급 자체보다 등급이 배포를 묶는다는 점입니다. 그동안 프런티어 모델 발표는 성능 지표를 앞세우고 안전 항목을 뒤에 붙이는 형식이었는데, 이번에는 능력 평가 결과가 그대로 접근 제한의 근거로 쓰였습니다. 방어하는 쪽에 먼저 주고 나머지에는 늦게 준다는 비대칭 배포를 실제 제품 일정에 적용한 사례입니다.

다만 확인되지 않은 부분이 많습니다. Critical 판정은 OpenAI가 자사 기준으로 자사 모델을 평가한 결과이고, 외부 기관의 독립 검증 결과는 이번 발표에 포함되지 않았습니다. 전직 OpenAI 연구자는 Astra가 규칙을 어기기를 거부한 것이 실제 안전성인지 시험 상황임을 알아차린 결과인지 구분되지 않는다고 지적했습니다. ExploitBench 만점도 문항 20건짜리 평가에서 나온 수치여서 일반화할 수 있는 폭이 넓지는 않습니다.

거절률을 올리는 방향에도 대가가 따릅니다. 지나치게 조이면 정당한 보안 업무 요청까지 막히는데, Fortune은 Hugging Face 사고 대응 과정에서 Anthropic 모델이 지나치게 보수적으로 작동했던 사례를 함께 짚었습니다. 접근 제한을 언제 어떤 기준으로 푸는지도 아직 문서로 나오지 않았습니다. Astra의 출시일, 가격, 모델 사양 역시 이번 글에 없습니다. 추측을 덧붙이자면, 모델 공개 전에 위험 등급부터 알리는 이 형식은 다른 연구소들이 따라 하기 쉬운 방식으로 보입니다.

## 한 줄 정리

OpenAI는 Astra가 자사 위험 기준의 최고 등급을 넘었다고 판단해, 공개 전에 사이버 기능 접근을 방어 목적 사용자로 먼저 좁혔습니다.
