---
title: "샤오미, MiMo-V2.6 공개하며 오픈웨이트 지능지수 46점 기록"
description: "샤오미가 1조 파라미터급 오픈웨이트 모델 MiMo-V2.6-Pro를 MIT 라이선스로 공개했고, Artificial Analysis 지능지수에서 46점을 받아 공개 가중치 모델 중 최고 점수를 기록했습니다."
date: 2026-09-23
tags: ["오픈웨이트", "MoE", "벤치마크", "오픈소스", "추론비용"]
sources:
  - title: "XiaomiMiMo/MiMo-V2.6-Pro-RL · Hugging Face"
    url: "https://huggingface.co/XiaomiMiMo/MiMo-V2.6-Pro-RL"
  - title: "Xiaomi MiMo-V2.6 Series: 3 New Models Officially Released"
    url: "https://mimo.mi.com/docs/en-US/news/latest/v2-6"
  - title: "Xiaomi's New Flagship Model Leads Open-Weight Rankings With a Score of 46"
    url: "https://www.unite.ai/xiaomis-new-flagship-model-leads-open-weight-rankings-with-a-score-of-46/"
---

## 왜 지금 이 주제인가

샤오미가 9월 21일 오픈웨이트 모델 MiMo-V2.6 시리즈를 공개했습니다. 플래그십 모델 MiMo-V2.6-Pro는 Artificial Analysis의 지능지수(Intelligence Index) v4.3에서 46점을 받아, 공개 가중치 모델 가운데 가장 높은 점수를 기록했습니다. 전작 MiMo-V2.5-Pro가 같은 지표에서 26점이었던 것과 비교하면 한 세대 만에 20점이 올랐습니다. 스마트폰 제조사가 자체 강화학습 인프라로 프런티어급 모델을 단 6일 만에 학습시켰다는 점에서, 오픈웨이트 진영의 학습 효율 경쟁이 새 국면에 들어섰다고 볼 만합니다.

## 핵심 내용

MiMo-V2.6 시리즈는 플래그십 Pro, 경량 Flash, 추론 속도를 높인 Pro-UltraSpeed 세 가지로 구성됩니다. Pro는 전체 파라미터 1.02조 개 중 토큰당 420억 개를 쓰는 희소 MoE(Mixture of Experts) 구조로, 384개 라우팅 전문가 가운데 8개가 활성화됩니다. 트랜스포머는 70개 레이어로, 이 중 60개는 슬라이딩 윈도우 어텐션(SWA), 10개는 전역 어텐션(GA)을 씁니다. Flash는 전체 3,090억 개 중 150억 개(4.9%)만 활성화하는 더 가벼운 구조입니다. 두 모델 모두 100만 토큰 컨텍스트를 지원합니다.

두 모델은 텍스트, 이미지, 비디오, 오디오를 하나의 모델로 처리하는 네이티브 옴니모달 구조입니다. 비전 인코더는 6억 8,100만 파라미터의 MiMo ViT, 오디오는 3억 800만 파라미터의 AudioTokenizer와 1억 2,700만 파라미터의 패치 인코더로 구성됩니다.

학습은 GRPO(Group Relative Policy Optimization) 기반 완전 비동기 강화학습으로 이뤄졌습니다. 프롬프트 1,568개에 롤아웃 16개를 곱한 대규모 배치로 30스텝, 약 75만 개의 궤적(trajectory)을 6일 이내에 학습했습니다. 학습 비용은 Pro가 약 262만 달러, Flash가 약 85만 달러로 샤오미 측이 공개했습니다.

벤치마크에서 Pro는 Artificial Analysis 지능지수 46점으로 Grok 4.7과 동률을 이루며 GLM-5.3(45점), Kimi K3(44점)를 앞섰습니다. 에이전트 코딩 벤치마크 DeepSWE v1.1에서는 Pro가 71.9점, Flash가 67.9점을 기록했고, 범용 에이전트 벤치마크 Toolathlon-Verified에서는 76.9점, 보안 벤치마크 CyberGym에서는 94.0점을 받았습니다. Pro-UltraSpeed는 같은 품질을 유지하면서 출력 속도를 최대 20배 높여 초당 129.7 토큰을 처리합니다.

샤오미는 세 모델 모두 상업적 이용이 가능한 MIT 라이선스로 공개했고, 90억 파라미터짜리 Qwen3.5 증류 모델과 7,000개가 넘는 강화학습 환경, 학습 코드, 기술 리포트도 함께 내놓았습니다.

## 의미와 한계

스마트폰 제조사인 샤오미가 자체 인프라로 6일 만에 지능지수 46점짜리 모델을 학습시켰다는 것은, 프런티어급 성능을 내는 데 필요한 학습 비용과 시간이 계속 줄고 있다는 뜻입니다. 262만 달러라는 학습 비용은 대형 연구소의 사전학습 비용과 비교하면 작은 규모이며, 가중치와 RL 환경, 학습 코드를 전부 공개한 점도 외부 연구자의 재현과 검증을 가능하게 합니다. MIT 라이선스 공개는 중국 오픈웨이트 모델이 상업적 이용까지 열어 두는 흐름을 이어가는 것으로, 기업이 자체 서비스에 이 모델을 적용할 때 라이선스 제약이 적다는 의미이기도 합니다.

다만 이번 발표는 샤오미 측이 공개한 수치와 자체 선택한 벤치마크에 기반한 것으로, Artificial Analysis 외 제3자 벤치마크에서도 같은 순위가 유지될지는 아직 확인되지 않았습니다. 또한 30스텝의 강화학습은 사전학습된 베이스 모델 위에서 이뤄진 결과이므로, 이번 수치만으로 샤오미의 사전학습 역량 전체를 가늠하기는 어렵습니다. 옴니모달 처리나 3차원 공간 추론 같은 새 기능에 대해서는 아직 폭넓은 제3자 검증이 공개되지 않았습니다.

## 한 줄 정리

샤오미가 6일간 262만 달러를 들인 강화학습으로 오픈웨이트 지능지수 1위 모델을 MIT 라이선스로 공개했습니다.
