---
title: "Qwen, Qwen4 구조를 미리 적용한 오픈웨이트 모델 Qwen3.8-Flash-Next 공개"
description: "Alibaba Qwen 팀이 차기 Qwen4 아키텍처를 앞당겨 적용한 125B 규모 MoE 모델의 가중치를 공개했습니다. 어텐션과 잔차, 임베딩, 최적화 네 갈래를 함께 손봤습니다."
date: 2026-08-29
tags: ["오픈웨이트", "Qwen", "MoE", "장문맥", "추론비용"]
sources:
  - title: "Qwen/Qwen3.8-Flash-Next · Hugging Face"
    url: "https://huggingface.co/Qwen/Qwen3.8-Flash-Next"
  - title: "QwenLM/Qwen3.8-Flash-Next (GitHub)"
    url: "https://github.com/QwenLM/Qwen3.8-Flash-Next"
  - title: "Qwen3.8-Flash-Next: Day-0 Support in SGLang"
    url: "https://www.lmsys.org/blog/2026-08-26-qwen-flash-next"
---

## 왜 지금 이 주제인가

Alibaba의 Qwen 팀이 8월 26일 Qwen3.8-Flash-Next의 가중치를 Hugging Face와 ModelScope에 올렸습니다. 이름은 3.8 계열이지만 팀이 붙인 설명은 다릅니다. 다음 세대인 Qwen4에 쓸 구조를 미리 실험한 프리뷰 모델이라는 것입니다. 완성된 제품을 내놓는 발표가 아니라, 아직 정식 모델이 나오지 않은 아키텍처를 먼저 열어 두고 생태계가 대응할 시간을 주는 방식입니다. 함께 공개된 기술 보고서의 제목도 성능이 아니라 설계를 앞세운 On the Design of Qwen3.8-Next Architecture입니다.

## 네 갈래로 나뉜 구조 변경

Qwen 팀은 바뀐 지점을 어텐션, 잔차, 임베딩, 최적화 네 갈래로 정리했습니다.

### 어텐션과 잔차

어텐션은 Gated DeltaNet과 Qwen Sparse Attention을 섞은 하이브리드입니다. 모델 카드에 적힌 층 구성은 12 × (3 × (Gated DeltaNet → MoE) → 1 × (Qwen Sparse Attention → MoE))으로, 전체 48개 층 가운데 36개가 Gated DeltaNet이고 12개가 희소 어텐션입니다. 희소 어텐션은 토큰 하나 단위가 아니라 마이크로 블록 단위로 동작해 긴 입력에서 지연을 줄이도록 설계됐습니다.

잔차 쪽에는 Gated Residual이라는 이름이 붙었습니다. 잔차 스트림을 네 갈래로 넓힌 뒤 읽기와 쓰기를 각각 게이트로 조절해, 층 사이 정보 흐름을 강화하면서 학습 안정성을 유지하겠다는 구상입니다.

### 임베딩과 규모

가장 눈에 띄는 항목은 N-gram Embedding입니다. 주변 문맥을 보고 짧은 n-gram을 조회해 자주 쓰이는 표현에 별도 표현을 붙여 주는 방식으로, 계산량은 거의 늘리지 않고 모델 용량만 키웁니다. 그 결과 파라미터 구성이 특이합니다. 본체가 125B이고 여기에 N-gram 임베딩 테이블 51B가 따로 붙는데, 토큰당 실제로 활성화되는 파라미터는 6B입니다. MoE 설정은 전문가 512개 가운데 라우팅 10개와 공유 1개를 켜는 구조입니다. 문맥 길이는 기본 262,144 토큰이고 YaRN으로 1M까지 늘릴 수 있습니다.

최적화에서는 직교화 정확도를 개선한 Muon 옵티마이저를 씁니다. 저장소에는 Qwen3.7-Plus와 비교해 학습 비용이 약 9분의 1이면서 코딩과 사무 작업에서 더 나은 성능을 낸다고 적혀 있습니다.

### 공개된 점수

모델 카드에 실린 수치는 SWE-bench Pro 62.5, CoWorkBench 73.9, JobBench 55.7, DeepSWE 1.1 58.7입니다. 비전 쪽은 AndroidWorld 84.5, MathVision 90.6, RealWorldQA 88.5입니다. 비교 대상은 Qwen3.8-27B, Qwen3.7-Plus, DeepSeek-V4-Flash입니다.

### 추론 스택의 대응

SGLang은 같은 날 지원을 붙이고 작업 내용을 공개했습니다. 51.2B짜리 N-gram 임베딩을 호스트의 고정 메모리로 내려 H200 기준 GPU 메모리를 약 23.46GiB 아꼈고, Gated Residual의 Mix와 Combine 연산자에서 커널 수준으로 각각 2.05배와 1.96배를 얻었다고 밝혔습니다. NVFP4 체크포인트는 배치 크기 1에 MTP를 켠 조건에서 초당 540토큰을 디코딩했고 수용 길이는 3.3이었습니다.

## 의미와 한계

이 모델의 설계에서 읽히는 방향은 파라미터를 늘리는 일과 계산량을 늘리는 일을 떼어 놓는 것입니다. MoE가 전문가를 골라 계산량을 억제한다면, N-gram 임베딩은 아예 조회 테이블이라 GPU 밖으로 내려놓을 수 있습니다. SGLang이 51.2B를 호스트 메모리로 옮긴 것이 그 성질을 그대로 이용한 사례입니다. 파라미터 수와 서빙 비용의 연결이 느슨해지는 흐름으로 보입니다.

다만 확인되지 않은 것도 많습니다. 공개된 점수는 모두 개발사가 스스로 측정한 값이고, 외부 재현은 아직 없습니다. 라이선스는 qwen-community-1.0이라 상용 이용 조건을 별도로 확인해야 합니다. 본체와 임베딩 테이블을 합치면 가중치 용량이 커서 워크스테이션 한 대에서 돌리기는 어렵고, 여러 장의 GPU가 필요합니다. 무엇보다 이것은 Qwen4가 아니라 Qwen4에 쓸 구조의 시험판입니다. 네 가지 변경이 더 큰 규모에서도 유지될지는 정식 모델이 나와야 판단할 수 있습니다.

## 한 줄 정리

Qwen이 차기 아키텍처를 완성 전에 가중치째 열어, 파라미터 확장과 계산 비용을 분리하려는 설계를 먼저 검증대에 올렸습니다.
