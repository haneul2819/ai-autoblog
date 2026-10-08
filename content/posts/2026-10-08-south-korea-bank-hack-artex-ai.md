---
title: "한국 은행권 해킹에 AI 펜테스트 도구 ARTEX와 Claude Code 흔적 확인"
description: "크라우드스트라이크가 9월 말부터 10월 초 한국 금융기관을 겨냥한 해킹에서 오픈소스 AI 에이전트 도구 ARTEX와 Claude Code 세션 흔적을 확인했다고 발표했습니다."
date: 2026-10-08
tags: ["보안", "에이전트", "산업동향", "정책", "Claude"]
sources:
  - title: "Unknown Threat Actor Uses ARTEX to Target South Korean Finance"
    url: "https://www.crowdstrike.com/en-us/blog/unknown-threat-actor-uses-artex-to-target-south-korean-finance/"
  - title: "Chinese-speaking hacker possibly linked to AI-driven attacks on S. Korean banks: report"
    url: "https://www.koreatimes.co.kr/southkorea/law-crime/20261008/chinese-speaking-hacker-possibly-linked-to-ai-driven-attacks-on-s-korean-banks-report"
  - title: "AI-driven hacks on banks leave customers fearing their data is fair game"
    url: "https://www.koreajoongangdaily.com/korea/aidriven-hacks-on-banks-leave-customers-fearing-their-data-is-fair-game/12905416"
  - title: "South Korea probes bank breaches amid suspected AI-powered attacks"
    url: "https://www.bleepingcomputer.com/news/security/south-korea-probes-bank-breaches-amid-suspected-ai-powered-attacks/"
---

## 왜 지금 이 주제인가

9월 말부터 10월 초 사이 신한은행, 국민은행, 하나은행을 포함해 한국 금융기관 최소 일곱 곳에서 고객 정보 유출이 잇따라 보고됐습니다. 이재명 대통령은 10월 6일 이 공격에 AI가 쓰였을 가능성을 언급했고, 다음 날 보안업체 크라우드스트라이크(CrowdStrike)가 공격자가 남긴 노출된 서버 디렉터리를 분석한 보고서를 공개했습니다. 보안 업계가 AI 연관성을 추정으로만 말하던 다른 사건들과 달리, 이번에는 공격자가 실제로 주고받은 AI 세션 기록이 그대로 드러나 구체적인 사용 방식까지 확인됐다는 점에서 눈여겨볼 만합니다.

## 핵심 내용

크라우드스트라이크는 10월 7일 공개한 보고서에서 공격자가 통제하던 서버의 열린 디렉터리를 통해 Claude Code 세션 기록, ARTEX 설정 파일, Claude 메모리 파일을 직접 확인했다고 밝혔습니다.

**ARTEX란 무엇인가** ARTEX는 중국에서 개발돼 GitHub에 공개된 오픈소스 에이전트형 침투 테스트 도구입니다. 정보 수집부터 취약점 탐색, 공격 경로 계획, 보안 도구 실행까지 자동화하도록 만들어졌습니다.

**어떤 모델을 어떻게 썼는가** 공격자는 ARTEX의 주 LLM 백엔드로 DeepSeek의 v4.1-flash를 사용했고, 자싱AI(Zhipu AI)의 GLM-5.3과 xAI의 Grok 4.6을 보조로 썼습니다. 취약점 탐색과 공격 경로 설계라는 핵심 작업은 오픈소스 모델이 맡은 반면, Anthropic의 Claude Code는 침투 자체가 아니라 문서 작성, 그리고 유출된 한국 데이터를 거래하는 마켓플레이스와 텔레그램 그룹을 찾는 주변 조사 작업에 쓰였습니다. 이런 역할 분담은 상용 모델의 안전장치를 피해 가면서도 그 편의성은 그대로 가져다 쓰려는 시도로 읽힙니다.

**침해 대상과 인프라** 확인된 피해 사례 중에는 한 은행의 금융중개인용 대출 조회 서비스, 다른 은행의 직원용 모바일 업무 지원 시스템이 포함돼 있습니다. 공격자는 홍콩 소재 서버를 주 인프라로, 별도 IP(38.244.50.120)를 ARTEX 인스턴스 구동용으로 나눠 운용했습니다. 지금까지 신한은행이 약 25,700명, 예가람저축은행이 약 40,000명 규모의 고객 정보 유출을 신고했고, 그 외 금융사들도 유출 사실을 밝힌 상태입니다.

**공격자 윤곽** 노출된 Claude Code 세션에는 공격자가 보안 연구원 행세를 하기 위해 허위 경력서 작성을 요청한 기록이 있었고, 여기서 나이(26세, 2007년생), 거주지(중국 광둥성 마오밍), 출신 학교(화남이공대학교) 등 신상 정보가 드러났습니다. 크라우드스트라이크는 이를 근거로 "중국어 사용자일 가능성이 높고 금전적 동기를 가진 위협 행위자"라고 중간 신뢰도로 평가했으며, 특정 해킹 조직에 귀속시키지는 않았습니다.

## 의미와 한계

이번 사례가 보여주는 것은 공격자가 여러 상용·오픈소스 AI 모델을 역할별로 나눠 쓰는 방식입니다. 취약점 탐색과 공격 경로 설계는 오픈소스 에이전트 도구에 맡기고, 상용 코딩 어시스턴트는 문서 작업과 사후 처리에 쓰는 식의 분업이 실제로 일어나고 있다는 점이 확인됐습니다. 크라우드스트라이크도 "에이전트형 AI 도구를 전통적 공격 수단과 함께 쓰는 것은 적대자의 전술이 계속 진화하고 있다는 신호"라고 평가했습니다.

다만 이것이 AI가 해킹을 자동으로 수행했다는 뜻은 아닙니다. 한국 금융당국 관계자도 "AI가 쓰인 것은 맞지만 AI가 인간의 개입 없이 단독으로 움직인 것은 아니다"라고 선을 그었습니다. ARTEX와 각 LLM은 공격자가 직접 조작하는 보조 도구였고, 침투 경로를 자동으로 찾아낸 것도 아니었습니다. 또 이번 분석은 공격자가 서버 접근 통제를 소홀히 해 생긴 노출된 디렉터리에서 나온 자료에 기대고 있어, 공격자의 실제 신원이나 전체 피해 규모는 아직 확정되지 않았습니다. 한국 금융당국은 긴급회의를 열어 각 금융기관에 외부에서 접근 가능한 시스템을 점검하고, 불필요한 정보 노출을 줄이고, 위협 정보를 빠르게 공유하라고 지시했습니다.

## 한 줄 정리

한국 금융권 해킹에서 공격자가 오픈소스 AI 펜테스트 도구와 상용 코딩 어시스턴트를 역할별로 나눠 쓴 흔적이 보안업체 분석으로 확인됐습니다.
