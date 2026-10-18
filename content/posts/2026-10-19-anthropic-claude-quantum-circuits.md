---
title: "Anthropic, Claude 스스로 설계한 양자 회로가 기존 최고 설계 앞질러"
description: "Anthropic이 Claude Mythos 5가 최소한의 인간 개입으로 양자 회로를 설계해 8개 과제 중 7개에서 기존 최고 설계를 넘어섰다고 공개했습니다."
date: 2026-10-19
tags: ["Anthropic", "Claude", "양자컴퓨팅", "연구협업", "에이전트"]
sources:
  - title: "Designing more efficient quantum circuits with Claude"
    url: "https://www.anthropic.com/research/designing-efficient-quantum-circuits"
  - title: "Discovering state-of-the-art quantum circuits with large language models"
    url: "https://arxiv.org/abs/2610.22367"
---

## 왜 지금 이 주제인가

Anthropic이 2026년 10월 16일, 자사 언어모델 Claude Mythos 5를 이용해 양자 회로를 설계한 연구 결과를 공개했습니다. Harvard University, QuEra Computing과 함께 진행한 이 작업은 하루 전인 10월 15일 arXiv에 논문으로도 올라왔습니다. 지금까지 언어모델이 코드 작성이나 에이전트형 업무에서 능력을 보여 준 사례는 많았지만, 이번에는 양자컴퓨팅이라는 고도로 전문화된 공학 영역에서 사람이 손으로 설계한 최고 기록을 넘어섰다고 주장한 점이 눈에 띕니다.

## 핵심 내용

이번 연구는 Anthropic의 STEM Fellows Program 소속 연구자 Andi Gu가 주도했고, Anthropic의 양자물리학자 Alek Kemeny가 멘토로 참여했습니다. 여기에 Harvard University의 Susanne Yelin, 그리고 Harvard와 QuEra Computing에 소속된 Mikhail Lukin이 공동 연구자로 합류했습니다.

실험 방식은 폐쇄 루프 구조입니다. Claude Mythos 5가 양자 회로 설계안을 제안하면, 자동화된 평가 프로그램이 정확성을 검증하고 점수를 매깁니다. Claude는 이 피드백을 받아 다음 설계를 개선합니다. 연구팀은 작업 초반에 과제를 설명하는 브리프를 주고 간헐적으로 프롬프트를 던지는 것 외에는 사람이 거의 개입하지 않았다고 밝혔습니다. 점 덧셈(point addition) 과제의 경우 이런 방식으로 53시간 동안 실행이 이어졌습니다.

연구팀은 화학, 최적화, 양자 시뮬레이션, 정수론, 수치 연산 영역에 걸친 8개의 기본 연산(computational primitive)에 이 방법을 적용했습니다. 그 결과 8개 과제 중 7개에서, 발견된 회로가 기존 최고 설계보다 Toffoli 게이트 수와 큐비트 수를 모두 유의미하게 줄였습니다.

가장 두드러진 사례는 타원곡선(elliptic curve) 암호 계산에 쓰이는 점 덧셈 회로입니다. Claude는 분기 정보를 저장하지 않는 새로운 방식으로 divsteps 연산을 역방향으로 구현해, 기존에 발표된 가장 간결한 설계보다 게이트 수를 17배 줄였습니다. 다만 그 대가로 큐비트 수는 약 12% 늘었습니다. 또 다른 과제인 DQI 디코더 회로에서는 게이트 수를 약 12배 줄이는 결과를 냈습니다. 8개 과제 가운데 유일하게 기존 최고 기록을 명확히 넘어서지 못한 것은 소수체(prime field) 모듈러 역원 계산 과제였는데, 이 경우에도 Claude는 Toffoli 게이트 수와 큐비트 수 사이의 트레이드오프를 다르게 가져가는 새로운 가역 아키텍처를 찾아냈습니다.

이 결과는 Gu, Kemeny, Yelin, Lukin이 공동 저자로 올린 논문 "Discovering state-of-the-art quantum circuits with large language models"에 정리되어 있습니다.

## 의미와 한계

이번 작업은 언어모델이 CUDA 커널이나 컴파일러 같은 고전적 소프트웨어 영역에서 보여 준 최적화 능력을, 양자 하드웨어를 위한 회로 설계라는 훨씬 전문적인 영역으로 확장한 사례입니다. 사람의 지속적인 개입 없이 평가자와의 피드백 루프만으로 7개 과제에서 발표된 최고 기록을 넘어섰다는 점은, 이런 자율 탐색 방식이 좁고 정형화된 공학 하위 분야에서 실질적인 성과를 낼 수 있음을 보여줍니다.

다만 한계도 뚜렷합니다. 이번 결과는 완전한 양자 알고리즘이 아니라 그 알고리즘을 구성하는 기본 연산 단위에 대한 최적화이며, 8개 과제 중 1개는 기존 기록을 명확히 넘지 못했습니다. Anthropic은 또한 Claude가 초반에 보수적인 태도를 보여, 명백한 개선을 거듭 의심하거나 이미 충분히 검증된 결과를 두세 차례 더 재확인하고 익숙한 접근법을 선호하는 경향이 있었다고 밝혔습니다. 연구팀은 이를 완화하기 위해 여러 설계 방식을 강제로 병렬 탐색하게 했다고 설명했는데, 이는 이런 자율 설계 루프를 다른 영역에 적용할 때도 비슷한 보정 장치가 필요할 수 있음을 시사합니다.

## 한 줄 정리

Anthropic은 Claude가 최소한의 인간 개입으로 설계한 양자 회로가 8개 과제 중 7개에서 기존 최고 설계를 넘어섰다고 공개했습니다.
