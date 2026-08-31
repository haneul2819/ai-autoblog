---
title: "Tencent, 770B 오픈웨이트 모델 Hy4 preview 공개"
description: "Tencent이 8월 28일 총 파라미터 770B, 활성 49B의 MoE 모델 Hy4 preview를 Apache 2.0으로 공개했습니다. 구조와 공개 수치, 모델이 참여했다는 자기 최적화 주장을 정리했습니다."
date: 2026-08-31
tags: ["오픈웨이트", "MoE", "장문맥", "벤치마크", "추론비용"]
sources:
  - title: "Tencent Releases and Open-Sources Tencent Hy4 preview"
    url: "https://www.tencent.com/tencent-releases-and-open-sources-tencent-hy4-preview/"
  - title: "tencent/Hy4-preview - Hugging Face"
    url: "https://huggingface.co/tencent/Hy4-preview"
  - title: "Tencent open-sources Hy4 preview with 770B parameters and a 1M-token context"
    url: "https://technode.com/2026/08/28/tencent-open-sources-hy4-preview-with-770b-parameters-and-a-1m-token-context/"
---

## 왜 지금 이 주제인가

Tencent이 8월 28일 대규모 언어 모델 Hy4 preview를 공개하고 가중치를 Apache License 2.0으로 배포했습니다. 총 파라미터 770B는 최근 공개된 오픈웨이트 모델 가운데 가장 큰 축에 속합니다. 다만 규모보다 눈에 띄는 대목은 따로 있습니다. Tencent은 이 모델을 자사의 학습 방법과 추론 시스템을 최적화하는 작업에 직접 투입했다고 밝혔고, 그 결과를 수치로 함께 내놨습니다. 모델이 자기 자신을 만드는 과정에 참여했다는 주장이 공식 발표문에 들어간 사례입니다.

## 공개된 것

### 구조

Hy4 preview는 Mixture-of-Experts(MoE, 전문가 혼합) 구조입니다. 총 파라미터 770B 가운데 토큰 하나를 처리할 때 실제로 쓰이는 것은 49B입니다. 백본은 78개 층으로, 첫 층만 일반 FFN을 쓰고 나머지 77개 층은 MoE로 대체했습니다. 각 MoE 층에는 라우팅 전문가 256개와 공유 전문가 1개가 있고, 토큰마다 라우팅 전문가 상위 8개가 공유 전문가와 함께 활성화됩니다. 은닉 차원은 6144, 어텐션 헤드는 64개, 어휘 크기는 120,832입니다.

어텐션은 Gated DeepSeek Sparse Attention(Gated DSA)을 쓰고, 여기에 IndexCache를 붙여 층 사이에서 희소 인덱스를 재사용합니다. 컨텍스트 길이는 100만 토큰입니다. 백본과 별도로 추측 디코딩(speculative decoding)용 MTP 층이 하나 붙어 있는데, 이 층은 총 10B 파라미터에 활성 0.7B입니다.

가중치는 Hugging Face에 올라와 있고 FP8 양자화판도 함께 배포됐습니다. 공식적으로 안내된 배포 경로는 vLLM과 SGLang입니다.

### 수치

모델 카드에 적힌 점수는 GPQA Diamond 92.3, SWE-Bench Pro 65.7, Deep-SWE 64.3, SWE-Bench Multilingual 82.9입니다. Tencent은 이와 별도로 사내 블라인드 평가 결과도 공개했습니다. 전문가 163명이 엔지니어링 과제 203개를 채점한 결과 Hy4 preview의 평균은 4점 만점에 2.99였고, 같은 조건에서 GLM-5.3은 2.92, Kimi K3는 2.94였습니다.

API 가격은 입력 100만 토큰당 0.834달러, 출력 100만 토큰당 2.501달러이며 캐시 적중은 100만 토큰당 0.042달러입니다. WorkBuddy와 CodeBuddy에서는 출시 후 2주간 무료로 쓸 수 있습니다.

### 모델이 참여한 최적화

Tencent은 Hy4 preview가 학습 방법, 데이터 전략, 평가 체계, 저수준 연산자를 자동으로 최적화하는 데 참여했다고 설명했습니다. 모델이 방법을 제안하고 실험을 돌린 뒤 결과를 보고 다시 시도하며, 그 과정에서 나온 코드와 로그와 피드백이 다음 탐색 라운드의 입력으로 들어가는 방식입니다. 추론 쪽에서는 모델이 자사 추론 시스템의 병목을 스스로 분석해 연산자 융합과 통신 최적화를 수행했고, 그 결과 기준선 대비 종단 간 처리량이 31.8% 늘었다고 밝혔습니다. 컨텍스트 길이와 동시 요청 수를 바꿔도 개선폭이 일정하게 유지됐다는 단서가 붙어 있습니다.

## 의미와 한계

770B급 가중치가 Apache 2.0으로 풀린다는 점은 그 자체로 의미가 있습니다. 활성 파라미터가 49B라 토큰당 연산량은 총 규모에서 짐작하는 것보다 낮지만, 770B를 메모리에 올려 두는 부담은 그대로 남습니다. FP8 판을 함께 낸 것도 이 지점을 의식한 선택으로 보입니다.

가장 조심해서 읽어야 할 부분은 자기 최적화 대목입니다. 31.8%라는 처리량 개선치는 Tencent이 자사 시스템에서 자체 기준선과 비교해 얻은 값이고, 어떤 최적화가 모델의 제안이었고 어디부터가 사람의 판단이었는지는 발표문만으로 구분되지 않습니다. 모델이 코드를 제안하는 것과 그 코드가 사람 검토 없이 반영되는 것은 다른 이야기인데, 공개된 내용에는 그 경계가 드러나 있지 않습니다.

사내 블라인드 평가도 마찬가지입니다. 과제 구성과 채점 기준을 Tencent이 정했고 외부에서 재현할 방법이 없어서, GLM-5.3이나 Kimi K3와의 0.05~0.07점 차이를 순위로 받아들이기에는 근거가 얇다고 봅니다. 지금 확인할 수 있는 것은 모델 카드에 적힌 공개 벤치마크 점수와, 가중치가 실제로 공개돼 있다는 사실입니다. 나머지는 외부에서 같은 모델을 돌려 본 결과가 쌓여야 판단할 수 있는 영역입니다.

## 한 줄 정리

Tencent이 770B 규모의 MoE 모델을 Apache 2.0으로 공개하면서, 그 모델을 자사 추론 시스템 최적화에 투입해 처리량을 31.8% 높였다고 밝혔습니다.
