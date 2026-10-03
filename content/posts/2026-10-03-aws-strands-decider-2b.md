---
title: "AWS, 텍스트 생성 없이 선택지만 고르는 결정 모델 공개"
description: "AWS 산하 Strands Labs가 문장을 쓰지 않고 선택지만 고르는 오픈소스 결정 모델 Strands Decider 2B를 공개했습니다."
date: 2026-10-03
tags: ["에이전트", "오픈소스", "추론비용", "인프라", "Qwen"]
sources:
  - title: "strands-labs/strands-decider (GitHub)"
    url: "https://github.com/strands-labs/strands-decider"
  - title: "StrandsAgents/strands-decider-2B-hobson-v19 (Hugging Face)"
    url: "https://huggingface.co/StrandsAgents/strands-decider-2B-hobson-v19"
  - title: "AWS Strands Labs Releases Strands Decider 2B: An Open Source Decision Model That Picks Options in About 115 ms"
    url: "https://www.marktechpost.com/2026/10/01/aws-strands-labs-releases-strands-decider-2b/"
  - title: "AWS launches a local answer to TypeSafe's Jev decision model"
    url: "https://thenewstack.io/aws-strands-decider-model/"
---

## 왜 지금 이 주제인가

언어모델 기반 에이전트는 도구를 고르거나 다음 단계를 판단할 때도 매번 문장을 생성합니다. 이 과정에서 적지 않은 지연과 토큰 비용이 듭니다. 스타트업 TypeSafe가 내놓은 비공개 모델 Jev가 "텍스트를 한 글자도 쓰지 않는 결정 모델"이라는 범주를 만든 뒤, 2026년 10월 1일 아마존웹서비스(AWS) 산하 연구 조직 Strands Labs가 같은 방식의 오픈소스 모델 Strands Decider 2B를 공개했습니다. 비공개 API로만 쓸 수 있던 결정 모델을 가중치와 학습 코드까지 그대로 내려받아 직접 돌려볼 수 있게 됐다는 점에서 살펴볼 만합니다.

## 핵심 내용

Strands Decider 2B는 질문에 글로 답하는 대신 미리 정해진 선택지 중 하나를 고르거나, 예/아니오 확률, 혹은 순서형 점수를 반환합니다. 지원하는 질문 유형은 세 가지로, 예/아니오를 묻는 noul, 여러 선택지 중 고르는 choice, 순서가 있는 척도로 매기는 score입니다.

구조는 오픈웨이트 모델 Qwen3.5-2B-Base(중국 알리바바가 공개한 소형 언어모델)를 바탕으로, 언어 생성을 담당하는 헤드를 떼어내고 약 100만 개 파라미터 규모의 포인터 헤드로 바꿔 끼운 형태입니다. 입력 문장의 answer 토큰 위치에서 나온 은닉 상태와 각 선택지의 마지막 토큰 위치 은닉 상태를 비교해 점수를 매기는 방식이어서, 디코딩 루프 없이 포워드 패스 한 번으로 답을 냅니다. 학습은 rank-16 LoRA(원본 모델은 그대로 두고 적은 수의 추가 가중치만 학습하는 기법) 어댑터로 이뤄졌고, 포인터 헤드만 fp32로 돌립니다. 전체 파라미터는 19억 개입니다. 학습 데이터로는 GLUE, PAWS, BoolQ 같은 공개 벤치마크 데이터셋에 ContractNLI, MuSiQue, 합성 데이터, Qwen3.5-4B가 생성한 출력을 섞어 썼습니다.

성능은 같은 범주의 모델을 겨루는 JevBench v1 공개 세트로 측정했습니다. 전체 231개 과제 중 167개를 맞혀 정확도 0.723을 기록했고, 난이도별로는 쉬움 1.000, 표준 0.875, 어려움 0.505였습니다. 확신도 보정 정도를 가리키는 예상보정오류(ECE)는 0.052, 브라이어 점수는 0.342입니다. 응답 속도는 RTX 3090에서 중앙값 115밀리초, p95 기준 299밀리초이고, Apple M3 Pro에서는 300토큰 이하 입력 기준 중앙값 153밀리초입니다.

공개 범위는 가중치, 코드, 학습 레시피, 데이터 목록까지를 모두 포함하며 라이선스는 아파치 2.0입니다. 모델은 허깅페이스의 StrandsAgents/strands-decider-2B-hobson-v19에 올라와 있고, pip install strands-decider 한 줄로 설치해 명령줄 도구나 로컬 HTTP 서버로 바로 쓸 수 있습니다. CPU, 일반 소비자용 GPU, 애플 실리콘 맥에서도 돌아갑니다.

## 의미와 한계

이번 공개로 결정 모델이라는 범주는 TypeSafe의 비공개 Jev, Cloudflare의 Clef에 이어 오픈웨이트 선택지를 갖추게 됐습니다. 모델 라우팅이나 도구 선택, 가드레일 판단처럼 에이전트가 수없이 반복하는 짧은 판단을 거대 언어모델 대신 처리하면 지연과 비용을 함께 줄일 수 있다는 것이 핵심 주장입니다.

다만 JevBench 기준으로 어려운 난이도 과제의 정확도는 0.505에 그쳐, 절반 가까운 판단이 빗나갑니다. 비공개 모델인 Jev 1.13.0과 같은 조건에서 직접 비교한 공식 수치는 아직 공개되지 않아, AWS가 밝힌 성능이 실제 상용 결정 모델과 얼마나 차이 나는지는 제3자의 재현 결과를 더 지켜봐야 합니다. 또 포인터 헤드가 비교하는 것은 어디까지나 모델이 학습한 토큰 표현이므로, 선택지 문구가 모호하거나 학습 분포에서 벗어난 영역에서는 판단 근거가 약해질 수 있습니다. 이 부분은 아직 검증되지 않은 추정입니다.

## 한 줄 정리

AWS가 텍스트를 쓰지 않고 선택지만 고르는 오픈소스 결정 모델 Strands Decider 2B를 공개하며 에이전트의 반복 판단을 가볍게 처리하는 방법을 제시했습니다.
