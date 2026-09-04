---
title: "Perplexity, 기기 안에서 개인정보를 걸러 내는 0.6B 모델을 공개"
description: "Perplexity가 Mac용 Hybrid Compute를 열면서 개인정보 경계를 지키는 0.6B 분류 모델과 13개 언어 합성 대화 벤치마크를 함께 공개했습니다."
date: 2026-09-04
tags: ["프라이버시", "에이전트", "Qwen", "벤치마크", "오픈웨이트"]
sources:
  - title: "perplexity-ai/pplx-pii-masking · Hugging Face"
    url: "https://huggingface.co/perplexity-ai/pplx-pii-masking"
  - title: "Perplexity Releases Hybrid Compute on Mac: Cloud Agents Orchestrate Down to a Local Model, Gated On Device"
    url: "https://www.marktechpost.com/2026/09/01/perplexity-releases-hybrid-compute-on-mac-cloud-agents-orchestrate-down-to-a-local-model-gated-on-device/"
  - title: "Perplexity Launches Hybrid Compute on Mac With Local Privacy Gate"
    url: "https://www.unite.ai/perplexity-launches-hybrid-compute-on-mac-with-local-privacy-gate/"
  - title: "Perplexity launches privacy-minded hybrid compute AI feature for Mac"
    url: "https://9to5mac.com/2026/09/01/perplexity-launches-privacy-minded-hybrid-compute-ai-feature-for-mac/"
---

## 왜 지금 이 주제인가

Perplexity가 9월 1일 macOS 앱에 Hybrid Compute를 켰습니다. 작업을 클라우드에서 시작하되 개인정보가 걸리는 단계만 Mac 안의 모델로 내려보내는 방식입니다. 제품 자체보다 눈여겨볼 부분은 그 경계를 지키는 장치가 규칙 목록이 아니라 별도의 작은 분류 모델이고, 회사가 그 모델과 평가용 벤치마크를 함께 내놓았다는 점입니다. 개인정보를 기기 밖으로 내보내지 않겠다는 주장이 남이 다시 재볼 수 있는 형태로 나온 사례입니다.

## 클라우드가 계획하고 기기가 민감한 단계를 맡습니다

지금까지 나온 온디바이스 제품 대부분은 작은 모델로 시작해 어려운 요청만 클라우드로 올렸습니다. Hybrid Compute는 방향이 반대입니다. 계획 수립, 웹 검색, 복잡한 추론은 클라우드의 대형 모델이 맡고, 개인 파일이나 민감한 정보를 만지는 단계가 나오면 그 단계만 Mac의 로컬 모델로 넘깁니다. 작업을 처음부터 다시 돌리지 않고 중간에 넘긴 뒤 결과를 합치는 구조입니다. 로컬이 처리한 몫에는 클라우드 크레딧이 들지 않고 API 키도 필요 없습니다.

실행 조건은 Apple silicon Mac, macOS 15 이상, 통합 메모리 24GB 이상이며 32GB를 권장합니다. Pro, Max, Enterprise 구독자에게 제공됩니다. 로컬 모델로는 Gemma 4 E4B, Qwen3.6 35B-A3B, 그리고 Perplexity가 자체 후처리 학습한 모델을 고를 수 있습니다.

기본값의 방향만 보면 이 회사가 앞서 NVIDIA 하드웨어에 올린 로컬 우선 모드와 정반대입니다. 그쪽은 기기에서 작업을 시작해 사용자가 허락할 때만 클라우드로 올라갑니다. 같은 오케스트레이션 위에서 어느 쪽을 출발점으로 둘지만 바꿔 놓은 셈입니다. 기업 관리자는 무엇을 기기에 남기고 무엇을 가리며 무엇에 승인을 받을지를 조직 단위 정책으로 정할 수 있고, 기기를 떠나는 데이터에는 감사 로그가 남습니다.

### 경계를 지키는 것은 6억 파라미터 인코더입니다

