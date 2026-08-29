---
title: "Google DeepMind, 모델도 문항도 가린 이중맹검 평가를 시범 실시"
description: "Google DeepMind가 기밀 컴퓨팅 환경에서 평가자는 모델 가중치를, 개발사는 시험 문항을 볼 수 없는 이중맹검 안전성 평가를 시범 운영했습니다."
date: 2026-08-29
tags: ["Google", "Gemini", "평가", "안전성", "프라이버시"]
sources:
  - title: "Piloting the world's first double-blind AI evaluations"
    url: "https://deepmind.google/blog/piloting-the-worlds-first-double-blind-ai-evaluations/"
  - title: "Double-blind evaluations technical report (Google DeepMind)"
    url: "https://storage.googleapis.com/deepmind-media/DeepMind.com/Blog/piloting-the-worlds-first-double-blind-ai-evaluations/double-blind-evaluations-technical-report.pdf"
  - title: "Google DeepMind Seals Gemini Test to Protect Benchmarks"
    url: "https://www.techrepublic.com/article/news-google-deepmind-gemini-tests-apac-singapore/"
  - title: "Secure Enclaves for AI Evaluation (OpenMined)"
    url: "https://openmined.org/blog/secure-enclaves-for-ai-evaluation/"
---

## 왜 지금 이 주제인가

외부 기관이 상용 모델의 안전성을 검증하려 할 때마다 같은 교착이 반복됐습니다. 평가자가 시험 문항을 모델 개발사에 넘기면 그 문항이 다음 학습 데이터에 섞일 위험이 생기고, 반대로 개발사가 모델 가중치를 평가자에게 넘기면 핵심 자산이 밖으로 나갑니다. 어느 쪽도 양보하기 어려운 문제였습니다. Google DeepMind는 8월 27일, 양쪽 모두 상대의 자료를 보지 못한 채 평가를 끝내는 이중맹검(double-blind) 방식을 시범 운영했다고 공개했습니다. 상용 프런티어급 모델을 대상으로 이 방식을 적용한 첫 사례라는 것이 회사의 설명입니다.

## 암호화된 상자 안에서 진행한 평가

핵심 장치는 Google Cloud의 기밀 컴퓨팅(Confidential Computing) 제품군 중 하나인 Confidential Space입니다. 모델과 평가 문항을 하드웨어로 격리된 실행 환경에 각각 넣고, 그 안에서만 추론과 채점이 이뤄지도록 한 뒤, 실행이 끝나면 결과 점수만 밖으로 내보내는 구조입니다. 평가자는 Gemini의 가중치에 접근할 수 없고, Google은 평가자의 문항을 볼 수 없습니다.

TechRepublic 보도에 따르면 실행 환경은 Google Cloud의 A3 Confidential VM으로, 호스트 메모리 암호화에 Intel TDX를, 가속기로는 기밀 모드의 NVIDIA H100 GPU를 썼습니다. 하드웨어 암호화와 원격 증명(remote attestation)을 함께 사용해, 상자 안에서 실제로 어떤 소프트웨어가 돌아가고 있는지를 양쪽이 확인할 수 있게 했습니다. 서로를 믿는 대신 실행 환경의 상태를 암호학적으로 확인하는 방식입니다.

시범 평가에는 싱가포르 AI 안전연구소(Singapore AI Safety Institute), OpenMined, AVERI, MLCommons가 참여했습니다. 대상 모델은 Gemini Flash Lite 계열의 소형 모델로, TechRepublic은 이를 Gemini 2.5 Flash Lite로 보도했습니다. AVERI는 MLCommons의 안전성 벤치마크 AILuminate에서 공개되지 않은 예비 문항을 사용했고, 사이버 공격, 화학·생물학적 위해, 혐오 표현, 자해, 폭력 범죄 유도 등의 범주를 다뤘습니다. 싱가포르 AI 안전연구소는 이와 별도로 자국 맥락에서 문제가 되는 유해 표현을 겨냥한 비공개 문항으로 시험을 진행했습니다. 평가가 끝난 뒤 상자 밖으로 나온 것은 채점 결과와 실행 환경이 정상이었음을 보증하는 증명 기록뿐이고, 이번 시범 평가에서 모델이 받은 구체적인 점수는 공개되지 않았습니다.

이런 시도가 갑자기 나온 것은 아닙니다. OpenMined는 앞서 영국 AI 안전연구소, Anthropic과 함께 같은 발상의 사전 실험을 진행했습니다. 당시에는 실제 모델 대신 GPT-2와 소량의 데이터 표본으로 절차만 검증했는데, 양쪽이 코드와 정책을 검토하고 승인하는 거버넌스 과정에만 28분 3초가 걸렸다고 기록돼 있습니다.

## 의미와 한계

이 방식이 자리를 잡으면 평가의 지형이 달라질 수 있습니다. 규제 기관이나 해외의 안전연구소가 민감한 시험 문항을 미국 기업에 넘기지 않고도 상용 모델을 검증할 수 있게 되기 때문입니다. 사이버 보안이나 생물학적 위해처럼 문항 자체가 기밀인 영역에서 특히 의미가 큽니다. 벤치마크 점수가 실력인지 암기인지 사후에 가려낼 방법이 없다는 오래된 문제에도 절차적인 답을 제시합니다. 문항을 한 번 공개하면 그 벤치마크는 사실상 수명을 다한다는 점을 생각하면, 같은 비공개 문항을 여러 모델에 반복해서 쓸 수 있게 만드는 쪽의 가치도 작지 않습니다.

다만 이번 발표만으로 판단하기에는 이른 지점이 많습니다. 대상은 프런티어급 대형 모델이 아니라 경량 모델 한 종이었고, 실제 평가 점수는 공개되지 않았습니다. 방법론은 검증 가능해졌지만 그 방법론으로 얻은 결과는 외부에서 확인할 수 없는 상태입니다. 실행 환경과 원격 증명이 모두 Google 인프라 위에 놓여 있다는 점도 남습니다. 모델 개발사를 신뢰의 고리에서 완전히 떼어내지는 못한 셈입니다. 이전 실험에서 드러났듯 기술보다 기관 간 법적 합의와 코드 검토 절차가 실제 병목이 될 가능성도 있습니다. 다른 연구소가 자사 최상위 모델을 같은 조건에 올려놓을지가 관건이 되리라 봅니다. 이 마지막 판단은 추측입니다.

## 한 줄 정리

평가 문항과 모델 가중치를 서로 감춘 채 검증을 끝내는 절차가 실제로 작동한다는 것을 보였지만, 아직 경량 모델 한 종의 시범 사례입니다.
