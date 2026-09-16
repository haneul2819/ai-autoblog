---
title: "744B 에이전트 모델을 만들며 인간-AI 작업 분담을 기록한 Atria Dawn 공개"
description: "상하이 AI 연구소가 744B 파라미터 에이전트 모델 Atria Dawn Preview를 공개하며, 개발 과정에서 사람과 AI가 실제로 작업을 어떻게 나눴는지 정량 기록한 연구도 함께 내놓았습니다."
date: 2026-09-16
tags: ["오픈웨이트", "에이전트", "MoE", "벤치마크", "평가"]
sources:
  - title: "Atria Dawn: The Dawn of Agentic Superintelligence (arXiv:2609.15818)"
    url: "https://arxiv.org/abs/2609.15818"
  - title: "internlm/Atria-Dawn-Preview · Hugging Face"
    url: "https://huggingface.co/internlm/Atria-Dawn-Preview"
  - title: "Atria Dawn Preview: InternLM's 744B Agentic MoE Ships Quietly"
    url: "https://www.orcarouter.ai/blog/atria-dawn-preview-quiet-release"
---

## 왜 지금 이 주제인가

상하이 AI 연구소(Shanghai AI Laboratory) 산하 InternLM 팀이 9월 11일 Hugging Face에 744B 파라미터 규모의 에이전트 모델 Atria Dawn Preview 가중치를 올렸습니다. 보도자료도 논문도 없이 모델 카드만 딸린 조용한 공개였습니다. 사흘 뒤인 9월 14일에야 arXiv에 기술 논문이 올라왔는데, 여기에는 모델 스펙 외에 연구자 56명과 AI가 개발 과정에서 작업을 어떻게 나눴는지 정량 분석한 협업 연구가 함께 담겨 있었습니다.

## 핵심 내용

### 모델 구조

Atria Dawn Preview는 GLM-5.2를 기반으로 한 744B 파라미터 MoE(Mixture of Experts) 모델입니다. 아키텍처 이름은 GlmMoeDsaForCausalLM으로, GLM 계열의 DSA(희소 어텐션) 방식 MoE 구조를 물려받았습니다. 훈련 데이터는 "Verifiable Experience Pipeline"이라는 방식으로 구성했는데, 모든 훈련 과제를 실제 실행 환경에 연결해 모델이 상태를 관찰하고 도구를 호출해 결과물을 만들면 테스트·지표·파일 상태 같은 외부 신호로 검증하는 절차입니다. 가중치는 MIT 라이선스로 공개돼 상업적 이용에 제약이 없습니다. 연구팀은 실세계 연구·엔지니어링·디지털 업무를 다루는 16개 벤치마크에서 5개 최고 점수를 받았다고 밝혔는데, 심층 검색 과제 DeepSearchQA에서 96.0점, 웹 탐색 과제 BrowseComp에서 92.5점을 기록했습니다.

### 인간-AI 협업 기록

논문에서 더 눈여겨볼 부분은 이 모델 자체를 개발한 R&D 과정을 사례 연구로 분석한 대목입니다. 연구팀은 56명의 참가자가 남긴 769건의 작업 기록과 에이전트 로그를 분석했습니다. 응답이 명확한 739건 중 713건(96.5%)에서 AI가 실제로 쓰였고, 완료된 작업 455건 중 151건(33.2%)은 AI 없이는 수행이 불가능했다고 참가자들이 답했습니다. 작업 방식이나 파라미터를 제안한 주체는 AI가 55.4%였지만, 최종 선택의 85.5%는 사람이 내렸습니다. 실질적인 수정을 거친 작업의 75.4%는 AI가 직접 수행했습니다.

## 의미와 한계

이 기록은 에이전트가 이미 상당 부분의 실행 노동을 떠맡고 있지만, 방향을 정하고 결과를 받아들이는 결정은 여전히 사람 몫이라는 점을 수치로 보여줍니다. 다만 이 데이터는 Atria Dawn을 개발한 연구팀 내부 표본으로, 56명이라는 참가자 규모와 자기 보고 방식 평가라는 한계가 있어 다른 조직이나 업무 영역에 그대로 적용하기는 어렵습니다. 벤치마크 점수도 연구팀이 직접 측정해 공개한 수치여서, 독립적인 재현 검증은 아직 없습니다.

## 한 줄 정리

744B 에이전트 모델 Atria Dawn 공개와 함께, 개발 과정에서 AI가 실행을 사람이 결정을 맡았다는 실측 기록이 나왔습니다.