핵심은 PII-Tracer입니다. Qwen3 백본을 양방향 인코더로 바꾼 약 6억 파라미터 모델로, 4,096 토큰 창 안에서 앞뒤 문맥을 함께 봅니다. 토큰마다 37개 라벨의 점수를 내는데, 37은 개인정보 9종에 BIOES 방식 위치 라벨 네 개씩을 붙이고 개인정보가 아닌 구간을 뜻하는 라벨 하나를 더한 값입니다. 9종에는 인명, 이메일, 전화번호, 계좌번호 등이 들어갑니다. 라벨 시퀀스는 제약을 건 Viterbi 디코더로 정리하며, 대화 전체의 민감도를 따로 판정하는 보조 헤드가 붙어 있습니다. 판정 결과에 따라 로컬 유지, 마스킹, 거부, 사용자 확인 중 하나를 고릅니다. 마스킹은 원래 값을 `[PRIVATE_PERSON]`, `[PRIVATE_EMAIL]` 같은 자리표시자로 바꿔 보낸 뒤 답이 돌아오면 되돌리는 방식입니다.

같이 공개된 PII-TRACE는 13개 언어로 만든 사용자와 어시스턴트의 합성 대화 13,148건짜리 벤치마크입니다. Perplexity는 탐지기 12종을 비교해 PII-Tracer가 문자 단위 F1 0.629로 가장 높았고, 같은 식별자가 여러 번 나올 때 그 언급을 모두 잡아내는 비율이 79.4%, 대화 턴을 넘어 반복될 때가 77.6%였다고 밝혔습니다. 긴 입력은 절반씩 겹치는 슬라이딩 윈도우로 디코딩해 재현율을 0.830에서 0.965로 올렸다고 설명합니다. 모델은 Hugging Face에 MIT 라이선스로 올라와 있고 BF16과 FP32 가중치, GGUF와 MLX 변환본이 함께 있습니다.

## 의미와 한계

에이전트가 파일과 계정을 직접 만지기 시작하면서 무엇을 클라우드로 보내지 않는지는 약속이 아니라 구현으로 답해야 하는 문제가 됐습니다. 정규식 목록 대신 작은 모델을 세우고, 그 모델을 공개해 같은 벤치마크로 남이 재볼 수 있게 한 점은 검증 가능한 방향입니다. 반복 언급 재현율을 따로 지표로 삼은 선택도 눈에 띕니다. 같은 이메일 주소가 대화에 다섯 번 나오는데 네 번만 가리면 결국 새어 나가므로, 평균 F1보다 이쪽이 실제 유출 여부에 가깝습니다.

다만 공개된 숫자가 79.4%와 77.6%라는 점은 그대로 봐야 합니다. 다섯 번에 한 번꼴로 놓치고, 그 한 번이 유출이 됩니다. 벤치마크가 합성 대화라는 조건도 남습니다. 실제 사용자의 문서와 스크린샷, 코드에 섞인 개인정보는 분포가 다를 수 있습니다. 4,096 토큰 창과 겹침 디코딩으로 긴 입력을 다루지만 문서 전체를 한 번에 보는 구조는 아닙니다. 무엇보다 이 분류기는 나가는 텍스트를 가릴 뿐이고, 어떤 작업 단계를 로컬로 내릴지 정하는 판단은 클라우드 쪽 오케스트레이터 몫입니다. 그 판단의 근거는 아직 공개되지 않았습니다. 여기서부터는 추측인데, 온디바이스 처리를 내세우는 다른 제품들도 이렇게 경계 판정만 떼어 내 별도 모델로 만드는 쪽으로 갈 가능성이 있습니다.

## 한 줄 정리

Perplexity는 개인정보 경계를 규칙이 아닌 6억 파라미터 분류 모델로 지키고, 그 모델과 벤치마크를 함께 공개해 성능을 재볼 수 있게 했습니다.
