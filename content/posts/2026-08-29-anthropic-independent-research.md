---
title: "Anthropic, 외부 연구기관 세 곳에 Claude 대화 25만 건 분석을 개방"
description: "Anthropic이 Stanford, Oxford, METR에 Claude 대화 25만 건의 집계 분석을 열었습니다. 무엇이 공개됐고 무엇이 여전히 닫혀 있는지 정리했습니다."
date: 2026-08-29
tags: ["Anthropic", "Claude", "사용자연구", "프라이버시", "평가"]
sources:
  - title: "Enabling independent research on how people use Claude"
    url: "https://www.anthropic.com/research/enabling-independent-research"
  - title: "Human-AI Collaboration at Scale: Task Criticality, Agency, and Friction Across 250,000 Conversations"
    url: "https://www.alphaxiv.org/abs/2608.human-ai-collaboration-at-scale"
  - title: "Anthropic/enabling-independent-research dataset"
    url: "https://huggingface.co/datasets/Anthropic/enabling-independent-research"
---

## 왜 지금 이 주제인가

사람들이 AI 챗봇을 실제로 어떻게 쓰는지에 대한 자료는 대부분 서비스를 운영하는 회사가 직접 만들어 발표해 왔습니다. 바깥에서 검증할 방법이 마땅치 않다는 점이 계속 지적돼 왔습니다. Anthropic은 2026년 8월 26일, 외부 연구기관 세 곳이 직접 설계한 질문으로 Claude 대화 데이터를 분석하고 그 결과를 독립적으로 발표하도록 한 시범 프로그램을 공개했습니다. 회사 바깥의 연구자가 상용 AI 서비스의 실사용 데이터를 연구해 공개한 사례로는 처음이라고 밝혔습니다.

## 프로그램은 어떻게 돌아갔나

대상은 2026년 4~5월에 오간 Claude.ai와 Claude Code 대화 약 25만 건입니다. 참여 기관은 Stanford의 SALT(Social and Language Technologies) 연구실, Oxford의 Human Information Processing Lab, 그리고 AI 평가를 다루는 비영리 단체 METR입니다.

연구자들은 원본 대화를 볼 수 없었습니다. 대신 Anthropic Insights(이전 이름 Clio)라는 분석 도구에 자연어로 질문을 넣으면, Claude가 대화를 범주로 나누고 연구자에게는 범주별 비율만 전달되는 구조였습니다. Anthropic은 정책 위반이 드러난 경우 등 전체 범주의 5% 미만을 수정하거나 제외했고, 제3자 프라이버시 감사는 Imperial College London이 맡았습니다. 계약상 Anthropic의 승인권은 프라이버시, 정책 위반, 기밀 정보, 연구의 정확성에 한정되며 결과 내용에는 관여하지 않는다고 설명했습니다. 회사에 불리한 결과라도 발표할 수 있다는 조항도 함께 두었습니다.

### 세 연구실이 본 것

SALT 연구실은 대화 249,834건을 세 축으로 분류했습니다. 일의 중대성을 재는 Task Criticality Index, 사람과 AI 중 누가 주도했는지를 H1부터 H5까지 나눈 Human-AI Agency Scale, 그리고 대화가 어긋나는 지점을 뜻하는 friction입니다.

전체의 56%가 되돌리기 어렵거나 남에게 영향을 주는 일이었고, 12%는 고위험으로 분류됐습니다. 고위험 대화는 평균 12.4턴이 오간 반면 영향이 적은 대화는 6.5턴이었습니다. 72%는 사람이 주도하고 AI가 거드는 H4에 속했고, 중대한 일에서는 60%가 AI 출력을 그대로 쓰지 않고 손봤습니다. 설명이나 개념 전달 같은 가르치는 행동은 67%의 대화에서 나타났습니다. 마찰은 49.7%의 대화에서 발생했는데 모델 쪽 원인이 38.6%, 사용자 쪽 원인이 19.4%였고, 마찰을 겪은 사용자의 78.7%는 복구를 시도했습니다.

Oxford 연구실은 사용자의 감정 상태와 Claude의 응답 방식이 함께 움직이는 패턴을 봤고, METR은 Claude Code에서 최신 모델이 이전 세대보다 작업 속도를 유의미하게 높였다는 예비 결과를 내놓았습니다. 두 기관의 보고서는 발표 시점 기준 아직 작성 중입니다. 집계 결과 데이터셋은 CC-BY-4.0으로 공개됐습니다.

## 의미와 한계

이번 프로그램의 값어치는 개별 수치보다 절차에 있습니다. AI 사용 실태를 두고 규제 기관이나 연구자가 논쟁할 때 그동안은 회사가 고른 지표를 그대로 인용하는 것 말고 선택지가 별로 없었습니다. 이번에는 질문 설계와 해석이 바깥에 있었고, 집계 결과가 공개 데이터셋으로 남았습니다. 반박하거나 이어서 파고들 출발점이 생긴 셈입니다.

다만 열린 폭은 좁습니다. 분석 도구도, 파트너 선정도, 범주 승인도 모두 Anthropic 쪽에 있습니다. 원본 대화를 볼 수 없으니 Claude의 분류가 틀렸을 때 연구자가 알아차릴 방법이 마땅치 않습니다. 표본도 두 달치, 한 회사 제품에 한정됩니다. 논문도 스스로 한계를 적었습니다. 결과를 채택하고 검증하고 최종 결정을 내리는 과정은 대화 밖에서 일어나기 때문에, 대화 기록만으로는 누가 통제와 책임을 쥐었는지 확정할 수 없다는 것입니다. Oxford와 METR의 결과는 아직 전문이 없어 지금으로서는 따져볼 수도 없습니다. 다른 연구소가 비슷한 창구를 열지는 알 수 없고, 한 회사의 시범 사업으로 끝날 가능성도 있다고 봅니다.

## 한 줄 정리

외부 연구자가 상용 AI의 실사용 데이터를 분석해 발표한 첫 사례지만, 창구의 폭과 열쇠는 여전히 회사가 쥐고 있습니다.
