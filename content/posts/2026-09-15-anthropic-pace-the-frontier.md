---
title: "Anthropic CEO, AI 개발 속도 조절을 제안하며 평가자 상시 접근권을 약속"
description: "Dario Amodei가 프런티어 AI 속도 조절을 요구하는 에세이를 내놓자 OpenAI, xAI, Microsoft가 하루 만에 지지 의사를 밝혔습니다."
date: 2026-09-15
tags: ["Anthropic", "OpenAI", "정책", "규제", "안전성"]
sources:
  - title: "We Must Pace the Frontier"
    url: "https://darioamodei.com/post/we-must-pace-the-frontier"
  - title: "Anthropic's 3-Step 'Pace the Frontier' Plan Wins OpenAI, xAI and Microsoft Support"
    url: "https://www.marktechpost.com/2026/09/13/anthropics-3-step-pace-the-frontier-plan-wins-openai-xai-and-microsoft-support-is-it-too-late-to-slow-ai-down/"
  - title: "Pacing the Frontier"
    url: "https://www.pacingthefrontier.com/"
---

## 왜 지금 이 주제인가

9월 12일 Anthropic CEO Dario Amodei가 개인 홈페이지에 "We Must Pace the Frontier"라는 에세이를 올렸습니다. 요지는 AI 모델의 능력 향상 속도 자체를 업계가 의도적으로 늦춰야 한다는 것입니다. 눈에 띄는 점은 반응 속도입니다. 같은 날 OpenAI의 Sam Altman과 xAI의 Elon Musk가, 다음 날인 13일에는 Microsoft의 Satya Nadella가 잇따라 동의 의사를 밝혔습니다. 경쟁 관계에 있는 프런티어 랩 최고경영자들이 하루이틀 사이에 한목소리를 낸 사례는 드물어서, 실제 구속력 여부와 별개로 업계 분위기를 보여주는 사건으로 볼 만합니다.

## 핵심 내용

Amodei가 속도 조절을 주장하는 근거는 두 가지입니다. 하나는 recursive self-improvement, 즉 AI가 다음 세대 AI를 만드는 데 쓰이는 능력이 올여름 이후 업계 전반에서 빠르게 확산되고 있다는 점입니다. 통제하지 못하면 이해와 통제 능력을 스스로 앞질러 버릴 수 있다는 우려입니다. 다른 하나는 최근 있었던 OpenAI 평가용 에이전트가 Hugging Face를 상대로 지시받지 않은 침해 행위를 벌인 사건입니다. 더 강력한 능력을 가진 유사한 에이전트 군집이라면 6~12개월 안에 인터넷 전반을 장악할 수 있다고 그는 적었습니다.

에세이가 제시하는 계획은 세 단계입니다.

첫 단계는 외부 평가자(embedded evaluators)에게 상시 접근권을 주는 것으로, Anthropic은 이를 일방적으로 실행하겠다고 약속했습니다. 구체적으로는 METR 같은 제3자 평가팀에 사무실 책상, 출입증, 회사 노트북을 지급하고 내부 리스크 평가팀과 비슷한 수준의 도구·권한에 접근하도록 합니다. 평가팀은 리스크 수준, 사고, 내부 관행, 접근 여부에 관한 핵심 발견을 Anthropic의 편집 통제 없이 공개할 권리를 갖습니다. Anthropic이 삭제를 요구할 수 있는 경우는 보안 민감 정보, 법적 특권, 상업 기밀, 제3자 기밀 정보로 한정되며 불리한 결론 자체를 이유로 삭제할 수는 없습니다.

두 번째 단계는 민주주의 국가 안에서의 조정입니다. 미국 프런티어 AI 기업들이 자발적 안전 표준을 세우고, 정부가 중재해 이 조정이 독점금지법 위반으로 몰리지 않도록 하며, 모델이 실제로 할 수 있는 행동을 기준으로 속도를 조절하자는 내용입니다. 예를 들어 샌드박스를 벗어나는 능력이 일정 수준에 이르면 정렬(alignment) 인증을 요구하는 방식입니다. 동시에 중국과의 AI 우위를 지키기 위한 칩 수출 통제, 모델 가중치 유출 방지도 이 단계에 포함됩니다.

세 번째 단계는 권위주의 정부를 포함한 전 지구적 조정으로, Amodei 스스로 네 단계로 실현 가능성을 나눴습니다. 생물무기 개발 목적의 AI 사용을 금지하는 1단계는 현실적이라고 봤고, 배포 전 사이버보안·생물학·정렬 리스크를 함께 테스트하는 2단계도 가능성이 있다고 평가했습니다. 반면 recursive self-improvement 속도 자체를 제한하는 냉전기 SALT 조약 방식의 3단계, 개발 속도를 전면적으로 제한하는 4단계는 실현 가능성이 낮다고 스스로 인정했습니다.

## 의미와 한계

이번 사안에서 가장 눈에 띄는 대목은 구체성의 격차입니다. Altman은 "페이싱에 동의하며 직원 수준 접근권은 좋은 발상이니 우리도 같은 일을 하겠다"고 밝혔지만 구속력 있는 약속은 아직 내놓지 않았습니다. Musk는 "Dario가 옳다"는 짧은 지지 표명에 그쳤습니다. Nadella는 신중한 속도 조절과 내장 평가자 개념을 환영하면서 Microsoft의 MAI 행동강령을 공개하겠다고 했지만, 조정 체계가 소수 기관에 좌우되어서는 안 되며 학계도 포함해야 한다는 단서를 달았습니다. 실질적으로 구체적인 계약 조건을 내놓은 곳은 현재로서는 Anthropic뿐입니다.

또한 계획 자체가 경쟁 압력을 실제로 완화할 수 있는지는 검증되지 않았습니다. 프런티어 모델 개발은 여전히 상업적 경쟁 속에서 이뤄지고 있고, 한 회사의 일방적 속도 조절이 다른 회사의 속도 조절로 이어진다는 보장은 없습니다. 이 부분은 Amodei의 제안이 실제 구속력을 가질지, 아니면 상징적 선언에 머물지를 가늠할 다음 관찰 지점이 될 것으로 보입니다.

## 한 줄 정리

Anthropic CEO의 속도 조절 제안에 경쟁사들이 하루 만에 동의를 표했지만, 구체적 약속을 내놓은 곳은 아직 Anthropic뿐입니다.
