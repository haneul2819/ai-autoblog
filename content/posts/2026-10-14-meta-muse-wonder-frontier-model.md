---
title: "메타, 에이전트형 모델 Muse Wonder와 Wonder Full 공개하며 프런티어 경쟁 합류"
description: "메타가 Active Memory와 Active Focus를 갖춘 Muse Wonder·Wonder Full을 공개하며 처음으로 프런티어급 모델 경쟁에 뛰어들었습니다."
date: 2026-10-14
tags: ["Meta", "에이전트", "벤치마크", "추론비용"]
sources:
  - title: "Introducing Muse Wonder and Muse Wonder Full: Frontier Models for Agents"
    url: "https://about.fb.com/news/2026/10/introducing-muse-wonder-models/"
  - title: "Muse Wonder: A Frontier Model For Personal & Professional AI Agents"
    url: "https://research.meta.ai/blog/muse-wonder"
  - title: "Meta's new Muse Wonder and Muse Wonder Full models achieve frontier performance, but only the weaker one is available via API"
    url: "https://venturebeat.com/technology/metas-new-muse-wonder-and-muse-wonder-full-models-achieve-frontier-performance-but-only-the-weaker-one-is-available-via-api"
  - title: "Meta releases its first frontier model, Muse Wonder"
    url: "https://techcrunch.com/2026/10/12/meta-releases-its-first-frontier-model-muse-wonder/"
---

## 왜 지금 이 주제인가

메타가 2026년 10월 12일 Muse Wonder와 Muse Wonder Full을 공개했습니다. 두 모델은 지난해 8월 Scale AI 창립자 Alexandr Wang이 메타의 AI 조직을 재구조화한 뒤 내놓은 첫 프런티어급 모델입니다. 그동안 메타는 누구나 가중치를 내려받아 쓸 수 있는 Llama 계열 오픈웨이트 모델로 알려졌지만, 이번 발표로 OpenAI·Anthropic·Google과 같은 구독형 폐쇄 모델 경쟁에 정식으로 합류했습니다. 메타 재구조화 이후 처음 나온 결과물이라는 점에서, 이번 공개는 조직 개편이 실제 제품으로 이어졌는지 가늠할 첫 시험대이기도 합니다.

## 핵심 내용

메타 공식 발표에 따르면 두 모델의 핵심 기능은 두 가지입니다. Active Memory는 "대화 전반에 걸쳐 사용자에 대한 중요한 맥락을 유지하고, 작업과 관련된 세부사항을 적극적으로 다시 불러오는" 기능입니다. Active Focus는 "목표가 어려워졌을 때도 대안을 시도하고, 장애물을 해쳐 나가며, 새로운 정보에 적응하면서" 작업을 계속 수행하는 능력으로 설명됩니다. 메타는 이 두 기능이 보험 청구 처리나 임대 계약 분석처럼 여러 단계를 거쳐야 하는 개인·업무용 에이전트 작업을 겨냥한 것이라고 밝혔습니다.

벤치마크에서는 Artificial Analysis Intelligence Index 기준으로 Muse Wonder Full이 56점, Muse Wonder가 52점을 받았습니다. 같은 지수에서 Claude Opus 5.5는 58점, GPT-6 Astra는 53점을 기록해, 메타 모델이 상위권 모델과 비슷한 구간에 들어왔습니다. 장기 소프트웨어 작업을 재는 SWE-Marathon에서는 Wonder Full이 57.5점으로 Opus 5.5의 46.3점을 앞섰고, 법률 지식을 평가하는 Harvey LAB-AA에서는 Wonder Full이 13.1점으로 GPT-6 Astra의 8.6점보다 높았습니다. 실제 깃허브 이슈 해결 능력을 보는 DeepSWE 1.1에서도 Wonder Full은 79.0점으로 Opus 5.5의 74.2점을 넘었습니다.

메타는 또 자체 벤치마크인 MemoryBench에서 Muse Wonder가 Fable, Claude Opus, GPT-6 Astra보다 높은 점수를 받았다고 밝혔는데, 이는 Active Memory 기능이 실제로 긴 대화 맥락을 다루는 능력으로 이어졌다는 주장을 뒷받침하기 위한 결과입니다.

두 모델은 텍스트, 이미지, 오디오, 비디오를 입력으로 받아 텍스트로 응답하며, 컨텍스트 윈도우는 약 100만 토큰입니다. 제공 방식은 두 모델이 다릅니다. Muse Wonder는 Meta Model API를 통해 입력 토큰 백만 개당 4달러, 출력 토큰 백만 개당 20달러로 이용할 수 있습니다. 반면 더 강력한 Muse Wonder Full은 API로 제공되지 않고, 월 50달러의 Power 요금제나 월 200달러의 Maximum 요금제를 갖춘 Muse Code 구독을 통해서만 쓸 수 있습니다.

## 의미와 한계

메타가 자체 벤치마크에서 상위권 모델과 비슷한 성적을 냈다고 공개한 것은 그동안 오픈웨이트 Llama에 머물던 메타의 전략이 바뀌었다는 신호로 읽힙니다. 다만 이번 모델들은 가중치가 공개되지 않는 완전한 폐쇄형이어서, 메타가 쌓아온 오픈소스 생태계와는 다른 노선입니다. 또한 가장 강력한 버전인 Wonder Full을 API로 제공하지 않고 구독 서비스에만 묶어 둔 점은, 외부 개발자가 가장 성능이 좋은 버전을 자유롭게 실험하기 어렵게 만드는 요인입니다. 벤치마크 수치 역시 메타가 직접 공개한 자체 측정치이기 때문에, 독립된 제3자 평가로 재현되기 전까지는 참고 자료로만 받아들일 필요가 있습니다. Active Memory와 Active Focus가 실제 사용 환경에서 얼마나 안정적으로 작동하는지도 아직 외부에서 검증되지 않았습니다. 그럼에도 메타, 구글, OpenAI, Anthropic이 모두 구독형 상시 작동 에이전트를 내놓는 흐름이 겹치는 것을 보면, 프런티어 모델 경쟁의 축이 단발성 질의응답에서 장기 기억과 자율적 작업 수행 쪽으로 옮겨가고 있다는 점은 분명해 보입니다.

## 한 줄 정리

메타가 Active Memory와 Active Focus를 내세운 Muse Wonder·Wonder Full로 처음 프런티어 모델 경쟁에 뛰어들었지만, 최상위 버전은 구독에만 묶여 있고 성능 수치는 아직 자체 측정치에 머물러 있습니다.
