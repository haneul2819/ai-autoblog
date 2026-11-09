---
title: "DARPA, 해킹 아닌 시장 설계 결함을 AI로 찾는 IMR 프로그램 공고"
description: "DARPA가 해킹이 아닌 시장 규칙 자체의 설계 결함을 찾아 고치는 연구 프로그램 IMR을 공고했습니다. LLM으로 규제 문서를 모델로 바꿔 취약점을 찾습니다."
date: 2026-11-09
tags: ["정책", "보안", "인프라", "안전성"]
sources:
  - title: "DARPA's Intrinsic Market Resilience program wants AI to find design flaws adversaries could use to crash markets"
    url: "https://mlq.ai/news/darpas-intrinsic-market-resilience-program-wants-ai-to-find-design-flaws-adversaries-could-use-to-crash-markets/"
  - title: "DARPA wants AI to find hidden flaws in digital markets that adversaries could exploit to wreak economic havoc"
    url: "https://www.yahoo.com/news/us/articles/darpa-wants-ai-hidden-flaws-140001995.html"
  - title: "Future Program: Intrinsic Market Resilience (IMR)"
    url: "https://sam.gov/opp/16977cc39ea44eb6b9313bcd068f62d6/view"
  - title: "Intrinsic Market Resilience (IMR), Matthew Wilding, PhD"
    url: "https://www.darpa.mil/sites/default/files/attachment/2026-10/darpa-program-imr-proposers-day-slides.pdf"
---

## 왜 지금 이 주제인가

미국 국방고등연구계획국(DARPA)이 11월 8일 새 연구 프로그램 Intrinsic Market Resilience(IMR)를 공고했습니다. 주식·채권·에너지·클라우드 컴퓨팅 시장의 운영 규칙에 숨은 설계 결함을 인공지능으로 찾아 고치는 것이 목표입니다. 기존 보안 연구가 시스템 침입과 데이터 탈취 방지에 집중했다면, IMR은 해킹 없이 시장 규칙의 허점만으로도 경제 혼란을 일으킬 수 있다는 문제의식에서 출발합니다. 규제 문서 같은 비정형 텍스트를 다루는 대규모 언어모델의 능력을 국가 핵심 인프라 방어에 쓰려는 시도가 구체적인 공고로 이어졌다는 점에서 살펴볼 만합니다.

## 핵심 내용

IMR은 DARPA 정보처리기술국(Information Processing Techniques Office) 소속 프로그램 매니저 Matthew Wilding이 주도합니다. 그는 Business Insider 인터뷰에서 공격자가 시스템을 뚫지 않고도 시장의 공개된 규칙과 인터페이스를 악용해 경제에 타격을 줄 수 있다고 설명했습니다. 솔리시테이션 식별번호는 DARPA-PS-26-138이며, 공고는 SAM.gov를 통해 공개됐고 제안서 제출 마감은 2026년 12월 7일, 문의처는 IMR@darpa.mil입니다.

핵심 방법론은 대규모 언어모델로 규제 공시, 기술 사양서, 거래소 운영 규정 같은 비정형 문서를 컴퓨터가 분석 가능한 형식적 시장 모델로 바꾸는 것입니다. 이를 위해 시장의 운영과 조정 방식을 정밀하게 기술하는 형식 표기법을 새로 개발합니다. 모델에는 주문 처리 로직, 체결 타이밍, 거래소 간 통신 방식까지 포함됩니다. 이렇게 만든 모델로 시장이 복원력 기준을 충족하는지 검증하고, 미달하면 실제로 어떤 방식의 악용이 가능한지 구체적인 사례를 생성합니다.

프로그램은 세 기술 영역(TA)으로 나뉩니다. TA1은 시장 운영 모델을 구축하고 복원력에 대한 가설을 검증합니다. TA2는 결함에 대한 수리 방안을 설계하고, 그 수리가 시장의 정상 작동에 미치는 영향을 함께 확인합니다. TA3는 모델에 결함을 의도적으로 심어 넣고 독립된 평가팀이 이를 탐지할 수 있는지 검증합니다. 전체 3단계, 총 32개월로 2027~2029 회계연도에 걸쳐 진행됩니다.

DARPA는 필요성의 근거로 두 역사적 사례를 듭니다. 2000~2001년 캘리포니아 에너지 위기는 공공정책연구소(PPIC) 추산 약 400억~450억 달러의 손실을 냈는데, 발전·거래 업체들이 시장 규칙의 허점을 이용해 가격을 조작한 것이 주요 원인이었습니다. 2010년 플래시 크래시는 미국 증시가 단 몇 분 만에 급락한 사건으로, 조사에서 한 거래자의 조작성 거래 관행이 부분적 원인으로 지목됐습니다. 두 사례 모두 해킹이 아니라 시장 메커니즘 자체의 허점에서 비롯됐다는 점을 DARPA는 프로그램 추진의 근거로 제시합니다.

## 의미와 한계

IMR은 대규모 언어모델을 코드 취약점 탐지가 아니라 경제 제도의 규칙 수준 결함을 찾는 데 적용한다는 점에서 기존 AI 보안 연구와 결이 다릅니다. 비정형 문서를 LLM으로 형식 모델화하고, 그 위에서 전통적인 정형 검증(formal verification) 기법으로 결함을 증명하는 결합 방식은 금융뿐 아니라 다른 규제 기반 인프라에도 적용될 여지가 있습니다.

다만 이 공고는 아직 제안서를 모집하는 단계로, 실제로 어떤 기관이 참여하고 어떤 결과를 낼지는 확인되지 않았습니다. DARPA는 프로그램 예산이나 수상 건수도 공개하지 않았습니다. 규제 문서처럼 모호하고 해석의 여지가 있는 텍스트를 LLM이 얼마나 정확하게 형식 모델로 옮길 수 있을지도 검증되지 않은 가정입니다. 또한 시장의 설계 결함을 찾아내는 도구는 그 자체로 결함을 악용하는 도구가 될 수 있다는 이중 용도 문제를 안고 있는데, 이는 공고문이 직접 다루지 않은 부분으로 추측의 영역입니다. 32개월이라는 연구 기간을 감안하면 실제 시장에 적용 가능한 결과물이 나오기까지는 적지 않은 시간이 걸릴 것으로 보입니다.

## 한 줄 정리

DARPA가 해킹이 아닌 시장 규칙 자체의 설계 결함을 AI로 찾아 고치는 연구 프로그램 IMR을 공고했습니다.
