---
title: "스탠퍼드, 논문을 실행 가능한 MCP 에이전트로 바꾸는 Paper2Agent 발표"
description: "스탠퍼드 연구팀이 논문과 코드를 검증된 MCP 에이전트로 자동 변환하는 Paper2Agent를 네이처에 발표했습니다. 생물학 논문 100편 중 74편 변환에 성공했습니다."
date: 2026-09-18
tags: ["에이전트", "MCP", "오픈소스", "평가", "벤치마크"]
sources:
  - title: "Paper2Agent: Reimagining Research Papers As Interactive and Reliable AI Agents"
    url: "https://arxiv.org/abs/2509.06917"
  - title: "Stanford Researchers Release Paper2Agent: Turning Research Papers Into AI Agents That Reproduce Results and Run on New Data"
    url: "https://www.marktechpost.com/2026/09/16/stanford-researchers-release-paper2agent-turning-research-papers-into-ai-agents-that-reproduce-results-and-run-on-new-data/"
  - title: "Paper2Agent in Nature: Research Papers Become Working Tools"
    url: "https://www.digitalapplied.com/blog/paper2agent-nature-research-paper-to-mcp-agent"
  - title: "Reimagining Research Papers as Interactive and Reliable AI Agents (New Journal Article)"
    url: "https://www.infodocket.com/2026/09/16/reimagining-research-papers-as-interactive-and-reliable-ai-agents-new-journal-article/"
---

## 왜 지금 이 주제인가

스탠퍼드대학교 제임스 조우(James Zou) 연구팀이 논문과 코드를 실행 가능한 AI 에이전트로 자동 변환하는 프레임워크 Paper2Agent를 2026년 9월 16일 네이처(Nature)에 발표했습니다. 논문에 딸린 코드가 재현되지 않거나 방치되는 문제는 오랫동안 과학계의 골칫거리였습니다. Paper2Agent는 논문과 코드 저장소를 통째로 분석해 모델 컨텍스트 프로토콜(MCP, Model Context Protocol) 서버로 바꾸고, Claude Code 같은 에이전트가 자연어로 논문의 방법론을 그대로 실행하게 합니다. 논문이 읽는 대상에서 실행하는 대상으로 바뀐다는 주장을 생물학 논문 100편으로 검증했다는 점에서 살펴볼 만합니다.

## 핵심 내용

Paper2Agent는 여섯 단계로 동작합니다. 먼저 논문에 딸린 코드 저장소를 내려받아 격리된 가상환경을 구축하고, 저장소 안의 튜토리얼을 색인화합니다. 이어 각 튜토리얼을 실제로 실행해 참조 출력을 기록한 뒤, 이 실행 과정을 MCP 도구(실행 가능한 함수)로 변환하고 검증합니다. 검증을 통과한 도구만 MCP 서버로 조립되는데, 이 검증 단계가 핵심입니다. 도구가 한 번 검증되면 고정되기 때문에, 에이전트가 코드를 그때그때 새로 생성하면서 발생하는 이른바 "코드 환각" 위험을 줄인다는 것이 연구팀의 설명입니다. 완성된 MCP 서버는 실행 가능한 도구(tool), 원고와 데이터셋 같은 리소스(resource), 여러 단계로 이어지는 워크플로우를 담은 프롬프트(prompt) 세 요소로 구성됩니다.

연구팀은 세 가지 사례로 이 파이프라인을 검증했습니다. 유전체 변이 해석 모델 AlphaGenome을 대상으로는 45분, 14달러의 비용으로 22개의 도구를 생성했고, 튜토리얼에 나온 질문에 대한 정확도는 98.7퍼센트(기준 모델 82.7퍼센트), 새로운 질문에 대한 정확도는 100.0퍼센트(기준 모델 78.7퍼센트)를 기록했습니다. 단일세포 분석 도구 Scanpy는 같은 45분, 13달러로 7개 도구를 만들었고, 세포·유전자 수 계산 등에서 사람 연구자의 결과와 일치했습니다. 공간 전사체 분석 도구 TISSUE 사례에서는 ADHD 위험과 연관된 새로운 스플라이싱 변이체를 찾아내는 데 이 에이전트가 쓰였습니다.

규모를 키운 실험도 있습니다. 생물학 분야 논문 100편에 파이프라인을 그대로 돌린 결과 74편이 에이전트로 변환됐고, 599개의 도구 후보 가운데 593개가 검증을 통과했습니다. 300개 질문으로 구성한 벤치마크에서는 91.2퍼센트의 정확도를 기록해 기준 모델의 80.3퍼센트를 앞섰습니다. 나머지 26편은 코드나 데이터가 빠져 있거나 의존성 문제로 변환에 실패했는데, 연구팀은 이 실패 사례를 그대로 공개해 어떤 저장소 구조에서 변환이 막히는지 짚었습니다. 코드는 MIT 라이선스로 공개됐고, 사전 구축된 서버는 Hugging Face Spaces에서, 호스팅 버전은 별도 사이트 paper2agent.ai에서 받아 볼 수 있습니다. 연구팀은 이 방식을 생물정보학 도구 세 종에 먼저 적용했지만, 논문과 코드가 함께 공개되는 관행을 따르는 분야라면 원칙적으로 같은 파이프라인을 적용할 수 있다고 밝혔습니다.

## 의미와 한계

Paper2Agent가 보여준 것은 논문에 딸린 코드를 사람이 일일이 설치하고 재현하지 않아도, 검증된 도구 형태로 곧장 불러 쓸 수 있다는 가능성입니다. MCP라는 공통 규격 위에서 논문 하나하나가 재사용 가능한 서비스가 된다면, 후속 연구자가 방법론을 확인하고 새 데이터에 적용하는 문턱이 크게 낮아집니다. 코드가 실행 시점에 새로 생성되지 않고 사전에 검증·고정된다는 점도 에이전트의 고질적 문제인 코드 환각을 줄이는 설계로 눈여겨볼 만합니다.

다만 한계도 뚜렷합니다. 검증한 100편 중 26편은 변환 자체가 실패했는데, 이는 공개된 코드와 데이터의 정합성이 여전히 들쭉날쭉하다는 뜻입니다. 지금까지 사례가 생물정보학 분야에 몰려 있어, 코드가 없거나 재현 관행이 약한 다른 분야에서도 같은 성공률이 나올지는 확인되지 않았습니다. 쿼리당 비용과 소요 시간(사례별로 13~14달러, 45분)도 대규모로 적용하기엔 아직 가볍지 않은 수준입니다. 검증을 통과한 도구가 논문 코드의 실행 재현성을 보장할 뿐, 논문의 결론이나 과학적 타당성까지 보증하는 것은 아니라는 점도 구분해서 봐야 합니다.

## 한 줄 정리

스탠퍼드 연구팀이 논문과 코드를 검증된 MCP 에이전트로 자동 변환하는 Paper2Agent를 네이처에 발표했습니다.
