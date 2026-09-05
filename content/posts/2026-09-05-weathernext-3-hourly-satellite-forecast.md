---
title: "Google DeepMind, 위성 영상을 직접 읽는 기상 모델 WeatherNext 3 공개"
description: "수치 예보 분석장 대신 정지궤도 위성 영상을 직접 입력으로 받아 매시간 예보를 생성하는 전 지구 기상 모델이 공개됐고, 발표 당일부터 Google 검색과 지도에 적용됐습니다."
date: 2026-09-05
tags: ["Google", "기상예측", "평가", "멀티모달", "API"]
sources:
  - title: "Introducing WeatherNext 3, our most advanced and accurate global weather AI model"
    url: "https://blog.google/innovation-and-ai/models-and-research/google-deepmind/introducing-weathernext-3/"
  - title: "WeatherNext 3 | Google for Developers"
    url: "https://developers.google.com/weathernext/guides/models"
  - title: "WeatherNext — Google DeepMind"
    url: "https://deepmind.google/science/weathernext/"
---

## 왜 지금 이 주제인가

Google DeepMind와 Google Research가 9월 3일 전 지구 기상 예보 모델 WeatherNext 3를 공개했습니다. 발표 당일부터 Google 검색, Gemini 앱, Google 지도, Google Maps Platform Weather API의 날씨 결과가 이 모델로 교체됐고, 연구자용 데이터 접근 경로도 함께 열렸습니다. 지난주는 언어 모델 발표가 몰려 있어 상대적으로 덜 다뤄졌지만, AI 예보 모델이 기존 수치 예보 시스템의 산출물을 받아 쓰는 단계에서 관측 자료를 직접 읽는 단계로 넘어갔다는 점에서 따로 볼 만합니다.

## 위성 영상을 직접 입력으로 받습니다

가장 큰 변화는 입력 데이터입니다. 그동안 AI 예보 모델은 대체로 수치 예보(NWP, Numerical Weather Prediction) 시스템이 만들어 낸 분석장을 초기 조건으로 받아 왔습니다. 분석장은 흩어진 관측을 모아 격자에 맞춰 정리하는 과정을 거치기 때문에 약 6시간의 지연이 생깁니다. WeatherNext 3는 전 지구 정지궤도 위성 모자이크를 실시간으로 받아 원본 위성 영상에서 대기 상태를 직접 읽습니다. Google은 이 구조 덕분에 하루 매시간 예보를 생성하는 최초의 전 지구 기상 모델이라고 설명했습니다.

구조는 Functional Generative Network(FGN)를 기반으로 한 메시 트랜스포머이고, 단일 예보가 아니라 앙상블로 동작합니다. 개발자 문서 기준 앙상블 멤버는 64개입니다. 예보 주기는 두 갈래로 나뉩니다. 00, 06, 12, 18 UTC의 정시 사이클에서는 15일 예보를 내고, 그 사이의 매시간 실행에서는 48시간 예보를 냅니다.

해상도는 변수마다 다릅니다. 지상 관측소 자료로 학습한 기온과 습도는 약 5km(0.05도), 바람을 포함한 나머지 지상 변수는 약 10km(0.1도), 기압면 상층 변수는 약 25km(0.25도) 격자입니다. Google은 이전 모델 WeatherNext 2와 비교해 전 지구 그림이 대략 5배 선명해졌다고 밝혔습니다.

학습에는 ERA5 재분석 자료와 함께 NASA의 IMERG 위성 강수 자료, 지상 관측소 관측값, 위성 영상이 쓰였습니다. 강수 예보 정확도는 중기 예보 구간에서 IMERG 기준 최대 60%, MRMS 기준 30%, 짧은 예보 구간의 우량계 실측 기준 10% 개선됐다고 제시됐습니다. 하루 이상 앞선 강수 예보에서는 최대 50% 개선이며, 그동안 예보가 상대적으로 부정확했던 지역에서 개선 폭이 컸다고 합니다. 독립 평가로는 Brightband의 실시간 평가 결과를 인용했습니다.

예보 산출물은 BigQuery, Earth Engine, Google Cloud Storage 일괄 내려받기로 접근할 수 있습니다. 풍력 터빈 높이에 맞춘 100m 고도 풍속, 구름량과 일사량 같은 항목이 별도로 제공됩니다.

## 의미와 한계

관측을 직접 읽는 구조는 재분석 파이프라인에 묶여 있던 갱신 주기 제약을 푼다는 점에서 실용적인 변화입니다. 6시간 주기가 1시간으로 줄면 소나기나 눈처럼 빠르게 변하는 현상, 그리고 재생에너지 발전량 예측처럼 시간 단위로 값이 달라지는 용도에서 쓰임새가 달라집니다. 격자 해상도를 25km에서 5~10km로 좁힌 것도 지역 단위 의사 결정에는 직접적인 차이입니다.

다만 공개된 수치는 대부분 Google 자체 발표 기준이고, 개선 폭이 기준 자료에 따라 60%, 30%, 10%로 크게 벌어진다는 점은 그대로 봐야 합니다. 같은 강수 예보라도 위성 추정치를 정답으로 두느냐 지상 우량계를 정답으로 두느냐에 따라 결과가 달라진다는 뜻이고, 실측에 가까운 기준일수록 개선 폭이 작았습니다. 가중치가 공개된 모델도 아니어서 외부에서 구조를 재현해 검증하기는 어렵습니다. 여기서부터는 추측인데, 위성 영상을 직접 넣는 방식은 위성 관측이 촘촘한 지역과 그렇지 않은 지역 사이의 성능 격차 문제를 새로 만들 가능성이 있습니다. 이 부분은 독립 평가 기관의 장기 기록이 쌓여야 판단할 수 있습니다.

## 한 줄 정리

WeatherNext 3는 수치 예보 분석장 대신 위성 영상을 직접 읽어 매시간, 더 촘촘한 격자로 예보를 내는 모델이며, 개선 폭은 어떤 관측을 정답으로 삼느냐에 따라 달라집니다.
