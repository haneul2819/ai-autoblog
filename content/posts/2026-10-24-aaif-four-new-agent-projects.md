---
title: "에이전틱 AI 표준화 재단 AAIF, 신규 프로젝트 4개 추가해 10개로"
description: "Linux Foundation 산하 AAIF가 Anthropic, OpenAI, Hugging Face, Alibaba가 각각 기여한 프로젝트를 추가해 출범 1년 만에 10개 프로젝트를 보유하게 됐습니다."
date: 2026-10-24
tags: ["에이전트", "오픈소스", "Anthropic", "OpenAI", "인프라"]
sources:
  - title: "Agentic AI Foundation Announces Four New Projects: Agent Skills, Open Responses, OpenEnv, and OpenSandbox"
    url: "https://www.linuxfoundation.org/press/agentic-ai-foundation-announces-four-new-projects-agent-skills-open-responses-openenv-and-opensandbox"
  - title: "Agentic AI Foundation Announces Four New Projects: Agent Skills, Open Responses, OpenEnv, and OpenSandbox"
    url: "https://aaif.io/news/agentic-ai-foundation-announces-four-new-projects"
  - title: "The Agent Stack Just Got Four New Open Building Blocks"
    url: "https://theagenticstack.substack.com/p/the-agent-stack-just-got-four-new"
---

## 왜 지금 이 주제인가

Linux Foundation 산하 Agentic AI Foundation(AAIF)이 2026년 10월 22일 미국 산호세에서 열린 AGNTCon·MCPCon North America 행사에서 Agent Skills, Open Responses, OpenEnv, OpenSandbox 네 프로젝트를 새 소속 프로젝트로 받아들였다고 발표했습니다. 각각 Anthropic, OpenAI, Hugging Face, Alibaba가 기여한 것으로, 그동안 각 회사가 따로 밀던 에이전트 관련 규격들이 한 중립 재단 아래로 모이는 흐름을 보여줍니다. 모델 경쟁이 치열한 와중에도 그 위에서 돌아가는 에이전트 생태계의 배관은 여러 회사가 공동으로 표준화하기로 합의한 셈입니다.

## 핵심 내용

AAIF는 2025년 12월 Model Context Protocol(MCP, Anthropic), goose(Block), AGENTS.md(OpenAI) 세 프로젝트로 출범했습니다. 이후 Agent2Agent(A2A) 프로토콜, Agent Router, agentgateway가 더해져 여섯 개로 늘었고, 이번 발표로 네 프로젝트가 추가돼 총 열 개가 됐습니다. AAIF CTO이자 공동 창립자인 Manik Surtani는 "1년 전 AAIF는 세 개 프로젝트와 에이전틱 AI가 번성하려면 중립적인 거처가 필요하다는 믿음으로 출발했다. 오늘 우리는 열 개를 호스팅한다"고 밝혔습니다.

네 프로젝트의 역할은 각기 다릅니다.

- **Agent Skills**(Anthropic 기여): 에이전트에게 새 기능과 도메인 지식을 주는 개방형 포맷입니다. 이름과 설명, 지시사항을 담은 `SKILL.md` 파일에 스크립트와 템플릿을 함께 묶어, 에이전트가 필요할 때 불러 쓸 수 있게 패키징합니다.
- **Open Responses**(OpenAI 기여): OpenAI의 Responses API를 기반으로 한 사양으로, 여러 모델 제공자 사이에서 쓸 수 있는 공통 요청·응답 스키마와 스트리밍 이벤트, 도구 호출 패턴을 정의합니다. 개발자가 요청과 출력 형식을 한 번만 작성하면 제공자를 바꿔도 변환 작업을 거의 없이 돌릴 수 있도록 하는 것이 목표입니다.
- **OpenEnv**(Hugging Face 기여): 강화학습 환경을 만들고 공유하기 위한 개방형 프레임워크입니다. 컨테이너화된 서비스로 에이전트 인터페이스와 MCP, 그리고 학습 라이브러리들이 쓰는 Gym 훈련 프로토콜을 함께 노출합니다.
- **OpenSandbox**(Alibaba 기여): AI 애플리케이션이 안전하게 실행될 격리 환경을 제공하는 범용 샌드박스 플랫폼입니다. 다중 언어 SDK와 통합 샌드박스 API를 갖추고 Docker, Kubernetes 런타임에서 동작합니다.

네 프로젝트를 합치면 에이전트의 능력 확장(Agent Skills), 모델 호출 인터페이스(Open Responses), 학습 환경(OpenEnv), 실행 격리(OpenSandbox)까지 에이전트 스택의 주요 단면을 각각 커버하는 구성입니다.

## 의미와 한계

이번 발표가 눈에 띄는 이유는 경쟁 관계인 네 회사가 각자 만든 프로젝트를 자사 소유로 남기지 않고 동시에 중립 거버넌스로 넘겼다는 점입니다. 한 회사가 표준을 독점하면 다른 회사의 에이전트나 도구가 그 표준에 종속되기 쉬운데, Linux Foundation 산하로 옮기면 거버넌스와 로드맵을 여러 당사자가 함께 결정하게 됩니다. 과거 MCP가 사실상 업계 표준으로 자리 잡았던 사례를 감안하면, 이번에 합류한 네 프로젝트도 비슷한 경로를 밟을 가능성이 있습니다.

다만 재단에 소속됐다는 사실 자체가 실제 채택을 보장하지는 않습니다. 사양이 발표된 지 며칠밖에 되지 않아 각 프로젝트가 실제 production 환경에서 얼마나 쓰이고 있는지, 혹은 다른 사양들과 경쟁 관계에 있는 유사 프로젝트들을 밀어낼지는 아직 확인되지 않았습니다. 네 회사가 각각 하나씩 프로젝트를 올렸다는 구조 자체도, 경쟁사 프로젝트를 서로 수용하기보다는 자사 설계를 표준으로 굳히려는 움직임일 수 있다는 해석도 가능합니다.

## 한 줄 정리

Anthropic, OpenAI, Hugging Face, Alibaba가 각자의 에이전트 관련 프로젝트를 Linux Foundation 산하 AAIF로 넘기면서, 출범 1년 만에 재단 소속 프로젝트가 10개로 늘었습니다.
