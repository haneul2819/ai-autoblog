---
title: "마이크로소프트, 사내 AI 에이전트를 내부자 위협으로 보고 감시 체계 확장"
description: "마이크로소프트가 Project Perception에 Guardian Agents를 추가해 기업 내부 AI 에이전트의 행동을 실시간 감시하고 위험도에 따라 권한을 조정하는 체계를 공개했습니다."
date: 2026-10-21
tags: ["에이전트", "보안", "안전성", "Microsoft"]
sources:
  - title: "Securing the agentic insider - The Official Microsoft Blog"
    url: "https://blogs.microsoft.com/blog/2026/10/19/securing-the-agentic-insider/"
  - title: "Microsoft Adds Guardian Agents to Project Perception for AI Insider Risk"
    url: "https://www.unite.ai/microsoft-adds-guardian-agents-to-project-perception-for-ai-insider-risk/"
  - title: "Microsoft says AI agents are like insider threats as 'frontier models can't be trusted'"
    url: "https://techcrunch.com/2026/10/19/microsoft-says-ai-agents-are-like-insider-threats-as-frontier-models-cant-be-trusted/"
---

## 왜 지금 이 주제인가

마이크로소프트가 10월 19일, 7월에 공개했던 보안 시스템 Project Perception에 Guardian Agents와 Dynamic Agent Risk 기능을 추가했습니다. 기존 Project Perception은 외부에서 들어오는 AI 공격 방어에 초점을 맞췄지만, 이번 확장은 기업이 사내에 직접 배치한 AI 에이전트 자체를 감시 대상으로 삼습니다. 외부 해커가 아니라 회사가 신뢰하고 권한을 준 에이전트가 위협이 될 수 있다는 전제라는 점에서 방향이 다릅니다.

## 핵심 내용

마이크로소프트 보안 담당 부사장 Nadim Abdo는 에이전트를 "에이전틱 인사이더(agentic insider)"로 규정했습니다. 조작당하거나 실수를 저지르거나 손상될 수 있으면서도 기계 속도로 24시간 작동한다는 점에서 사람 내부자 위협과 비슷하게 다뤄야 한다는 논리입니다. 보안 담당자 Hayete Gallot은 "frontier 모델은 출처와 관계없이 신뢰할 수 없다"고 밝혔는데, 모델이 악의적이라서가 아니라 행동을 예측할 수 없기 때문이라고 설명했습니다.

Guardian Agents는 모든 에이전트의 행동을 사전에, 지속적으로 감시하고 조절합니다. 탐지 대상 에이전트 유형을 35종 늘려 총 60종까지 확대했고, Claude Code, OpenAI Codex, GitHub Copilot 등을 Microsoft Entra Agent ID로 통합 레지스트리에 등록해 추적합니다. 격리는 Microsoft Execution Container로 구현되는데, 에이전트는 처음에 권한이 없는 상태로 시작해 작업 범위와 시간이 제한된 권한만 부여받으며 자신을 배치한 사용자보다 높은 권한을 가질 수 없습니다. 마이크로소프트가 염두에 둔 위협 모델에는 신뢰할 수 없는 이메일 내용을 통한 프롬프트 인젝션, 악성 플러그인이 지시를 덮어쓰는 tool poisoning, 과도하게 허용된 OAuth 동의를 통한 credential relay 등이 포함됩니다.

핵심은 Dynamic Agent Risk입니다. 신원, 데이터, 엔드포인트, 클라우드, 네트워크, 런타임 신호를 종합해 위험도를 실시간으로 계산하고, 의도한 작업과 실제 행동이 얼마나 벗어났는지를 함께 봅니다. 이번에 추가된 변화는 여기에 모델의 chain-of-thought 신호까지 끌어와 의도 이탈을 잡아내고, 신뢰할 수 없는 외부 정보가 추론에 영향을 주는 상황이나 계획된 행동이 할당된 작업과 어긋나는 상황을 감지한다는 점입니다. 감시와 집행은 모델 자체와 독립적으로 이뤄지도록 설계했다고 밝혔습니다.

위험도가 올라가면 읽기 권한은 유지한 채 쓰기·승인 권한을 제거하거나, 접근 가능한 데이터 범위를 줄이고, 고위험 작업 실행 전에는 암호화된 방식으로 사람의 승인을 요구하는 식으로 단계적으로 대응합니다. 가장 위험도가 높을 때는 런타임을 격리하거나 실행을 중단시킵니다. 예로 든 시나리오는 외부 문서의 프롬프트 인젝션을 감지했을 때 읽기 접근은 유지하되 쓰기·승인 권한을 즉시 제거하는 식입니다. 이 체계는 5월부터 제공 중인 Microsoft 365 E7(월 99달러)과 제어 평면 Microsoft Agent 365(월 15달러)에 포함됩니다.

## 의미와 한계

이번 발표는 에이전트 보안을 "모델을 더 신뢰하게 만드는" 문제가 아니라 "모델을 믿지 않아도 안전하게 운용하는" 문제로 재정의했습니다. Satya Nadella는 "가장 신뢰할 수 있는 에이전트 시스템은 가장 믿을 만한 모델을 쓴 시스템이 아니라, 모델을 가장 믿지 않도록 설계된 시스템일 것"이라고 말했습니다. 모델 성능 경쟁과는 별개로 모델 바깥에서 권한과 행동을 통제하는 계층을 두겠다는 접근입니다.

다만 chain-of-thought 신호로 의도 이탈을 감지할 때 오탐과 미탐을 어느 수준으로 줄이는지에 대한 수치는 공개되지 않았습니다. 마이크로소프트가 OpenAI와 Anthropic 양쪽에 투자하면서 동시에 이들의 모델을 "신뢰할 수 없는 대상"으로 전제한 보안 상품을 판다는 점도, 이 체계가 중립적 방어 도구인지 자사 클라우드 생태계로의 유인책인지 따로 볼 부분입니다.

## 한 줄 정리

마이크로소프트는 사내 AI 에이전트를 모델 신뢰 여부와 무관하게 통제하는 감시 계층을 Project Perception에 추가했습니다.
