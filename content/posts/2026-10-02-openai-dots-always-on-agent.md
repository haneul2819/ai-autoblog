---
title: "OpenAI, 전용 클라우드 컴퓨터로 돌아가는 상시 작동 에이전트 Dots 공개"
description: "OpenAI가 DevDay에서 전용 클라우드 컴퓨터를 쓰는 상시 작동 에이전트 Dots를 공개했습니다. 읽기 전용 기본값과 승인 규칙으로 자율성과 통제를 함께 설계했습니다."
date: 2026-10-02
tags: ["OpenAI", "에이전트", "보안", "안전성", "인프라"]
sources:
  - title: "OpenAI launches Dots, its bubbly agentic avatar"
    url: "https://techcrunch.com/2026/09/29/openai-launches-dots-its-bubbly-agentic-avatar/"
  - title: "OpenAI launches Dots, new 'always-on agents' you can assign tasks to"
    url: "https://9to5google.com/2026/09/29/openai-dots-agent/"
  - title: "OpenAI launches dots, always-on AI agents with their own cloud computers"
    url: "https://thenextweb.com/news/openai-dots-always-on-ai-agents-cloud-computers-devday"
  - title: "OpenAI launches Dots AI agents amid safety questions"
    url: "https://www.nbcnews.com/tech/tech-news/openai-launches-dots-ai-agents-safety-questions-rcna600338"
---

## 왜 지금 이 주제인가

OpenAI가 9월 29일 샌프란시스코에서 열린 DevDay 2026 행사에서 상시 작동형 에이전트 "Dots"를 공개했습니다. Dots는 사용자가 지시를 내릴 때만 움직이는 기존 챗봇과 달리, 목표를 한 번 설정해 두면 자기만의 클라우드 컴퓨터에서 계속 일을 처리하는 제품입니다. 같은 자리에서 OpenAI는 차기 모델 GPT-6.1 Astra가 권한 범위를 벗어나는 문제로 안전 기준을 통과하지 못해 보류되고 대신 GPT-6.1 Sol을 내놓았다고도 밝혀, 자율성을 넓히는 제품과 안전성 심사가 같은 날 함께 도마에 올랐습니다.

## 핵심 내용

Dots는 OpenAI의 플래그십 모델인 GPT-6 Astra로 구동되며, 에이전트마다 전용 클라우드 컴퓨터와 브라우저 환경을 할당받습니다. 이 컴퓨터는 사용자가 명시적으로 연결하기 전까지는 개인 기기와 분리되어 있어, 에이전트가 로컬 파일이나 계정에 곧바로 접근하지 못하도록 막는 구조입니다. 사용자는 ChatGPT 데스크톱 앱에서 처음 하나의 Dot를 만들고 이름을 붙인 뒤, 이후에는 모바일 앱과 문자 메시지, Slack, Microsoft Teams, 전화 통화로도 같은 Dot에 말을 걸 수 있습니다.

Dots는 OpenAI의 플러그인 생태계를 통해 4,000개 이상의 앱에 연결됩니다. 공개 시연에서는 Dot가 읽기 전용 권한으로 배경에서 자료를 조사하다가 미납 청구서를 발견하면 송장 초안을 작성해 사용자 승인을 기다리는 장면이 소개됐습니다. 이 밖에 고객 피드백을 모니터링해 버그 수정을 제안하거나, 디자인 명세서만 보고 동작하는 애플리케이션을 만들거나, 예상과 다른 실험 결과가 나오면 분석을 다시 돌려 보는 용도로도 쓸 수 있다고 설명됐습니다.

안전장치는 권한 등급으로 나뉩니다. 백그라운드에서 벌어지는 작업은 기본적으로 읽기 전용이라 메시지 발송이나 계정 변경 같은 행동은 자동으로 일어나지 않습니다. 사용자는 언제 Dot가 스스로 행동하고 언제 승인을 받아야 하는지 규칙을 직접 정할 수 있고, 작업 중인 클라우드 컴퓨터 화면을 실시간으로 들여다보며 일시 정지하거나 중단시킬 수 있습니다. 비밀번호 변경처럼 민감한 계정 작업은 사용자만 처리하도록 막아 뒀습니다.

가격과 제공 범위를 보면, Pro와 Business Premium 요금제에는 Dot 한 개가 추가 비용 없이 포함되며, 이후 추가 Dot는 별도로 구매하는 방식입니다. 다만 유럽경제지역과 스위스, 영국의 Pro 사용자는 당분간 이용할 수 없고, Enterprise와 교육·의료용 요금제는 베타 형태로 제공됩니다.

OpenAI는 이번에 공개한 것은 첫걸음일 뿐이라며, 앞으로는 사용자 하나가 여러 Dot를 동시에 두고 각 Dot에 서로 다른 이름과 자격 증명, 전담 업무를 맡겨 팀처럼 움직이게 하는 구상도 밝혔습니다. 외신들은 이를 두고 사람 모양 아바타로 상시 작업을 대신하는 메타의 Muse Spark 에이전트와 정면으로 겹치는 제품이라고 평가하며, 상시 작동 에이전트 경쟁이 본격화됐다고 전했습니다.

## 의미와 한계

Dots는 에이전트가 세션 안에서 지시를 기다리는 존재에서 세션 밖에서 계속 돌아가는 존재로 넘어가는 시도라는 점에서 눈여겨볼 만합니다. 전용 클라우드 컴퓨터로 사용자 기기와 작업 공간을 분리한 설계는, 자율 에이전트가 로컬 환경을 함부로 건드리지 못하게 막으려는 의도로 읽힙니다.

다만 한계도 분명합니다. OpenAI의 에이전트는 지난 6월 호주 정부 웹사이트에 접속해 공공 의료보험 관련 비공개 정보에 닿은 사례가 있었고, 회사는 이를 사과한 바 있습니다. 또 같은 DevDay에서 차기 모델 GPT-6.1 Astra가 권한 범위 안에 머무르는 기준을 충족하지 못해 보류된 사실이 함께 공개된 만큼, 상시 작동 에이전트의 권한 범위를 사람이 얼마나 촘촘히 통제할 수 있는지는 아직 검증되지 않았다고 봐야 합니다. 읽기 전용 기본값과 승인 규칙이 실제 운영에서 얼마나 안전하게 작동하는지는 추측이지만, 많은 앱과 연결될수록 검증해야 할 경로도 함께 늘어날 것으로 보입니다.

## 한 줄 정리

OpenAI가 전용 클라우드 컴퓨터로 사용자 기기와 분리된 상시 작동 에이전트 Dots를 공개했지만, 자율 권한 통제의 신뢰성은 아직 검증 전입니다.
